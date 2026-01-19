require("init")

function love.load()
    gs.registerEvents()
    font=lg.newFont("assets/font/monogram-extended.ttf",16)
    lg.setFont(font)
    shove.createLayer("game")

    pal=require("lib/pal")
    pal:new("waft",li.newImageData("assets/palette/waft.png"))
    pal:load("waft")

    state={
        title=require "scenes/title"
    }
    gs.switch(state.title)
end

function love.update(dt)
    input:update()
end 

function love.draw()

end
