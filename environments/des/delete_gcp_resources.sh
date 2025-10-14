#!/bin/bash

# Script to delete GCP resources in defined order
gcloud -q storage buckets delete gs://bck-eusw1-des-pgoum-frontend-01 gs://bck-eusw1-des-pgoum-carto-01/ gs://bck-eusw1-des-pgoum-carto-02/
gcloud -q container clusters delete gke-eusw1-des-pgoum-carto-01 --zone europe-southwest1
gcloud -q artifacts repositories delete art-eusw1-des-pgoum-repository-01 --location=europe-southwest1
gcloud -q sql instances delete sql-eusw1-des-pgoum-carto-01
gcloud -q compute forwarding-rules delete psc-eusw1-des-pgoum-carto-01 --region=europe-southwest1
gcloud -q compute addresses delete psc-eusw1-des-pgoum-carto-01-ip --region=europe-southwest1

