# Generated by Django 4.2.4 on 2024-04-18 13:10

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('projects', '0003_rename_name_project_projectname'),
    ]

    operations = [
        migrations.AddField(
            model_name='project',
            name='creation_date',
            field=models.DateTimeField(auto_now_add=True, null=True),
        ),
    ]