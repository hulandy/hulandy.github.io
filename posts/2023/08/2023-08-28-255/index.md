---
title: "The notice of Hdzero on ardupilot"
date: 2023-08-28
categories: 
  - "fpv"
---

Categories：FPV August 28, 2023

When we first setup our Hdzero vtxs with Ardupilot firmware we tend to google it first, at least that's what I have been. And there are articles that suggest to set "MSP" option to "4". But as times gone by we no longer need to do so. Just simply leave it there the default "0" and set the corresponding serial port to "42", don't mess up with braud rates and leave the default "115" and it is good to go.  
Also need to know you need the newer versions of Hdzero firmware. It contains the essential fonts that ardupilot OSD use to display.
