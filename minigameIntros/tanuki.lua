function load()
    food={
        imgs={assets.egg,assets.noodles,assets.beans,assets.pill},
        objs={},
        xmin=16,xmax=78-16
    }
    img=assets.tanukiNormal
    if not firstTime then
        if win then
            img=assets.tanukiWin
            for i=0,3 do
                table.insert(food.objs,{x=math.random(food.xmin,food.xmax),y=-16,img=food.imgs[math.random(1,3)]})
            end
        else
            img=assets.tanukiLose
            for i=0,3 do
                table.insert(food.objs,{x=math.random(food.xmin,food.xmax),y=-16,img=food.imgs[4]})
            end
        end
        timer:after(0.5,function()
            for k,v in pairs(food.objs) do
                timer:tween(math.random(10,15)*0.1,v,{y=conf.gH})
            end
            timer:after(1.5,function()
                img=assets.tanukiNormal
            end)
        end)
    end
end

function update(dt)

end

function draw()
    lg.clear(pal:color(10))
    
    lg.draw(assets.ramenBg)
    lg.draw(img,0,math.cos(time*4)*2)
    for k,v in pairs(food.objs) do
        lg.draw(v.img,v.x,v.y,time*2,1,1,8,8)
    end
    lg.draw(assets.ramenBowl,0,math.cos(time*3+0.2)*1.5+3)
end