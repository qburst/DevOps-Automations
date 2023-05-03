# DevOps Automations
This repo is a bunch of various scripts, modules and other resources the QB Devops team uses. It is all licensed to be public.

## Prerequisite
For anyone commiting to this repo, please setup the below githook to ensure you dont commit to `main` by mistake
```
git config core.hooksPath .githooks
```

## Structure
We have structured the content of this repo as follows
1. **scripts**: This folder contains various scripts we have used over time in the company

    Pod_restart_fail.sh:
    ---------------------
        A script to find all pods in a particular namespace that are restarting/failed to start.
            * Script will check for the pod status in a given namespace.
            * When a pod is either in  failed or restart phase, its name and status, including the restart count, will be displayed. Additionally, a variable named 'count' is initialized to zero, which is incremented when any of the pods are in a failed or restart phase.
            * Once the complete iteration is over and if the defined variable equals zero, then there are no pods in the namespace with failed/restart status.
