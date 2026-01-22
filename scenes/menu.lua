local menu={}

function menu:enter()
    shove.clearEffects("game")
    timer.clear()
    shove.addEffect("game",shader.trans)
    self.prog=-4
    self.canAction=false
    timer.tween(1.5,self,{prog=6},"out-cubic",function()
        self.canAction=true
    end)
end

function menu:update(dt)
    timer.update(dt)
    shader.trans:send("time",love.timer.getTime()*8)
    shader.trans:send("th",self.prog)

    if input:pressed("a") and self.canAction then
        self.canAction=false
        self.prog=6
        timer.tween(2,self,{prog=-4},"out-cubic",function()
            gs.switch(state.title)
        end)
    end
end

function menu:draw()
    beginDraw()
        lg.clear(pal:color(10))
        local i=assets.image.gachaMachineBase
        lg.draw(i,conf.gW/2,8,0,1,1,i:getWidth()/2,0)
    endDraw()
end

return menu