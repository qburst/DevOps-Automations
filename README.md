
This Python script can be used to get a report of the under utilized EC2 instances in Multiple regions. You may replace the mentioned region names with the actual one seprated by commas.
The script uses the CPU threshold as 10 and Traffic (NetworkIn) as 1000 and the period taken is 604800 seconds (1 week). Hence this script will take the report of all such under utilized EC2 instances. 
