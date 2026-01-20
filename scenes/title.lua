local title={}

function title:enter()
    self.ball = {
        img = lg.newImage("assets/title/ball-1.png")
    }
    shove.addEffect("game",shader.trans)
    self.prog=-4
    timer.tween(1.5,self,{prog=6},"out-cubic")
end

function title:update(dt)
    timer.update(dt)
    shader.trans:send("time",love.timer.getTime()*8)
    shader.trans:send("th",self.prog)
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
            lg.setColor(pal:color(0))
            lg.print("Yes.",1,-3)
    endDraw()
end

function title:keypressed(k)
    if k=="left" then
        self.prog=6
        timer.tween(3,self,{prog=-4},"out-cubic")
    end
    if k=="right" then
        self.prog=-4
        timer.tween(3,self,{prog=6},"out-cubic")
    end
end

return title