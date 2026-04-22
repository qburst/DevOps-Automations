# Power Platform ALM — Setup from Scratch

This guide walks through creating a new GitHub repository, registering a Microsoft Entra ID service principal for GitHub Actions, granting access in Power Platform, and wiring secrets, environments, and branch protection. Complete these steps in order.

---

## Step 1: Create the GitHub repository

1. Log in to your GitHub account.
2. Click the **+** icon in the top-right corner and select **New repository**.
3. Name the repository (for example, `power-platform-alm`).
4. Select **Private** (recommended for company code).
5. Check **Add a README file** so the default branch (`main`) is created automatically.
6. Click **Create repository**.

---

## Step 2: Create the bot account (Microsoft Entra ID)

GitHub Actions needs a **service principal** (app identity) so it can authenticate to Microsoft without a human username and password.

1. Open the [Azure portal](https://portal.azure.com) and sign in with Microsoft admin credentials.
2. Search for **Microsoft Entra ID** and open it.
3. In the left menu, go to **App registrations** → **New registration**.
4. Enter a clear name (for example, `GitHub Actions Power Platform CI/CD`). Leave other settings as default and click **Register**.
5. On **Overview**, copy and save:
   - **Application (client) ID**
   - **Directory (tenant) ID**  
   You will map these to GitHub secrets in Step 4.
6. Create a client secret: **Certificates & secrets** → **New client secret**.
7. Add a description (for example, `GitHub Secret`) and set an expiration (for example, 12 months). Click **Add**.
8. **Critical:** Copy the secret **Value** immediately. It cannot be retrieved again after you leave the page. Store it with your other IDs.

---

## Step 3: Grant the bot access (Power Platform admin center)

Register the Entra ID application as an **application user** in each environment GitHub will touch (Development and UAT).

### Development environment

1. Open the [Power Platform admin center](https://admin.powerplatform.microsoft.com).
2. Go to **Environments** and select your **Development** environment.
3. Open **Settings** → **Users + permissions** → **Application users**.
4. Click **+ New app user**.
5. Click **+ Add an app** and select the Entra ID app you created in Step 2.
6. Under **Business unit**, select your main business unit.
7. Under **Security roles**, assign **System Administrator** (or a narrower role your organization approves for export/import).
8. Save.

### UAT environment

Repeat the same steps (**Application users** → new app user → same Entra app → business unit → security role → save) for your **UAT** environment.

---

## Step 4: Configure GitHub (secrets, environments, branch rules)

### A. Repository secrets

1. In the repository, open **Settings**.
2. Go to **Secrets and variables** → **Actions**.
3. Click **New repository secret** and add each of the following (names must match exactly):

| Secret name | Value |
|-------------|--------|
| `POWER_PLATFORM_TENANT_ID` | Directory (tenant) ID from Step 2 |
| `POWER_PLATFORM_SPN_APP_ID` | Application (client) ID from Step 2 |
| `POWER_PLATFORM_SPN_SECRET` | Client secret value from Step 2 |
| `DEV_ENVIRONMENT_URL` | Development Dataverse URL (for example, `https://orgdev.crm.dynamics.com`) |
| `UAT_ENVIRONMENT_URL` | UAT Dataverse URL (for example, `https://orguat.crm.dynamics.com`) |

### B. GitHub environments (approvals for UAT)

1. In **Settings**, open **Environments**.
2. Click **New environment**, name it **`Development`**, and configure (no reviewers required unless you want them). The export workflow references this environment name.
3. Click **New environment** again, name it **`UAT`**, and configure.
4. Enable **Required reviewers**.
5. Add the users or teams who may approve deployments to UAT (for example, your GitHub user for testing). Save protection rules.

### C. Protect the `main` branch (peer review)

1. In **Settings**, open **Rules** → **Rulesets** (or **Branches** → branch protection), depending on your GitHub UI.
2. Add a ruleset (or branch protection rule) that targets **`main`**.
3. Enable **Require a pull request before merging**.
4. Enable **Require approvals** and set the minimum (for example, **1**).
5. Save.

---

## Step 5: Add workflow files and documentation

GitHub Actions only runs workflows from **`.github/workflows/`** at the repository root.

1. Open the **Code** tab.
2. Add the workflow files (from this folder in source control, or paste their contents):

   | File in repo (this project) | Target path in your GitHub repo |
   |-------------------------------|----------------------------------|
   | `export-solution.yaml` | `.github/workflows/export-solution.yaml` |
   | `deploy-to-uat.yaml` | `.github/workflows/deploy-to-uat.yaml` |

   You may use `.yml` extensions instead if you prefer; GitHub accepts both.

3. Commit each file to the default branch (`main`).
4. Update **`README.md`** with your project overview and link to this file: **Power Platform automated ALM** — see `README.md` in this directory for architecture and day-to-day usage.

After this, confirm in the **Actions** tab that both workflows appear and run a manual test of **Export Power Platform Solution** before relying on merge-to-main deploys.

---

## Quick reference

| Item | Where it lives |
|------|----------------|
| Service principal IDs and secret | Step 2 → Step 4A secrets |
| Dev / UAT API access | Step 3 (application users per environment) |
| Manual approval before UAT import | Step 4B (`UAT` environment) |
| PR required to merge to `main` | Step 4C |
