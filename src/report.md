
### Part 1. Setting up the **gitlab-runner**

**== Task ==**

##### Start *Ubuntu Server 22.04 LTS* virtual machine.

![](pic/Ubuntu_20.04.png)

##### Download and install **gitlab-runner** on the virtual machine.

Download:
![](pic/part1_install-runner.png)

Install:

![](pic/part1_install-runner.png)

Register:

![](pic/part1_register-runner.png)


### Part 2. Building

**== Task ==**

#### Write a stage for **CI** to build applications from the *C2_SimpleBashUtils* project.

##### In the _gitlab-ci.yml_ file, add a stage to start the building via makefile from the _C2_ project.

Install packages on Ubuntu:

- sudo apt install make
- sudo apt install gcc
- sudo apt install clang-format

Write .gitlab-ci.yml with "stage: build":

![](pic/part2_gitlab-ci.png)


Launch on Ubuntu gitlab-runner `gitlab-runner run`:

![](pic/part2_gitlab-runner_run.png)

After push project to our repository check `CI/CD -> Piplines` 

success
![](pic/part2_job_success.png)

or error
![](pic/part2_job_error.png)


### Part 3. Codestyle test

#### Write a stage for **CI** that runs a codestyle script (*clang-format*).
![](pic/part3_gitlab-ci_yml.png)

![](pic/part3_style-code_success.png)

![](pic/part3_code-style_success_details.png)

##### If the codefile didn't pass, "fail" the pipeline.

![](pic/part3_style-code_fail.png)

![](pic/part3_style-code_fail_details.png)


### Part 4. Integration tests

#### Write a stage for **CI** that runs your integration tests from the same project.

##### Run this stage automatically only if the build and codestyle test passes successfully.

![](pic/part4_integration_tests_skipped.png)

##### If tests didn't pass, "fail" the pipeline.
![](pic/part4_pipeline_failed.png)

##### In the pipeline, display the output of the succeeded / failed integration tests.

![](pic/part4_integration_tests_success.png)

### Part 5. Deployment stage

##### Start the second virtual machine *Ubuntu Server 22.04 LTS*.

- create a 2nd VM
- configure and rewrite netplan *.yaml file for both VM
    - 1st:
    ![](pic/part_yaml_1stVM.png)
    - 2nd:
    ![](pic/part_yaml_2ndVM.png)


#### Write a stage for **CD** that "deploys" the project on another virtual machine:

![](pic/part5_deploy_stage.png)

##### Write a bash script which copies the files received after the building (artifacts) into the */usr/local/bin* directory of the second virtual machine using **ssh** and **scp** `src/deploy.sh`

- provide to 1st VM access to connect to 2nd VM via ssh
    - switch to user gitlab-runner `sudo su gitlab-runner`
    - create ssh key `ssh-keygen -t rsa -b 2048`
    - establish ssh connection `ssh-copy-id rosiotam@10.10.0.2`
- give the rights to user rosiotam on the 2nd VM where we copy files `chown rosiotam /usr/local/bin`    

As a result, you should have applications from the *C2_SimpleBashUtils* (s21_cat and s21_grep) project ready to run on the second virtual machine.

![](pic/part5_pipeline_success.png)

![](pic/part5_2VM_usr-local-bin1.png)
![](pic/part5_2VM_usr-local-bin2.png)

##### Save dumps of virtual machine images.

### Part 6. Bonus. Notifications

##### Set up notifications of successful/unsuccessful pipeline execution via bot named "[your nickname] DO6 CI/CD" in *Telegram*.
- The text of the notification must contain information on the successful passing of both **CI** and **CD** stages.

- create the new bot in Telegram using BotFather:
![](pic/part6_create_bot.png)

- create script `notification.sh` using the bot's token and telegram profile id


add to every job in .gitlab-ci.yml:

![](pic/part6_afterscript.png)

![](pic/part6_notification.png)

