#!/bin/bash

scp /home/gitlab-runner/builds/cLasHXx4/0/students/DO6_CICD.ID_356283/rosiotam_student.21_school.ru/DO6_CICD-1/src/C3_SimpleBashUtils/cat/s21_cat rosiotam@10.10.0.2:/usr/local/bin/
scp ./C3_SimpleBashUtils/grep/s21_grep rosiotam@10.10.0.2:/usr/local/bin/
ssh rosiotam@10.10.0.2 ls -lha /usr/local/bin