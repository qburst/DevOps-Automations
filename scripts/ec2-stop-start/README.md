# EC2-START/STOP-SCRIPT

The EC2 Stop/Start Script is a Python script designed to automate the process of stopping and starting Amazon EC2 instances based on predefined schedules by tags. It utilizes the Boto library to interact with the EC2 service and provides a convenient way to manage the state of your EC2 instances.

### PREREQUISTES: 
    • Ensure you have Python installed on your system.
    • Install the required dependencies by running the following command:
            pip install boto croniter argparse tabulate
    • Obtain your AWS credentials (access key and secret key) and configure them using the AWS Command Line Interface (CLI) or by manually editing the AWS credentials file (~/.aws/credentials).
    • Download the “ec2_stop_start.py” file.

### EXECUTION:
Run the below command:

            python3 ec2_stop_start.py -p <profile> -r <region>
Please replace the profile with AWS credential profile and region

### CONFIGURATION:
The script relies on specific tags assigned to your EC2 instances to determine their start and stop schedules. These tags are as follows:

      “auto:start”: Specifies the start schedule for an instance. The tag value should be a cron expression representing the desired start time.

      “auto:stop”: Specifies the stop schedule for an instance. The tag value should be a cron expression representing the desired stop time.

## Example for creating tags:
             Key                                                Value
          auto:start                                          cron value
 
### HOW IT WORKS:
    • Connects to the specified AWS region using the provided AWS credential profile.
    • Retrieves information about all instances in the region.
    • Checks the “auto:start” and “auto:stop” tags for each instance to determine their schedules.
    • Creates a list of instances that need to be started based on the current time and the start schedules.
    • Creates a list of instances that need to be stopped based on the current time and the stop schedules.
    • Starts the instances in the start list.
    • Stops the instances in the stop list.
