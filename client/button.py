#!/usr/bin/env python
import RPi.GPIO as GPIO
import time
import os

GPIO.setmode(GPIO.BCM)
GPIO.setup(24, GPIO.IN, pull_up_down=GPIO.PUD_UP)

last_state = 0
first = True
while True:
  state = GPIO.input(24)
  if (first):
    first = False
  else:
    if ((not last_state) and state):
      print("button was pressed")
      os.system("echo scan | nc 192.168.1.3 19607")
      #debouncing#1
      time.sleep(0.25)
  last_state = state
  #short delay to let the things cool down-debouncing#2
  time.sleep(0.05)
