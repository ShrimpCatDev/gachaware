msg="Catch!"
icons={5,6}
color=15

function load()
    win=false
    pillow={}
    pillow.w=26
    pillow.h=15
    pillow.x=conf.gW/2-pillow.w/2
    pillow.y=121-math.floor(pillow.h/3)
    pillow.spd=80

    para={
        x=math.random(0,conf.gW-18),
        y=-18,
        w=18,
        h=18,
        spd=40,
        mode="fall",
        r=0,
        dx=0,
        dy=0
    }
    assets.catch.woosh:setLooping(true)
    msc(assets.catch.woosh)
end

function update(dt)
    if para.mode=="fall" then
        if input:down("left") then
            pillow.x=pillow.x-pillow.spd*dt
        end
        if input:down("right") then
            pillow.x=pillow.x+pillow.spd*dt
        end
        pillow.x=clamp(pillow.x,0,conf.gW-pillow.w)
        para.dx=para.x
        para.dy=para.y
        para.r=math.cos(time*4)/2
        para.y=para.y+para.spd*dt
        para.x=para.x+math.cos(time*4)/2

        if col(para.x,para.y,pillow.x,pillow.y+pillow.w/2,para.w,para.h,pillow.w,pillow.h/2) and para.y<pillow.y+pillow.w/2 then
            para.mode="land"
            win=true
            sfx(assets.catch.win)
        end
    else
        para.r=lerp(para.r,0,0.00001,dt)
        para.spd=0
        para.x=(pillow.x+pillow.w/2)-para.w/2
        para.dy=lerp(para.dy,para.y,0.1*dt,dt)
        para.dx=lerp(para.dx,para.x,0.1*dt,dt)
    end
end

function draw()
    lg.draw(assets.catch.bg)
    lg.draw(assets.catch.pillow,pillow.x,pillow.y)
    lg.draw(assets.catch.para,para.dx+para.w/2,para.dy,para.r,1,1,para.w/2,0)
    --122 or 121
end

function leave()
    assets.catch.woosh:stop()
end