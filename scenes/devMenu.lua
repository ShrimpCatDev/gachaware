local devMenu={}

function devMenu:mainMenu()
    self.items={}
    table.insert(self.items,{text="Go to title",func=function(selection)
        gs.switch(state.title)
    end})
    table.insert(self.items,{text="Go to menu",func=function(selection)
        gs.switch(state.menu)
    end})
    table.insert(self.items,{text="Test minigame",func=function(selection)

    end})
    table.insert(self.items,{text="Test gachapon",func=function(selection)

    end})
    table.insert(self.items,{text="Toggle web mode",func=function(selection)
        dev.web= not dev.web
    end})
    table.insert(self.items,{text="Delete options data",func=function(selection)
        love.filesystem.remove("options.save",data)
    end})
end

function devMenu:enter()
    self.items={}
    self:mainMenu()
    self.selection=1
end

function devMenu:update(dt)
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
end

function devMenu:draw()
    lg.setFont(fontDlg)
    lg.setColor(pal:color(6))
    lg.print("Cool debug menu",2,2)
    lg.setColor(pal:color(10))
    lg.print("IF YOU SEE THIS AND YOU'RE\nNOT A DEV, PLEASE LMK",2,fontDlg:getHeight()+2)
    local oy=fontDlg:getHeight()*3+2
    for k,v in ipairs(self.items) do
        if k==self.selection then
            lg.setColor(pal:color(0))
            local t="-"..v.text
            lg.print(t,2,(k-1)*fontDlg:getHeight()+2+oy)
        else
            lg.setColor(pal:color(16))
            lg.print(v.text,2,(k-1)*fontDlg:getHeight()+2+oy)
        end
    end
    lg.setFont(font)
end

return devMenu

