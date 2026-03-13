msg="Dodge!"
icons={3,4,5,6}
color=18

function load()
    win=true
    local g=anim8.newGrid(16,16,assets.dodge.player:getWidth(),assets.dodge.player:getHeight())
    local s=0.15
    pl={
        anim={
            up=anim8.newAnimation(g("1-2",2),s),
            down=anim8.newAnimation(g("1-2",1),s),
            right=anim8.newAnimation(g("1-2",3),s),
            left=anim8.newAnimation(g("1-2",4),s)
        }
    }
    pl.anim.current=pl.anim.down
    pl.w=16
    pl.h=16
    pl.x=conf.gW/2-pl.w/2
    pl.y=conf.gH/2-pl.h/2
    pl.spd=50
    pl.dead=false

    bullets={}
    timer:every(0.4,function()
        local n=math.random(1,2)
        local m={1,-1}
        if math.random(1,2)==1 then
            local t={-16,conf.gH}
            table.insert(bullets,{x=math.random(0,conf.gW-16),y=t[n],vx=0,vy=60*m[n]})
        else
            local t={-16,conf.gW}
            table.insert(bullets,{x=t[n],y=math.random(0,conf.gH-16),vx=60*m[n],vy=0})
        end
    end)
    local g=anim8.newGrid(16,16,assets.dodge.killer:getWidth(),assets.dodge.killer:getHeight())
    anim=anim8.newAnimation(g("1-2",1),0.1)
    img={x=0,y=0,w=0,h=0}
    assets.actionBg:setLooping(true)
    msc(assets.actionBg)
end

function update(dt)
    if not pl.dead then
        if input:down("up") then
            pl.anim.current=pl.anim.up
            pl.anim.current:update(dt)
            pl.y=pl.y-pl.spd*dt
        end
        if input:down("down") then
            pl.anim.current=pl.anim.down
            pl.anim.current:update(dt)
            pl.y=pl.y+pl.spd*dt
        end
        if input:down("left") then
            pl.anim.current=pl.anim.left
            pl.anim.current:update(dt)
            pl.x=pl.x-pl.spd*dt
        end
        if input:down("right") then
            pl.anim.current=pl.anim.right
            pl.anim.current:update(dt)
            pl.x=pl.x+pl.spd*dt
        end
        pl.x=clamp(pl.x,0,conf.gW-pl.w)
        pl.y=clamp(pl.y,0,conf.gH-pl.h)
        for k,v in ipairs(bullets) do
            v.x=v.x+v.vx*dt
            v.y=v.y+v.vy*dt
            if col(v.x+2,v.y+2,pl.x,pl.y,16-4,16-4,16,16) then
                pl.dead=true
                win=false
                img.x,img.y=pl.x+8,pl.y+8
                timer:tween(0.5,img,{x=conf.gW/2,y=conf.gH/2,w=1,h=1})
                assets.actionBg:stop()
                sfx(assets.dodge.death)
            end
        end
    else

    end
    anim:update(dt)
end

function draw()

    local w,h=conf.gW,conf.gH
    local n=8
    local ty=time*15
    local tx=ty
    lg.setColor(pal:color(30))
    for x=-1,w/n do
        for y=-1,h/n do
            if (x+y)%2==0 then
                lg.rectangle("fill",x*n+(tx%n),y*n+(ty%n),n,n)
            end
        end
    end

    lg.setColor(0,0,0,1)
    pl.anim.current:draw(assets.dodge.player,pl.x+2,pl.y+2)
    lg.setColor(1,1,1,1)
    pl.anim.current:draw(assets.dodge.player,pl.x,pl.y)

    for k,v in ipairs(bullets) do
        anim:draw(assets.dodge.killer,v.x,v.y)
    end

    lg.draw(assets.dodge.images,img.x,img.y,0,img.w,img.h,assets.dodge.images:getWidth()/2,assets.dodge.images:getHeight()/2)

    lg.setColor(0,0,0,0.1)
    for y=0,conf.gH do
        if y%2==0 then
            lg.rectangle("fill",0,y,conf.gW,1)
        end
    end
end

function leave()
    assets.dodge.death:stop()
    assets.actionBg:stop()
end