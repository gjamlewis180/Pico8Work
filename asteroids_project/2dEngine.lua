--library of code for 2d games

--draw the supplied object centered at its x,y centered for a 8x8 sprite
function DrawObject(o)
    if (o.destroy ~= true) then
        line(o.x,o.y,o.x1,o.y1,8)
        line(o.x,o.y,o.x2,o.y2,8)
        line(o.x1,o.y1,o.x2,o.y2,8)
    end
end


--creates and returns a new object
function MakePlayer(x,y,speed,direction)
    local o={}
    o.x=x
    o.y=y
    o.x1=x-4
    o.y1=y+8
    o.x2=x+4
    o.y2=y+8
    o.speed=speed
    o.direction=direction
    o.destroy=false
    o.Draw = DrawObject
    o.w = 3 --pixels wide of half the width
    o.h = 5 --pixels tall
    return o
end


--move object based on speed and direction
function MoveObject(o)
    o.x = o.x +cos(o.direction/360)*o.speed
    o.y = o.y +sin(o.direction/360)*o.speed
end

--this function returns true of false depending on whether x,y is inside the object
function PtInRect( x,y,o )
    if (x>= o.x-o.w/2 and x <= o.x+o.w/2)then
        if (y>= o.y-o.h/2 and y <= o.y+o.h/2)then
            return true
        end
    end
   return false
end

--returns true or false based on whether the objects overlap of not
function RectHit( o1,o2 )
    local dx= abs(o2.x - o1.x)
    local dy= abs(o2.y - o1.y)
    
    if (dx< o1.w/2 + o2.w/2) then
        if (dy< o1.h/2 + o2.h/2) then
            return true
        end
    end
    return false

end

--moves an object toward,destX, destY
--speed is optional
function MoveToward( o,destX,destY,newSpeed )
    if (newSpeed ~= nil) then
        o.speed=newSpeed
    end

    o.direction = atan2( destX - o.x, destY - o.y)*360
end


--starts o moving toward o2
function MoveTowardObject( o,o2,newSpeed )
    if (newSpeed ~= nil) then
        o.speed=newSpeed
    end

    o.direction = atan2( o2.x - o.x, o2.y - o.y)*360
end
--returns the distance between o1 and o2
function Distance(o1,o2)
    local dx = o1.x-o2.x
    local dy = o1.y-o2.y
    return sqrt( dx*dx + dy*dy )    
end
--return the distance between o1 and the point px,py
function DistanceToPoint(o1,px,py)
    local dx = o1.x-px
    local dy = o1.y-py
    return sqrt( dx*dx + dy*dy )    
end
