#!/bin/bash

cd /ssd2/application/nf-tower/tower-backend/build/distributions
unzip tower-backend-20.06.0.zip
cd tower-backend-20.06.0/bin/
nohup ./tower-backend > tower-backend.log 2>&1 &