pico-8 cartridge // http://www.pico-8.com
version 29
__lua__

#include buttons.lua
#include colors.lua
#include alarms.lua


function _init()
    gamePaths={}
    OutterRing=NewObject(63,63,56,RING)
    add(gamePaths,OutterRing)
    InnerRing1=NewObject(63,63,42,RING)
    add(gamePaths,InnerRing1)
    InnerRing2=NewObject(63,63,36,RING)
    add(gamePaths,InnerRing2)
    InnerRing3=NewObject(63,63,28,RING)
    add(gamePaths,InnerRing3)
    CenterCirc=NewObject(63,63,8,CIRCLE)
    player=NewObject(0,0,5,PLAYER)
    pIndex=1
    player.curPath=gamePaths[pIndex]
    

    --rotateObject(player.curPath.x,player.curPath.y,player.curPath.radius,player)--place player on the outer ring of the 

end

function _update60()
    if (btn(RIGHT,0)) then
        player.degrees -= 0.0125
    end
    if (btn(LEFT,0)) then
        player.degrees += 0.0125
    end

    --the move the player onto different paths
    if (btnp(UP,0)) then
        pIndex+=1
        if  pIndex>#gamePaths then
            pIndex=1 
        end
        setPath(gamePaths[pIndex],player)
    end

    if (btnp(DOWN,0)) then
        pIndex-=1
        if  pIndex<1 then
            pIndex=#gamePaths
        end
        setPath(gamePaths[pIndex],player)
    end
    rotateObject(player.curPath.x,player.curPath.y,player.curPath.radius,player)
    
end

function _draw()
    cls()
    OutterRing.Draw(OutterRing)
    CenterCirc.Draw(CenterCirc)
    InnerRing1.Draw(InnerRing1)
    InnerRing2.Draw(InnerRing2)
    InnerRing3.Draw(InnerRing3)
    player.Draw(player)
end

--these constants are for the type of game object
RING=1
CIRCLE=2
PLAYER=3
--game engine starts here 
--make an object in pico8 based on pico8's circle functions
--type relates to the type of circle/pattren for drawing
    --type constants are set above 
function NewObject(x,y,radius,type)
    local o ={}
    o.x=x
    o.y=y
    o.radius=radius
    o.degrees=0
    o.type=type
    o.curPath={}
    --not working persently , attempt to make a turret object that would be on the player object
 --[[    o.turret=nil
    if (o.type==PLAYER) then
        --build and add a turret object to the player 
        o.turret={
            x=o.x,
            y=o.y,
            length=o.radius,
            degrees=o.degrees            
         }
    end
     ]]
    o.visible=true
    o.Draw = DrawObject
    return o
end

--draw our game objects 
--depending on o.type, what is drawn/ what is 
function DrawObject(o)
    if (o.visible == true) then
        if (o.type==RING) then
            circ(o.x,o.y,o.radius,ORANGE)
        elseif (o.type==CIRCLE) then
            circfill(o.x,o.y,o.radius,ORANGE)
            circfill(o.x,o.y,o.radius-1,LAVENDER)

        elseif (o.type==PLAYER) then
            circfill(o.x,o.y,o.radius,BLUE)--outer
            circfill(o.x,o.y,o.radius-1,WHITE)
            circfill(o.x,o.y,o.radius-2,DARK_BLUE)
            circfill(o.x,o.y,o.radius-3,RED)--center
            line(o.x,o.y,o.x-o.radius * cos(o.degrees),
            o.y-o.radius * sin(o.degrees),DARK_GREEN) -- a line drawn on the player that is currently pointing toward center 
            
        end

    end
end

--rotate an object around a given circle
function rotateObject(x, y, radius, o)
    --We update the o's position by incrementing the degrees and using our formula
    --x + (radius * cosine(degrees)) = a point on the edge of the circle in the x-axis
    --y + (radius * sine(degrees)) = a point of the edge of the circle in the y-axis
    o.x = x + (radius * cos(o.degrees))
    o.y = y + (radius * sin(o.degrees))
end
--the funstion takes in 2 objects, a game path and game object
--it places the game object on the given path object
function setPath(oPath,oGame)
    oGame.curPath=oPath

    oGame.x = oGame.curPath.x + (oGame.curPath.radius * cos(oGame.degrees))
    oGame.y = oGame.curPath.y + (oGame.curPath.radius * sin(oGame.degrees))
end

----this function returns true of false depending on whether x,y is inside the given circle object
function PtInCirc(x,y,o)
    testX=o.x-x
    testY=o.y-y
    d=(o.radius*o.radius) - ((testX*testX)+(testY*testY))

    if (d>=0) then
        return true
    end

    return false
    
end
__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
