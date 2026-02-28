require("init")

function sfx(sound)
    sound:stop()
    sound:setVolume(clamp(options.sfxVolume*options.volume,0,1))
    sound:play()
end

function saveOptions()
    local data=lume.serialize(options)
    love.filesystem.write("options.save",data)
end

dev={
    web=false
}

function love.load()
    love.filesystem.setIdentity("GachaWare")
    love.window.setTitle("GachaWare")
    music=require("lib/music")
    dialog=require("data/dialog")
    assets=require("lib/cargo").init("assets")

    local oldDraw=love.draw
    gs.registerEvents()
    love.draw=oldDraw

    fontDlg=lg.newFont("assets/font/Able 5.ttf",9)
    font=lg.newFont("assets/font/monogram-extended.ttf",16)
    lg.setFont(font)
    shove.createLayer("game")

    pal=require("lib/pal")
    pal:new("waft",li.newImageData("assets/palette/waft.png"))
    pal:load("waft")

    state={
        title=require "scenes/title",
        menu=require "scenes/menu",
        minigame=require "scenes/minigame",
        minigameIntro=require "scenes/minigameIntro",
        gameover=require "scenes/gameover",
        intro=require "scenes/intro"
    }
    
    shader={
        trans=lg.newShader("shaders/plasmaTransition.glsl"),
        wave=lg.newShader("shaders/wave.glsl")
    }

    talkies.font=fontDlg
    talkies.padding=4
    talkies.rounding=2
    talkies.messageBackgroundColor={pal:color(30)}
    talkies.talkSound=assets.sfx.dialog
    talkies.optionSwitchSound=assets.sfx.click

    icons={}
    for x=0,(assets.image.buttons:getWidth()/6)-1 do
        table.insert(icons,lg.newQuad(x*6,0,6,6,assets.image.buttons:getWidth(),assets.image.buttons:getHeight()))
    end

    themes=require("data/themes")
    options={
        volume=1,
        musicVolume=1,
        sfxVolume=1,
        flavor=1,
        fullscreen=false
    }
    
    if love.filesystem.getInfo("options.save") then
        local file=love.filesystem.read("options.save")
        local data=lume.deserialize(file)
        options=data
    end
    
    if not dev.web then
        love.window.setFullscreen(options.fullscreen or false)
    end

    flavor=function()
        lg.setColor(pal:color(themes[options.flavor].color))
    end

    gs.switch(state.menu)
end

function love.update(dt)
    input:update()
    talkies.titleBackgroundColor={pal:color(themes[options.flavor].color)}
    talkies.messageBackgroundColor={pal:color(themes[options.flavor].dark)}
end 

function love.draw()
    lg.clear(pal:color(themes[options.flavor].windowBg))
    local w,h=love.window.getMode()
    local n=100
    local t=love.timer.getTime()*24
    lg.setColor(pal:color(themes[options.flavor].windowFg))
    for x=-1,w/n do
        for y=-1,h/n do
            if (x+y)%2==0 then
                lg.draw(assets.image.ballIcon,x*n+(t%n),y*n+(t%n),0,2,2)
            end
        end
    end
    lg.setColor(1,1,1,1)
    beginDraw()
        lg.clear(0,0,0,1)
        gs.draw()
    endDraw()
end
