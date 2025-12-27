---
title: "Fixed my corrupted  database last night"
date: 2019-03-03
categories: 
  - "linux"
  - "raspi"
---

For some reason, I turned off the power switch last night, before I have done it, I forgot to shut down my home servers correctly. Then, it was not a surprise that the database on one of my Raspi crashed.  
In order to solve this problem, Follow the message it provide, use "journalctl -xe" command to show related information. Modify "my.cnf", add " innodb\_force\_recovery > 0 " then start the database, afterward comment the " innodb\_force\_recovery > 0" line in again, restart the database subsequently. Done.
