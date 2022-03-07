#!/bin/sh

#
# This script create the Solr indexes for a cassandra table.
#
# Arguments :
# - SOLR_HOST=Solr search node IP address or hostname.
# - SOLR_PORT=Solr search node port.
# - SOLR_CONFIG=Solr configuration file
# - SOLR_SCHEMA=SOLR_SCHEMA=Index schema
# - CASSANDRA_KEYSPACE=Cassandra keyspace
# - CASSANDRA_TABLE=Cassandra Table name
#

echo "Installing the Solr schema..."
if [ $# != 6 ] 
 then
    echo "Arguments: [SOLR_HOST] [SOLR_PORT] [SOLR_CONFIG] [SOLR_SCHEMA] [CASSANDRA_KEYSPACE] [CASSANDRA_TABLE]"
 	exit;
 fi
 
SOLR_HOST=127.0.0.1
SOLR_PORT=8983
SOLR_CONFIG=solrconfig.xml
SOLR_SCHEMA=schema.xml
CASSANDRA_KEYSPACE=keyspace
CASSANDRA_TABLE=table

if [ "$1" != "" ] 
 then
 	echo "Using SOLR_HOST=$1"
 	SOLR_HOST=$1;
 fi
 
 if [ "$2" != "" ] 
 then
 	echo "Using SOLR_PORT=$2"
 	SOLR_PORT=$2;
 fi
 
 if [ "$3" != "" ] 
 then
 	echo "Using SOLR_CONFIG=$3"
 	SOLR_CONFIG=$3;
 fi
 
 if [ "$4" != "" ] 
 then
 	echo "Using SOLR_SCHEMA=$4"
 	SOLR_SCHEMA=$4;
 fi
 
 if [ "$5" != "" ] 
 then
 	echo "Using CASSANDRA_KEYSPACE=$5"
 	CASSANDRA_KEYSPACE=$5;
 fi
 
 if [ "$6" != "" ] 
 then
 	echo "Using CASSANDRA_TABLE=$6"
 	CASSANDRA_TABLE=$6;
 fi
 
echo "Creating Solr configuration host=$SOLR_HOST, port=$SOLR_PORT with Cassandra keyspace=$CASSANDRA_KEYSPACE, table=$CASSANDRA_TABLE"; 

echo curl "http://$SOLR_HOST:$SOLR_PORT/solr/resource/$CASSANDRA_KEYSPACE.$CASSANDRA_TABLE/solrconfig.xml --data-binary @$SOLR_CONFIG -H 'Content-type:text/xml; charset=utf-8'"
curl http://$SOLR_HOST:$SOLR_PORT/solr/resource/$CASSANDRA_KEYSPACE.$CASSANDRA_TABLE/solrconfig.xml --data-binary @$SOLR_CONFIG -H 'Content-type:text/xml; charset=utf-8'
sleep 3

echo curl http://$SOLR_HOST:$SOLR_PORT/solr/resource/$CASSANDRA_KEYSPACE.$CASSANDRA_TABLE/schema.xml --data-binary @$SOLR_SCHEMA -H 'Content-type:text/xml; charset=utf-8'
curl http://$SOLR_HOST:$SOLR_PORT/solr/resource/$CASSANDRA_KEYSPACE.$CASSANDRA_TABLE/schema.xml --data-binary @$SOLR_SCHEMA -H 'Content-type:text/xml; charset=utf-8'
sleep 3

echo curl http://$SOLR_HOST:$SOLR_PORT/solr/admin/cores?action=CREATE&name=$CASSANDRA_KEYSPACE.$CASSANDRA_TABLE
curl "http://$SOLR_HOST:$SOLR_PORT/solr/admin/cores?action=CREATE&name=$CASSANDRA_KEYSPACE.$CASSANDRA_TABLE"

echo "Done."