local pause={}

function pause:loadMenu(type,data)
    self.menuItems={}
    table.insert(self.menuItems,{text="Resume",func=function(selection)
        self.open=false
        self.gy=self.dy
        sfx(assets.sfx.menuClose)
        self:fadeOut(0)
    end})
    table.insert(self.menuItems,{text="Options",func=function(selection)
        self.items=self.menuOptions
        self.selection=1
        sfx(assets.sfx.click)
        self.title="Options"
    end})
    if type=="menu" then
        table.insert(self.menuItems,{text="Back to title",func=function(selection)
            sfx(assets.sfx.menuClose)
            data.prog=6
            timer.tween(1,data,{prog=-4},"out-cubic",function(selection)
                --local g=data.machineMenu.data[selection].id
                gs.switch(state.title)
            end)
            music:endMusic(0.5)
        end})
    elseif type=="game" then
        table.insert(self.menuItems,{text="Back to menu",func=function(selection)
            sfx(assets.sfx.menuClose)
            data.tScale=0
            timer.tween(0.5,data,{tScale=20},"in-linear",function() 
                gs.switch(state.menu)
            end)
            music:endMusic(0.5)
        end})
    end
    if not dev.web then
        table.insert(self.menuItems,{text="Exit game",func=function(selection)
            love.event.quit()
        end})
    end
end

function pause:loadOptions(type,data)
    self.menuOptions={}
    table.insert(self.menuOptions,{text="Volume: 10",func=function(selection)
        options.volume=options.volume+0.1
        if options.volume>1 then options.volume=0 end
        sfx(assets.sfx.click)
    end})
    table.insert(self.menuOptions,{text="Music: 10",func=function(selection)
        options.musicVolume=options.musicVolume+0.1
        if options.musicVolume>1 then options.musicVolume=0 end
        sfx(assets.sfx.click)
    end})
    table.insert(self.menuOptions,{text="SFX: 10",func=function(selection)
        options.sfxVolume=options.sfxVolume+0.1
        if options.sfxVolume>1 then options.sfxVolume=0 end
        sfx(assets.sfx.click)
    end})
    table.insert(self.menuOptions,{text="Theme:",func=function(selection)
        options.flavor=options.flavor+1
        if options.flavor>#themes then options.flavor=1 end
        sfx(assets.sfx.click)
    end})
    if not dev.web then
        table.insert(self.menuOptions,{text="Toggle fullscreen",func=function(selection)
            options.fullscreen = not options.fullscreen
            love.window.setFullscreen(options.fullscreen)
        end})
    end
    table.insert(self.menuOptions,{text="Back",func=function(selection)
        if type=="title" then
            self.open=false
            self.gy=self.dy
            sfx(assets.sfx.menuClose)
            self.selection=1
            self:fadeOut(0)
        else
            sfx(assets.sfx.menuClose)
            self.items=self.menuItems
            self.selection=1
            self.title="Paused"
        end
        saveOptions()
    end})
end

function pause:init(type,data)
    self.title="Paused"
    self.type=type
    self.open=false
    self.selection=1
    self.items={}

    self:loadMenu(type,data)
    self:loadOptions(type,data)
    self.items=self.menuItems

    self.dx=0
    self.dy=-conf.gH
    self.sx=0
    self.sy=0

    self.gx=self.dx
    self.gy=self.dy
    self.x=self.gx
    self.y=self.gy
    self.w=86
    self.gh=#self.items*(fontDlg:getHeight()+1)+16
    self.h=self.gh
    self.fade=0
end

function pause:fadeOut(val,dur)
    timer.tween(dur or 0.5,self,{fade=val})
end

function pause:update(dt)
    self.gh=#self.items*(fontDlg:getHeight()+1)+16
    self.menuOptions[1].text="Volume: "..options.volume*10
    self.menuOptions[2].text="Music: "..options.musicVolume*10
    self.menuOptions[3].text="SFX: "..options.sfxVolume*10
    self.menuOptions[4].text="Theme: "..themes[options.flavor].name
    if self.open then
        if input:pressed("exit") or input:pressed("b") then
            self.open=false
            self.gy=self.dy
            input:update()
            sfx(assets.sfx.menuClose)
            saveOptions()
            self:fadeOut(0)
        end
        if input:pressed("up") then
            self.selection=self.selection-1
            if self.selection<1 then
                self.selection=#self.items
            end
            input:update()
            sfx(assets.sfx.click)
        end
        if input:pressed("down") then
            self.selection=self.selection+1
            if self.selection>#self.items then
                self.selection=1
            end
            input:update()
            sfx(assets.sfx.click)
        end
        if input:pressed("a") then
            self.items[self.selection].func(self.selection)
            input:update()
        end
        --input:update()
    else
        if input:pressed("exit") or (self.type=="title" and input:pressed("b")) then
            if self.type=="title" then
                self.items=self.menuOptions
                self.open=true
                self.gy=self.sy
                input:update()
                sfx(assets.sfx.menuOpen)
                self.title="Options"
                self:fadeOut(0.5)
            else
                self.items=self.menuItems
                self.open=true
                self.gy=self.sy
                input:update()
                sfx(assets.sfx.menuOpen)
                self.title="Paused"
                self:fadeOut(0.5)
            end
        end
        --input:update()
    end
    self.x=lerpDt(self.x,self.gx,0.005,dt)
    self.y=lerpDt(self.y,self.gy,0.005,dt)
    self.h=lerpDt(self.h,self.gh,0.000005,dt)
end

function pause:draw()
    lg.setColor(0,0,0,self.fade)
    lg.rectangle("fill",0,0,conf.gW,conf.gH)
    lg.setColor(1,1,1,1)

    lg.push()
    lg.setFont(fontDlg)
    lg.translate(self.x,self.y)
        flavor()
        sdraw(function()
            lg.rectangle("fill",conf.gW/2-(self.w/2),conf.gH/2-(self.h/2),self.w,self.h,2,2)
        end)
        lg.setColor(1,1,1,1)

        local t=self.title
        lg.print(t,conf.gW/2-(fontDlg:getWidth(t)/2),conf.gH/2-(self.h/2)+1)

        for k,v in ipairs(self.items) do
            if k==self.selection then
                local t="-"..v.text
                lg.print(t,conf.gW/2-(fontDlg:getWidth(t)/2),k*fontDlg:getHeight()+conf.gH/2-(self.h/2)+6)
            else
                lg.print(v.text,conf.gW/2-(fontDlg:getWidth(v.text)/2),k*fontDlg:getHeight()+conf.gH/2-(self.h/2)+6)
            end
        end
    lg.setFont(font)
    lg.pop()
end

return pause