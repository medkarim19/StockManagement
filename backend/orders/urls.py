from django.urls import path
from .views import order_list, get_order_count, get_order_count_within_range, get_monthly_order_count

urlpatterns = [
    path('orders/', order_list, name='order_list'),
    path('orders/count/', get_order_count, name='get_order_count'),
    path('orders/count_within_range/', get_order_count_within_range, name='get_order_count_within_range'),
    path('orders/monthly_order_count/', get_monthly_order_count, name='get_monthly_order_count'),
    
]
