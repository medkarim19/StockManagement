from django.db import models
from projects.models import Project  # Import the Project model

class Order(models.Model):
    project = models.ForeignKey(Project, on_delete=models.CASCADE)
    supplier = models.CharField(max_length=100)
    status = models.CharField(max_length=20, default='ordered')
    created_at = models.DateTimeField(auto_now_add=True)

class OrderItem(models.Model):
    order = models.ForeignKey(Order, related_name='order_items', on_delete=models.CASCADE)
    productName = models.CharField(max_length=100)
    quantity = models.IntegerField()
