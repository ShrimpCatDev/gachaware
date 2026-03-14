local click={}

function click:enter()

end

function click:update(dt)

end

function click:draw()
    love.graphics.setColor(pal:color(16))
    love.graphics.rectangle("fill",0,0,conf.gW,conf.gH)
    love.graphics.setColor(pal:color(8))
    for x=0,conf.gW-1 do
        for y=0,conf.gH-1 do
            if ((x+y+(love.timer.getTime()*16))/2)%16>8 then
                love.graphics.points(x+0.5,y+0.5)
            end
        end
    end
    lg.setColor(pal:color(6))
    lg.rectangle("fill",16,16,conf.gW-32,conf.gH-32,4,4)
    lg.setColor(1,1,1,1)
    local t="Click to focus"
    lg.print(t,conf.gW/2-font:getWidth(t)/2,conf.gH/2-font:getHeight()/2-3)
end

function click:mousepressed(x,y)
    gs.switch(state.splash)
end

return click