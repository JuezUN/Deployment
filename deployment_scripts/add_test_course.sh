#!/bin/bash

# Script to download the test course and set in the tasks folder

# Install `unzip` and `wget` in case they are not already installed
sudo yum install -y unzip wget

wget https://github.com/JuezUN/INGInious/wiki/assets/course_example/test_course.zip -O /tmp/test_course.zip

unzip /tmp/test_course.zip -d /tmp/test_course

# Move test course to the tasks directory
sudo mv /tmp/test_course/test /var/www/INGInious/tasks
sudo chown -R lighttpd:lighttpd /var/www/INGInious/tasks

# Remove downloaded files
rm /tmp/test_course.zip