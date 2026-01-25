local intro={}

function intro:enter(prev,firstTime,id)
    shove.clearEffects("game")
    if id then self.id=id end
    if firstTime then
        self.gameAssets=require("lib/cargo").init("games/"..self.id.."/assets")
    end

    self.tScale=20
    self.rad=20

    timer.tween(0.5,self,{tScale=0},"in-linear")

    timer.after(2,function()
        timer.tween(0.5,self,{tScale=self.rad},"in-linear",function()
            gs.switch(state.minigame,"balloon",self.id,self.gameAssets)
        end)
    end)
    
    --[[timer.after(1,function()
        timer.tween(1,self,{tScale=self.rad},"in-linear",function()
            timer.after(1,function()
                timer.tween(0.5,self,{tScale=0},"in-linear")
            end)
        end)
    end)]]
end

function intro:update(dt)
    timer.update(dt)
end

function intro:draw()
    lg.clear(pal:color(10))
    lg.print("This is good intro screen.",1,-3)
    lg.setColor(0,0,0,1)
    local rad=20
    for x=0,conf.gW/rad do
        for y=0,conf.gW/rad do
            lg.circle("fill",x*rad,y*rad,self.tScale)
        end
    end
    lg.setColor(1,1,1,1)
end

return intro