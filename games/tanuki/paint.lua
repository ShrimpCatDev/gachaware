msg="Flash!"

function load()
    win=false
    flash={v=0,flashed=false}
    local i=assets.paint.tanuki
    ta={x=i:getWidth()-16,out=false}
    timer.after(math.random(1,3)/2,function()
        timer.tween(0.5,ta,{x=0},"out-cubic",function()
            ta.out=true
            timer.after(2,function()
                if not win then
                    ta.out=false
                    timer.tween(0.5,ta,{x=i:getWidth()},"out-cubic")
                end
            end)
        end)
    end)
end

function update(dt)
    if not flash.flashed and (input:pressed("a") or input:pressed("b") ) then
        flash.flashed=true
        flash.v=1
        timer.tween(0.5,flash,{v=0},"out-cubic",function()
            
        end)
        if ta.out and flash.flashed then
            win=true
            
        end
    end
    print(flash.flashed and ta.out)
end

function draw()
    lg.draw(assets.paint.bg)
    local i=assets.paint.tanuki
    local y=conf.gH/2
    if win then
        i=assets.paint.tanukiFlash
        y=y+math.cos(time*32)*2
    end
    lg.draw(i,conf.gW+ta.x,y,0,1,1,i:getWidth(),i:getHeight()/2)
    lg.setColor(1,1,1,flash.v)
    lg.rectangle("fill",0,0,conf.gW,conf.gH)
    lg.setColor(1,1,1,1)
end