function load()

end

function update()

end

function draw()
    lg.clear(pal:color(10))
    
    lg.draw(assets.ramenBg)
    lg.draw(assets.tanukiNormal,0,math.cos(time*4)*2)
    lg.draw(assets.ramenBowl,0,math.cos(time*3+0.2)*1.5+3)
end