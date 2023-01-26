--alarm library for PICO-8

alarms= {} -- list of alarms
--number of ticks and the function to run 
function MakeAlarm(ticks, func)
    local a={}
    a.ticks=ticks
    a.Action=func
    add(alarms,a)
    return a
end 

function UpdateAlarm(alarm)
    if (alarm.ticks>0) then
        alarm.ticks = alarm.ticks- 1
        --printh("tick")
    elseif(alarm.ticks==0) then
        alarm.ticks= -1 --stop counting
        alarm.Action()
    end
end

--called in _update()
function UpdateAlarms()
    foreach(alarms,UpdateAlarm)
end

--start/restart an alarm
function StartAlarm(alarm,t)
    if(alarm.ticks==-1) then
        alarm.ticks=t
    end
end