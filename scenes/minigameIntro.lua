local intro={}

local function getNames(path)
    local n={}
    local files=love.filesystem.getDirectoryItems("games/"..path)
    for k,v in ipairs(files) do
        local name=v:match("^(.+)%.lua$")
        table.insert(n,name)
    end
    return n
end

function intro:enter(prev,firstTime,id,win)
    shove.clearEffects("game")

    if id then self.id=id end
    if firstTime then
        self.gameAssets=require("lib/cargo").init("games/"..self.id.."/assets")
        self.games=getNames(self.id)
        for k,v in ipairs(self.games) do
            print(v)
        end
    else
        self.win=win
    end

    self.tScale=20
    self.rad=20

    timer.tween(0.5,self,{tScale=0},"in-linear")

    if #self.games>=1 then
        local g=table.remove(self.games,math.random(1,#self.games))
        timer.after(2,function()
            timer.tween(0.5,self,{tScale=self.rad},"in-linear",function()
                gs.switch(state.minigame,g,self.id,self.gameAssets)
            end)
        end)
    else
        timer.after(2,function()
            timer.tween(0.5,self,{tScale=self.rad},"in-linear",function()
                gs.switch(state.menu)
            end)
        end)
    end
    
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
    lg.print(tostring(self.win),0,8)
end

return intro