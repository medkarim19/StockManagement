from django.urls import path
from .views import project_list, delete_project, create_project, get_project_count, get_project_count_within_range, get_monthly_project_count

urlpatterns = [
    path('projects/', project_list, name='project_list'),
    path('projects/create', create_project, name='create_project'),
    path('projects/delete/<int:pk>/', delete_project, name='delete_project'),
    path('projects/count', get_project_count, name='get_project_count'),
    path('projects/count_within_range/', get_project_count_within_range, name='get_project_count_within_range' ),
    path('projects/monthly_project_count/',get_monthly_project_count, name='get_monthly_project_count'),
]