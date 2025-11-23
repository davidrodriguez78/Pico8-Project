function _init()
	i_plr()
	i_ui()
	

	--main menu init--
	game_state="menu"
	clip_w=32

	--music--
	music(0)

	--particle--
	part={}
end


function _update()
	if game_state=="play" then
		u_plr()
		u_ui()
		
	end
	--clipping txt--
	if clip_w<128 then
		clip_w=clip_w + 1
	end
	--switching to state--
	if game_state=="menu" then
		if btnp(🅾️) then
			game_state="play"
		end
	end
	if game_state=="loss" or game_state=="finish" then
		if btnp(🅾️) then
			run()
		end
	end
	if game_state=="finish" then
		music(-1)

		--part efx--
		u_part()
	end
end

function _draw()
	cls()
	map()
	d_ui()
	d_part()
	d_plr()

	--main menu--
	if game_state=="menu" then
		rectfill(0,0,128,128,12)
		spr(48,0,56,128,10)
		--bird
		spr(25,25,30)
		spr(25,80,25)
		--cloud
		spr(26,20,20,3,1)
		spr(26,60,10,3,1)
		spr(26,80,50,3,1)
		--make by--
		print("by oldpixelpr",70,120,10)
		clip(0,40,clip_w,10)
		print("press 🅾️/z to start",32,40,8)
		clip()
	end
	
	if game_state=="loss" then
		print("time out",56,63,8)
		clip(0,40,clip_w,10)
		print("press 🅾️/z to start",32,40,8)
		clip()
		
	elseif game_state=="finish" then
		print("you win!!",56,63,9)
		clip(0,40,clip_w,10)
		print("press 🅾️/z to start",32,40,9)
		clip()
	end
end