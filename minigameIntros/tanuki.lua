function load()
    img=assets.tanukiNormal
    if not firstTime then
        if win then
            img=assets.tanukiWin
        else
            img=assets.tanukiLose
        end
        timer:after(1.5,function()
            img=assets.tanukiNormal
        end)
    end
end

function update()

end

function draw()
    lg.clear(pal:color(10))
    
    lg.draw(assets.ramenBg)
    lg.draw(img,0,math.cos(time*4)*2)
    lg.draw(assets.ramenBowl,0,math.cos(time*3+0.2)*1.5+3)
end