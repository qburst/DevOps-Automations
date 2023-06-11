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

    a-record.py:
    ---------------------
        A python script to create A Records to Route53. Users can provide a list of IP addreses and a group name. The script will validate the inputs and checks for the following.
            * Checks if the hosted zone provided exists in the AWS account.
            * Checks if the elastic IPs exist in the aws account.
            * Checks if the elastic IPs have resources associated with it.
            * Checks if the elasitc IPs have A Records in Route 53.
            * Failing any of these validations will fail the script.
        Once validations are complete, the script checks to see if Route53 has any records with the group name. If group name exists, script will find the record with the highest number and adds records. If the group name records does not exist, records starting from 1 will be created.