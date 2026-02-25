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

    self.img=assets.image.machines[self.id]
    if data.firstTime then
        self.gameAssets=require("lib/cargo").init("games/"..self.id.."/assets")
        self.games=getNames(self.id)
        music:beginMusic(self.gameAssets.bgm,1)
        self.lives=3
    else
        self.win=data.win
        env.win=data.win
        if self.win then

        else
            self.lives=self.lives-1
        end
    end

    self.tScale=20
    self.rad=20

    timer.tween(0.5,self,{tScale=0},"in-linear")

    if env.load then env.load() end

    if #self.games>=1 then
        local g=table.remove(self.games,math.random(1,#self.games))
        timer.after(3,function()
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
    self.screen=lg.newCanvas(78,56)
    self.livesImg=lg.newImage("assets/image/lives.png")
    --9,20
end

function intro:update(dt)
    env.time=env.time+dt
    timer.update(dt)
    env.timer:update(dt)
    music:update()
    if env.update then env.update(dt) end
end

function intro:draw()
    lg.setColor(1,1,1,1)

    lg.clear(1,1,1,1)

    local c=lg.getCanvas()
    lg.setCanvas(self.screen)
        lg.clear()
        if env.draw then env.draw() end
    lg.setCanvas(c)

    local x,y=conf.gW/2-self.img:getWidth()/2,40
    lg.draw(self.img,x,y)
    lg.draw(self.screen,x+9,y+20)

    --lg.setColor(1,1,1,1)
    --pause:draw()

    local space=8
    local w=assets.image.lives:getWidth()+space
    local tw=self.lives*w
    local sx=(conf.gW/2)-(tw/2)+(space/2)
    for i=0,self.lives-1 do
        lg.draw(assets.image.lives,sx+(i*w),6+math.cos(love.timer.getTime()*8+(i*1.2))*3)
    end
    
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