from rest_framework.decorators import api_view, permission_classes
from rest_framework.response import Response
from rest_framework import status
from .models import Order
from django.db.models.functions import ExtractMonth
from .serializers import OrderSerializer, OrderItemSerializer
from rest_framework.permissions import IsAuthenticated, IsAdminUser
from django.db.models import Count
from django.utils import timezone
from datetime import datetime


@api_view(['GET'])
@permission_classes([IsAdminUser, IsAuthenticated])
def order_list(request):
    orders = Order.objects.annotate(item_count=Count('order_items'))
    serialized_orders = []

    for order in orders:
        if order.item_count == 0:
            # Update the status to 'delivered' if the order_items count is 0
            order.status = 'delivered'
            order.save()

        order_data = OrderSerializer(order).data
        order_data['order_items'] = OrderItemSerializer(order.order_items.all(), many=True).data
        serialized_orders.append(order_data)

    return Response(serialized_orders)

@api_view(['GET'])
@permission_classes([IsAdminUser, IsAuthenticated])
def get_order_count(request):
    order_count = Order.objects.count()
    return Response({'order_count': order_count})


@api_view(['GET'])
@permission_classes([IsAuthenticated])
def get_order_count_within_range(request):

    start_date = request.query_params.get('start_date')
    end_date = request.query_params.get('end_date')

    start_date = timezone.make_aware(datetime.strptime(start_date, '%Y-%m-%d'))
    end_date = timezone.make_aware(datetime.strptime(end_date, '%Y-%m-%d'))
    order_count = Order.objects.filter(created_at__range=(start_date, end_date)).count()
    return Response({'order_count_within_range': order_count})


@api_view(['GET'])
@permission_classes([IsAuthenticated])
def get_monthly_order_count(request):
    monthly_order_count = Order.objects.annotate(month=ExtractMonth('created_at')).values('month').annotate(count=Count('id')).order_by('month')
    return Response({'monthly_order_count': monthly_order_count})