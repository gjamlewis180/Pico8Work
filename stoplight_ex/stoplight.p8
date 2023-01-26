pico-8 cartridge // http://www.pico-8.com
version 29
__lua__

#include alarms.lua
#include colors.lua

function _init()
    c=RED
    alarm0=MakeAlarm(90,ChangeColor)
end

function _update()
    UpdateAlarms()
end

function _draw()
    --printh("clearing screen")
    cls(0)
    rect(0,0,32,76,WHITE)
    circ(16,16,8,WHITE)-- top light
    circ(16,38,8,WHITE)-- middle light
    circ(16,60,8,WHITE)-- bottom light
    --printh("building light frame")
    if (c==RED) then
        circfill(16,16,7,RED)
    elseif (c==DARK_GREEN) then
        circfill(16,60,7,DARK_GREEN)
    elseif (c==YELLOW) then
        circfill(16,38,7,YELLOW)
    end


end

function ChangeColor()
    if (c==RED) then
        c=DARK_GREEN
        StartAlarm(alarm0,150)
        printh("green light")
    elseif (c==DARK_GREEN) then
        c=YELLOW
        StartAlarm(alarm0,60)
        printh("yellow light")
    elseif (c==YELLOW) then
        c=RED
        StartAlarm(alarm0,90)
        printh("red light")
    end
end

__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
