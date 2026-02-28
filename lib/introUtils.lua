local int={}

function int:init(e)
    self.actors={}

    e.addActor=function(name,x,y,data,draw)
        self.actors[name]=data
        self.actors[name].x=x or 0
        self.actors[name].y=y or 0
        self.actors[name].hidden=data.hidden or false
        self.actors[name].draw=draw or (function() end)
    end
    e.removeActor=function(name)
        self.actors[name]=nil
    end
    e.getActor=function(name)
        return self.actors[name]
    end

    e.talk=function(title,text)
        talkies.say(title,text)
    end

    e.script=function(func)
        e.timer:script(function(wait)
            func(wait)
        end)
    end

    e.move=function(wait,dur,...)
        e.timer:tween(dur,...)
        wait(dur)
    end
end

function int:draw()
    for k,v in pairs(self.actors) do
        v.draw(v)
    end
end

return int