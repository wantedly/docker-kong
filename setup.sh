#!/bin/sh

# Setting params from environment
DNS_RESOLVER=${DNS_RESOLVER:-dnsmasq}
DNS_IP=${DNS_IP:-127.0.0.1}
DNS_PORT=${DNS_PORT:-8053}
DNSMASQ_PORT=${DNSMASQ_PORT:-8053}
CLUSTER_IP=${CLUSTER_IP:-0.0.0.0}
CLUSTER_PORT=${CLUSTER_PORT:-7946}
ADVERTISE_IP=${ADVERTISE_IP:-}
ADBERTISE_PORT=${ADBERTISE_PORT:-}
DATABASE=${DATABASE:-cassandra}
POSTGRES_HOST=${POSTGRES_HOST:-kong-database}
POSTGRES_PORT=${POSTGRES_PORT:-5432}
POSTGRES_DATABASE=${POSTGRES_DATABASE:-kong}
POSTGRES_USER=${POSTGRES_USER:-kong}
POSTGRES_PASSWORD=${POSTGRES_PASSWORD:-}
CASSANDRA_CONTACT_POINTS_HOST=${CASSANDRA_CONTACT_POINTS_HOST:-kong-database}
CASSANDRA_CONTACT_POINTS_PORT=${CASSANDRA_CONTACT_POINTS_PORT:-9042}
CASSANDRA_PORT=${CASSANDRA_PORT:-9042}
CASSANDRA_KEYSPACE=${CASSANDRA_KEYSPACE:-kong}
CASSANDRA_TIMEOUT=${CASSANDRA_TIMEOUT:-5000}
CASSANDRA_REPLICATION_STRATEGY=${CASSANDRA_REPLICATION_STRATEGY:-SimpleStrategy}
CASSANDRA_REPLICATION_FACTOR=${CASSANDRA_REPLICATION_FACTOR:-1}
CASSANDRA_DATA_CENTERS_DC1=${CASSANDRA_DATA_CENTERS_DC1:-2}
CASSANDRA_DATA_CENTERS_DC2=${CASSANDRA_DATA_CENTERS_DC2:-3}
CASSANDRA_CONSISTENCY=${CASSANDRA_CONSISTENCY:-ONE}
CASSANDRA_SSL_ENABLED=${CASSANDRA_SSL_ENABLED:-false}
CASSANDRA_SSL_VERIFY=${CASSANDRA_SSL_VERIFY:-false}
CASSANDRA_SSL_CERTIFICATE_AUTHORITY=${CASSANDRA_SSL_CERTIFICATE_AUTHORITY:-} # ex. export CASSANDRA_SSL_CERTIFICATE_AUTHORITY="\/path\/to\/user\.pem"
CASSANDRA_USERNAME=${CASSANDRA_USERNAME:-cassandra}
CASSANDRA_PASSWORD=${CASSANDRA_PASSWORD:-cassandra}

# Setting up the dns resolber in kubernetes
sed -i "s/DNS_RESOLVER/$DNS_RESOLVER/g" /etc/kong/kong.yml
sed -i "s/DNS_IP/$DNS_IP/g" /etc/kong/kong.yml
sed -i "s/DNS_PORT/$DNS_PORT/g" /etc/kong/kong.yml
sed -i "s/DNSMASQ_PORT/$DNSMASQ_PORT/g" /etc/kong/kong.yml

# Setting up the cluster in kubernetes
sed -i "s/CLUSTER_IP/$CLUSTER_IP/g" /etc/kong/kong.yml
sed -i "s/CLUSTER_PORT/$CLUSTER_PORT/g" /etc/kong/kong.yml
if [ -n "$ADVERTISE_IP" ] && [ -n "$ADBERTISE_PORT" ]; then
  sed -i "s/ADVERTISE_IP/$ADVERTISE_IP/g" /etc/kong/kong.yml
  sed -i "s/ADBERTISE_PORT/$ADBERTISE_PORT/g" /etc/kong/kong.yml
else
  sed -i "s/cluster://g" /etc/kong/kong.yml
  sed -i "s/advertise: \"ADVERTISE_IP\:ADBERTISE_PORT\"//g" /etc/kong/kong.yml
fi

# Setting up the postgres
sed -i "s/POSTGRES_HOST/$POSTGRES_HOST/g" /etc/kong/kong.yml
sed -i "s/POSTGRES_PORT/$POSTGRES_PORT/g" /etc/kong/kong.yml
sed -i "s/POSTGRES_DATABASE/$POSTGRES_DATABASE/g" /etc/kong/kong.yml
sed -i "s/POSTGRES_USER/$POSTGRES_USER/g" /etc/kong/kong.yml
sed -i "s/POSTGRES_PASSWORD/$POSTGRES_PASSWORD/g" /etc/kong/kong.yml

# Setting up the cassandra
sed -i "s/CASSANDRA_CONTACT_POINTS_HOST/$CASSANDRA_CONTACT_POINTS_HOST/g" /etc/kong/kong.yml
sed -i "s/CASSANDRA_CONTACT_POINTS_PORT/$CASSANDRA_CONTACT_POINTS_PORT/g" /etc/kong/kong.yml
sed -i "s/CASSANDRA_PORT/$CASSANDRA_PORT/g" /etc/kong/kong.yml
sed -i "s/CASSANDRA_KEYSPACE/$CASSANDRA_KEYSPACE/g" /etc/kong/kong.yml
sed -i "s/CASSANDRA_TIMEOUT/$CASSANDRA_TIMEOUT/g" /etc/kong/kong.yml
sed -i "s/CASSANDRA_REPLICATION_STRATEGY/$CASSANDRA_REPLICATION_STRATEGY/g" /etc/kong/kong.yml
sed -i "s/CASSANDRA_REPLICATION_FACTOR/$CASSANDRA_REPLICATION_FACTOR/g" /etc/kong/kong.yml
sed -i "s/CASSANDRA_DATA_CENTERS_DC1/$CASSANDRA_DATA_CENTERS_DC1/g" /etc/kong/kong.yml
sed -i "s/CASSANDRA_DATA_CENTERS_DC2/$CASSANDRA_DATA_CENTERS_DC2/g" /etc/kong/kong.yml
sed -i "s/CASSANDRA_CONSISTENCY/$CASSANDRA_CONSISTENCY/g" /etc/kong/kong.yml
sed -i "s/CASSANDRA_SSL_ENABLED/$CASSANDRA_SSL_ENABLED/g" /etc/kong/kong.yml
sed -i "s/CASSANDRA_SSL_VERIFY/$CASSANDRA_SSL_VERIFY/g" /etc/kong/kong.yml
if [ -n "$CASSANDRA_SSL_CERTIFICATE_AUTHORITY" ]; then
  sed -i "s/CASSANDRA_SSL_CERTIFICATE_AUTHORITY/$CASSANDRA_SSL_CERTIFICATE_AUTHORITY/g" /etc/kong/kong.yml
else
  sed -i "s/certificate_authority: \"CASSANDRA_SSL_CERTIFICATE_AUTHORITY\"//g" /etc/kong/kong.yml
fi
sed -i "s/CASSANDRA_USERNAME/$CASSANDRA_USERNAME/g" /etc/kong/kong.yml
sed -i "s/CASSANDRA_PASSWORD/$CASSANDRA_PASSWORD/g" /etc/kong/kong.yml

# Setting up the proper database
sed -i "s/DATABASE/$DATABASE/g" /etc/kong/kong.yml
