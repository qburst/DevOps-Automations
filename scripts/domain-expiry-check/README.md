# Domain Expiry Checker

A bash script to monitor the expiration dates of domain names. It fetches domain information using WHOIS queries and send email alerts when domains are about to expire.

## Features

- Users can provide a list of domain names in the text file.
- The script will check the following conditions and sends email alerts:
  - Expiring Soon: When a domain is about to expire within a specified threshold.
  - Expired: When a domain has already expired.
  - Expiring Today: When a domain is expiring on the same day.
  - Invalid/Unable to fetch: When a given domain is invalid or it's expiry date cannot be retrieved.
- Users can customize the threshold days value.
- Send HTML formatted email alerts.
- Table like strcuture in the terminal output.

## Prerequisites
- Bash shell
- Ensure the packages ssmtp, mailutils, and mutt are installed on your system.
- Update SMTP server information in the ssmtp configuration file `/etc/ssmtp/ssmtp.conf` , refer the wiki https://wiki.archlinux.org/title/SSMTP

## Usage

1. Clone this repository.
2. Navigate to project's directory.
3. Update the domain list file path in the `domain_list` variable which should contain domains you want to monitor line by line.
4. Modify the variables `days_threshold` and `email_address` in the script `domain_expiry_checker.sh` to configure the threshold days and email address to receive alert respectively.
5. Run the script as a cronjob, you can add the following to your crontab file using `crontab -e` command to schedule the script to run daily at 4:00 AM. Replace the path of log file according to yours.
   ```
   0 3 * * * /bin/bash /path/to/domain_expiry_checker.sh >> /path/to/logfile.log 2>&1
   ```

## Sample terminal output and Email alerts

- Tested on Ubuntu 20.04.6 LTS (Focal Fossa)

```
$ bash ./domain_expiry_checker.sh
+--------------------------------+------------------+--------------------+
|          Domain Name           |   Expiry Date    |      Status        |
+--------------------------------+------------------+--------------------+
| example.com                    | 2024-08-13       | OK                 |
| flipkart.in                    | 2023-09-25       | Expiring Soon      |
| amazon.in                      | 2024-02-11       | OK                 |
| mcninewuwnec.com               | N/A              | Error              |
| starbucks.au                   | N/A              | Error              |
| sancharam.in                   | 2023-07-25       | Expired            |
| fsb333.com                     | 2023-06-15       | Expired            |
+--------------------------------+---------------+-----------------------+

```

![Domain Expiry Alert Image](<output.png>)
