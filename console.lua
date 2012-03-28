console={}
console.text=""
console.visible=false
console.interval=0
console.invc=false
console.lines={}
console.linesc = 0
console.helpno = true

function console.cmd()
	helpno = true
	local cmd=console.text
	console.text=""
	if cmd:sub(1, 4) == "gst " then
		gamestate=cmd:sub(5)
	elseif cmd:sub(1, 5) == "echo " then
			message(cmd:sub(6))
	elseif cmd:sub(1, 5) == "host " then
			server_load(cmd:sub(6))
	elseif cmd:sub(1, 8) == "connect " then
			local portip = {}
			portip = string.split(cmd:sub(9), ":")
			client_load(portip[1], portip[2])
	elseif cmd=="exit" then
		love.event.push("quit");
	elseif cmd=="pause" then
		pausemenuopen=true;
		love.audio.pause();
	elseif cmd == "grow" and gamestate=="game"	then
		objects["player"][1]:grow()
	elseif cmd == "shrink" and gamestate=="game" then
		objects["player"][1]:shrink()
	elseif cmd:sub(1, 5) == "pnts " and gamestate=="game" then
		local points=cmd:sub(6)
		local points=tonumber(points)
		if points then
			addpoints(points)
		end
	elseif cmd:sub(1, 5) == "load " then
		local points=cmd:sub(6)
		local points=tonumber(points)
		if points then
			game_load(points)
		end
	elseif cmd:sub(1, 5) == "sblv " then
		local points=cmd:sub(6)
		local points=tonumber(points)
		if points then
			startlevel(points)
			end
	elseif cmd == "invc" and gamestate=="game" then
		objects["player"][1].invincible = not objects["player"][1].invincible
		console.invc = objects["player"][1].invincible
	elseif cmd:sub(1, 6) == "lives " then
		local life=cmd:sub(7)
		local life=tonumber(life)
		if life then
			mariolives[1] = life
		end
	elseif cmd:sub(1, 5) == "time " and gamestate=="game" then
		local points=cmd:sub(6)
		local points=tonumber(points)
		if points then
			mariotime=points
		end
	elseif cmd == "star" and gamestate=="game" then
		objects["player"][1]:star()
	elseif cmd == "die" and gamestate=="game" then
		objects["player"][1]:die("Console")
	elseif cmd == "flag" and gamestate=="game" then
		objects["player"][1]:flag()
	elseif cmd == "mc" and gamestate=="game" then
		if playertype=="minecraft" then playertype="portal" else playertype="minecraft" end
		
		-------------------------------------------
		------------Edits by Teryakisan------------
		-------------------------------------------
		
		
		elseif 
			cmd == "help" 
				then
					helpno = false
					console.text = "help - This menu. \n \n exit - exits the game. \n \n grow - Grows Mario Equivelant to mushroom or flower.\n \n shrink - Opposite of grow.\n \n pnts <amount> - Gives Mario a specified amount of points.\n \n invc - Toggles whether invincibility is on or not.\n Persists through world changes. \n \n lives <amount> - Changes the amount of lives Mario has. \n \n time <amount> - Sets the game time to the specified number. \n \n star - Equivalent to Mario getting a Star. \n \n die - Kills Mario :( \n \n flag - Teleports Mario the flag at the end of the level. \n \n mc - Toggles Minecraft mode \n \n gst <gamestate> - Changes the gamestate -- Use with caution!"
					
					elseif 
						cmd == "morehelp" 
							then
								helpno = false
								console.text = "morehelp - This menu. \n\n mappack - Loads the mappack menu. \n\n edit - Switch to level edit mode. \n\n menu - Switch to menu mode. \n\n game - start Mari0. \n\n big - bigmario = true. \n\n small- bigmario = false. \n\n nograv - yaccelleration = -80\n Ceiling blocks suggested. \n\n grav - yacceleration = 80\n(regular gravity) \n\n halfgrav - yaccelerayion = 40\n(moon bounce!) "
		
		elseif 
			cmd == "mappack"
		 		then
			console.text = "OK"
			editormode = "true"
			gamestate = "mappackmenu"
			mappacks()
			
		else
	 		if 
				cmd == "edit"
								then
			console.text = "OK"
			editormode = true
			players = 1
			playertype = "portal"
			playertypei = 1
			bullettime = false
			portalknockback = false
			bigmario = false
			goombaattack = false
			sonicrainboom = false
			playercollisions = false
			infinitetime = false
			infinitelives = false
			game_load()
			
			else 
				if cmd == "esc"
					then
						function love.keypressed(k)
						    if k == 'escape' then
						        love.event.push('q') -- quit the game
						    end 
						end
			
			
		else 
			if 
				cmd == "menu"
							then
								console.text = "OK"
								gamestate = "menu"
			
		
		else 
			if 
				cmd == "game"
								then
			console.text = "Mari0 Launched"
			editormode = false
			players = 1
			playertype = "portal"
			playertypei = 1
			game_load()
			
		else
			if
				cmd == "big"
					then
					 bigmario = true
					
		else if cmd == "small" then bigmario = false
		else if cmd == "nograv" then  yacceleration = -80
		else if cmd == "grav" then yacceleration = 80
		else if cmd == "halfgrav" then yacceleration = 40
	
			end
			end
			end
			end
			end
			end
			end
			end
			end
		
			-------- End Teryakisan Edits --------		
	end
	
end



function draw_console()
	if console.visible then
		love.graphics.setColor(10, 10, 10, 200)
		love.graphics.polygon("fill", 10, 10, (400*scale)-10, 10, (400*scale)-10, 420, 10, 420)
		love.graphics.setColor(255, 255, 255)
		love.graphics.print(console.interval>100 and ">  "..console.text.."_" or ">  "..console.text, 20, 20)
		if helpno then
		for i = 1, #console.lines, 1 do
		love.graphics.print(console.lines[i], 20, 30+10*i)
		end
		end
	end
	if gamestate=="game" and objects["player"][1].invincible then
		properprint("invincible", uispace*1.5-8*scale, 8*scale)
	end
end

function update_console()
	if gamestate=="game" and objects["player"][1].invincible ~= console.invc then
		objects["player"][1].invincible = console.invc
	end
end