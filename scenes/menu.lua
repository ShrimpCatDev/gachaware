local menu={}

function menu:enter()
    shove.clearEffects("game")
    timer.clear()
    shove.addEffect("game",shader.trans)
    self.prog=-4
    self.canAction=false
    timer.tween(1,self,{prog=6},"out-cubic",function()
        self.canAction=true
        for k,v in ipairs(dialog.test) do
            talkies.say("Joseph", v)
        end
    end)
    self.machineMenu={
        data=require("data/machines"),
        selected=false,
        defaultYPosition=32,
        selectedYPosition=4,
        sy=32,
        gy=32,
        sx=0,
        gx=0,
        gx=0,
        select=0,
        titleY=4
    }
    self.gameOptionMenu={
        x=-57,
        y=1,
        w=56,
        h=conf.gH-2,
        gx=-57,
        gy=1
    }
    self.machineMenu.len=#self.machineMenu.data
    test={x1=0,x2=0,time=0}
    
end

function menu:update(dt)
    talkies.update(dt)
    timer.update(dt)
    shader.trans:send("time",love.timer.getTime()*8)
    shader.trans:send("th",self.prog)

    if self.canAction then
        if talkies.isOpen() then
            if input:pressed("a") then
                talkies.onAction()
            end
        else
            --[[if input:pressed("a") then
                self.canAction=false
                self.prog=6
                timer.tween(2,self,{prog=-4},"out-cubic",function()
                    gs.switch(state.title)
                end)
            end]]
            
            if self.machineMenu.selected==false then
                if input:pressed("right") and self.machineMenu.select<self.machineMenu.len-1 then
                    self.machineMenu.select=self.machineMenu.select+1
                end
                if input:pressed("left") and self.machineMenu.select>0 then
                    self.machineMenu.select=self.machineMenu.select-1
                end
                if input:pressed("a") then
                    self.machineMenu.gy=self.machineMenu.selectedYPosition
                    self.machineMenu.selected=true
                end
            else
                if input:pressed("b") then
                    self.machineMenu.gy=self.machineMenu.defaultYPosition
                    self.machineMenu.selected=false
                end
            end
        end
    end

    if self.machineMenu.selected then
        self.machineMenu.titleY=lerpDt(self.machineMenu.titleY,-8,0.00025,dt)
        self.machineMenu.gx=-self.machineMenu.select*assets.image.gachaMachineBase:getWidth()+(assets.image.gachaMachineBase:getWidth()/2)-20
        self.gameOptionMenu.gx=1
    else
        self.machineMenu.titleY=lerpDt(self.machineMenu.titleY,4,0.00025,dt)
        self.machineMenu.gx=-self.machineMenu.select*assets.image.gachaMachineBase:getWidth()
        self.gameOptionMenu.gx=-self.gameOptionMenu.w-1
    end

    self.machineMenu.select=clamp(self.machineMenu.select,0,self.machineMenu.len-1)

    self.machineMenu.sy=lerpDt(self.machineMenu.sy,self.machineMenu.gy,0.0005,dt)
    self.machineMenu.sx=lerpDt(self.machineMenu.sx,self.machineMenu.gx,0.0005,dt)
    self.gameOptionMenu.x=lerpDt(self.gameOptionMenu.x,self.gameOptionMenu.gx,0.000025,dt)
    self.gameOptionMenu.y=lerpDt(self.gameOptionMenu.y,self.gameOptionMenu.gy,0.000025,dt)
end

function menu:draw()
    beginDraw()
        lg.clear(pal:color(10))
        lg.draw(assets.image.bg.menuBg)
        
        for x=0,self.machineMenu.len-1 do
            local i=self.machineMenu.data[x+1].img
            if x==self.machineMenu.select then
                lg.setColor(1,1,1,1)
            else
                lg.setColor(0.8,0.8,0.8,1)
            end
            lg.draw(i,conf.gW/2+x*i:getWidth()+self.machineMenu.sx,self.machineMenu.sy,0,1,1,i:getWidth()/2,0)
        end

        lg.setColor(pal:color(6))
        local m=self.gameOptionMenu

        lg.push()
        lg.translate(m.x,m.y)
            sdraw(function()
                lg.rectangle("fill",0,0,m.w,m.h,2,2)
            end)
            lg.setColor(pal:color(0))
            lg.setFont(fontDlg)
            lg.print("Hello world!",2,0)
            lg.setFont(font)
        lg.pop()

        lg.setColor(1,1,1,1)
        cprint(self.machineMenu.data[self.machineMenu.select+1].name,conf.gW/2,self.machineMenu.titleY)
        talkies.draw()
        lg.setFont(font)
    endDraw()
end

return menu