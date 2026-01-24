local mg={}

function mg:enter(prev,game,path)
    local p="games/"..path.."/"..game..".lua"
    print(p)

    local code,size=love.filesystem.read("games/"..path.."/"..game..".lua")

    func,err=loadstring(code)
    if not func then error(err) end

    env=require("env")
    setfenv(func,env)

    func()

    if env.load then env.load() end
end

function mg:update(dt)
    if env.update then env.update(dt) end
end

function mg:draw()
    if env.draw then env.draw() end
end

return mg