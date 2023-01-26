pico-8 cartridge // http://www.pico-8.com
version 29
__lua__

#include colors.lua
#include buttons.lua

function _init()
    player={sprite=1,x=0,y=0}
    shots={}
    gameOutterRad=60
    gameInnerRad=5
    game_centerX=63
    game_centerY=63

    degrees=0
end

function _update60()
    if (btn(RIGHT,0)) then
        degrees += 0.0125
    end
    if (btn(LEFT,0)) then
        degrees -= 0.0125
    end
    if (btnp(BUTTONO,0)) then
        local sh= {x=player.x-4,y=player.y-4, shotRad=gameOutterRad, shotDegrees=degrees}
        add(shots,sh)
    end

    rotateObject(63, 63, 60, player)
    --update each shot
    for s in all(shots) do
        s.shotRad-=1
        s.x = 63 + (s.shotRad * cos(s.shotDegrees))
        s.y = 63 + (s.shotRad * sin(s.shotDegrees))
    end

    
    for s in all(shots) do
        testX=game_centerX-s.x
        testY=game_centerY-s.y
        d=(gameInnerRad*gameInnerRad) - ((testX*testX)+(testY*testY))

        if (d>=0) then
            del(shots,s)
        end

    end

end

function _draw()
    cls()
    --inner tube
    circ(63,63,5,yellow)
    x0=63
    y0=63
    for i=0,360,30 do
        segSize=i/360

        endLinex = 63 + (60 * cos(segSize))
        endLiney = 63 + (60* sin(segSize))

        line(x0+(5 * cos(segSize)),y0+(5* sin(segSize)),endLinex,endLiney,yellow)
        
    end
    
    
    --outter tube
    circ(63,63,60,yellow)

    spr(player.sprite,player.x-4,player.y-4)
    --draw shots 
    for s in all(shots) do
        pset(s.x,s.y,blue)
    end
    
end



--rotate an object around a give circle
function rotateObject(x, y, radius, o)
    
    --We update the o's position by incrementing the degrees and using our formula
    --x + (radius * cosine(degrees)) = a point on the edge of the circle in the x-axis
    --y + (radius * sine(degrees)) = a point of the edge of the circle in the y-axis
    o.x = x + (radius * cos(degrees))
    o.y = y + (radius * sin(degrees))
end

function makeShoot()
    
end

function moveShoot(player,radius)
    
end

__gfx__
0000000000aaaa000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000a8888a00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700a8acca8a0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000a8c44c8a0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000a8c44c8a0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700a8acca8a0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000a8888a00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000aaaa000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
