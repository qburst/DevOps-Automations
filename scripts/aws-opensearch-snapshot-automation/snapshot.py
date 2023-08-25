import datetime
import json
import requests
import boto3

def lambda_handler(event, context):

    #Create a Secrets Manager client
    secrets_client = boto3.client('secretsmanager')
    
    #Replace these variables with your OpenSearch cluster details
    repository_name = "new_repo"
    snapshot_name = "snapshot-{}".format(datetime.datetime.now().strftime("%Y-%m-%d-%H-%M-%S"))
    opensearch_endpoint = "https://search-newtest-cgsp4wiqedeibk6cnxxxfcsg44.us-east-1.es.amazonaws.com"
    secret_name="dev/opensearch/creds"
    
    
    #Get the secret value from Secrets Manager
    response = secrets_client.get_secret_value(SecretId=secret_name)
    secret_value = json.loads(response['SecretString'])
    
    #Fetching opensearch cluster auth 
    opensearch_username = secret_value['username']
    opensearch_password = secret_value['password']

    
    #Create a session with basic authentication
    session = requests.Session()
    session.auth = (opensearch_username, opensearch_password)

    #Take the snapshot backup
    try:
        url = f"{opensearch_endpoint}/_snapshot/{repository_name}/{snapshot_name}"
        response = session.put(url)
        response.raise_for_status()
        return {
            "statusCode": 200,
            "body": "OpenSearch backup successfully taken."
        }
    except requests.exceptions.RequestException as e:
        return {
            "statusCode": 500,
            "body": f"Failed to take OpenSearch backup. Error: {str(e)}"
        }
