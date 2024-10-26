from django.urls import path
from .views import register_view, CustomTokenObtainPairView, LogoutAndBlacklistRefreshTokenForUserView, \
    user_detail, UserDetailsView, MyTokenRefreshView, EmailAPI, ConfirmationView, get_user_count, get_user_count_within_range, get_regular_user_count, get_staff_user_count, get_user_list, create_user

urlpatterns = [
    path('login/', CustomTokenObtainPairView.as_view()),
    path('login/refresh/', MyTokenRefreshView.as_view()),
    path('logout/', LogoutAndBlacklistRefreshTokenForUserView.as_view()),
    path('register/', register_view),
    path('users/', get_user_list),
    path('users/create', create_user),
    path('users/<int:pk>/', user_detail),
    path('users/details/', UserDetailsView.as_view()),
    path('users/count/', get_user_count),
    path('users/count_within_range/', get_user_count_within_range),
    path('users/count_regular_user/', get_regular_user_count),
    path('users/count_staff_user/', get_staff_user_count),
    path('email/', EmailAPI.as_view(), name='email_api'),
    path('confirmation/', ConfirmationView.as_view(), name='confirmation_view'),
]
