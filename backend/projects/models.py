# projects/models.py
from django.db import models

class Project(models.Model):
    projectName = models.CharField(max_length=100)
    description = models.TextField()
    creation_date = models.DateTimeField(auto_now_add=True, null=True)


    def __str__(self):
        return self.name
