pico-8 cartridge // http://www.pico-8.com
version 29
__lua__

#include alarms.lua

function _init()
    
	index = 1
	title = {s,n,a,k,e}
	
	add( title, {x=0,y=48,spr=16} )
	add( title, {x=16,y=48,spr=18} )
	add( title, {x=32,y=48,spr=20} )
	add( title, {x=48,y=48,spr=18} )
	add( title, {x=16,y=64,spr=22} )
	
	titlealarm = MakeAlarm(5, nextletter)
	--resetalarm = MakeAlarm(180, _init)
end

function _update()
    
end

function _draw()
    
 --   cls()
--	drawlist(title)
	
	if (index == #title) then
		print("by dai z", 32, 86)
		print("press a button to start", 16, 100)
	end

end

--Drawing title letters.
function nextletter()
	if (index != #title) then
		index +=1
		StartAlarm(titlealarm,5)
	end
end

function drawlist()
	for i=1,index do
		spr(title[i].spr,title[i].x,title[i].y,2,2)
		end
	end

__gfx__
00000000000000000000000077777770770000070777777077000777077777700000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000070000080777000070770077077007700077777700000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000070000000777700070770077077077000077000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000077777770707770070770077077770000077777700000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000070700777070777777077770000077777700000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000040000070700077770777777077077000077000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000070000070700007770770077077007700077777700000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000077777770700000770770077077000777077777700000000000000000000000000000000000000000000000000000000000000000
