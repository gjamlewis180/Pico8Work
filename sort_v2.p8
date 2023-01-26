pico-8 cartridge // http://www.pico-8.com
version 29
__lua__

#include alarms.lua
#include colors.lua


function _init()


	alarm0 = MakeAlarm(10,Tick)
	alarm1 = MakeAlarm(-1,_init)
	
	list = {}
	top = 128 --the index where you're going to put the biggest number
	
	--Step 1
	--Create a list of numbers 1 - 128
	--Here's one way to do it:
	--create a for loop that run from 1 to 128
	--inside the loop, put the loop counter into the list using the add() function
	 for i=1,128 do
		 add(list,i)
	 end
 	
	--Step 2
	--Shuffle the list.  Here's one way to do it`
	--Repeat 1000 times:
	--	generate a random number 1-128, call it r
	--	delete r number from the list using the del() function
	--	use the add() function to put r back into the list
	 for i=0,1000 do
		 r=flr(rnd(128))+1
		 del(list,r)
		 add(list,r)
	 end

end

--This function performs 1 pass of the sorting algorithm
--its purpose is to make a pass over the list and put the biggest
--value into list[top], which is the end of the list
function Sort()

	--Step 3
	--The variable 'top' contains the index to put the largest value in
	--Use a for loop that runs a counter from 1 to 'top', call your loop counter i.
	--(i is going to be your index into the list)
	--Inside the loop, if the value at index i  that is bigger than the value in list[top], 
	--exchange the values at those index i and index top (so the biggest one is at index top). 
	--This requires a temp variable (See the video if needed)
	for i=1,top do
		if list[i]>list[top] then
			temp=list[i]
			list[i]=list[top]
			list[top]=temp
		end
	end
	 
 
end

--Don't modify this
function Tick()

	if (top > 0) then
		Sort()
		top -= 1
		RestartAlarm(alarm0,1)
	else
		RestartAlarm(alarm1, 60)
	end	
end

--Don't alter this
function _update()
	UpdateAlarms()
end

--Don't alter this
function _draw()
	cls(BLACK)
		
	color(WHITE)
	print("TOP INDEX: " .. top, 0, 0)
	for i=1,128 do
		color( (i%15)+1 ) -- draw with the 15 non-black colors
		line(i-1,127,i-1,127 - list[i])
	end
end



__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
