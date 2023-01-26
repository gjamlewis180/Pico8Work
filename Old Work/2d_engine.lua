--basic framework for a 2d engine
-- for use with pico-8

--


--for drawing objects 
--modifiy/fix later
--in pico-8 spr(sprite_number,x,y,optional_width,optional_height,optional_flip_x,optional_flip_y)
function DrawObj(o)
    if o.visible==true then
        spr(o.sprite,o.x,o.y,1,1,o.flipped)
    end
end

--move objects because of trigonomitry
function MoveObject(o)
    o.x=o.x+cos(o.direction/360)*o.speed
    o.y=o.y-sin(o.direction/360)*o.speed
end

function UpdateObj(o)
    MoveObject(o)
end

function NewObject(x,y,w,h,sprite,speed,direction,flipped,type)
    local o ={}
    o.x=x;
    o.y=y; 
    o.w=w; 
    o.h=h;
    o.sprite=sprite
    o.speed=speed or 0
    o.direction=direction or 0
    o.flipped=flipped or false
    o.type=type or 0
    o.destroyed=false
    o.visible=true
    o.Draw=DrawObj
    o.Update=UpdateObj
    return o
end

function RectHit(r1,r2)
    if (PtInRect(r1.x, r1.y, r2)) then return true end
    if (PtInRect(r1.x+r1.w, r1.y, r2)) then return true end
    if (PtInRect(r1.x, r1.y+r1.h, r2)) then return true end
    if (PtInRect(r1.x+r1.w, r1.y+r1.h, r2)) then return true end

    if (PtInRect(r2.x, r2.y, r1)) then return true end
    if (PtInRect(r2.x+r2.w, r2.y, r1)) then return true end
    if (PtInRect(r2.x, r2.y+r2.h, r1)) then return true end
    if (PtInRect(r2.x+r2.w, r2.y+r2.h, r1)) then return true end

    return false
end

--assumes r has x,y,w,has
function PtInRect(x,y,r)
    if x>=r.x and x<=r.x+r.w then
        if y>=r.y and y<=r.y+r.h then
            return true
        end
    end
    return false
end