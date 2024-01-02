#!/bin/bash

# Set your AWS credentials and region
AWS="aws --profile default"
export AWS_DEFAULT_REGION="ap-southeast-1"

# Set the RDS instance identifier
RDS_INSTANCE_IDENTIFIER="database-01"

# Read the global start time and end time in string format (e.g., "24 August 2023 15:37")
read -p "Enter start time: " START_TIME
read -p "Enter end time: " END_TIME

# Convert start time and end time to POSIX timestamps
START_TIME_POSIX=$(date -d "$START_TIME (UTC+05:30)" '+%s')
END_TIME_POSIX=$(date -d "$END_TIME (UTC+05:30)" '+%s')

# Define the function to list log files within a specified time range
list_log_files() {
  local instance_identifier="$1"
  local start_time="$2"
  local end_time="$3"

  # List available log files within the specified time range (with last 3 digits stripped)
  $AWS rds describe-db-log-files \
    --db-instance-identifier "$instance_identifier" \
    --output json | jq -r --argjson start_time "$start_time" --argjson end_time "$end_time" \
    '.DescribeDBLogFiles[] | select($start_time <= (.LastWritten/1000|floor)) | select((.LastWritten/1000|floor) <= $end_time) | .LogFileName'
}

# Call the function to list log files within the specified time range
log_files=$(list_log_files "$RDS_INSTANCE_IDENTIFIER" "$START_TIME_POSIX" "$END_TIME_POSIX")

# Create a temporary directory to store downloaded logs
TEMP_DIR=$(mktemp -d)

# Create a subdirectory for the logs (e.g., "error")
LOG_SUBDIR="error"
mkdir -p "$TEMP_DIR/$LOG_SUBDIR"

# Download matching RDS log files
for log_file in $log_files; do
  $AWS rds download-db-log-file-portion \
    --db-instance-identifier "$RDS_INSTANCE_IDENTIFIER" \
    --log-file-name "$log_file" \
    --output text --no-paginate > "$TEMP_DIR/$log_file"
  echo "Downloaded log: $log_file"
done

echo "Logs downloaded to: $TEMP_DIR/$LOG_SUBDIR"
