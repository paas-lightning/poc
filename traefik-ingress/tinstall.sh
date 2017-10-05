
set -x


traefik_version="v1.4.0-rc4/traefik_linux-amd64"

wget https://github.com/containous/traefik/releases/download/$traefik_version



if [ -f traefik_linux-amd64 ];
then
	mv traefik_linux-amd64 traefik
	chmod u+x traefik
else
        echo "An error occured when downloading the $traefik_version traefik version. Exiting..."
        exit 1
fi


