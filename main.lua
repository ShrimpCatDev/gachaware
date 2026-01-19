require("init")

function love.load()
    font=lg.newFont("assets/font/monogram-extended.ttf",16)
    lg.setFont(font)
    shove.createLayer("game")
end

function love.update(dt)
    input:update()
end 

function love.draw()
    beginDraw()
    endDraw()
end
