+++
title = "Running a Hacker news clone"
date = "2013-10-21T15:25:00"
tags = ["self-notes", "web", "tech"]
+++

I very much like the presentation of [hackernews](https://news.ycombinator.com/item?id=6576560) when it comes to understanding and making sense of the discussions quickly. It is a lot easier than reading pages of forums to get the main ideas of the discussions since the top comments and active discussions bubble to the top.

I wanted to run a site for discussing and sharing information that are useful for people working in techparks and the format that immediately clicked in my mind was the hacknews style. I began writing my own [clone](https://github.com/techparknews/hsnews) based on the work of people from [hackerschool](http://hackerschool.com/) but it lacked the polish and look to make the people trust and even sign up, I had send invites to few of my friends to try but the turnaround rate was quite low.

Now I wanted to validate whether there is any market for this idea (ie) do many techies have the need/difficulty to get info about the things and happenings around thier work place. I decided to deploy a polished better looking open source product and see how it gets picked up and used. I zeroed in on [Telescope](https://github.com/SachaG/Telescope) after having evaluated [Telescope](https://github.com/SachaG/Telescope) and [lobsters](https://github.com/jcs/lobsters). 

Reason for choosing Telescope are

1. Looks better and intutive and will be easy for people who have not used hacknews before
2. Supports sharing on social networks out of the box
3. Easy to setup
3. I like the idea of single page apps

Here are the steps that I did to install telescope on my VPS running Ubuntu 12.04

####Do all these from a previliged user

###Install nodejs
```bash
sudo apt-get install python-software-properties
sudo add-apt-repository ppa:chris-lea/node.js
sudo apt-get update
```
npm is now part of nodejs and installing nodejs installs it

```bash
sudo apt-get install nodejs
```
Check the node version, as of this writing Chris Lea repo has version 0.10.21
```bash
node --version
v0.10.21
```

###Install meteorite - Installer & smart package manager for Meteor
```bash
sudo npm install -g meteorite
```

####Login to the web user with limited previlage and clone the repository
I was testing the application from this user before starting it using upstart
```bash
git clone https://github.com/SachaG/Telescope.git
```
Configure Telescope to start automatically when system reboots, I have to do this because my VPS provider had restarted the server more than 3-4 times in a month

Create a file ```telescope.conf``` in ```/etc/init``` with the following contents
```bash
# meteorjs - meteorjs job file

description "Start Telescope"
author "tutysara"

# When to start the service
start on runlevel [2345]

# When to stop the service
stop on runlevel [016]

# Automatically restart process if crashed
respawn

# Essentially lets upstart know the process will detach itself to the background
expect fork

# Start the process
script
	export PATH=/opt/local/bin:/opt/local/sbin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
	export PWD=/home/web/telescopes/Telescope
	export NODE_PATH=/usr/lib/nodejs:/usr/lib/node_modules
	export HOME=/home/web
	export MONGO_URL=mongodb://localhost:27017/meteor
	echo "---- start ----"
	cd "/home/web/telescopes/Telescope"
	exec meteor run -p 3000 --production
end script
```
Finally test the scipt by starting, stopping and checking status
```bash
sudo start telescope
sudo status telescope
sudo stop telescope
```
If there are errors it can be seen in upstart logs at ```/var/log/upstart/telescope.log```.

The application can be accessed [here](http://www.techparknews.in). I use a rproxy to send port 80 to 3000

I registered for google analytics account and included it from the settings page after the application is deployed to check how this all goes.
