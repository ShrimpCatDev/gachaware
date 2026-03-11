msg="Grow!"
icons={5,6}
color=12

function load()
    win=false
    --79, 133
    hole={x=49,y=1,w=63,h=21}
    sprout={x=79,y=133,rad=2,spd=35,r=math.rad(-90),dir=1,rspd=3,growed=false}
    canvas=lg.newCanvas(conf.gW,conf.gH)

    assets.countBg:setLooping(true)
    msc(assets.countBg)
end

function update(dt)
    if not sprout.growed then
        if input:pressed("left") then
            sprout.dir=-1
        end
        if input:pressed("right") then
            sprout.dir=1
        end
        sprout.r=sprout.r+(sprout.rspd*sprout.dir)*dt
        local r=sprout.r
        local spd=sprout.spd
        sprout.x=sprout.x+math.cos(r)*(spd*dt)
        sprout.y=sprout.y+math.sin(r)*(spd*dt)
        if col(sprout.x,sprout.y,hole.x,hole.y,1,1,hole.w,hole.h) then
            sprout.growed=true
            win=true
            sfx(assets.grow.win)
        end
    else

    end
end

function draw()
    lg.draw(assets.grow.bg)
    local c=lg.getCanvas()
    lg.setCanvas(canvas)
        lg.setColor(1,1,1,1)
        lg.circle("fill",sprout.x,sprout.y,sprout.rad)
    lg.setCanvas(c)
    
    lg.setColor(pal:color(12))
        lg.draw(canvas,1,0)
        lg.draw(canvas,-1,0)
        lg.draw(canvas,0,1)
        lg.draw(canvas,0,-1)
    lg.setColor(pal:color(4))
        lg.draw(canvas)
    lg.setColor(1,1,1,1)
    
    if sprout.growed then
        lg.draw(assets.grow.bloom,sprout.x,sprout.y,0,1,1,assets.grow.bloom:getWidth()/2,assets.grow.bloom:getHeight()/2)
    else
        lg.draw(assets.grow.blossom,sprout.x,sprout.y,sprout.r,1,1,0,assets.grow.blossom:getHeight()/2)
    end
    
end

function leave()
    assets.countBg:stop()
end