# General description
This script parses csv file with name `input.csv` with data about moodle course_id (1st column) and course_short_name (2nd column) and performs course backup operation for selected course id using moodle's backup.php script.
# Logfiles
This script writes logs to this files:
1. backup.log - general script log
2. failed_ile with course_id (1st col) and course_short_name (2nd col) for courses that failed to backup.
Also this script writes logs to stdout.
# How to configure
All backup parameters (backup user, php interpreter, path to backup.php, course_id and destination path.) are configured inside script code. Look at line where `backup.php` is executed.
`.MBZ` files are saved in directory that is specified inside the `--destination=/path/to/moodlebak` parameter to `backup.php` script.