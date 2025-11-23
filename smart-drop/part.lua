function i_part()
    exps={}
    clrs={12,5,9,10,7}
end

function u_part()
    for p in all(exps) do
        p.x+=p.spdx
        p.y+=p.spdy
        p.scale-=.1
        p.l-=.1
        p.c=flr(p.l)
        if p.l<=0 then
            del(exps,p)
        end
    end
    if game_state=="finish" then
        xp=rnd(128)
        yp=rnd(128)
        for i=0,10 do
            add(exps,{
                x=xp,
                y=yp,
                spdx=1-rnd(2),
                spdy=1-rnd(2),
                scale=2+rnd(5),
                l=5
            })
            
        end
    end
    for pr in all(exps) do
        sfx(1)
    end
end

function d_part()
    for p in all(exps) do
        circfill(p.x,p.y,p.scale,clrs[p.c])
    end
end