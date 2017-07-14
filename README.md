# README #


### What is this repository for? ###

This repository is for setting up Moodle via Docker Compose. Docker Compose is a tool for running multi-container Docker applications. 

### An Overview of the Moodle Structure ###

A Moodle application consists of three parts:

1. Moodle Core -- what you see at https://github.com/moodle/moodle

2. A Moodle Database -- this is a database (Mysql, in this case) which the Moodle application populates automatically. It contains site themes and settings.

3. Moodledata -- This is a Moodle term and means uploaded site content (i.e, course material).

### How do I get set up? ###

1. Install Docker
https://docs.docker.com/engine/installation/

2. Install Docker Compose
https://docs.docker.com/compose/install/

3. Clone this repo
git clone https://ELaskin@bitbucket.org/eeg1/complete-moodle-setup-with-docker-compose-pc.git

4. Change directories to the project
`cd complete-moodle-setup-with-docker-compose-pc/`

5. Spin it up `docker-compose up`

6. Visit [localhost](http://localhost)

* I have gotten an error related to port binding upon running this last command (Error Bind for 0.0.0.0:3306 failed: port is already allocated). This is because the docker-compose.yml file is binding port 3306 of the container to 3306 on your host machine. There are two ways to resolve this:

1. Kill the process on 3306

* Find port `sudo lsof -i :3306`

* Kill process (at your own risk!) `sudo kill -9 PID` replace PID with process ID.

2. Change the port in docker-compose.yml
ports:
      - "3306:3306" ----> "3300:3306"