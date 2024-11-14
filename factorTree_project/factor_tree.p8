pico-8 cartridge // http://www.pico-8.com
version 42
__lua__
#include colors.lua

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
    poke(0x5F2D,1)
    --for holding given input 
    t=""
    --this will be used test if the given input is valid to use for this program
    c="" 
    txt_h=6
    txt_w=4
    x=0
    y=0
end

function _update60()
    --disable pausing menu when enter is pressed
    --this must be in update to work 
    poke(0x5f30,1)
    --printh(STATE)
    
    --need to fix for some reason even when state is invalid it
    --still takes keystrokes from runtime enviorment
    --need to find right moment to poke keyboard devkit and disable it
    if stat(30)==true and STATE!=INVALID then
        
        --get keyboard input and store it in c
        c=stat(31)
        --for debugging printing c to terminal
        printh(c)
        if c>="\48" and c<="\57" then
            --add the number stored in c to t
            t=t..c 
        --if backspace is pressed lets delete a character frim the string
        elseif c=="\8" then  
            t=backspacing(t)
        --when the  user presses enter
        elseif c=="\13"then
            printh("time to factor the number")
            STATE=RUN 
            --add the number to list
            add(list_of_factors,t) 
            divide(t)
            
            --still need to add error handling for invalid numbers 
            --[[ if tonum(t)<=98999 then
                printh("in if")
                STATE=INVALID
            else
                
            end ]]
            
        elseif c<="\47" or c >="\58" then
            --user pressed a key that isnt a number so time to handle that
            STATE=INVALID
        end
    end
end

function _draw()
    cls()
    if STATE==START then
        --print start message
        print(instruct,0,1,3)
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
    elseif STATE==INVALID and wait_time<=60 then 
        cls()
        print(invalid_mess,0,1,3)
        wait_time+=1
        if wait_time>=30 then
            wait_time=0
            STATE=START
            t=""
            c=""
        end
    elseif STATE==RUN then
        cls()
        --print(listAsString(list_of_factors),30,30,8)
        make_Fact_tree()
    end
end

--draw proper rectangle for the cursor h=x0, v=y0, x=x1,y=y1, c=color
function grect(h,v,x,y,c)
    --the 1 is just to make the rect on pixel smaller
    rectfill(h,v,h+x-1,v+y-1,c)
  end 

--[[
    function is provided the initial number, num, if it is divisible by the current 
    prime factor, prime_fact, then check if num divided by prime_fact is 
    not 1 then preform the division and add the prime factor and new factor 
    to our factor list. if num divided by prime_fact is 1 then prime_fact is the last prime factor 
    of the original number.
    if num is not divisible by the current prime factor then add 1 to prime_fact and call divide(num)
    ]]
prime_fact=2
function divide(num)
    if num%prime_fact == 0 then
        if num/prime_fact!=1 then
            num=num/prime_fact
            add(list_of_factors,prime_fact)
            add(list_of_factors,num)
            divide(num)
        else
            printh("finished running divided function")
            return
        end
    else
        prime_fact+=1
        divide(num)
    end   
end

--used to get length of string for math purposes 
function len(a)
    return #a
end
--can be used to turn contents of a list into a string

function listAsString(list)
    data_as_string=""
    for i=1,#list do
        if i==#list then
            data_as_string=data_as_string..list[i]
        else
            data_as_string=data_as_string..list[i]..","
        end
    end
    return data_as_string
end

function make_Fact_tree()
    cursor()--reset system cursor to upper left
    str=list_of_factors[1]
    color(3)
    x=print(str)--first number in the list of factors
    lastX,lastY,lastClr=cursor()
    x=lastX
    y=lastY
    --these are for placing the lines of factor tree
    x0=10
    y0=6
    lin1_x1=4
    y1=11
    lin2_x1=16
    --printh(x)
    for i=2,#list_of_factors do
        str=list_of_factors[i]
        if i%2==0 then

            print(str,x+(i*txt_w)-txt_w,y+(i*txt_h)-txt_h,3)
            line(x0,y0,lin1_x1,y1,red)
            
        else
            print(str,x+(i*txt_w)+txt_w,y+((i-1)*txt_h)-txt_h,3)
            line(x0,y0,lin2_x1,y1,red)
            x0+=8
            y0+=12
            lin1_x1+=8
            lin2_x1+=8
            y1+=12
        end
        
        --[[ this is the  work to figure out the line of the tree
        line(9,6,4,11,10)
        line(9,6,16,11,9)
       
        line(18,18,13,23,8)
        line(18,18,25,23,8)

        line(27,30,21,35,8)
        line(27,30,33,35,8)

        line(36,42,30,47,8)
        line(36,42,42,47,8)  ]]
        if i==#list_of_factors then
            --txt=listAsString(locations)
            --printh(txt)
            return--when we are done going through the list, finish running
        end

    end
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
