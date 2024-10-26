from rest_framework.permissions import BasePermission

class CanCreateProduct(BasePermission):
    def has_permission(self, request, view):
        if hasattr(request.user, 'permission_level'):
            return request.user.permission_level in ['Editor', 'Create', 'Edit', 'Refine']
        return False

class CanUpdateProduct(BasePermission):
    def has_object_permission(self, request, view, obj):
        if hasattr(request.user, 'permission_level'):
            return request.user.permission_level in ['Editor', 'Refine', 'Modify', 'Emend']
        return False

class CanDeleteProduct(BasePermission):
    def has_object_permission(self, request, view, obj):
        if hasattr(request.user, 'permission_level'):
            return request.user.permission_level in ['Editor', 'Delete', 'Edit', 'Emend']
        return False

class CanViewProduct(BasePermission):
    def has_object_permission(self, request, view, obj):
        if hasattr(request.user, 'permission_level'):
            return request.user.permission_level in ['Editor', 'Viewer', 'Edit', 'Delete', 'Create', 'Modify', 'Refine', 'Emend']
        return False

class IsSuperUser(BasePermission):
    """
    Allows access only to superusers.
    """

    def has_permission(self, request, view):
        return request.user and request.user.is_superuser
