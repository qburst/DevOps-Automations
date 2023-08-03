# AWS opensearch-cluster backup-automation

A small project to take automated backup of aws opensearch cluster, this project can be used when the requirement is to
migrate the opensearch cluster from one region to another or with further modification the project can be used for setting up
a DR strategy (cross-region cluster replication) for any exsisting opensearch cluster.

## Pre-requisites
Name | Description
--- | ---
Opensearch cluster | Opensearch cluster containing at least one index
S3 bucket | The snapshot from the opensearch cluster domain is restored into S3 bucket
Secret manager | Secret manager can be used to store 
Eventbridge | Event bridge schedule with target type LambdaInvoke

## Global variables

Name | Description
--- | ---
repository_name | Name provided while registering the repository.
opensearch_endpoint | Opensearch domain endpoint
secret_name | Name of the secret in which the master username and password to access the opensearch cluster is stored

Steps
-----

* Register a repository (link the opensearch cluster with s3 bucket) refer https://docs.aws.amazon.com/opensearch-service/latest/developerguide/managedomains-snapshots.html#managedomains-snapshot-registerdirectory

* Configure AWS secret name with the necessary credentails to access the opensearch cluster.

* Deploy the code as lambda function and test the code. (runtime Python 3.7).

* Configure AWS Event bridge schedule with the required policy to Invoke the lambda function on daily basis
