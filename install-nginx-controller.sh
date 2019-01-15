## Install OS
sudo yum update 
sudo yum install -y epel-release
sudo yum install -y jq
sudo yum install vim-enhanced


## Docker Install
sudo yum remove docker docker-common docker-selinux docker-engine
sudo yum install -y yum-utils device-mapper-persistent-data lvm2
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
# sudo yum-config-manager --enable docker-ce-test
sudo yum install docker-ce
sudo systemctl start docker
DOCKER_HOST=192.168.0.6
DOCKER=$DOCKER_HOST:5000
alias docker="sudo docker -H $DOCKER"

sudo yum install -y wget





GCLOUD=google-cloud-sdk-172.0.1-linux-x86_64.tar.gz
wget https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/$GCLOUD
tar -xvf $GCLOUD
./google-cloud-sdk/install.sh



## GCloud Install
sudo tee -a /etc/yum.repos.d/google-cloud-sdk.repo << EOM
[google-cloud-sdk]
name=Google Cloud SDK
baseurl=https://packages.cloud.google.com/yum/repos/cloud-sdk-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg
       https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOM









sudo yum -y install google-cloud-sdk

## NGinx Controller
NGINX_CONTROLLER=/home/centos/paas-lightning/kubernetes-ingress/nginx-controller
cd $NGINX_CONTROLLER
make clean
sudo make TAG=latest 





### If you have the following Error: 
```gcloud docker -- push gcr.io/my-k8s-project/nginx-ingress:latest
ERROR: (gcloud.docker) You do not currently have an active account selected.
```

### gcloud asks an auth login : gcloud auth login
Result:
```You are now logged in as [mahyar.sepehr@gmail.com].
Your current project is [toto].  You can change this setting by running:
  $ gcloud config set project PROJECT_ID
```

