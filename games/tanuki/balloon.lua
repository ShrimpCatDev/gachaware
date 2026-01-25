msg="Pop!"

function load()

end

function update(dt)

end

function draw()
    lg.clear(pal:color(18))
    lg.circle("fill",conf.gW/2,conf.gH/2,32+math.cos(time)*4)
end