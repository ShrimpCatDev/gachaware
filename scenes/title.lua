local title={}

function title:newBall(x,y)
    table.insert(self.balls,{})
    local b = self.balls[#self.balls]
    b.body = lp.newBody(self.world, x, y, "dynamic")
    b.shape = lp.newCircleShape(15)
    b.fixture = lp.newFixture(b.body, b.shape, 1)
end

function title:enter()
    self.world = lp.newWorld(0,9.81*64,true)
    self.balls = {}
    self.ball = {
        img = lg.newImage("assets/title/ball-1.png")
    }
    self:newBall(15,15)
end

function title:update(dt)
    self.world:update(dt)
end

function title:draw()
    beginDraw()
        lg.clear(pal:color(6))
        lg.setColor(pal:color(0))
        for k,v in ipairs(self.balls) do
            lg.circle("fill", v.body:getX(), v.body:getY(), 15)
        end
    endDraw()
end

return title