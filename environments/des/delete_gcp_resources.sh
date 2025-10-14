#!/bin/bash

# Script to delete GCP resources in defined order
gcloud -q storage buckets delete gs://pgoum-frontend gs://carto-import-storage-bucket/ gs://carto-thumbnails-storage-bucket/
gcloud -q container clusters delete dev-carto-gke --zone europe-southwest1
gcloud -q artifacts repositories delete backend-image-repository --location=europe-southwest1
gcloud -q sql instances delete carto-des-environment
gcloud -q compute forwarding-rules delete cloudsql-psc-endpoint --region=europe-southwest1
gcloud -q compute addresses delete cloudsql-psc-endpoint-ip --region=europe-southwest1

