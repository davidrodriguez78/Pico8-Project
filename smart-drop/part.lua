function i_part(x,y)
    for i=1,20 do
        local angle=rnd(1)*1*3.1415
        local speed=1+rnd(1.5)

        add(part,{
            x=x,
            y=y,
            dx=cos(angle)*speed,
            dy=sin(angle)*speed,
            l=30+flr(rnd(20)),
            col=8+flr(rnd(7))
        })
    end
end

function u_part()
    for p in all(part) do
        p.x+=p.dx
        p.y+=p.dy

        p.dy+=0.03 --gravity

        p.l-=1
        if p.l<=0 then
            del(part,p)
        end
    end
end

function d_part()
    for p in all(part) do
        pset(p.x,p.y,p.col)
    end
end