msg="Flash!"
icons={1,2}
color=6

function load()
    win=false
    flash={v=0,flashed=false}
    local i=assets.flash.tanuki
    ta={x=i:getWidth()-16,out=false}
    timer:after(math.random(1,3)/2,function()
        ta.out=true
        timer:tween(0.5,ta,{x=0},"out-cubic",function()
            
            timer:after(1,function()
                if not win then
                    ta.out=false
                    timer:tween(0.5,ta,{x=i:getWidth()},"out-cubic")
                end
            end)
        end)
    end)
    assets.flash.birds:setLooping(true)
    sfx(assets.flash.birds)
end

function update(dt)
    if not flash.flashed and (input:pressed("a") or input:pressed("b") ) then

        flash.flashed=true
        flash.v=1
        timer:tween(0.5,flash,{v=0},"out-cubic",function()
            msc(assets.flash.photo)
        end)
        if ta.out and flash.flashed then
            win=true
            
        end
    end
end

function draw()
    lg.draw(assets.flash.bg)
    local i=assets.flash.tanuki
    local y=conf.gH/2
    if win then
        i=assets.flash.tanukiFlash
        y=y+math.cos(time*32)*2
    end
    lg.draw(i,math.floor(conf.gW+ta.x),math.floor(y),0,1,1,i:getWidth(),i:getHeight()/2)
    lg.setColor(1,1,1,flash.v)
    lg.rectangle("fill",0,0,conf.gW,conf.gH)
    lg.setColor(1,1,1,1)
end

function leave()
    assets.flash.birds:stop()
end