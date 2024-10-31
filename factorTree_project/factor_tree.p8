pico-8 cartridge // http://www.pico-8.com
version 42
__lua__
--
instruct=[[
  welcome to factor tree!!!
  this program you will give a
  4 digit number, and it will 
  generate the factor tree!!
]]

invalid_mess=[[
  only numbers work with this
  program, give me a sec
  and lets try again]]
wait_time=0
blink_time=0
list_of_factors={}

--these are the states of the program 
--used to set what the program should draw
--and to help handle errors
START=1
RUN=2
DONE=3
INVALID=4
TWOLONG=5
STATE=START

function _init()
    cls()
    --lets us use the keyboard for alphanumeric input
    poke(0x5F2D,0x1)
    t=""--for holding given input 
    c=""--this will be used test if the given input is valid to use for this program 
end

function _update60()
    if stat(30)==true then
        c=stat(31)--get keyboard input and store it in c
        printh(c)
        if c>="\48" and c<="\57" then
            t=t..c --add the number stored in c to t
        elseif c=="\8" then--if backspace is pressed lets delete a character frim the string 
            t=backspacing(t)
        elseif c=="\13"then
            printh("time to factor the number")
            --STATE=RUN
            poke(0x5f30,1)--disable pausing menu when enter is pressed
            --add the numberr to list

            --add(list_of_factors,t)
        elseif c<="\47" or c >="\58" then
            --user pressed a key that isnt a number so time to handle that
            STATE=INVALID
        end
    end
end

function _draw()
    cls()
    if STATE==START then
        print(instruct,0,1,3)--print start message
        --logic to make blinking cursor 
        blink_time+=1
        if blink_time<=10 then
            grect(64+len(t)*2,30,3,5,3)
            print(t,64-len(t)*2,30,8)
        elseif blink_time<=20 then
            grect(64+len(t)*2,30,3,5,3)
            print(t,64-len(t)*2,30,8)
            grect(64+len(t)*2,30,3,4,0)
        else
            grect(64+len(t)*2,30,3,5,3)
            print(t,64-len(t)*2,30,8)
            blink_time=0    
        end
        --end of cursor logic 
    elseif STATE==INVALID and wait_time<=120 then 
        cls()
        print(invalid_mess,0,1,3)
        wait_time+=1
        if wait_time>=120 then
            wait_time=0
            STATE=START
        end
    end
end

--draw proper rectangle for the cursor h=x0, v=y0, x=x1,y=y1, c=color
function grect(h,v,x,y,c)
    rectfill(h,v,h+x-1,v+y-1,c)--the 1 is just to make the rect on pixel smaller
  end 

function divide(a)
    number=a
    prime_fact=0
    factor=0
    if number%2 ==0 then

    end
end

--used to get length of string for math purposes 
function len(a)
    return #a
end

-- return string minus last chr
function backspacing(a)
    return sub(a,1,#a-1)
  end

__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
