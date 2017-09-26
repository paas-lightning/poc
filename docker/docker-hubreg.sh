# Create the Docker Hub Registry Secret
kubectl create secret docker-registry dockerhubreg --docker-username=kub-poc --docker-password=secret --docker-email=me@local

