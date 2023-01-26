pico-8 cartridge // http://www.pico-8.com
version 29
__lua__

#include buttons.lua
#include alarms.lua

function _init()
    game_sprites={1,3,5} --list of all of the games sprite indexes that are found from Pico-8 sprite editor 
    i=1 -- set a variable used for holding the list's index
    player=1 --set a variable that holds what the image index the player currently is 
    computer=1 --set a variable that holds what the image index the computer currently is 
    game_output=""--set a variable used to hold output string

    player_score=0 -- set a variable to hold players score
    com_score=0 -- set a variable to hold computers score
    draws=0 -- set a variable to hold how many tie games have occured
    animate_com_alarm=MakeAlarm(90, Animate_com_selection)
end

function _update60()
    UpdateAlarms()
    --If the player pressed the left button
    --subtract 1 from the list index variable
    --then if the list index variable is greater than or equal to 1 set the player to the game sprite from our 
    if btnp(LEFT) then
        --print("in left press")
        i-=1
        if (i>=1) then
            player=game_sprites[i]
        elseif i<=0 then
            i=3
            player=game_sprites[i]
        end
    end
    if btnp(RIGHT) then
        --print("in right press")
        i+=1
        if (i<=3) then
            player=game_sprites[i]
        elseif i>3 then
            i=1
            player=game_sprites[i]
        end
    end
    
    if (btnp(BUTTON1)) then
        StartAlarm(animate_com_alarm,-1)
        Pick_Computers_Move()
        Check_Winner()
    end

end

function _draw()
    cls()
    --players ui stuff
    print("score: "..player_score,28,45,12)
    
    print("you",36,52,7)
    spr(player,34,60,2,2,true)

    --com ui stuff
    print("score: "..com_score,72,45,12)
    print("computer",72,52,7)
    spr(computer,78,60,2,2)

    print("draws: "..draws,44,90,12)
    if game_output=="draw" then
        print("its a draw",44,100,8)
    elseif game_output=="Com_Win" then
        print("you lose!!",44,100,8)
    elseif game_output=="Player_Win" then
        print("you win!!",44,100,8)
    end
    
end

function Pick_Computers_Move()
    comPick=flr(rnd(3))
    
    if (comPick==0) then
        computer=game_sprites[1]
    elseif (comPick==1) then
        computer=game_sprites[2]
    elseif (comPick==2) then
        computer=game_sprites[3]
    end
    
end

function Check_Winner()
    if player == computer then
        game_output="draw"
        draws+=1
    elseif (computer==1 and player==5) or
    (computer==3 and player==1) or
    (computer==5 and player==3) then
        game_output="Com_Win"
        com_score+=1
    elseif (player==1 and computer==5) or
    (player==3 and computer==1) or
    (player==5 and computer==3) then
        game_output="Player_Win"
        player_score+=1
    end
end

function Animate_com_selection(x)
    i+=1
    if (x==1) then
        
    end
    if (i<=3) then
        computer=game_sprites[i]
    elseif i>3 then
        i=1
        computerq=game_sprites[i]
    end
    StartAlarm(animate_com_alarm,90)
end

__gfx__
00000000777777777777777777777777777777777777777777777777000000000000000000000000000000000000000000000000000000000000000000000000
00000000700000000000000770000000000000077000000000000007000000000000000000000000000000000000000000000000000000000000000000000000
007007007000006666600007700aaaaaaaaaa007700000000ccc0007000000000000000000000000000000000000000000000000000000000000000000000000
000770007000066444666607700aaaaaaaaaa007700000000c00c007000000000000000000000000000000000000000000000000000000000000000000000000
000770007000664444444607700ffffffffff007705500000c00c007000000000000000000000000000000000000000000000000000000000000000000000000
007007007006644444444667700aaaaaaaaaa007700555005ccc0007000000000000000000000000000000000000000000000000000000000000000000000000
000000007666444444444467700ffffffffff0077000555555000007000000000000000000000000000000000000000000000000000000000000000000000000
000000007664444444444467700aaaaaaaaaa0077000005565000007000000000000000000000000000000000000000000000000000000000000000000000000
000000007644444444444667700ffffffffff007700000055cccc007000000000000000000000000000000000000000000000000000000000000000000000000
000000007644444444444467700aaaaaaaaaa007700005550c000c07000000000000000000000000000000000000000000000000000000000000000000000000
000000007666444444444667700ffffffffff0077000555000c00c07000000000000000000000000000000000000000000000000000000000000000000000000
000000007006444444444467700aaaaaaaaaa00770055000000cc007000000000000000000000000000000000000000000000000000000000000000000000000
000000007006444444666667700ffffffffff0077050000000000007000000000000000000000000000000000000000000000000000000000000000000000000
000000007006664466600007700aaaaaaaaaa0077000000000000007000000000000000000000000000000000000000000000000000000000000000000000000
00000000700006666000000770000000000000077000000000000007000000000000000000000000000000000000000000000000000000000000000000000000
00000000777777777777777777777777777777777777777777777777000000000000000000000000000000000000000000000000000000000000000000000000
