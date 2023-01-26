pico-8 cartridge // http://www.pico-8.com
version 18
__lua__

#include alarms.lua
#include colors.lua



function _init()

	alarm0 = MakeAlarm(10,Tick)
	alarm1 = MakeAlarm(-1,_init)
	
	list = {}
	S1={}
	S2={}
	top = 2 --the index where you're going to put the biggest number
	
	--Step 1
	--Use a for loop to populate indexes 1 to 128 with
	--the numbers from 1 to 128.
	--
	--for example:  index 1 in the list should contain 1
	--				index 2 in the list should contain 2
	--				index 3 in the list should contain 3...
	for i=1,128 do
		list[i]=i
	end
	 
	
	--Step 2
	--Shuffle the list
	--Repeat 1000 times:
	--	generate a random number 1-128
	--	delete that number from the list
	--	add the number back to the list (to move it to the end)
	for i=0,1000 do
		x=flr(rnd(128))+1
		del(list,x)
		add(list,x)
	end
end

--Step 3:
--This function performs 1 pass of the sorting algorithm
--to sort "list" into ascending order.
--
--The variable top contains the index to put the highest value in.
--Use a for loop to look at the list entries in indexes 1 to top.
--
--If you find a value at an index that is bigger than the one stored 
--at the top index, exchange the values at those indexes, so the 
--biggest one is at index top.  See the "Shuffling" video.  This is in C#
--but I think you can adapt it to Lua.
--
--
--After the loop, add 1 to top
function SelectSort()
	 --Complete this using the instructions above
	for i=1,top do
		if list[i]>list[top] then
			temp = list[top]
			list[top]=list[i]
			list[i]=temp
		end
	end
	top+=1
end
 
function MergeSort(S)
	n=count(S)
	if (n<2) return
	mid = flr(n/2)
	for i=1,mid do
		del(S1,i)
		add(S1,list[i])
	end
	for i=mid,128 do
		del(S2,i)
		add(S2,list[i])
	end
	MergeSort(S1)
	MergeSort(S2)
	Merge(S1,S2,list)

end

function Merge(S1,S2,S)
	i=0
	j=0
	while (i+j < #S) do
		if (j==#S2) or (i<#S1 and S1[i] < S2[j] ) then
			list[i+j]=S1[i]
			i+=1
		else
			list[i+j]=S2[j]
			j+=1
		end
	end
end 
--Don't modify this
function Tick()

	if (top <= 128) then
		SelectSort()
		--MergeSort(list)		this wont work herk 
		RestartAlarm(alarm0,1)
	else
		RestartAlarm(alarm1, 60)
	end

	
end
--Don't alter this
function _update()
	UpdateAlarms()
end

--Don't modify this
function _draw()
	
	cls(BLACK)
	
	color(WHITE)
	printh("top index: " .. top)
	
	if (#list == 128) then
	
		for i=1,128 do
			color( (i%15)+1 ) -- draw with the 15 non-black colors
			line(i-1,127,i-1,127 - list[i])
		end
	else
		printh("your list needs 128 values!")
	end
	 
end



__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
