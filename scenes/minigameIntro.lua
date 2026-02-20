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

function intro:enter(prev,data)--firstTime,id,win)
    shove.clearEffects("game")

    if data.id then self.id=data.id end
    local p="minigameIntros/"..self.id..".lua"

    local code,size=love.filesystem.read(p)

    func,err=loadstring(code)
    if not func then error(err) end

    env=require("env")
    env.assets=require("lib/cargo").init("minigameIntros/assets/"..self.id)
    setfenv(func,env)

    env.time=0

    func()

    if data.firstTime then
        self.gameAssets=require("lib/cargo").init("games/"..self.id.."/assets")
        self.games=getNames(self.id)
        music:beginMusic(self.gameAssets.bgm,1)
    else
        self.win=data.win
        env.win=data.win
    end

    self.tScale=20
    self.rad=20

    timer.tween(0.5,self,{tScale=0},"in-linear")

    if env.load then env.load() end

    if #self.games>=1 then
        local g=table.remove(self.games,math.random(1,#self.games))
        timer.after(2,function()
            timer.tween(0.5,self,{tScale=self.rad},"in-linear",function()
                gs.switch(state.minigame,g,self.id,self.gameAssets)
            end)
        end)
    else
        timer.after(2,function()
            music:endMusic(0.5)
            timer.tween(0.5,self,{tScale=self.rad},"in-linear",function()
                self.gameAssets=nil
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
    music:update()
    if env.update then env.update(dt) end
end

function intro:draw()
    lg.setColor(1,1,1,1)
    if env.draw then env.draw() end

    --lg.setColor(1,1,1,1)
    --pause:draw()
    
    lg.setColor(0,0,0,1)
    local rad=20
    for x=0,conf.gW/rad do
        for y=0,conf.gW/rad do
            lg.circle("fill",x*rad,y*rad,self.tScale)
        end
    end
    lg.setColor(1,1,1,1)
    --lg.print(tostring(self.win),0,8)
end

return intro