local title={}

function title:enter()
    self.ball = {
        img = lg.newImage("assets/title/ball-1.png")
    }
end

function title:update(dt)

end

function title:draw()
    beginDraw()
        lg.clear(pal:color(0))
        lg.setColor(1,1,1,1)

        local t=love.timer.getTime()
        local sc=10
        
        for x=-10,20 do
            for y=-10,20 do
                lg.setColor(pal:color((x+y-8)%16))
                lg.circle("fill",x*sc+math.cos(t+(x+y)*0.2)*20,y*sc+math.sin(t+(x+y)*0.2)*20,10+math.sin(t+(x+y)*0.8)*5)
            end
        end
    endDraw()
end

return title