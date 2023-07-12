import boto.ec2
import croniter
import datetime
import argparse
from tabulate import tabulate

# Argument parser to grab the aws profile name.
def aws_profile(output="profile"):
        parser = argparse.ArgumentParser(
            description='Specify the AWS profile to use'
        )
        parser.add_argument(
            '-p', '--profile',
            help='The AWS credential profile to use '
                 '(defined in ~/.aws/credentials)',
            required=True
        )
        parser.add_argument(
            '-r', '--region',
            help='The region to run the job against; defaults to us-east-1', 
            required=False, default='us-east-1'
        )
        args = parser.parse_args()
        if output == "region":
            return args.region
        else:
            return args.profile

# return true if the cron schedule falls between now and now+seconds
def time_to_action(schedule, now, seconds):
    try:
        cron = croniter.croniter(schedule, now)
        d1 = now + datetime.timedelta(0, seconds)
        if seconds > 0:
            d2 = cron.get_next(datetime.datetime)
            ret = now < d2 and d2 < d1
        else:
            d2 = cron.get_prev(datetime.datetime)
            ret = d1 < d2 and d2 < now
    except:
        ret = False
    return ret

# Retrieve instance information
def get_instance_info(instance):
        instance_id = instance.id
        instance_name = instance.tags.get('Name', 'Unknown')
        instance_type = instance.instance_type
        launch_time = instance.launch_time
        state = instance.state
        stop_sched = instance.tags.get('auto:stop', '')
        start_sched = instance.tags.get('auto:start', '')
        return (instance_id, instance_name, instance_type, launch_time,
               state, stop_sched, start_sched
        )

now = datetime.datetime.now()

try:
    region = aws_profile("region")
    conn = boto.ec2.connect_to_region(region, profile_name=aws_profile())
    reservations = conn.get_all_instances()
    start_list = []
    stop_list = []

    for res in reservations:
        for inst in res.instances:
            name = inst.tags.get('Name', 'Unknown')
            state = inst.state

            start_sched = inst.tags.get('auto:start', None)
            stop_sched = inst.tags.get('auto:stop', None)

            if (start_sched and state == "stopped" 
                    and time_to_action(start_sched, now, 16 * 60)):        
                start_list.append(inst)

            if (stop_sched and state == "running" 
                    and time_to_action(stop_sched, now, -16 * 60)):
                stop_list.append(inst)

    if len(start_list) > 0:
        ret = conn.start_instances(instance_ids=
                    [instance.id for instance in start_list], dry_run=False)
        print("start_instances:")

        table_data = []
        for instance in start_list:
            (instance_id, instance_name, instance_type, launch_time, state, 
                        stop_sched, start_sched) = get_instance_info(instance)
            values = [instance_id, launch_time, instance_name,
                        state, start_sched, stop_sched]
            table_data.append(values)

        attributes = ["Instance ID", "Launch Time", "Instance Name",
                        "State", "Start Schedule", "Stop Schedule"]

        print(tabulate(table_data, headers=attributes, tablefmt="grid"))

    if len(stop_list) > 0:
        ret = conn.stop_instances(instance_ids=[
                        instance.id for instance in stop_list], dry_run=False)
        print("stop_instances:")

        table_data = []
        for instance in stop_list:
            (instance_id, instance_name, instance_type, launch_time, state,
                        stop_sched, start_sched) = get_instance_info(instance)
            values = [instance_id, launch_time, instance_name,
                         state, start_sched, stop_sched]
            table_data.append(values)

        attributes = ["Instance ID", "Launch Time", "Instance Name",
                        "State", "Start Schedule", "Stop Schedule"]

        print(tabulate(table_data, headers=attributes, tablefmt="grid"))

except Exception as e:
    print('Exception error: %s' % str(e))

