local mg={}

function mg:enter(prev,game,path,asts)
    self.assets=asts
    timer.clear()
    local p="games/"..path.."/"..game..".lua"
    print(p)

    local code,size=love.filesystem.read("games/"..path.."/"..game..".lua")

    func,err=loadstring(code)
    if not func then error(err) end

    env=require("env")
    setfenv(func,env)

    env.time=0

    func()

    if env.load then env.load() end

    self.maxTime=5
    self.time=self.maxTime
    self.timeEnable=false
    timer.after(1,function()
        self.timeEnable=true
    end)
end

function mg:update(dt)
    timer.update(dt)
    env.time=env.time+dt
    if self.timeEnable then
        self.time=self.time-dt
    end
    if env.update then env.update(dt) end
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

    lg.push()
    lg.translate(1,conf.gH-h-1)
        lg.setColor(pal:color(29))
        lg.rectangle("fill",0,0,max,h,r,r)
        lg.setColor(pal:color(12))
        lg.rectangle("fill",0,0,c,h,r,r)
        lg.setColor(pal:color(4))
    lg.pop()

    lg.setColor(1,1,1,1)
    lg.print(env.msg)
end

return mg