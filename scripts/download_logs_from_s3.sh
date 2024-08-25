#!/bin/bash

## Set AWS to use --profile ; Please change this as per your use case
AWS="aws --profile dev"
PREFIX=""
PARALLEL_DOWNLOADS=10  # Number of parallel downloads

usage() {
cat << EOF
This script is used to get all files between 2 timestamps from a specified bucket and prefix. It expects the following inputs:
  -b   The name of the BUCKET from where to get files
  -p   The prefix within the BUCKET to get files from. If not specified it defaults to ""
  -s   Start timestamp in format YYYYMMDDHHMM
  -e   End timestamp in format YYYYMMDDHHMM
EOF
exit 1;
}

list_files() {
  local start_timestamp=$(date -d "${START:0:8} ${START:8:2}:${START:10:2}" +%s)
  local end_timestamp=$(date -d "${END:0:8} ${END:8:2}:${END:10:2}" +%s)
  
  local filter=""
  for ((t = start_timestamp; t <= end_timestamp; t += 60)); do
    local current_time=$(date -d "@$t" +"%Y%m%d.*%H%M")
    if [ -n "$filter" ]; then
      filter="${filter}|"
    fi
    filter="${filter}${current_time}"
  done
  
  echo "Debug: Filter pattern is: $filter" >&2
  
  $AWS s3api list-objects-v2 --bucket $BUCKET --prefix $PREFIX --query "Contents[].Key" --output json | 
  jq -r '.[]' | 
  grep -E "(${filter})"
}

get_files() {
  mkdir -p downloaded
  echo "$FILES" | xargs -P $PARALLEL_DOWNLOADS -I {} $AWS s3 cp s3://$BUCKET/{} ./downloaded/ --quiet
}

# Main script starts here
while getopts "b:p:s:e:" option; do
  case $option in
    p) PREFIX=${OPTARG};;
    b) BUCKET=${OPTARG};;
    s) START=${OPTARG}
       if [[ ! "$START" =~ ^[0-9]{12}$ ]]; then
         echo "Invalid start timestamp. Must be in format YYYYMMDDHHMM."
         usage
       fi
       ;;
    e) END=${OPTARG}
       if [[ ! "$END" =~ ^[0-9]{12}$ ]]; then
         echo "Invalid end timestamp. Must be in format YYYYMMDDHHMM."
         usage
       fi
       ;;
    *) usage;;
  esac
done

FILES=$(list_files)
COUNT=$(echo "$FILES" | wc -l)

if [ $COUNT -eq 0 ]; then
  echo "There are no files matching those conditions. Exiting."
  exit 0
else
  echo "There are $COUNT files. Shall we download them? Enter YES to proceed."
  read choice
  if [ "$choice" == "YES" ]; then
    get_files
  else
    echo "Exiting"
    exit 0
  fi
fi
