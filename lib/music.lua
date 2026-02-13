local m={}

function m:beginMusic(source,duration)
    self.data={volume=0}
    self.song=source
    self.song:stop()
    self.song:setLooping(true)
    self.song:play()
    timer.tween(duration or 1,self.data,{volume=1})
end

function m:update()
    self.song:setVolume(clamp((self.data.volume-(1-options.musicVolume))*options.volume,0,1))
end

function m:endMusic(duration)
    timer.tween(duration or 1,self.data,{volume=0},"in-linear",function()
        self.song:stop()
    end)
end

return m