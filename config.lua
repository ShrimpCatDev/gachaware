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
        a={"key:z"},
        b={"key:x"},
        up={"key:up"},
        down={"key:down"},
        left={"key:left"},
        right={"key:right"},
        exit={"key:escape"}
    },
    pairs={

    },
    joystick = love.joystick.getJoysticks()[1],
}

return conf