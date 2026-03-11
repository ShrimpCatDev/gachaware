msg="Wake him up!"
icons={1,2}
color=9

function load()
    win=false
    chirps=0
    ct=0
    assets.flash.birds:setLooping(true)
    sfx(assets.flash.birds)
    max=20
end

function update(dt)
    if chirps<max then
        if input:pressed("a") or input:pressed("b") then
            chirps=chirps+1
            ct=0.2
            assets.wake.chirp:setPitch(math.random(10,25)*0.1)
            sfx(assets.wake.chirp)
        end
    else
        win=true
    end
    ct=ct-dt
end

function draw()
    lg.draw(assets.wake.bg1)
    
    if chirps>=max then
        lg.draw(assets.wake.bg2)
    else
        lg.draw(assets.wake.bg1)
    end
    if ct>0 then
        lg.draw(assets.wake.bird2)
    else
        lg.draw(assets.wake.bird1)
    end
end

function leave()
    assets.flash.birds:stop()
end