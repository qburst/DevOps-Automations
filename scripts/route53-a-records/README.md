# Route53 A Record creation Script
A python script to create A Records to Route53. Users can provide a list of IP addreses and a group name. The script will validate the inputs and checks for the following.
            
* Checks if the hosted zone provided exists in the AWS account.
* Checks if the elastic IPs exist in the aws account.
* Checks if the elastic IPs have resources associated with it.
* Checks if the elasitc IPs have A Records in Route 53.
* Failing any of these validations will fail the script.

Once validations are complete, the script checks to see if Route53 has any records with the group name. If group name exists, script will find the record with the highest number and adds records. If the group name records does not exist, records starting from 1 will be created.

## Script Usage: 

``` python3 a-record.py ```

Please update the hosted_zone_id, eip, group_name variables as per your need.
