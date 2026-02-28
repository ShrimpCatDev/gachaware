function load()
    addActor("test",8,conf.gH/2-4,{},function(a)
        lg.setColor(1,1,1,1)
        lg.rectangle("fill",a.x,a.y,8,8)
        lg.setColor(1,1,1,1)
    end)

    addActor("test2",conf.gW+8,conf.gH/2-4,{},function(a)
        lg.setColor(1,0.5,0.2,1)
        lg.rectangle("fill",a.x,a.y,8,8)
        lg.setColor(1,1,1,1)
    end)
    
    script(function(wait)
        wait(1)
        move(wait,2,getActor("test"),{x=conf.gW/2-16,y=conf.gH/2-4})
        wait(1)
        talk("Actor 1","Ugh. where is actor 2, they are ALWAYS late!")
        wait(0.5)
        talk("Actor 2","WAITTTTTTT")
        wait(0.5)
        move(wait,1,getActor("test2"),{x=conf.gW/2+16,y=conf.gH/2-4},"out-elastic")
        wait(0.25)
        talk("Actor 2","HERE I AM *huff*")
        talk("Actor 1","Took you long enough...")
        talk("Actor 2","Sorry!")
        talk("Actor 1","Well, anyways, lets continue to the game")
        wait(1)
        finished()
    end)
end

function update(dt)

end

function draw()
    lg.clear(0.15,0.5,1)
end

function drawOverlay()

end

