--[[ 
    draw the cannon via built in line function and circle functions
 ]]
function DrawCannon(can)
    if (can.visible == true) then
        --left side
        line(can.x0,can.y0,can.x1,can.y1,11)
        --right side
        line(can.x2,can.y2,can.x3,can.y3,11)

        --top
        line(can.x1,can.y1,can.x2,can.y2,3)
        --bottom
        line(can.x0,can.y0,can.x3,can.y3,11)

        --drawing the four points and origin
        pset(can.x0,can.y0,8)
        pset(can.x1,can.y1,8)
        pset(can.x2,can.y2,8)
        pset(can.x3,can.y3,8)
        pset(can.originX,can.originY,14)
    end
end

--[[ this function creates a cannon object 



 ]]
function newCannon(x,y,canW,canH)
    local can={}

    can.canW=canW
    can.canH=canH
    --initializing cannons the four points of the cannon
    --
    can.x0=x
    can.y0=y

    can.x1=x
    can.y1=y-canH

    can.x2=x+canW
    can.y2=y-canH

    can.x3=x+canW
    can.y3=y

    --setting up point of rotation
    can.originX=x+(canW/2)
    can.originY=y
    --

    --cannons initial angle 
    can.angle=0


    can.visible=true
    can.Draw = DrawCannon
    return can
end

--set cannons points according to provided x and y can the cannon to work with
function setCannonPoints(cannon,x,y)
    cannon.x0=x
    cannon.y0=y
    cannon.x1=x
    cannon.y1=y-cannon.canH

    cannon.x2=x+cannon.canW
    cannon.y2=y-cannon.canH

    cannon.x3=x+cannon.canW
    cannon.y3=y

end

--[[ 
    rotate a pt (x,y) around a given origin s
 ]]
function rotatePtByOrig(x,y,ox,oy,rotation)
    local sina=sin(rotation)
    local cosa=cos(rotation)
   
    x-=cx
    y-=cy
    local rotx=cosa*x-sina*y
    local roty=sina*x+cosa*y
    rotx+=cx
    roty+=cy
   
    return rotx,roty
end

