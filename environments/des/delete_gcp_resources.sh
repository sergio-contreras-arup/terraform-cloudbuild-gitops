#!/bin/bash

# Script to delete GCP resources in defined order

gcloud container clusters delete dev-carto-gke --zone europe-southwest1
gcloud artifacts repositories delete backend-image-repository --location=europe-southwest1
gcloud compute routers nats delete gke-nat --region=europe-southwest1 --router="gke-nat-router"
gcloud compute networks subnets delete gke-subnet-eu-west1 --region=europe-southwest1
gcloud compute routers delete gke-nat-router --region=europe-southwest1
gcloud compute addresses delete gke-vpc-private-ip-alloc # Seleccionar global
gcloud compute networks delete gke-vpc
