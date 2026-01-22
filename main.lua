require("init")

function love.load()
    dialog=require("data/dialog")
    assets=require("lib/cargo").init("assets")

    gs.registerEvents()
    fontDlg=lg.newFont("assets/font/Able 5.ttf",9)
    font=lg.newFont("assets/font/monogram-extended.ttf",16)
    lg.setFont(font)
    shove.createLayer("game")

    pal=require("lib/pal")
    pal:new("waft",li.newImageData("assets/palette/waft.png"))
    pal:load("waft")

    state={
        title=require "scenes/title",
        menu=require "scenes/menu"
    }
    shader={
        trans=lg.newShader("shaders/plasmaTransition.glsl"),
        wave=lg.newShader("shaders/wave.glsl")
    }

    talkies.font=fontDlg
    talkies.padding=4
    talkies.rounding=2
    talkies.messageBackgroundColor={pal:color(30)}
    talkies.titleBackgroundColor={pal:color(6)}

    gs.switch(state.title)
end

function love.update(dt)
    input:update()
end 

function love.draw()
    
end
