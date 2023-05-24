import boto.ec2
import croniter
import datetime
import argparse
from tabulate import tabulate
# Argument parser to grab the aws profile name.
def awsProfile(output="profile"):
    parser = argparse.ArgumentParser(description='Which aws profile to use')
    parser.add_argument('-p','--profile', help='The aws credential profile to use. (defined in ~/.aws/credentials)',required=True)
    parser.add_argument('-r','--region', help='The region to run the job against, it defaults to us-east-1',required=False, default='us-east-1')
    args = parser.parse_args()
    if output == "region":
        return args.region
    else:
        return args.profile

# return true if the cron schedule falls between now and now+seconds
def time_to_action(sched, now, seconds):
  try:
    cron = croniter.croniter(sched, now)
    d1 = now + datetime.timedelta(0, seconds)
    if (seconds > 0):
      d2 = cron.get_next(datetime.datetime)
      ret = (now < d2 and d2 < d1)
    else:
      d2 = cron.get_prev(datetime.datetime)
      ret = (d1 < d2 and d2 < now)
#    print "now %s" % now
#    print "d1 %s" % d1
#    print "d2 %s" % d2
  except:
    ret = False
#  print "time_to_action %s" % ret
  return ret

now = datetime.datetime.now()

# Retrieve instance information
def get_instance_info(instance):
    instance_id = instance.id
    instance_name = instance.tags.get('Name', 'Unknown')
    instance_type = instance.instance_type
    launch_time = instance.launch_time
    state = instance.state
    stop_sched = instance.tags.get('auto:stop', '')
    start_sched = instance.tags.get('auto:start', '')
    return instance_id, instance_name, instance_type, launch_time, state, stop_sched, start_sched

now = datetime.datetime.now()

# go through all regions
try:
    region = awsProfile("region")
    conn = boto.ec2.connect_to_region(region, profile_name=awsProfile())
    reservations = conn.get_all_instances()
    start_list = []
    stop_list = []
    for res in reservations:
        for inst in res.instances:
            name = inst.tags['Name'] if 'Name' in inst.tags else 'Unknown'
            state = inst.state

            # check auto:start and auto:stop tags
            start_sched = inst.tags['auto:start'] if 'auto:start' in inst.tags else None
            stop_sched = inst.tags['auto:stop'] if 'auto:stop' in inst.tags else None

            # queue up instances that have the start time falls between now and the next 15 minutes
            if start_sched != None and state == "stopped" and time_to_action(start_sched, now, 16 * 60):
                start_list.append(inst)

            # queue up instances that have the stop time falls between 15 minutes ago and now
            if stop_sched != None and state == "running" and time_to_action(stop_sched, now, -16 * 60):
                stop_list.append(inst)

    # start instances
    if len(start_list) > 0:
        ret = conn.start_instances(instance_ids=[instance.id for instance in start_list], dry_run=False)
        print("start_instances:")

        table_data = []
        for instance in start_list:
            instance_id, instance_name, instance_type, launch_time, state, stop_sched, start_sched = get_instance_info(instance)
            values = [instance_id, launch_time, instance_name, state, start_sched, stop_sched]
            table_data.append(values)

        attributes = ["Instance ID", "Launch Time", "Instance Name", "State", "Start Schedule", "Stop Schedule"]

        print(tabulate(table_data, headers=attributes, tablefmt="grid"))

    # stop instances
    if len(stop_list) > 0:
        ret = conn.stop_instances(instance_ids=[instance.id for instance in stop_list], dry_run=False)
        print("stop_instances:")
        
        table_data = []
        for instance in stop_list:
            instance_id, instance_name, instance_type, launch_time, state, stop_sched, start_sched = get_instance_info(instance)
            values = [instance_id, launch_time, instance_name, state, start_sched, stop_sched]
            table_data.append(values)

        attributes = ["Instance ID", "Launch Time", "Instance Name", "State", "Start Schedule", "Stop Schedule"]

        print(tabulate(table_data, headers=attributes, tablefmt="grid"))
except Exception as e:
            print('Exception error in : %s' % str(e))