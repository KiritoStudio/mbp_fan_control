#!/bin/bash

hotTemp=42
fireTemp=52

normalFanSpeed=2000
hotFanSpeed=3500
fireFanSpeed=5000

#smc directory
smcDir='/Applications/smcFanControl.app/Contents/Resources'
ggrep='/usr/local/bin/ggrep'

get16xFrom10xSpeed() {
    speed=$(python -c "print hex($1 << 2)" | sed 's/0x//g')
}

getCPUTemp() {
    echo "smc.gettemp: $(./smc -k TC0P -r)"
    cputemp=$(./smc -k TC0P -r | $ggrep -P '(?<=\s)[\d\.]+(?=[\s]*\(.*)' -o)
}

changeFanModeIfAuto() {

    mode=$(./smc -k "FS! " -r | $ggrep -P '(?<=\s)\d+(?=[\s]*\(.*)' -o)
    if [ $mode != '1' ]; then
        ./smc -k "FS! " -w 0001
        echo 'changed the fan mode to force.'
    else
        echo 'mode is already setting to force.'
    fi

}

setFanSpeed() {

    speed16x=$(python -c "print hex($1 << 2)" | sed 's/0x//g')
    ./smc -k F0Tg -w $speed16x
    echo "set speed to $1"
}


# go to smc directory
cd $smcDir

#control fan in manual mode
changeFanModeIfAuto

getCPUTemp

echo "cpu proximity temp: $cputemp"

if [ $(echo $cputemp'>'$fireTemp | bc -l) -eq 1 ]; then
    setFanSpeed $fireFanSpeed
elif [ $(echo $cputemp'>'$hotTemp | bc -l) -eq 1 ]; then
    setFanSpeed $hotFanSpeed
else
    setFanSpeed $normalFanSpeed
fi





