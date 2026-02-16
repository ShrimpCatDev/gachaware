local menu={}
local infoDlg=require("data/infoDialog")

function menu:init()

end

function menu:enter()
    self.time=0
    self.tScale=0
    self.rad=20

    shove.clearEffects("game")
    timer.clear()
    shove.addEffect("game",shader.trans)
    self.prog=-4
    self.canAction=false
    timer.tween(1,self,{prog=6},"out-cubic",function()
        self.canAction=true
        for k,v in ipairs(dialog.test) do
            --talkies.say("Joseph", v)
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
        gy=1,
        items={
            {text="Play!",func=function(selection)
                self.frozen=true
                self.canAction=false
                self.prog=6
                music:endMusic(1)
                timer.tween(1,self,{prog=-4},"out-cubic",function()
                    local g=self.machineMenu.data[selection].id
                    gs.switch(state.minigameIntro,{firstTime=true,id=g})
                end)
            end},
            --[[{text="Credits",func=function()
            
            end},]]
            {text="Info",func=function(selection)
                for k,v in ipairs(infoDlg[selection]) do
                    talkies.say("Shopkeeper", v)
                end
            end}
        },
        select=1
    }
    self.machineMenu.len=#self.machineMenu.data
    test={x1=0,x2=0,time=0}
    self.frozen=false
    pause=require("pause")
    pause:init("menu",self)
    music:beginMusic(assets.music.menu,1)
end


function menu:update(dt)
    music:update()
    pause:update(dt)
    timer.update(dt)
    shader.trans:send("time",love.timer.getTime()*8)
    shader.trans:send("th",self.prog)

    if not self.frozen and not pause.open then
        self.time=self.time+dt
        talkies.update(dt)
        if self.canAction then
            if talkies.isOpen() then
                if input:pressed("a") then
                    talkies.onAction()
                    sfx(assets.sfx.click)
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
                        sfx(assets.sfx.click)
                    end
                    if input:pressed("left") and self.machineMenu.select>0 then
                        self.machineMenu.select=self.machineMenu.select-1
                        sfx(assets.sfx.click)
                    end
                    if input:pressed("a") then
                        self.machineMenu.gy=self.machineMenu.selectedYPosition
                        self.machineMenu.selected=true
                        self.gameOptionMenu.select=1
                        sfx(assets.sfx.menuOpen)
                    end
                    if input:pressed("b") then
                        talkies.say("","Not available in the demo!")
                    end
                else
                    if input:pressed("up") then
                        self.gameOptionMenu.select=self.gameOptionMenu.select-1
                        if self.gameOptionMenu.select<1 then
                            self.gameOptionMenu.select=#self.gameOptionMenu.items
                        end
                        sfx(assets.sfx.click)
                    end
                    if input:pressed("down") then
                        self.gameOptionMenu.select=self.gameOptionMenu.select+1
                        if self.gameOptionMenu.select>#self.gameOptionMenu.items then
                            self.gameOptionMenu.select=1
                        end
                        sfx(assets.sfx.click)
                    end
                    if input:pressed("a") then
                        print(self.machineMenu.select+1)
                        self.gameOptionMenu.items[self.gameOptionMenu.select].func(self.machineMenu.select+1)
                        sfx(assets.sfx.click)
                    end

                    if input:pressed("b") then
                        self.machineMenu.gy=self.machineMenu.defaultYPosition
                        self.machineMenu.selected=false
                        sfx(assets.sfx.menuClose)
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
end

function menu:draw()
    lg.clear(pal:color(themes[options.flavor].bg1))
    lg.setColor(pal:color(themes[options.flavor].bg2))
    local s=16
    local rep=math.floor(conf.gW/s)+1
    for y=0,rep do
        for x=0,rep do 
            lg.circle("fill",(((x*s)+(-self.time*16))%(conf.gW+32))-16,(((y*s)+(-self.time*16))%(conf.gW+32))-16,math.cos(self.time*2+((x-y)*0.5))*8+8)
        end
    end
    --lg.draw(assets.image.bg.menuBg)
    
    for x=0,self.machineMenu.len-1 do
        local i=self.machineMenu.data[x+1].img
        if x==self.machineMenu.select then
            lg.setColor(1,1,1,1)
        else
            lg.setColor(0.7,0.7,0.9,1)
        end
        lg.draw(i,conf.gW/2+x*i:getWidth()+self.machineMenu.sx,self.machineMenu.sy,0,1,1,i:getWidth()/2,0)
    end

    flavor()
    local m=self.gameOptionMenu

    lg.push()
    lg.translate(m.x,m.y)
        sdraw(function()
            lg.rectangle("fill",0,0,m.w,#m.items*font:getHeight()+6,2,2)
        end)
        lg.setColor(pal:color(0))
        lg.setFont(fontDlg)
        lg.print(self.machineMenu.data[self.machineMenu.select+1].name,2,0)
        for k,v in ipairs(self.gameOptionMenu.items) do
            if k==self.gameOptionMenu.select then
                lg.print("-"..v.text,2,k*fontDlg:getHeight()+4)
            else
                lg.print(v.text,2,k*fontDlg:getHeight()+4)
            end
        end
        lg.setFont(font)
    lg.pop()

    lg.setFont(fontDlg)
        flavor()
        local h=fontDlg:getHeight()+2
        lg.push()
        lg.translate(1,conf.gH-h-1)
        lg.rectangle("fill",0,0,conf.gW-2,h,2,2)

        lg.setColor(1,1,1,1)
        lg.draw(assets.image.buttons,icons[1],1,2)
        lg.print("Select",9,1)

        if self.machineMenu.selected then
            lg.draw(assets.image.buttons,icons[2],fontDlg:getWidth("Select")+12,2)
            lg.print("Back",fontDlg:getWidth("Select")+12+8,1) 
        else
            lg.draw(assets.image.buttons,icons[2],fontDlg:getWidth("Select")+12,2)
            lg.print("View trinkets",fontDlg:getWidth("Select")+12+8,1) 
        end
        lg.pop()

        lg.setColor(1,1,1,1)
    lg.setColor(1,1,1,1)

    cprint(self.machineMenu.data[self.machineMenu.select+1].name,conf.gW/2,self.machineMenu.titleY)
    talkies.draw()
    lg.setFont(font)

    pause:draw()

    lg.setColor(0,0,0,1)
    local rad=20
    for x=0,conf.gW/rad do
        for y=0,conf.gW/rad do
            lg.circle("fill",x*rad,y*rad,self.tScale)
        end
    end
end

return menu