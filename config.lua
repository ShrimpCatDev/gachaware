local conf = {}

conf.gW = 160
conf.gH = 144

conf.wW = conf.gW*5
conf.wH = conf.gH*5

conf.textureFilter = "nearest"
conf.fit = "aspect"
conf.render="layer"
conf.vsync=true

conf.input={
    controls={
        a={"key:z","key:j"},
        b={"key:x","key:k"},
        up={"key:up","key:w"},
        down={"key:down","key:s"},
        left={"key:left","key:a"},
        right={"key:right","key:d"},
        exit={"key:escape","key:return"}
    },
    pairs={
        
    },
    joystick = love.joystick.getJoysticks()[1],
}

return conf