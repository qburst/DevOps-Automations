import boto3

hosted_zone_id = "Z05545191UNEXAMPLE"
eip = ["XX.XXX.XX.XXX"]
group_name = "dev"

route53 = boto3.client('route53')
ec2 = boto3.client('ec2')

def check_if_hosted_zone_exist():
    '''
    First step of validation starts here.
    Checks to see if the Hosted Zone provided in the input exists in the AWS account.
    If the hosted zone does not exist, the script will exit.
    '''
    try:
        response = route53.get_hosted_zone(Id=hosted_zone_id)
        if response['HostedZone']['Id'].split('/')[2] == hosted_zone_id:
            print("Hosted zone found. Zone name: {0}".format(response['HostedZone']['Name']))
            return(response['HostedZone']['Name'])
    except route53.exceptions.ClientError as a:
        print(a)
        print("This script will now exit.")
        exit(1)

def check_eip_association(address):
    """ Checks if the EIPs are already associated to resources."""
    for a in address["Addresses"]:
        if "InstanceId" not in a:
            print("{0} is not attached to any instance.".format(a['PublicIp']))
            print("Remove {0} from list and then try again. Script will now exit.".format(a['PublicIp']))
            exit(1)

def check_if_eip_exist():
    """
    Checks if the elastic IPs provided exist in the account.
        Also Checks if the Elastic IPs have resources assigned to it.
        If the IPs are assigned to any resources, the script will exit. 
    """
    print("Validating EIPs...")
    try:
        response = ec2.describe_addresses(PublicIps=eip)
        check_eip_association(response)
    except ec2.exceptions.ClientError as e:
        print(e)
        print("Remove IPs that could not be found and run the script again.")
        exit(1)

def check_if_eip_has_records():
    """Checks to see if there are any A records in Route53 already pointing to these IP address.
    If an A records already exist for the IPs, the script will exit."""
    record_values = []
    existing_values = []
    response = route53.list_resource_record_sets(HostedZoneId=hosted_zone_id)

    for records in response["ResourceRecordSets"]:
        for entries in records['ResourceRecords']:
           record_values.append(entries["Value"])

    for ip in eip:
        if ip in record_values:
            existing_values.append(ip)
    if len(existing_values) > 0:
        print("The following IPs already have A-Records assigned to it. Remove the IPs and try again.")
        print(existing_values)
        print("The script will now exit.")
        exit(1)

def validate_input():
    """Validates the input provided.
        1. Check if the hosted zone provided exists in the AWS account.
        2. Checks to see if the provided elastic ips exist in the account.
        3. Check if the eips have records already assigned to then.

        Failing these condition will exit the script."""
    zone_name = check_if_hosted_zone_exist()
    check_if_eip_exist()
    check_if_eip_has_records()
    print("EIP validation succeded.")
    return(zone_name)

def check_group_name_in_hosted_zone_records():
    """Checks to see if the hosted zone has records with the group name. 
    This function will generate a sorted list and find the highest number on the existing record.
    If a the group does not exist, it will start from 1."""
    records_with_group_name = []
    response = route53.list_resource_record_sets(HostedZoneId=hosted_zone_id)
    for records in response['ResourceRecordSets']:
        if group_name in records['Name']:
            records_with_group_name.append(records['Name'])
    print(records_with_group_name)
    if len(records_with_group_name) > 0:
        records_with_group_name.sort()
        highest_record = records_with_group_name[-1]
        print("Record with the highest number is {0}. Records will start from {1}".format(highest_record, len(records_with_group_name) + 1))
    else:
        print("No records were found under this group name. Group name records starting with 1 will be created.")
    return(len(records_with_group_name))

def add_record_in_hosted_zone(number_of_existing_records, zone_name):
    """Function to add records to the hosted zone.
    Generates a list of records and displayes it to the user and asks for confirmation.
    User can confirm and it will proceed or else it will exit.
    """
    records = {}
    changes = []
    for ip in eip:
        i = 1
        records[ip] = "{0}-{1}.{2}".format(group_name, str(number_of_existing_records + i), zone_name)
        i+=1
    print("Records that are going to be created: {0}".format(records))
    if input("Does this look good? y/n: ") == "y":
        for key in records:
            change = { 'Action': 'CREATE', 'ResourceRecordSet': { 'Name': records[key], 'ResourceRecords': [{ 'Value': key, }, ], 'TTL': 300, 'Type': 'A',} }
            changes.append(change)
        try:
            response = route53.change_resource_record_sets(ChangeBatch={'Changes': changes},HostedZoneId=hosted_zone_id)
            print("A-Record created")
        except route53.exceptions.ClientError as e:
            print(e)
        return(records)
    else:
        print("Operation cancelled by user. The script will not exit.")
        exit(1)

def tag_volumes(instanceId, name):
    """Tags Volumes with the group name."""
    response = ec2.describe_instances(InstanceIds=[instanceId])
    for reservation in response['Reservations']:
        for instance in reservation['Instances']:
            for devices in instance['BlockDeviceMappings']:
                response = ec2.create_tags(Resources=[devices['Ebs']['VolumeId']], Tags=[{'Key': 'Name','Value': name}])
    

def tag_instance(instanceId, name):
    """Tags Instances with the group name."""
    try:
        ec2.create_tags(Resources=[instanceId], Tags=[{'Key':'Name', 'Value':name}])
        tag_volumes(instanceId, name)
    except ec2.exceptions.ClientError as e:
        print(e)

def add_tags(records):
    """Adds tags to the instances and volume."""
    instance_map = {}
    response = ec2.describe_addresses(PublicIps=list(records.keys())) 
    for address in response["Addresses"]:
        instance_map[address['InstanceId']] = records[address['PublicIp']]
    for key in instance_map:
        tag_instance(key, instance_map[key])
    print("Instances and Volumes where tagged.")
        
    
def main():
    """This script assumes that aws cli is configured with access and secret key of the appropriate aws account.
    Make sure Boto3 package is installed.
    Script Usage: python3 cname.py 
    Script executes in the following order.
    1. check if provided hosted zone exists.
    2. check if the elastic ips provided are attached to ec2 instances.
    3. create a list of all the A records with the group name and find its length.
    4. create records in hosted zone.
    5. tags and corresponding instances and volumes."""
    zone_name = validate_input()
    number_of_existing_records = check_group_name_in_hosted_zone_records()
    records = add_record_in_hosted_zone(number_of_existing_records, zone_name)
    add_tags(records)
    

if __name__ == "__main__":
    main()
