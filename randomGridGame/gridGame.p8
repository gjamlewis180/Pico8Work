pico-8 cartridge // http://www.pico-8.com
version 42
__lua__


--this is just a simple checkers game
#include buttons.lua
#include colors.lua

function _init()
    --initialize the board, board will be 16x16
    checker={}
    curX=0
    curY=0
    NORMAL=0
    DEAD=2
    KING=1
    
    for i=0,7 do
        checker[i]={}
    end
    for i=0,7 do
        for j=0,7 do
            if i%2==j%2 and j<=2 then
                checker[i][j]={color=RED }
            end
        end
    end
    
end

function _update60()
    if btnp(UP) and curY>0 then
        curY-=16
    elseif btnp(UP) and curY<=0 then
        curY=112
    end
    if btnp(DOWN) and curY<112 then
        curY+=16
    elseif btnp(DOWN) and curY>=112 then
        curY=0
    end
    if btnp(LEFT) and curX>0 then
        curX-=16
    elseif btnp(LEFT) and curX<=0 then
        curX=112
    end
    if btnp(RIGHT) and curX<112 then
        curX+=16
    elseif btnp(RIGHT) and curX>=112 then
        curX=0
    end
    --printh(curX)
    --printh(curY)
end

function _draw()
    cls()
    --code to draw board goes here 
    for i=0,7 do
        for j=0,7 do
            if i%2 == j%2 then
                rectfill((16*i),(16*j),16*(i+1),16*(j+1),DARK_BLUE)
            else
                rectfill((16*i),(16*j),16*(i+1),16*(j+1),WHITE)
            end
            --boarders on each square 
            rect(16*i,16*j,16*(i+1),16*(j+1),BLUE)
        end
        
    end
    --this is because im lazy and dont want to make
    --drawing the board overly complicated just redraw 
    --exterior board 
    rect(0,0,127,127,BLUE) 
    DrawCursor(curX,curY)
    
end

function curCell(x,y)
    local x=curX/16
    local y=curY/16

    return x,y

end

function DrawCursor(x,y)
    
    rect(x,y,x+16,y+16,RED)
    --this makes a nice box around the bottom right box 
    if x==112 and y==112 then
        rect(x,y,x+15,y+15,RED)
    end
    --makes nice box for last column
    if x==112 and y==0 or x==112 and y==16 or
       x==112 and y==32 or x==112 and y==48 or
       x==112 and y==64 or x==112 and y==80 or
       x==112 and y==96 then
        rect(x,y,x+15,y+16,RED)
    end
    --makes nice box for last row
    if y==112 and x==0 or y==112 and x==16 or
       y==112 and x==32 or y==112 and x==48 or
       y==112 and x==64 or y==112 and x==80 or
       y==112 and x==96 then
        rect(x,y,x+16,y+15,RED)
    end
end

__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
