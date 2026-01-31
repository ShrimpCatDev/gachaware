msg="Jump!"

function load()
    t=0
    spd=100
    assets.log.bg:setWrap("repeat")
    logs={}
    timer.every(2,function()
        table.insert(logs,{x=conf.gW,y=117-14,w=16,h=14})
    end)
    local g=anim8.newGrid(11,12,assets.log.sheet:getWidth(),assets.log.sheet:getHeight())
    pl={x=8,y=117-12,w=11,h=12,vy=0,anim=anim8.newAnimation(g('1-5',1),0.05),die=anim8.newAnimation(g('6-6',1),0.05)}
    pl.current=pl.anim
    win=true
    die=false
end

function update(dt)
    if not die then
        t=t+spd*dt
        for k,v in pairs(logs) do
            v.x=v.x-spd*dt
            if col(v.x,v.y,pl.x,pl.y,v.w,v.h,pl.w,pl.h) then
                die=true
                pl.vy=-50
                pl.current=pl.die
            end
        end
    end
    pl.vy=pl.vy+200*dt
    pl.y=pl.y+pl.vy*dt
    if pl.y>=117-12 then
        pl.vy=0
        pl.y=117-12
        if input:pressed("a") and not die then
            pl.vy=-100
        end
    end
    pl.current:update(dt)
end

function draw()
    for i=0,1 do
        lg.draw(assets.log.bg,-(math.floor(t)%assets.log.bg:getWidth())+i*assets.log.bg:getWidth(),0)
    end
    --117
    for k,v in pairs(logs) do
        lg.draw(assets.log.log,v.x,v.y)
    end
    pl.current:draw(assets.log.sheet,pl.x,pl.y)
end