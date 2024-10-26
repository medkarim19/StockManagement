from rest_framework import serializers
from rest_framework.exceptions import ValidationError
from .models import Product
from users.models import User
from orders.models import OrderItem  # Import the OrderItem model
from django.db import transaction
from django.utils import timezone

class ProductSerializer(serializers.ModelSerializer):
    creator_username = serializers.SerializerMethodField()
    modifier_username = serializers.SerializerMethodField()

    class Meta:
        model = Product
        fields = '__all__'

    def get_creator_username(self, obj):
        creator_id = obj.creator_id
        try:
            user = User.objects.get(id=creator_id)
            return user.username
        except User.DoesNotExist:
            return None

    def get_modifier_username(self, obj):
        modifier_id = obj.modifier_id
        try:
            user = User.objects.get(id=modifier_id)
            return user.username
        except User.DoesNotExist:
            return None

    def create(self, validated_data):
        productName = validated_data.get('name')
        quantity = validated_data.get('quantity')

        # Retrieve the quantity for the specified product name
        try:
            order_item = OrderItem.objects.get(productName=productName)
            order_quantity = order_item.quantity
        except OrderItem.DoesNotExist:
            raise serializers.ValidationError({'error': 'No matching product name'})

        # Compare the retrieved quantity with the submitted quantity
        if order_quantity != quantity:
            raise serializers.ValidationError({'error': 'No matching quantity for the specified product name'})

        # Create the product
        product = Product.objects.create(**validated_data)

        # Delete the order item with the same product name
        order_item.delete()

        return product

    def update(self, instance, validated_data):
        user_id = self.context['request'].user.id
        instance.modifier_id = user_id
        instance.change_date = timezone.now()

        previous_project_id = instance.project_id

        instance = super().update(instance, validated_data)

        instance.previous_project_id = previous_project_id
        instance.project_id = validated_data.get('project_id', instance.project_id)

        instance.save()

        return instance

class AssignProductSerializer(serializers.ModelSerializer):
    class Meta:
        model = Product
        fields = ['id', 'name', 
                  'creation_date', 'last_modified_date',
                'change_date', 
                  'creator_id', 'project_id']

