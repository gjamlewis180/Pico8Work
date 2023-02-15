pico-8 cartridge // http://www.pico-8.com
version 33
__lua__


#include buttons.lua
#include colors.lua
#include alarms.lua

function _init()
    cell={}
    curX=0
    curY=0
    ALIVE=10
    DEAD=9
    PICKING=8
    for i=0,31 do
        cell[i]={}
    end
    for i=0,31 do
        for j=0,31 do
            cell[i][j]={STATE=ALIVE,neighbors=0}
        end
    end


end

function _update60()
    --to navigate the game board
    if btnp(UP) and curY>0 then
        curY-=4
    elseif btnp(UP) and curY<=0 then
        curY=124
    end
    if btnp(DOWN) and curY<127 then
        curY+=4
    elseif btnp(DOWN) and curY>=127 then
        curY=0
    end
    if btnp(LEFT) and curX>0 then
        curX-=4
    elseif btnp(LEFT) and curX<=0 then
        curX=124
    end
    if btnp(RIGHT) and curX<124 then
        curX+=4
    elseif btnp(RIGHT) and curX>=124 then
        curX=0
    end


end


function _draw()
    cls()
    --draw the board, each cell is 4 x 4 pixels 
    --draw each cell with its give state color and with a blue outline on each cell
    for i=0,31 do
        for j=0,31 do
            rectfill(4*i,4*j,4*(i+1),4*(j+1),cell[i][j].STATE)
            rect(4*i,4*j,4*(i+1),4*(j+1),BLUE)
        end
    end
    DrawCursor(curX,curY)

end


--
function DrawCursor(x,y)
    -- for i=0,3 do
    --     for j=0,3 do
    --         pset(x+i,y+j,PICKING) 
    --     end
    -- end
    rect(x,y,x+3,y+3,PICKING)
end





__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
