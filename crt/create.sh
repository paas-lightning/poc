openssl genrsa -out server.key 1024
# req -x509 -newkey rsa:4096 -keyout key.pem -out cert.pem -days 730
openssl req -new -key server.key -out server.csr
# subject=/C=FR/ST=IDF/L=Paris/O=Banque De France/OU=2118/CN=Eclair
openssl x509 -req -days 366 -in server.csr -signkey server.key -out server.crt

# Now add the below lines into your apache conf and ensure ssl is enabled
# SSLCertificateFile /path/to/ssl/server.crt 
# SSLCertificateKeyFile /path/to/ssl/server.key 
