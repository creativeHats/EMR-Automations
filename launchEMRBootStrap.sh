#!/bin/bash
set -xe

sudo mkdir /opt/jars
sudo chmod -R 777 /opt/jars
aws s3 cp s3://<>/jars/postgresql-42.2.5.jar /opt/jars
aws s3 cp s3://<>/jars/mysql-connector-java-5.1.47.jar /opt/jars

sudo mkdir /opt/scripts
sudo chmod -R 777 /opt/scripts
aws s3 cp s3://<>/PythonFiles/AppGraph_AppOpen.py /opt/scripts
aws s3 cp s3://<>/PythonFiles/AppGraph_AppPurchase.py /opt/scripts
aws s3 cp s3://<>/PythonFiles/AppGraph_AppPresence.py /opt/scripts
aws s3 cp s3://<>/PythonFiles/AppGraph_AppPresence_s3_pg.py /opt/scripts
aws s3 cp s3://<>/PythonFiles/DBConfig.py /opt/scripts
aws s3 cp s3://<>/PythonFiles/DBHelper.py /opt/scripts
aws s3 cp s3://<>/PythonFiles/db_properties.ini /opt/scripts
aws s3 cp s3://<>/PythonFiles/styx.py /opt/scripts

sudo chmod -R 777 /opt/scripts/*
sudo chmod -R 777 /opt/jars/*


sudo pip install -U configparser
sudo pip install -U psycopg2-binary
