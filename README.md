# mbp_fan_control
Control your mac fan with your custom level.

### Warning
The script is test on my MacBook Pro (Retina, 13-inch, Early 2015), you may use it with your own risk.

### Prerequest
1. brew install grep
2. install smcFanControl from https://github.com/hholtmann/smcFanControl

### Alter script
1. Two level temperatures: hotTemp(42), fireTemp(52). 
2. Three level speed: normalFanSpeed(2000), hotFanSpeed(3500), fireFanSpeed(5000)
You can edit it with your like.
3. Alter smcDir to change the smcFanControl path 

### Add to crontab
1. Open the terminal and type: crontab -e
2. Add tasks:
```bash
* * * * * ( /Users/kirito/Projects/fan_control.sh >> /Users/kirito/Projects/fan_control.log)
* * * * * ( sleep 10 ; /Users/kirito/Projects/fan_control.sh >> /Users/kirito/Projects/fan_control.log )
* * * * * ( sleep 20 ; /Users/kirito/Projects/fan_control.sh >> /Users/kirito/Projects/fan_control.log )
* * * * * ( sleep 30 ; /Users/kirito/Projects/fan_control.sh >> /Users/kirito/Projects/fan_control.log )
* * * * * ( sleep 40 ; /Users/kirito/Projects/fan_control.sh >> /Users/kirito/Projects/fan_control.log )
* * * * * ( sleep 50 ; /Users/kirito/Projects/fan_control.sh >> /Users/kirito/Projects/fan_control.log )
```
You can edit your own directory instead of the given path.
Also you can remove the fan_control.log
