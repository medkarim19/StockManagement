from rest_framework.decorators import api_view, permission_classes
from rest_framework.response import Response
from rest_framework import status
from .models import Project
from .serializers import ProjectSerializer
from orders.serializers import OrderSerializer
from rest_framework.permissions import IsAdminUser, IsAuthenticated
from .permissions import IsSuperUser
from django.utils import timezone
from datetime import datetime

@api_view(['GET'])
@permission_classes([IsAuthenticated])
def project_list(request):
    projects = Project.objects.all()
    serializer = ProjectSerializer(projects, many=True)
    return Response(serializer.data)

    
@api_view(['POST'])
@permission_classes([IsAdminUser, IsAuthenticated])
def create_project(request):
    project_serializer = ProjectSerializer(data=request.data)
    if project_serializer.is_valid():
        project = project_serializer.save()

        order_items_data = request.data.get('orderItems', [])  # Ensure correct key
        supplier_name = request.data.get('supplierName', 'Default Supplier')  # Default value if supplierName is not provided

        order_serializer = OrderSerializer(data={
            'project': project.id,
            'supplier': supplier_name,
            'status': 'ordered'
        }, context={'order_items': order_items_data})
        
        if order_serializer.is_valid():
            order_serializer.save()
            return Response({'project': project_serializer.data, 'order': order_serializer.data}, status=status.HTTP_201_CREATED)

    return Response({'detail': 'Invalid data'}, status=status.HTTP_400_BAD_REQUEST)

@api_view(['DELETE'])
@permission_classes([IsAdminUser, IsAuthenticated])
def delete_project(request, pk):
    try:
        project = Project.objects.get(pk=pk)
    except Project.DoesNotExist:
        return Response({'detail': 'Project not found'}, status=status.HTTP_404_NOT_FOUND)

    if request.method == 'DELETE':
        project.delete()
        return Response({'detail': 'Project deleted'}, status=status.HTTP_204_NO_CONTENT)



@api_view(['GET'])
@permission_classes([IsAuthenticated])
def get_project_count(request):
    project_count = Project.objects.count()
    return Response({'project_count': project_count})


@api_view(['GET'])
@permission_classes([IsAuthenticated])
def get_project_count_within_range(request):

    start_date = request.query_params.get('start_date')
    end_date = request.query_params.get('end_date')

    start_date = timezone.make_aware(datetime.strptime(start_date, '%Y-%m-%d'))
    end_date = timezone.make_aware(datetime.strptime(end_date, '%Y-%m-%d'))
    project_count = Project.objects.filter(creation_date__range=(start_date, end_date)).count()
    return Response({'project_count_within_range': project_count})


@api_view(['GET'])
@permission_classes([IsAuthenticated])
def get_monthly_project_count(request):
    monthly_project_count = Project.objects.annotate(month=ExtractMonth('creation_date')).values('month').annotate(count=Count('id')).order_by('month')
    return Response({'monthly_project_count': monthly_project_count})
