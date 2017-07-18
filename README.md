# README #


### What is this repository for? ###

This repository is for setting up Moodle via Docker Compose. This configuration is intended for spinning up an instance of the web app for testing purposes.

### An Overview of the Moodle Structure ###

A Moodle application consists of three parts:

1. Moodle Core -- what you see at https://github.com/moodle/moodle

2. A Moodle Database -- this is a database (Mysql, in this case) which the Moodle application populates automatically. It contains site themes and settings.

3. Moodledata -- This is a Moodle term and means uploaded site content (i.e, course material).

### A Little Bit About Docker, Docker Compose, and this Repo ###

Similar to a virtual machine, Docker is used as a means of isolating application parts for development. The commands for setting up the Docker environment/image are included in a file called Dockerfile. Docker images are portable and are thus used in development, testing, and production. An image can either be created by "building" off of a Dockerfile or by pulling an existing Docker image from a Docker Image Repository such as DockerHub. This repo contains the Dockerfile that I used to build the image on Dockerhub. 

Docker Compose is a tool for linking multiple Docker containers (instances of Docker images). For example, in this repo, the web application, web server, and libraries are set up in a container called "moodle" and the database runs in a separate "mysql" database. The containers are linked together in the docker-compose.yml file. Since Docker containers are ephemeral, Docker provides a system for persisting data via data volumes. The volume in this case is specified at the end of the docker-compose.yml file.

### Contents of this Repo ###

* .data directory contains the file-contents of the **moodle database**
* Dockerfile
* docker-compose.yml
* foreground.sh -- a shell script called by the Dockerfile
* moodle-config.php -- usually the install script will run and auto-create the config file. This configuration allows skipping the installation process. 

### How do I get set up? ###

You can spin up this project on your local pc or on a cloud provider. The configuration for a pc and cloud service varies slightly. The master branch of this repository will work for setting up the project on your **pc**.

If you're testing on the cloud, please clone the [config-for-cloud-service](https://bitbucket.org/eeg1/complete-moodle-setup-with-docker-compose-pc/src/a0548ccc6cd61fea2a81f71810e91df254b3aa35/docker-compose.yml?at=config-for-cloud-service) branch. The instructions below will work for installation on pc and cloud service. If serving on the cloud, be sure you are logged in to the server before you start.

1. Install Docker
https://docs.docker.com/engine/installation/

2. Install Docker Compose
https://docs.docker.com/compose/install/

3. Clone this repo

    For installation on your PC:
 
    `git clone https://ELaskin@bitbucket.org/eeg1/complete-moodle-setup-with-docker-compose-pc.git`

    For installation on Cloud Service:

    `git clone https://ELaskin@bitbucket.org/eeg1/complete-moodle-setup-with-docker-compose-pc.git --branch config-for-cloud-service --single-branch`

4. Change directories to the project
`cd complete-moodle-setup-with-docker-compose-pc/`

5. Spin it up `docker-compose up`

6. Visit [localhost](http://localhost)

    Note: I have gotten an error related to port binding upon running this last command (Error Bind for 0.0.0.0:3306 failed: port is already allocated). This is because the docker-compose.yml file is binding port 3306 of the container to 3306 on your host machine. There are two ways to resolve this:

    1. Kill the process on 3306

        * Find port `sudo lsof -i :3306`

        * Kill process (at your own risk!) `sudo kill -9 PID` replace PID with process ID.

    2. Change the port in docker-compose.yml
ports:
      - "3306:3306" ----> "3300:3306"