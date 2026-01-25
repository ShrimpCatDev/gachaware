require("init")

function love.load()
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
        minigameIntro=require "scenes/minigameIntro"
    }
    shader={
        trans=lg.newShader("shaders/plasmaTransition.glsl"),
        wave=lg.newShader("shaders/wave.glsl")
    }

    talkies.font=fontDlg
    talkies.padding=4
    talkies.rounding=2
    talkies.messageBackgroundColor={pal:color(30)}
    talkies.titleBackgroundColor={pal:color(10)}

    gs.switch(state.menu)
end

function love.update(dt)
    input:update()
end 

function love.draw()
    lg.clear(pal:color(30))
    local w,h=love.window.getMode()
    local n=100
    local t=love.timer.getTime()*24
    lg.setColor(pal:color(29))
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
