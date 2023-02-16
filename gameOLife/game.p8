pico-8 cartridge // http://www.pico-8.com
version 33
__lua__


#include buttons.lua
#include colors.lua
#include alarms.lua

function _init()
    cell={}
    cur_X=0
    cur_Y=0

    ALIVE=10
    DEAD=0
    PICKING=8
    RUN=1
    STOP=2
    
    for i=0,31 do
        cell[i]={}
    end
    for i=0,31 do
        for j=0,31 do
            cell[i][j]={STATE=DEAD,neighbors=0}
        end
    end
end

function _update60()
    --to navigate the game board
    --mod cur_x and/or cur_y to get which cell

    if btnp(UP) and cur_Y>0 then
        cur_Y-=4
    elseif btnp(UP) and cur_Y<=0 then
        cur_Y=124
    end
    if btnp(DOWN) and cur_Y<124 then
        cur_Y+=4
    elseif btnp(DOWN) and cur_Y>=124 then
        cur_Y=0
    end
    if btnp(LEFT) and cur_X>0 then
        cur_X-=4
    elseif btnp(LEFT) and cur_X<=0 then
        cur_X=124
    end
    if btnp(RIGHT) and cur_X<124 then
        cur_X+=4
    elseif btnp(RIGHT) and cur_X>=124 then
        cur_X=0
    end


end


function _draw()
    cls()
    --draw the board, each cell is 4 x 4 pixels 
    --draw each cell with its give state color and with a blue outline on each cell
    for i=0,31 do
        for j=0,31 do
            rectfill(4*i,4*j,4*(i+1),4*(j+1),cell[i][j].STATE)
            rect(4*i,4*j,4*(i+1),4*(j+1),BLUE)--check if this is correct, think i am 1 tmany pixels for each square
        end
    end
    DrawCursor(cur_X,cur_Y)

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
