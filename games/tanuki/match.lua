msg="Match!"
icons={1,5,6}
color=13

function load()
    win=false
    imgs={assets.match.obj1,assets.match.obj2,assets.match.obj3}
    spacing=assets.match.obj1:getWidth()+8
    chosen=math.random(1,#imgs)
    revealed=false
    selection=1
    assets.countBg:setLooping(true)
    msc(assets.countBg)
end

function update(dt)
    if not revealed then
        if input:pressed("right") then
            selection=selection+1
            sfx(assets.log.jump)
        elseif input:pressed("left") then
            selection=selection-1
            sfx(assets.log.jump)
        end
        selection=clamp(selection,1,#imgs)
        if input:pressed("a") then
            revealed=true
            if chosen==selection then
                win=true
                sfx(assets.catch.win)
            else
                win=false
                sfx(assets.log.die)
            end
        end
    end
end

function draw()
    lg.clear(pal:color(4))

    if revealed then
        lg.draw(assets.match.bgBright)
    else
        lg.draw(assets.match.bgDark)
    end

    if revealed then lg.setColor(1,1,1,1) else lg.setColor(0,0,0,1) end
        lg.draw(imgs[chosen],conf.gW/2-16,(conf.gH/2)-20)
    lg.setColor(1,1,1,1)

    for k,v in ipairs(imgs) do
        if k==selection then
            lg.setColor(1,1,1,1)
        else
            lg.setColor(0.6,0.7,0.7)
        end
        local x=(k-1)
        local s=spacing
        lg.draw(v,(x*spacing)+(s/2),(conf.gH/2)+24)
    end
end

function leave()
    assets.countBg:stop()
end