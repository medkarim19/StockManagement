from django.urls import path
from .views import product_list, product_detail, get_product_count, get_product_count_within_range, get_monthly_product_count

urlpatterns = [
    path('products/', product_list, name='product_list'),
    path('products/create/', product_list, name='product_create'), 
    path('products/count/', get_product_count, name='get_product_count'),
    path('products/count_within_range/', get_product_count_within_range, name='get_product_count_within_range'),
    path('products/monthly_product_count/', get_monthly_product_count, name='get_monthly_product_count'),
    path('products/<int:pk>/', product_detail, name='product_detail'),
]
