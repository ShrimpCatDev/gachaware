local title={}

function title:newBall(x,y)
    table.insert(self.balls,{})
    local b = self.balls[#self.balls]
    b.body = lp.newBody(self.world, x, y, "dynamic")
    b.shape = lp.newCircleShape(12)
    b.fixture = lp.newFixture(b.body, b.shape, 1)
    b.fixture:setRestitution(0.6)
end

function title:newWall(x,y,w,h)
    table.insert(self.walls,{})
    local b = self.walls[#self.walls]
    b.body = lp.newBody(self.world, x+w/2, y+h/2, "static")
    b.shape = lp.newRectangleShape(w,h)
    b.fixture = lp.newFixture(b.body, b.shape, 1)
    b.fixture:setRestitution(0.4)
end

function title:enter()
    self.world = lp.newWorld(0,9.81*64,true)
    self.balls = {}
    self.ball = {
        img = lg.newImage("assets/title/ball-1.png")
    }
    self.walls={}
    self:newWall(0,conf.gH,conf.gW,8)
    self:newWall(-8,0,8,conf.gH)
    self:newWall(conf.gW,0,8,conf.gH)
    for i=0,29 do
        self:newBall(math.random(15,conf.gW-15),math.random(-15,-40))
    end
end

function title:update(dt)
    self.world:update(dt)
end

function title:draw()
    beginDraw()
        lg.clear(pal:color(6))
        lg.setColor(pal:color(0))
        for k,v in ipairs(self.balls) do
            --lg.circle("fill",v.body:getX(),v.body:getY(),15)
            lg.draw(self.ball.img,v.body:getX(),v.body:getY(),v.body:getAngle(),1,1,self.ball.img:getWidth()/2,self.ball.img:getHeight()/2)
        end
    endDraw()
end

return title