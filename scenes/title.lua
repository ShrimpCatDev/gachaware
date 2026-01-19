local title={}

function title:newBall(x,y)
    table.insert(self.balls,{})
    self.balls[#self.balls].body=lp.newBody(self.world,x,y,"dynamic")
    self.balls[#self.balls].shape=lp.newCircleShape(15)
    self.balls[#self.balls].fixture=lp.newFixture(self.balls[#self.balls].body,self.balls[#self.balls].shape,1)
end

function title:enter()
    self.world=lp.newWorld(0,9.81*64,true)
    self.ball={
        balls={},
        img=lg.newImage("assets/title/ball-1.png")
    }
end

function title:update(dt)
    self.world:update(dt)
end

function title:draw()
    beginDraw()
        lg.clear(pal:color(6))
    endDraw()
end

return title