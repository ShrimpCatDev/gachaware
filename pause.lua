local pause={}

function pause:init(type,data)
    self.open=false
    self.selection=1
    self.items={}

    if type=="menu" then
        table.insert(self.items,{text="Back to title",func=function(selection)
            sfx(assets.sfx.menuClose)
            data.prog=6
            timer.tween(1,data,{prog=-4},"out-cubic",function()
                local g=data.machineMenu.data[selection].id
                gs.switch(state.title)
            end)
        end})
    elseif type=="game" then
        table.insert(self.items,{text="Back to menu",func=function(selection)
            sfx(assets.sfx.menuClose)
            data.tScale=0
            timer.tween(0.5,data,{tScale=20},"in-linear",function() 
                gs.switch(state.menu)
            end)
        end})
    end
    table.insert(self.items,{text="Resume",func=function(selection)
        self.open=false
        self.gy=self.dy
        sfx(assets.sfx.menuClose)
    end})

    self.dx=0
    self.dy=-conf.gH
    self.sx=0
    self.sy=0

    self.gx=self.dx
    self.gy=self.dy
    self.x=self.gx
    self.y=self.gy
    self.w=64
    self.h=#self.items*(fontDlg:getHeight()+1)+16
end

function pause:update(dt)
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
end

function pause:draw()
    lg.push()
    lg.setFont(fontDlg)
    lg.translate(self.x,self.y)
        lg.setColor(pal:color(6))
        sdraw(function()
            lg.rectangle("fill",conf.gW/2-(self.w/2),conf.gH/2-(self.h/2),self.w,self.h,2,2)
        end)
        lg.setColor(1,1,1,1)

        local t="Paused"
        lg.print(t,conf.gW/2-(fontDlg:getWidth(t)/2),conf.gH/2-(self.h/2)+1)

        for k,v in ipairs(self.items) do
            if k==self.selection then
                lg.print("-"..v.text,conf.gW/2-(fontDlg:getWidth(v.text)/2),k*fontDlg:getHeight()+conf.gH/2-(self.h/2)+6)
            else
                lg.print(v.text,conf.gW/2-(fontDlg:getWidth(v.text)/2),k*fontDlg:getHeight()+conf.gH/2-(self.h/2)+6)
            end
        end
    lg.setFont(font)
    lg.pop()
end

return pause