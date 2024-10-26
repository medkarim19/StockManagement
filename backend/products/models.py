from django.db import models

class Product(models.Model):
    name = models.CharField(max_length=100, unique=True)
    reference = models.CharField(max_length=50, null=True, default=None)
    category = models.CharField(max_length=50, null=True, default=None)
    description = models.TextField(null=True, default=None)
    project_id = models.IntegerField(null=True, default=None)  
    creator_id = models.IntegerField(null=True, default=None)  
    modifier_id = models.IntegerField(null=True, default=None)
    creation_date = models.DateTimeField(auto_now_add=True)
    last_modified_date = models.DateTimeField(auto_now=True)
    previous_project_id = models.IntegerField(null=True, blank=True)
    change_date = models.DateTimeField(null=True, blank=True)
    change_reason = models.TextField(null=True, blank=True)
    quantity = models.IntegerField(default=0)
    def __str__(self):
        return self.name
