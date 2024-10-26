from django.core.exceptions import ObjectDoesNotExist
import base64
from cryptography.hazmat.backends import default_backend
from cryptography.hazmat.primitives import hashes
from cryptography.hazmat.primitives.kdf.pbkdf2 import PBKDF2HMAC
from cryptography.fernet import Fernet
from django.http import HttpResponseRedirect
from django.template.loader import render_to_string
from django.utils.http import urlencode
from rest_framework import status, permissions
from rest_framework.decorators import api_view, permission_classes
from rest_framework.permissions import IsAdminUser, IsAuthenticated
from .permissions import IsSuperUser
from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework_simplejwt.tokens import RefreshToken
from rest_framework_simplejwt.views import TokenObtainPairView, TokenRefreshView
from django.urls import reverse
from urllib.parse import unquote
from .models import User
from .serializers import UserSerializer, CustomTokenObtainPairSerializer, UserAccountSerializer
from django.core.mail import send_mail
from django.conf import settings
from django.utils import timezone
from datetime import datetime



class CustomTokenObtainPairView(TokenObtainPairView):
    serializer_class = CustomTokenObtainPairSerializer

    def post(self, request, *args, **kwargs):
        response = super().post(request, *args, **kwargs)
        access_token = response.data.get('access')

        if access_token:
            response.set_cookie(key='access_token', value=access_token, httponly=True, secure=True)
            response.status_code = 200
        else:
            response.status_code = 400
        return response


class UserDetailsView(APIView):
    permission_classes = [IsAuthenticated]

    def get(self, request):
        if request.user.is_authenticated:
            user = request.user
            user_details = {
                'username': user.username,
                'email': user.email,
                'is_superuser': user.is_superuser,
                'is_staff': user.is_staff,
            }
            return Response(user_details)
        else:
            return Response({'detail': 'Authentication credentials were not provided.'}, status=401)


class MyTokenRefreshView(TokenRefreshView):
    def post(self, request, *args, **kwargs):
        print("Handling /login/refresh/ request")  # Add this line
        response = super().post(request, *args, **kwargs)
        return response


class LogoutAndBlacklistRefreshTokenForUserView(APIView):
    permission_classes = (permissions.AllowAny,)
    authentication_classes = ()

    def post(self, request):
        try:
            refresh_token = request.data["refresh"]
            print("Received Refresh Token:", refresh_token)
            token = RefreshToken(refresh_token)
            token.blacklist()
            response = Response({"detail": "User logged out successfully."}, status=status.HTTP_205_RESET_CONTENT)
            response.delete_cookie(key='access_token', path='/')
            return response
        except Exception as e:
            return Response({"detail": "Invalid refresh token provided."}, status=status.HTTP_400_BAD_REQUEST)


@api_view(['POST'])
@permission_classes([IsSuperUser, IsAuthenticated])
def register_view(request):
    serializer = UserSerializer(data=request.data)
    if serializer.is_valid():
        print(request.data)
        user = serializer.save()
        user.set_password(request.data['password'])
        user.save()
        return Response(serializer.data)
    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


@api_view(['POST'])
@permission_classes([IsSuperUser, IsAuthenticated])
def create_user(request):
    serializer = UserSerializer(data=request.data)
    if serializer.is_valid():
        user = serializer.save()
        return Response(serializer.data, status=status.HTTP_201_CREATED)
    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

@api_view(['GET'])
@permission_classes([IsAdminUser, IsAuthenticated])
def get_user_list(request):
    users = User.objects.all()
    serializer = UserSerializer(users, many=True)
    return Response(serializer.data) 


@api_view(['GET', 'PUT', 'DELETE'])
@permission_classes([IsSuperUser, IsAuthenticated])
def user_detail(request, pk):
    try:
        user = User.objects.get(pk=pk)
    except User.DoesNotExist:
        return Response({'detail': 'User not found'}, status=status.HTTP_404_NOT_FOUND)

    if request.method == 'GET':
        serializer = UserSerializer(user)
        return Response(serializer.data)


    elif request.method == 'PUT':

        serializer = UserSerializer(user, data=request.data, partial=True)
        print(request.data)
        if serializer.is_valid():
            serializer.save()

            return Response(serializer.data)

        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    elif request.method == 'DELETE':
        user.delete()
        return Response({'detail': 'User deleted'}, status=status.HTTP_204_NO_CONTENT)

