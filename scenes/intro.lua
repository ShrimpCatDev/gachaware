local intro={}

function intro:enter(prev,data)
    shove.clearEffects("game")
    timer.clear()

    self.fade={v=1}
    self.action=false
    timer.tween(0.5,self.fade,{v=0},"in-linear",function()
        self.action=true
    end)

    self.data=data
    if data.id then self.id=data.id end

    local p="intros/"..self.id..".lua"
    local code,size=love.filesystem.read(p)

    func,err=loadstring(code)
    if not func then error(err) end

    env=require("env")
    env.assets=require("lib/cargo").init("intros/assets/"..self.id)
    setfenv(func,env)

    env.timer:clear()
    env.time=0

    env.finished=function()
        self.action=false

        self.fade={v=0}
        timer.tween(0.5,self.fade,{v=1},"in-linear",function()
            timer.after(0.5,function()
                gs.switch(state.minigameIntro,self.data)
            end)
        end)
    end

    int=require("lib/introUtils")
    int:init(env)

    func()

    if env.load then env.load() end
end    
    

function intro:update(dt)
    talkies.update(dt)
    timer.update(dt)
    if talkies.isOpen() then
        if input:pressed("a") then
            talkies.onAction()
            sfx(assets.sfx.click)
        end
    else
        if self.action then
            env.timer:update(dt)
            if env.update then env.update(dt) end
        end
    end
end

function intro:draw()
    if env.draw then env.draw() end
    int:draw()

    lg.setColor(0,0,0,self.fade.v)
    lg.rectangle("fill",0,0,conf.gW,conf.gH)
    lg.setColor(1,1,1,1)

    if env.drawOverlay then env.drawOverlay() end
    talkies.draw()
    lg.setFont(font)
end

return intro