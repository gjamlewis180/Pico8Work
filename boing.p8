pico-8 cartridge // http://www.pico-8.com
version 29
__lua__
#include colors.lua

function _init()
    x=0
    y=0
    ymax=128
    oldYmax=ymax
    bounced=0
    angle=0
    cls(black)
end

function _update60()
    angle = x/128
    angle = angle *360
    angle*=4
    x+=1
    if (x==128) then
        x=0
        if (ymax<=0.5) then
            ymax=256
            oldYmax=ymax
        end 
        cls(0)
    end
    y=sin(angle/360)
    y=abs(y)
    y*=ymax

    if (oldYmax==ymax and bounced==1) then
        bounced=0
        ymax=flr(ymax/2)     
        oldYmax=ymax
    end
    if(y==0) then
        bounced=1  
        -- if (ymax<=0.5) then
        --     ymax=64
        --     oldYmax=ymax
        -- end 
    end
    
    printh(y)
end

function _draw()
    line(0,100,127,100,yellow)
    circfill(x,100-y,1,yellow)
    
end

__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
