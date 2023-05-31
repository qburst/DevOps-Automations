# Google Cloud-Run Docker 

This workflow build and push a Docker container to Google Artifact Registry and deploy it on Cloud Run when a release is triggered.
It also tests each deployment for a working url and deployed image version.

## Overview:
 1. Authenticate to Google Cloud
 2. Authenticate Docker to Artifact Registry
 3. Build a docker container
 4. Publish it to Google Artifact Registry
 5. Deploy it to Cloud Run Staging environment
 6. Test Staging
 7. Wait for Approval
 8. Deploy to production Environment
 9. Test production 


## To configure this workflow:


 1. Ensure the required Google Cloud APIs are enabled:

   Cloud Run            run.googleapis.com
   Artifact Registry    artifactregistry.googleapis.com

 2. Create and configure Workload Identity Federation for GitHub (https://github.com/google-github-actions/auth#setting-up-workload-identity-federation)

 3. Ensure the required IAM permissions are granted

   Cloud Run
      roles/run.admin
      roles/iam.serviceAccountUser     (to act as the Cloud Run runtime service account)

    Artifact Registry
      roles/artifactregistry.admin     (project or repository level)

    NOTE: You should always follow the principle of least privilege when assigning IAM roles

 4. Create GitHub secrets for WIF_PROVIDER and WIF_SERVICE_ACCOUNT

 5. Configure two environments "dev" and "prod" each with values for PROJECT_ID, GAR_LOCATION, SERVICE, REGION and APP_URL environment variables
    Select the "Required reviewers" option for "prod" environment and Specify people or teams that may approve workflow runs when they access this environment.

    NOTE: To use Google Container Registry instead, replace ${{ env.GAR_LOCATION }}-docker.pkg.dev with gcr.io

