function i_ui()
    clock={
        x=8*8,
        y=2*8,
        t=20
    }
end

function u_ui()
    if clock.t>0 then
        clock.t-=1/30
    end
    if clock.t<=0 then
        clock.t=0
        game_state="loss"
        music(-1)
        sfx(3)

    end
end

function d_ui()
    print(flr(clock.t),clock.x,clock.y,7)
    print("condens",8,84,7)
    print([[ be solid
    to push]],8,16)
    print("h2o",16,42,7)
    print("freeze",80,16,7)
    print("fill me!",80,114,7)
end