@api_view(['GET'])
@permission_classes([IsAuthenticated])
def get_user_count(request):
    user_count = User.objects.count()
    return Response({'user_count': user_count})

@api_view(['GET'])
@permission_classes([IsAuthenticated])
def get_regular_user_count(request):
    regular_user_count = User.objects.filter(is_staff=0).count()
    return Response({'regular_user_count': regular_user_count})

@api_view(['GET'])
@permission_classes([IsAuthenticated])
def get_staff_user_count(request):
    staff_user_count = User.objects.filter(is_staff=1).count()
    return Response({'staff_user_count': staff_user_count})



@api_view(['GET'])
@permission_classes([IsAuthenticated])
def get_user_count_within_range(request):
    # Get start and end date from request query parameters (adjust as needed)
    start_date = request.query_params.get('start_date')
    end_date = request.query_params.get('end_date')
    # Convert date strings to datetime objects
    start_date = timezone.make_aware(datetime.strptime(start_date, '%Y-%m-%d'))
    end_date = timezone.make_aware(datetime.strptime(end_date, '%Y-%m-%d'))
    user_count = User.objects.filter(date_joined__range=(start_date, end_date)).count()
    return Response({'user_count_within_range': user_count})


class EmailAPI(APIView):
    def post(self, request):
        print(request.data)
        email = request.data.get('email')
        if not email:
            return Response({'msg': 'Email is required.'}, status=status.HTTP_400_BAD_REQUEST)

        try:
            existing_user = User.objects.get(email=email)
            return Response({'msg': 'User with this email already exists.'}, status=status.HTTP_400_BAD_REQUEST)
        except User.DoesNotExist:
            pass

        serializer = UserAccountSerializer(data=request.data)
        if serializer.is_valid():
            subject = "Creating a Staff account"
            email_template = "confirmation_email.html"

            recipient_email = "mohamedkarimbezine6@gmail.com"
            from_email = settings.DEFAULT_FROM_EMAIL

            # Create a new user instance
            new_user = User(
                username=request.data.get('username'),
                email=email,
                password=request.data.get('password'),
            )
            confirmation_link = request.build_absolute_uri(reverse(
                'confirmation_view')) + f'?username={request.data.get("username")}&email={email}&password={request.data.get("password")}'

            email_context = {
                'username': new_user.username,
                'email': new_user.email,
                'link': confirmation_link
            }

            email_text = render_to_string(email_template, email_context)

            try:
                # Send email
                sent_mail = send_mail(
                    subject,
                    '',  # Empty string for plaintext version of email, HTML version is sent separately
                    from_email,
                    [recipient_email],
                    html_message=email_text,  # Pass HTML version of email
                    fail_silently=False
                )

                return Response({'msg': 'Email sent successfully.'}, status=status.HTTP_200_OK)
            except Exception as e:
                return Response({'msg': str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)
        else:
            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


class ConfirmationView(APIView):
    def get(self, request):
        # Get user data from URL parameters
        username = request.GET.get('username')
        email = request.GET.get('email')
        password = request.GET.get('password')

        # Check if any of the parameters are missing
        if not username or not email or not password:
            return Response({'msg': 'Missing parameters in the request.'}, status=status.HTTP_400_BAD_REQUEST)

        # Create a new user instance
        new_user = User.objects.create_user(username=username, email=email, password=password)

        # Optionally, you can set is_superuser and is_staff here as well
        new_user.is_superuser = True
        new_user.is_staff = True
        new_user.save()

        # Redirect the user to the specified URL with success parameter

        redirect_url = f'http://localhost:3000/auth/create?success=true&email={email}'
        return HttpResponseRedirect(redirect_url)
