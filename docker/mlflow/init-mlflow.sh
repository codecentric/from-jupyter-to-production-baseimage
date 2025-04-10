#!/bin/bash

# Default values for local storage
DEFAULT_BACKEND_STORE_URI="sqlite:///mlflow.db"
MLFLOW_PORT=5001

# Check for the presence of environment variables and set them if provided
if [ -n "$MLFLOW_DB_URI" ]; then
  BACKEND_STORE_URI=$MLFLOW_DB_URI
else
  BACKEND_STORE_URI=$DEFAULT_BACKEND_STORE_URI
fi

if [ -n "$MLFLOW_ARTIFACT_ROOT" ]; then
  ARTIFACT_ROOT=$MLFLOW_ARTIFACT_ROOT
  mlflow server --backend-store-uri $BACKEND_STORE_URI --default-artifact-root $ARTIFACT_ROOT --host 0.0.0.0 --port $MLFLOW_PORT
else
  mlflow server --backend-store-uri $BACKEND_STORE_URI --host 0.0.0.0 --port $MLFLOW_PORT
fi

