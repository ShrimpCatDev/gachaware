require("init")

function love.load()
    assets=require("lib/cargo").init("assets")

    gs.registerEvents()
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
    gs.switch(state.title)
end

function love.update(dt)
    input:update()
end 

function love.draw()

end
