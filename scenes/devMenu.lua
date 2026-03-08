local devMenu={}

function devMenu:mainMenu()
    self.selection=1
    self.items={}
    table.insert(self.items,{text="Go to title",func=function(selection)
        gs.switch(state.title)
    end})
    table.insert(self.items,{text="Go to menu",func=function(selection)
        gs.switch(state.menu)
    end})
    table.insert(self.items,{text="Test minigame",c1=7,c2=22,func=function(selection)
        self:gachaMinigameSelectMenu()
    end})
    table.insert(self.items,{text="Test gachapon",c2=29,c1=13,func=function(selection)
        --[[for k,v in ipairs(self.machines) do
            print(v.id)
        end
        local g=self.machines[1].id
        gs.switch(state.minigameIntro,{firstTime=true,id=g})]]
        self:gachaSelectMenu()
    end})
    table.insert(self.items,{text="Toggle web mode ("..tostring(dev.web)..")",c1=4,c2=12,func=function(selection,text)
        dev.web= not dev.web
        self.items[self.selection].text="Toggle web mode ("..tostring(dev.web)..")"
    end})
    table.insert(self.items,{text="Disable debug mode",c1=18,c2=26,func=function(selection)
        dev.debug=false
        gs.switch(state.title)
    end})
    table.insert(self.items,{text="Delete options data (DANGER)",c1=17,c2=25,func=function(selection)
        love.filesystem.remove("options.save",data)
    end})
end

function devMenu:gachaSelectMenu()
    self.selection=1
    self.items={}

    for k,v in ipairs(self.machines) do
        print(v.id)
        table.insert(self.items,{text=v.id,func=function(selection)
            local g=self.machines[selection].id
            gs.switch(state.minigameIntro,{firstTime=true,id=g})
        end})
    end

    table.insert(self.items,{text="BACK",c1=21,c2=29,func=function(selection)
        self:mainMenu()
    end})
end

function devMenu:gachaMinigameSelectMenu()
    self.selection=1
    self.items={}

    for k,v in ipairs(self.machines) do
        print(v.id)
        table.insert(self.items,{text=v.id,func=function(selection)
            local g=self.machines[selection].id
            devMenu:minigameMenu(g)
            --gs.switch(state.minigameIntro,{firstTime=true,id=g})
        end})
    end

    table.insert(self.items,{text="BACK",c1=21,c2=29,func=function(selection)
        self:mainMenu()
    end})
end

local function getNames(path)
    local n={}
    local files=love.filesystem.getDirectoryItems("games/"..path)
    
    for k,v in ipairs(files) do
        local name=v:match("^(.+)%.lua$")
        table.insert(n,name)
    end
    return n
end

function devMenu:minigameMenu(id)
    self.gameAssets=require("lib/cargo").init("games/"..id.."/assets")
    local names=getNames(id)
    self.selection=1
    self.items={}

    for k,v in ipairs(names) do
        print(v)
        table.insert(self.items,{text=v,func=function(selection)
            local g=id
            gs.switch(state.minigameIntro,{firstTime=true,id=g,repeatGame=v})
        end})
    end

    table.insert(self.items,{text="BACK",c1=21,c2=29,func=function(selection)
        self:gachaMinigameSelectMenu()
    end})
end

function devMenu:enter()
    shove.clearEffects("game")
    self.machines=require("data/machines")
    self.items={}
    self:mainMenu()
    self.selection=1
    if not dev.web then
        love.audio.stop()
    end
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
        self.items[self.selection].func(self.selection,self.items[self.selection].text)
        input:update()
    end
end

function devMenu:draw()
    lg.setFont(fontDlg)
    lg.setColor(pal:color(6))
    lg.print("Cool debug menu",2,2)
    lg.setColor(pal:color(10))
    lg.print("If you see this and you're\nnot a dev, PLEASE LMK and GET OUT!",2,fontDlg:getHeight()+2)
    local oy=fontDlg:getHeight()*3+2
    for k,v in ipairs(self.items) do
        if k==self.selection then
            lg.setColor(pal:color(v.c1 or 0))
            local t="-"..v.text
            lg.print(t,2,(k-1)*fontDlg:getHeight()+2+oy)
        else
            lg.setColor(pal:color(v.c2 or 16))
            lg.print(v.text,2,(k-1)*fontDlg:getHeight()+2+oy)
        end
    end
    lg.setFont(font)
end

return devMenu

