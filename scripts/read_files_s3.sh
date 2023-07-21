#!/bin/bash

## Set AWS to use --profile ; Please change this as per your use case
AWS="aws --profile qb"
PREFIX=""

usage() {
cat << EOF
This script is used to get all files between 2 timestamps from a specified bucket and prefix. It expects the following inputs
  -b   The name of the BUCKET from where to get files
  -p   The prefix within the BUCKET to get files from. If not specified it defaults to ""
  -s   All files would be last modified after this time. This must be in YYYY-MM-DDTHH:MM:SS format in UTC.
  -e   All files would be last modfied before this time. This must be in YYYY-MM-DDTHH:MM:SS format in UTC.
EOF
}

list_files() {
  $AWS s3api list-objects-v2 --bucket $BUCKET --prefix $PREFIX --query "Contents[?(LastModified>='$START' && LastModified<='$END')].[Key]" --output text
}

get_files() {
  mkdir -p downloaded
  for file in $FILES
  do
    $AWS s3 cp s3://$BUCKET/$file ./downloaded/
  done
}

#main script starts here
while getopts "b:p:s:e:" option; do
  case $option in
    p) PREFIX=${OPTARG};;
    b) BUCKET=${OPTARG};;
    s) START=${OPTARG};;
    e) END=${OPTARG};;
    *) # display help
       usage;;
  esac
done

FILES=`list_files`
COUNT=`echo $FILES| awk -F" " '{print NF}'`
if [ $COUNT -eq 0 ]
then
  echo "There are no files matching those conditions. Exiting."
  exit 0
else
  echo "There are $COUNT files. Shall we download the same? Enter YES to proceed."
  read choice
  if [ $choice == "YES" ]
  then
    get_files
  else
    echo "Exiting"
    exit 0
  fi
fi