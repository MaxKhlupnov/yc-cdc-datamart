
# Создание кластера
yc managed-kafka cluster create --folder-id=<my-folder-id> --zone-ids ru-central1-a --brokers-count 1 \
--unmanaged-topics --network-name main \
inventory-cluster
# Добавляем админа
yc managed-kafka user create --cluster-name inventory-cluster --password=pass@word1 --permission topic="*",role=ACCESS_ROLE_ADMIN admin