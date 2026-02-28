local over={}

function over:enter(prev,id)
    shove.clearEffects("game")
    self.img=lg.newImage("minigameIntros/assets/"..id.."/gameover.png")
    self.fade={v=1}
    self.action=false
    timer.tween(1,self.fade,{v=0},"in-linear",function()
        self.action=true
    end)
end

function over:update(dt)
    timer.update(dt)
    if (input:pressed("a") or input:pressed("b") or input:pressed("exit")) and self.action then
        self.action=false
        timer.tween(1,self.fade,{v=1},"in-linear",function()
            timer.after(0.5,function()
                gs.switch(state.menu)
            end)
        end)
    end
end

function over:draw()
    lg.draw(self.img)
    lg.setColor(0,0,0,self.fade.v)
    lg.rectangle("fill",0,0,conf.gW,conf.gH)
    lg.setColor(1,1,1,1)
    if self.action then
        cprint("Press Z",conf.gW/2,conf.gH-8)
    end
end

return over