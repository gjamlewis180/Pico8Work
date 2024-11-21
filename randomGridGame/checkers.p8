pico-8 cartridge // http://www.pico-8.com
version 42
__lua__


--this is just a simple checkers game
#include buttons.lua
#include colors.lua

function _init()
    --initialize the board, board will be 16x16
    checkerBoard={}
    curX=0--used for x cord on screen
    curY=0--used for y cord on screen 
    -- row=0 --used to what row on board
    -- col=0 --used for what col on board

    --these are the state for the pieces 
    EMPTY=0
    NORMAL=1
    DEAD=3--may not need 
    KING=2

    --this state is for when a cell should have nothing in it 
    NONE=nil

    WhosTurn=p1
    p1=1
    p2=2
    cursColor=RED

    --Game States used for selecting game pieces 
    PICKING=1
    MOVING=2
    gameState=PICKING
    --make i is col j is rows 
    for i=0,7 do
        checkerBoard[i]={}
    end
    for i=0,7 do
        for j=0,7 do
            checkerBoard[i][j]={state=EMPTY,Team=NONE }
        end
    end

    for i=0,7 do
        for j=0,7 do
            if i%2==j%2 then
                if j<=2 then
                    checkerBoard[i][j].state=NORMAL
                    checkerBoard[i][j].Team=p2
                elseif j>=5 then
                    checkerBoard[i][j].state=NORMAL
                    checkerBoard[i][j].Team=p1
                end
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
    --did the  current player  select a space that isnt empty 
    if btnp(BUTTONX) then
        if gameState==PICKING then

            col,row=curCell(curX,curY)
            printh("col: "..col.." row: "..row)
            printh(DataInCurCell(col,row))
            if checkerBoard[col][row].state==nil then
                printh("in if the says state is none")
                return
            else
                
                CheckCanMove(col,row)
            end
        end
    end

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

    --draw checkers pieces 
    for i=0,7 do
        for j=0,7 do
            if checkerBoard[i][j].Team==p2 and checkerBoard[i][j].state==NORMAL then
                --circfill((i*16)+8,(j*16)+8,6,RED)
                --circ((i*16)+8,(j*16)+8,6,ORANGE)
                spr(1,(i*16),(j*16),2,2)
            elseif checkerBoard[i][j].Team==p2 and checkerBoard[i][j].state==KING then --p2 piece draw as king
                circfill((i*16)+8,(j*16)+8,6,RED)
                circ((i*16)+8,(j*16)+8,6,ORANGE)
                circfill((i*16)+8,(j*16)+8,3,ORANGE)
            elseif checkerBoard[i][j].Team==p1 and checkerBoard[i][j].state==NORMAL then
                circfill((i*16)+8,(j*16)+8,6,PURPLE)
                circ((i*16)+8,(j*16)+8,6,DARK_GREEN)
                spr(9,i*16,j*16,2,2)
                spr(11,i*16,j*16,2,2)
            elseif checkerBoard[i][j].Team==p1 and checkerBoard[i][j].state==KING then --p1 piece draw as king 
                circfill((i*16)+8,(j*16)+8,6,PURPLE)
                circ((i*16)+8,(j*16)+8,6,DARK_GREEN)
                circfill((i*16)+8,(j*16)+8,3,PURPLE)
            end
        end
    end
    --this is because im lazy and dont want to make
    --drawing the board overly complicated just redraw 
    --exterior boarder 
    --rect(0,0,127,127,BLUE) 
    DrawCursor(curX,curY)

 
end

function curCell(x,y)
    local x=curX/16
    local y=curY/16

    return x,y

end

function DrawCursor(x,y)
    
    rect(x,y,x+16,y+16,cursColor)
    --this makes a nice box around the bottom right box 
    if x==112 and y==112 then
        rect(x,y,x+15,y+15,cursColor)
    end
    --makes nice box for last column
    if x==112 and y==0 or x==112 and y==16 or
    x==112 and y==32 or x==112 and y==48 or
    x==112 and y==64 or x==112 and y==80 or
    x==112 and y==96 then
        rect(x,y,x+15,y+16,cursColor)
    end
    --makes nice box for last row
    if y==112 and x==0 or y==112 and x==16 or
    y==112 and x==32 or y==112 and x==48 or
    y==112 and x==64 or y==112 and x==80 or
    y==112 and x==96 then
        rect(x,y,x+16,y+15,cursColor)
    end
end

function CheckCanMove(bX,bY)
    if checkerBoard[bX][bY].state!=EMPTY then
        
        

        if checkerBoard[bX][bY].Team ==p1 then
            printh(""..tostr(checkerBoard[bX][bY].Team))
            printh("picked current players piece")
        else
            
        end
    end

end

function DataInCurCell(dX,dY)
    cellData=""
    cellData="cell State: "..checkerBoard[dX][dY].state
    cellData=cellData..", cell Team: "..tostr(checkerBoard[dX][dY].Team)
    return cellData
    
end

__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050000000000000000000000000000000
00000000000000888880000000000000000000000000000000000000000000000000000000000000000000000000000060000000000000000000000000000000
00700700000008000008000000000222222000000000088888800000000002222220000000000000000000000000000050000000000000000000000000000000
00077000000080000000800000002233332200000000889999880000000022333322000000000000000000000000000060000000000000000000000000000000
00077000000800000000080000023333333320000008999999998000000233333333200000000000000000000000000050000000000000000000000000000000
0070070000800000000000800022332222332200008899c88c998800002233b22b33220000000000000000000000000060000000000000000000000000000000
0000000000800000000000800023322222233200008998c8c8899800002332b2b223320000000000000000000000000050000000000000000000000000000000
0000000000800000000000800023322222233200008998cc88899800002332bb2223320000000000000000000000000060000000000000000000000000000000
0000000065856565656565850023322222233200008998cc88899800002332bb2223320065656565656565650000000050000000000000000000000000000000
0000000000800000000000800023322222233200008998c8c8899800002332b2b223320000000000000000000000000060000000000000000000000000000000
0000000000800000000000800022332222332200008899c88c998800002233b22b33220000000000000000000000000050000000000000000000000000000000
00000000000800000000080000023333333320000008999999998000000233333333200000000000000000000000000060000000000000000000000000000000
00000000000080000000800000002233332200000000889999880000000022333322000000000000000000000000000050000000000000000000000000000000
00000000000008000008000000000222222000000000088888800000000002222220000000000000000000000000000060000000000000000000000000000000
00000000000000888880000000000000000000000000000000000000000000000000000000000000000000000000000050000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000060000000000000000000000000000000
