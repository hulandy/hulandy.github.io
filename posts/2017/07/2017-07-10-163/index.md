---
title: "How to use arduino UNO  Flash BLHELI to a turnigy plush 18a esc"
date: 2017-07-10
categories: 
  - "default"
---

I wish I had coding skills, then I could reprogram my brushless ESCs to brushed ESCs.  
After I flashed a mod hex of an older plush 30a ESC(with the different MCU. [https://launchpad.net/brushed](https://launchpad.net/brushed)) to my plush 18a but failed.

In order to save my poor ESC, I used BLHELISuite to do this:  
Open BlheliSuite, "Make interfaces", make "Arduino 4way-interface", for "SiLabs C2" interface.

Then select "Interfaces" to " SiLabs C2(4way-IF)

Use 3 wires to connect between UNO and ESC, ![owsilprog-arduino-uno-scheme-02-wp.jpg](images/601497636.jpg "owsilprog-arduino-uno-scheme-02-wp.jpg")  
![Turnigy Plush 25A\_30A front.jpg](images/2459162054.jpg "Turnigy Plush 25A\_30A front.jpg")

Then the ESC can be rewritten.  
There is a little trick to connect wires, that is just connect the black wire to GND pin on the ESC cable.
