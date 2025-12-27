---
title: "iptables"
date: 2022-08-19
categories: 
  - "linux"
---

Base on debian:

sudo apt update && sudo apt install -y ufw

sudo ufw allow ssh  
sudo ufw allow

sudo ufw enable

iptables -t nat -A PREROUTING -p tcp --dport 12000:12010 -j REDIRECT --to-port  
iptables -t nat -A PREROUTING -p udp --dport 12000:12010 -j REDIRECT --to-port

iptables -t nat -L PREROUTING -nv --line-number
