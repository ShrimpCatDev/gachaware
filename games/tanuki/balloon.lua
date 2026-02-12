msg="Pop!"
icons={3,4}
color=21

function load()
    win=false
    pl={
        x=16,
        y=32,
        spd=50,
        imgs={assets.balloon.tanukiPump1,assets.balloon.tanukiPump2,assets.balloon.tanukiPump3},
        img=1
    }
    pumps=0
    --118,63
    b={
        x=118,
        y=63,
        rad=5
    }
    maxPumps=8
end

function update(dt)
    if pumps<maxPumps then
        if input:pressed("up") and pl.img==2 then
            pl.img=1
            pumps=pumps+1
        end
        if input:pressed("down") and pl.img==1 then
            pl.img=2
        end
    else
        win=true
        pl.img=3
    end
end

function draw()
    lg.clear(pal:color(6))

    local y=math.floor(math.cos(time*4)*3)
    lg.line(pl.x+40,pl.y+64,b.x,b.y+y)

    lg.draw(pl.imgs[pl.img],pl.x,pl.y)
    local r=b.rad+(pumps*2)

    lg.setColor(pal:color(17))
    lg.circle("fill",b.x,b.y-r+y,r)
    lg.setColor(pal:color(1))
    lg.circle("fill",b.x+(r/3),(b.y-r/3)-r+y,clamp(r/2-5,1,5000))
    lg.setColor(pal:color(25))
    lg.circle("line",b.x,b.y-r+y,r)
    lg.setColor(1,1,1,1)
end