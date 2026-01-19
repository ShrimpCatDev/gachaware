local title={}

function title:enter()
    self.ball = {
        img = lg.newImage("assets/title/ball-1.png")
    }
end

function title:update(dt)

end

function title:draw()
    beginDraw()
        lg.clear(pal:color(6))
        lg.setColor(1,1,1,1)
    endDraw()
end

return title