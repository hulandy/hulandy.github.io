---
title: "Delete a NVROM entry[reference]"
date: 2019-06-28
categories: 
  - "linux"
---

The EFI version 2 shell provides a command called bcfg that can do the job. You'd need to do bcfg boot dump -b to see the entries, then bcfg boot rm # to delete entry number # -- # must be the number associated with whatever entry you want to remove.

In Linux, efibootmgr can do the job: Type efibootmgr or efibootmgr -v to see the entries, then do efibootmgr -b # -B to delete entry #. (You must type these commands as root or using sudo.)

In Windows, the EasyUEFI tool should be able to handle the job, although I've only toyed with it briefly, so I can't give detailed instructions.
