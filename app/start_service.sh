#!/bin/bash

# Wait for SPIFFE Helper to provision TLS certificates
echo "Waiting for SPIFFE certificates in /certs ..."
while [ ! -f /certs/svid_key.pem ] || [ ! -f /certs/svid.pem ] || [ ! -f /certs/bundle.pem ]; do
    sleep 1
done
echo "Certificates ready."

if [ ! -d "./vendor" ]; then
    composer install
fi

if [ ! -f "./vendor/bin/rr_server" ]; then
    php spark burner:init RoadRunner
fi

php spark burner:start
