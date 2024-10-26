from rest_framework.decorators import api_view, permission_classes
from rest_framework.response import Response
from rest_framework import status
from django.db.models import Count
from django.db.models.functions import ExtractMonth
from .models import Product
from .serializers import ProductSerializer
from rest_framework.permissions import IsAuthenticated, IsAdminUser
from .permissions import CanCreateProduct, CanUpdateProduct, CanDeleteProduct, CanViewProduct, IsSuperUser
from users.models import User
import jwt
from django.conf import settings
from django.utils import timezone
from datetime import datetime



def extract_user_id_from_token(request):
    auth_header = request.headers.get('Authorization', '')
    token = auth_header.split(' ')[1] if auth_header.startswith('Bearer ') else None

    if token:
        try:
            decoded_token = jwt.decode(token, settings.SECRET_KEY, algorithms=['HS256'])
            user_id = decoded_token.get('user_id')
            return user_id
        except jwt.ExpiredSignatureError:
            return None
        except jwt.InvalidTokenError:
            return None
    else:
        return None

@api_view(['GET', 'POST'])
@permission_classes([IsAuthenticated])
def product_list(request):
    user_id = extract_user_id_from_token(request)
    if user_id:
        try:
            user = User.objects.get(id=user_id)
        except User.DoesNotExist:
            return Response({'detail': 'User not found'}, status=status.HTTP_404_NOT_FOUND)
    else:
        return Response({'detail': 'Invalid token'}, status=status.HTTP_401_UNAUTHORIZED)

    if request.method == 'GET':
        products = Product.objects.all()
        serializer = ProductSerializer(products, many=True)
        return Response(serializer.data)

    elif request.method == 'POST':
        permission_classes = [CanCreateProduct | IsSuperUser]
        for permission in permission_classes:
            if not permission().has_permission(request, None):
                return Response({'detail': 'You do not have permission to perform this action'}, status=status.HTTP_403_FORBIDDEN)

        serializer = ProductSerializer(data=request.data)
        if serializer.is_valid():
            product = serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        print(serializer.errors)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

@api_view(['GET', 'PUT', 'PATCH', 'DELETE'])
@permission_classes([IsAuthenticated])
def product_detail(request, pk):
    user_id = extract_user_id_from_token(request)
    if user_id:
        try:
            user = User.objects.get(id=user_id)
        except User.DoesNotExist:
            return Response({'detail': 'User not found'}, status=status.HTTP_404_NOT_FOUND)
    else:
        return Response({'detail': 'Invalid token'}, status=status.HTTP_401_UNAUTHORIZED)

    try:
        product = Product.objects.get(pk=pk)
    except Product.DoesNotExist:
        return Response({'detail': 'Product not found'}, status=status.HTTP_404_NOT_FOUND)

    if request.method == 'GET':
        serializer = ProductSerializer(product)
        return Response(serializer.data)

    elif request.method in ['PUT', 'PATCH']:
        permission_classes = [CanUpdateProduct | IsSuperUser]
        for permission in permission_classes:
            if not permission().has_object_permission(request, None, product):
                return Response({'detail': 'You do not have permission to perform this action'}, status=status.HTTP_403_FORBIDDEN)

        serializer = ProductSerializer(product, data=request.data, context={'request': request}, partial=request.method == 'PATCH')
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    elif request.method == 'DELETE':
        permission_classes = [CanDeleteProduct | IsSuperUser]
        for permission in permission_classes:
            if not permission().has_object_permission(request, None, product):
                return Response({'detail': 'You do not have permission to perform this action'}, status=status.HTTP_403_FORBIDDEN)

        product.delete()
        return Response({'detail': 'Product deleted'}, status=status.HTTP_204_NO_CONTENT)


@api_view(['GET'])
@permission_classes([IsAuthenticated])
def get_product_count(request):
    product_count = Product.objects.count()
    return Response({'product_count': product_count})


@api_view(['GET'])
@permission_classes([IsAuthenticated])
def get_product_count_within_range(request):

    start_date = request.query_params.get('start_date')
    end_date = request.query_params.get('end_date')

    start_date = timezone.make_aware(datetime.strptime(start_date, '%Y-%m-%d'))
    end_date = timezone.make_aware(datetime.strptime(end_date, '%Y-%m-%d'))
    product_count = Product.objects.filter(creation_date__range=(start_date, end_date)).count()
    return Response({'product_count_within_range': product_count})


@api_view(['GET'])
@permission_classes([IsAuthenticated])
def get_monthly_product_count(request):
    monthly_product_count = Product.objects.annotate(month=ExtractMonth('creation_date')).values('month').annotate(count=Count('id')).order_by('month')
    return Response({'monthly_product_count': monthly_product_count})