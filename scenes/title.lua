local title={}

function title:enter()
    self.showText=false
    timer.clear()
    self.canAction=false --peak variable name :3 (i need to use comments more)
    shove.addEffect("game",shader.trans)
    self.prog=-4
    timer.tween(1.5,self,{prog=6},"out-cubic")

    self.title={x=conf.gW/2,y=conf.gH+50}
    timer.after(1.2,function() 
        timer.tween(2,self.title,{y=conf.gH/2-16},"out-elastic",function()
            self.canAction=true
            self.showText=true
        end)
    end)
end

function title:update(dt)
    timer.update(dt)
    shader.trans:send("time",love.timer.getTime()*8)
    shader.wave:send("time",love.timer.getTime()*2)
    shader.trans:send("th",self.prog)

    if input:pressed("a") and self.canAction then
        self.canAction=false
        self.prog=6
        timer.tween(2,self,{prog=-4},"out-cubic",function()
        
        end)
    end
end

local function sdraw(drawFunction)
    lg.push()

    lg.translate(1,1)
        lg.setColor(0,0,0,0.5)
        drawFunction()
    lg.pop()

    lg.setColor(1,1,1,1)
    drawFunction()
end

function title:draw()
    beginDraw()
            lg.clear(pal:color(5))
            lg.setColor(1,1,1,1)

            local t=love.timer.getTime()
            local sc=10
            
            for x=-10,20 do
                for y=-10,20 do
                    lg.setColor(pal:color((x+y-8)%16))
                    lg.circle("fill",x*sc+math.cos(t+(x+y)*0.2)*20,y*sc+math.sin(t+(x+y)*0.2)*20,10+math.sin(t+(x+y)*0.8)*5)
                end
            end
            local x,y=self.title.x,self.title.y
            local ox,oy=assets.image.title:getWidth()/2,assets.image.title:getHeight()/2

            lg.setShader(shader.wave)
                lg.setColor(0,0,0,0.5)
                lg.draw(assets.image.title,x+1,y+1,0,1,1,ox,oy)
                lg.setColor(1,1,1,1)
                lg.draw(assets.image.title,x,y,0,1,1,ox,oy)
            lg.setShader()

            if self.showText then
                sdraw(function()
                    cprint("press z",conf.gW/2,conf.gH/2+16)
                end)
            end
    endDraw()
end

function title:keypressed(k)
    if k=="left" then
        self.prog=6
        timer.tween(3,self,{prog=-4},"out-cubic")
    end
    if k=="right" then
        self.prog=-4
        timer.tween(3,self,{prog=6},"out-cubic")
    end
end

return title