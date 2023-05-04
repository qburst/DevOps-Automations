# S3 object monitoring script

This Python script can be used to monitor Amazon S3 buckets for new object versions and send an alert if no new objects have been added to a bucket for a specified period of time.

The variable "monitor_period" specifies the period of time in seconds for which the script will check for new objects. The "check_interval" specifies the delay between two checks. It is set to 3600 and 60 in the script respectively and you may replace it according to your requirement.

You need to set up an SNS topic to send alerts. You can set up it by creating a topic in AWS console and subscribing an email address to the topic so that it can receive alerts. Once done, you can specify the topic ARN in the script.

The Dockerfile contains instructions to build an image and the requirements.txt contains the Python packages that the script depends on.

## Installation

1. Clone this repository or download the script "s3object_check.py"
2. Install the required dependencies using `pip`
3. Configure the script with your AWS credentials and settings for S3 and SNS.
4. Set up an SNS topic and configure the script with the topic ARN and region.
5. Optionally, modify the `monitor_period` and `check_interval` variables to adjust the monitoring frequency and check interval.

## Usage

You can run this script in three methods:

1. ### Running as a background process
  
   `python3 s3object_check.py </dev/null &>/dev/null &`
   
   This will run the script in the background and suppress any output or error message that it may generate.

2. ### Running as a cronjob

   To run this script as a cronjob, you can add the following to your crontab file using `crontab -e` command:

   `* * * * * /usr/bin/python3 /path/to/s3object_check.py > /dev/null 2>&1`

   This will run the script every minute and redirect any output or error messages to /dev/null

3. ### Run as a Docker container
   
   To run the script as a Docker container, build the Docker image using the command

   `docker build -t s3object-monitor .`

   Run the Docker container using the command

   `docker run -d --name s3object-monitor-container -v /aws/credentials/path:/home/appuser/.aws/config s3object-monitor`

   Note: Before running the container, you will need to configure the script with the appropriate S3 and SNS credentials and settings, as well as the topic ARN and region. You can pass the configuration settings at runtime or by modifying the script itself.

