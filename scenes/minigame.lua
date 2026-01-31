local mg={}

function mg:enter(prev,game,path,asts)
    shove.clearEffects("game")
    timer.clear()
    local p="games/"..path.."/"..game..".lua"
    print(p)

    local code,size=love.filesystem.read("games/"..path.."/"..game..".lua")

    func,err=loadstring(code)
    if not func then error(err) end

    env=require("env")
    setfenv(func,env)

    env.time=0
    env.assets=asts

    func()

    if env.load then env.load() end
    self.frozen=true

    self.maxTime=5
    self.time=self.maxTime
    self.timeEnable=false
    timer.after(1.5,function()
        self.timeEnable=true
    end)

    self.rad=20
    self.tScale=self.rad
    timer.tween(0.5,self,{tScale=0},"in-linear",function() self.frozen=false end)
end

function mg:update(dt)
    timer.update(dt)

    if not self.frozen then
        env.time=env.time+dt
        if self.timeEnable then
            self.time=self.time-dt
            if self.time<=0 then
                self.frozen=true
                self.tScale=0
                timer.tween(0.5,self,{tScale=self.rad},"in-linear",function() 
                    gs.switch(state.minigameIntro)
                end)
            end
        end
        if env.update then env.update(dt) end
    end
end

function mg:draw()
    lg.setColor(1,1,1,1)
    if env.draw then env.draw() end

    local frac=self.time/self.maxTime
    local max=conf.gW-2
    local w=math.floor(max*frac)
    local h=6
    local c=clamp(w,3,max)

    local r=3

    lg.setColor(0,0,0,1)
    lg.rectangle("fill",0,conf.gH-8,conf.gW,8)
    lg.push()
    lg.translate(1,conf.gH-h-1)
        lg.setColor(pal:color(29))
        lg.rectangle("fill",0,0,max,h,r,r)
        lg.setColor(pal:color(12))
        lg.rectangle("fill",0,0,c,h,r,r)
    lg.pop()

    lg.setColor(1,1,1,1)
    --lg.print(env.msg)

    lg.setColor(0,0,0,1)
    local rad=20
    for x=0,conf.gW/rad do
        for y=0,conf.gW/rad do
            lg.circle("fill",x*rad,y*rad,self.tScale)
        end
    end
    lg.setColor(1,1,1,1)
end

return mg