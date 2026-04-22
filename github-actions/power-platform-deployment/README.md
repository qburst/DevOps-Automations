# Power Platform Automated ALM (CI/CD)

This repository contains the automated Application Lifecycle Management (ALM) pipelines for our Microsoft Power Platform assets. It utilizes GitHub Actions to enforce version control, peer reviews, and governed deployments across all environments.

## Architecture Overview

Our deployment lifecycle is broken down into three governed phases:
1. **Phase 1: Automated Asset Capture** (Dev → GitHub)
2. **Phase 2: Version Control & Peer Review** (Feature Branch → Main)
3. **Phase 3: Governed Deployments** (GitHub → UAT/Prod)

---

## Prerequisites & Setup
Before running these pipelines, the repository must be configured with the proper Microsoft Entra ID (Service Principal) credentials and environment protections.

### 1. Repository Secrets
Navigate to **Settings > Secrets and variables > Actions** and add the following:
* `POWER_PLATFORM_TENANT_ID`: Your Microsoft tenant ID.
* `POWER_PLATFORM_SPN_APP_ID`: The Client ID of your registered App/Bot.
* `POWER_PLATFORM_SPN_SECRET`: The Client Secret for authentication.
* `DEV_ENVIRONMENT_URL`: The URL of the Development environment (e.g., `https://orgdev.crm.dynamics.com`).
* `UAT_ENVIRONMENT_URL`: The URL of the UAT environment.

### 2. Environment Protection Rules
To enforce manual deployment approvals:
1. Go to **Settings > Environments**.
2. Create an environment named `UAT`.
3. Check **Required reviewers** and assign the Release Manager or QA lead.

---

## The 3-Phase Workflow

### Phase 1: Automated Asset Capture
*Extracts the raw visual apps/flows into readable source code.*

1. Navigate to the **Actions** tab in GitHub.
2. Select the **1 - Export and Unpack to Branch** workflow.
3. Click **Run workflow**.
4. Enter the **Solution Name** (e.g., `HRApp`) and a new **Branch Name** (e.g., `feature/update-hr-forms`).
5. **What happens:** The pipeline connects to Dev, exports the unmanaged solution, extracts it into readable XML/JSON files, and safely pushes it to your new feature branch.

### Phase 2: Version Control & Peer Review
*Ensures code quality and prevents accidental deployments.*

1. Go to the **Pull Requests** tab.
2. Open a Pull Request from your feature branch (e.g., `feature/update-hr-forms`) into the `main` branch.
3. Assign a team member to review the unpacked source files.
4. Once the code is approved, click **Merge Pull Request**.

### Phase 3: Governed Deployments
*Automated, zero-touch deployment to higher environments requiring management sign-off.*

1. Merging the Pull Request in Phase 2 **automatically triggers** the deployment pipeline (`2 - Build, Pack, and Deploy to UAT`).
2. **The Build:** The pipeline zips the approved source code into a locked, `Managed` solution artifact.
3. **The Governance Pause:** The pipeline halts and waits for a human. The assigned Release Manager will receive a notification to review the deployment.
4. **The Deployment:** Once the Release Manager clicks **Approve** in the GitHub UI, the pipeline resumes and imports the Managed solution into the UAT environment.
