function i_plr()
	plr={
		x=4*8,
		y=14*8,
		dx=0,
		dy=0,
		sp=1,
		state="drop",
		speed=1
	}
	
	ptimer=0
	is_moving=false
	gravity=2
	jforce=0
	loss=false
end


function u_plr()
	local lx=plr.x
	local ly=plr.y
	
	--all state--
	if plr.state=="drop" or plr.state=="ice" or plr.state=="gas" then
		if btn(⬅️)then
			plr.dx= -plr.speed
			is_moving=true
		elseif btn(➡️)then
			plr.dx= plr.speed
			is_moving=true
		else
			plr.dx=0
			plr.sp=1
			is_moving=false
		end
		
	end
	plr.x+=plr.dx
	plr.y+=plr.dy
	
	--collision x--
	if collision_x(plr) then
		plr.x=lx
	end
	
	--gravity--
	if not onground() then
		plr.y+=gravity
	else
		plr.y-=(plr.y+8)%8
	end
	
	--jump--
	if onground() then
		if btnp(❎) then  
			if plr.state=="drop" or plr.state=="ice" then
				jforce=8
				sfx(0)
			end
		end
	end
	
	--jump anim--
	if jforce>0 then 
		if plr.state=="drop" then 
			plr.sp=3
			jforce-=1
		elseif plr.state=="ice" then
			jforce-=1
		end
	end
	plr.y-=jforce
	--gas--
	if plr.state=="gas" then
		gravity=0
		if btn(⬆️) then
			plr.dy= -plr.speed
		elseif btn(⬇️) then
			plr.dy= plr.speed
		else
			plr.dy=0
		end
		--plr.sp=4
	else
		gravity=2
		--plr.y-=(plr.y+8)%8
	end
	--anim--
	if is_moving and onground() and plr.state=="drop" then
		p_anim()
	end
	
	--ceiling coll--
	if celling() then
		plr.y=ly
	end
	--state change--
	if sprite_swith(4) and plr.state!="gas" then
		plr.state="ice"
		plr.speed=2
		sfx(1)
		mset((plr.x+4)/8,(plr.y+4)/8,23)
	elseif sprite_swith(2) and plr.state!="ice" then
		plr.state="drop"
		plr.speed=1
		sfx(1)
		mset((plr.x+4)/8,(plr.y+4)/8,23)
	elseif sprite_swith(1) and plr.state!="gas" then
		plr.state="gas"
		plr.speed=1
		sfx(1)
		mset((plr.x+4)/8,(plr.y+4)/8,23)
	end

	if plr.state=="ice" then
		plr.sp=5
	elseif plr.state=="gas" then
		plr.sp=4
	end
	--trigger door--
	trigger()
	--add time--
	add_sec()

	--loss--
	
end


function d_plr()
	spr(plr.sp,plr.x,plr.y)
end
function trigger()
	local px1=plr.x/8
	local px2=(plr.x+8)/8
	local py=(plr.y)/8

	if mget(px1,py)==12 and plr.state=="ice" then
		mset(1,3,13)
		mset(14,12,24)
	end
	--win--
	if mget(px1,py)==9 and plr.state=="drop" then
		plr.sp=10
		sfx(2)
		game_state="finish"
		i_part(63,63)
	end
end
function p_anim()
	if ptimer<0 then
		plr.sp+=1
		if plr.sp>2 then
			plr.sp=1
		end
		ptimer=4
	end
	ptimer-=1
end

function onground()
	local px1=plr.x/8
	local px2=(plr.x+7)/8
	local py=(plr.y+8)/8
	
	if fget(mget(px1,py),0) or fget(mget(px2,py),0) then
		return true
	else
		return false
	end
end

function celling()
	local px1=plr.x/8
	local px2=(plr.x+8)
	local py=plr.y/8
	
	if fget(mget(px1,py),0)or fget(mget(px2,py),0)then
		return true
	else
		return false
	end
end

function collision_x(obj)
	local x1=obj.x/8
	local y1=obj.y/8
	local x2=(obj.x+7)/8
	local y2=(obj.y+4)/8
	
	local a=fget(mget(x1,y1),0)
	local b=fget(mget(x1,y2),0)
	local c=fget(mget(x2,y2),0)
	local d=fget(mget(x2,y1),0)
	
	if a or b or c or d then
		return true
	else
		return false
	end
end 

function sprite_swith(flg)
	local px1=(plr.x+4)/8
	local py1=(plr.y+7)/8

	if fget(mget(px1,py1),flg) then
		return true
	else 
		return false
	end
end

function add_sec()
	local px1=plr.x/8
	local px2=(plr.x+8)/8
	local py1=plr.y/8
	local py2=(plr.y+8)/8

	if mget(px1,py1)==21 or mget(px2,py2)==21 then
		mset(px1,py1,23)
		mset(px2,py2,23)
		clock.t+=2rnd(5)
	end
end