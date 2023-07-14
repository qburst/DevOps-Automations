usage: aws_utility_script.py [-h] [-a ACTION]

Script to report unused volumes and orphan snapshots to CSV file.

optional arguments:
  -h, --help            show this help message and exit
  -a ACTION, --action ACTION
                        Action can be either of the two values
                        report_unused_vol / report_orphan_snapshot

example:
  aws_utility_script.py --action report_unused_vol
	OR
  aws_utility_script.py -a report_orphan_snapshot
