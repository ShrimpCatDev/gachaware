msg="Wake him up!"
icons={1,2,3,4,5,6}
color=9

function load()
    win=false
    chirps=0
    ct=0
end

function update(dt)
    --haha long if statement :3
    if input:pressed("up") or input:pressed("down") or input:pressed("left") or input:pressed("right") or input:pressed("a") or input:pressed("b") then
        chirps=chirps+1
        ct=0.2
        assets.wake.chirp:setPitch(math.random(10,25)*0.1)
        sfx(assets.wake.chirp)
    end
    ct=ct-dt
end

function draw()
    if ct>0 then
        lg.draw(assets.wake.bird2)
    else
        lg.draw(assets.wake.bird1)
    end
end

function leave()

end