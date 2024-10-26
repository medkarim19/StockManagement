import subprocess
import redis
from .permissions import IsSuperUser
from rest_framework.decorators import api_view, permission_classes
from rest_framework.permissions import IsAuthenticated
from django.http import JsonResponse

@api_view(['POST'])
@permission_classes([IsSuperUser, IsAuthenticated])
def backup_database(request):
    redis_client = redis.StrictRedis(host='localhost', port=6379, db=0)
    backup_file = 'backup.sql'
    subprocess.run(['mysqldump', '-u', 'root', '-proot', 'pfa'], stdout=open(backup_file, 'wb'))
    with open(backup_file, 'rb') as file:
        backup_content = file.read()
    redis_client.set('backup', backup_content)
    return JsonResponse({'message': 'Backup completed successfully'})

@api_view(['POST'])
@permission_classes([IsSuperUser, IsAuthenticated])
def restore_database(request):
    redis_client = redis.StrictRedis(host='localhost', port=6379, db=0)
    backup_content = redis_client.get('backup')
    backup_file = 'backup.sql'
    with open(backup_file, 'wb') as file:
        file.write(backup_content)

    subprocess.Popen(['mysql', '-u', 'root', '-proot', 'test'], stdin=subprocess.PIPE, stdout=subprocess.PIPE, stderr=subprocess.PIPE).communicate(input=backup_content)
    return JsonResponse({'message': 'Restore completed successfully'})
