#!/bin/bash

while IFS=";" read -r course_id course_short_name; do
  backup_msg="$(date) Backing up course with COURSE_ID ($course_id) and SHORT_NAME ($course_short_name)"
  echo "$backup_msg" >> backup.log
  echo "$backup_msg"

  # Run the command with error trapping
  time_start=$(date +%s)

  backup_command_result=$(sudo -u w1 /path/to/php7.2 /path/to/admin/cli/backup.php --courseid=$course_id --destination=/path/to/moodlebak)


  # Check the exit status of the last command
  if [[ $? -ne 0 ]]; then
      # Command failed, write error to log
      backup_command_fail_msg="$(date) Backup failed with errors: \n$backup_command_result"
      echo -e "$backup_command_fail_msg"  >> backup.log
      echo -e "$backup_command_fail_msg"
      
      # Write failed course information to the log
      backup_msg="$(date) Writing COURSE_ID ($course_id) and SHORT_NAME ($course_short_name) to failed_courses.log"
      echo "$backup_msg" >> backup.log
      echo "$backup_msg"
      echo "$course_id;$course_short_name" >> failed_courses.log
  else
      # Count time
      time_end=$(date +%s)
      elapsed_time=$((time_end - time_start))
      minutes=$((elapsed_time / 60))
      seconds=$((elapsed_time % 60))

      # Command succeeded, print response and time
      backup_command_success_msg="$(date) SUCCESS! backup.php response: \n$backup_command_result"
      echo -e "$backup_command_success_msg"
      echo -e "$backup_command_success_msg" >> backup.log

      formatted_time=$(printf "Time (minutes:seconds) passed: %02d:%02d\n" "$minutes" "$seconds")
      
      echo "$formatted_time" >> backup.log
      echo "$formatted_time"
  fi
done < input.csv

backup_done_msg="FINISHED BACKUP!"
echo $backup_done_msg