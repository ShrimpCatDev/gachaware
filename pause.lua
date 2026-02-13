local pause={}

function pause:loadMenu(type,data)
    self.menuItems={}
    table.insert(self.menuItems,{text="Resume",func=function(selection)
        self.open=false
        self.gy=self.dy
        sfx(assets.sfx.menuClose)
    end})
    table.insert(self.menuItems,{text="Options",func=function(selection)
        self.items=self.menuOptions
        self.selection=1
        sfx(assets.sfx.click)
    end})
    if type=="menu" then
        table.insert(self.menuItems,{text="Back to title",func=function(selection)
            sfx(assets.sfx.menuClose)
            data.prog=6
            timer.tween(1,data,{prog=-4},"out-cubic",function(selection)
                --local g=data.machineMenu.data[selection].id
                gs.switch(state.title)
            end)
        end})
    elseif type=="game" then
        table.insert(self.menuItems,{text="Back to menu",func=function(selection)
            sfx(assets.sfx.menuClose)
            data.tScale=0
            timer.tween(0.5,data,{tScale=20},"in-linear",function() 
                gs.switch(state.menu)
            end)
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
    table.insert(self.menuOptions,{text="Back",func=function(selection)
        sfx(assets.sfx.menuClose)
        self.items=self.menuItems
        self.selection=1
    end})
end

function pause:init(type,data)
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
    self.w=64
    self.gh=#self.items*(fontDlg:getHeight()+1)+16
    self.h=self.gh
end

function pause:update(dt)
    self.gh=#self.items*(fontDlg:getHeight()+1)+16
    self.menuOptions[1].text="Volume: "..options.volume*10
    self.menuOptions[2].text="Music: "..options.musicVolume*10
    self.menuOptions[3].text="SFX: "..options.sfxVolume*10
    if self.open then
        if input:pressed("exit") or input:pressed("b") then
            self.open=false
            self.gy=self.dy
            input:update()
            sfx(assets.sfx.menuClose)
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
        if input:pressed("exit") then
            self.open=true
            self.gy=self.sy
            input:update()
            sfx(assets.sfx.menuOpen)
        end
        --input:update()
    end
    self.x=lerpDt(self.x,self.gx,0.005,dt)
    self.y=lerpDt(self.y,self.gy,0.005,dt)
    self.h=lerpDt(self.h,self.gh,0.000005,dt)
end

function pause:draw()
    lg.push()
    lg.setFont(fontDlg)
    lg.translate(self.x,self.y)
        flavor()
        sdraw(function()
            lg.rectangle("fill",conf.gW/2-(self.w/2),conf.gH/2-(self.h/2),self.w,self.h,2,2)
        end)
        lg.setColor(1,1,1,1)

        local t="Paused"
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