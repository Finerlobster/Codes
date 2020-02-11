
tfm.exec.disableAutoNewGame()
tfm.exec.disableAutoShaman()
tfm.exec.disableAutoScore ()

--teams
blue = {} 
red = {}

function GetRandomTeamPlayer(team)
	return team[math.random(0, #team)]
end

function MakeTeam()
	for k,v in pairs(tfm.get.room.playerList) do
		if #blue <= #red then
			table.insert(red, k)
		else
			table.insert(blue, k)
		end 		 
	end	
end

function GetPlayerTeam(playername)
	if blue[playername] then
		return "blue"
	else
		return "red"
	end
end

function eventLoop(elapsedTime, remainingTime)
	if remainingTime <= 0 then
		tfm.exec.newGame("7681280")
	end
end

function eventChatCommand(player, cmd)
	if cmd == "team" then
		ui.addPopup ( 3, 0, "blue: " .. blue[1] .. "\n red: " .. red[1] .."", nil, 100, 150, 100)
	end
	if cmd == "lua_off" then
		system.exit()
	end 
end

function eventNewGame()
	MakeTeam()
	tfm.exec.setGameTime(20)
	for k,v in pairs(red) do
		tfm.exec.setNameColor(v, 0000)
		tfm.exec.setVampirePlayer(v)
		tfm.exec.movePlayer(v, 550, 360)
		tfm.exec.setPlayerScore(v, 0, false)
	end
	for k,v in pairs(blue) do
		tfm.exec.setPlayerScore(v, 1, true)
		tfm.exec.setNameColor(v, 242424)
		tfm.exec.giveMeep(v)
	end
end

function eventPlayerWon ( playerName, timeElapsed, timeElapsedSinceRespawn )
	ui.updateTextArea(2, playerName .. " collected the cheese!")
	tfm.exec.newGame("7681280")
	tfm.exec.setPlayerScore(playerName, 1, true)
end

ui.addPopup( 1, 0, "The Vampires stole the cheese. Maybe our Shaman can help get it back! \n Each round is divided in 2 teams: vampires x mice. The mice should bring the cheese back to the hole! Vampires should protect the cheese.", nill, 300, 200, width, false )
ui.addTextArea( 2, "Preparing...", nil, 10, 370, 220, 20)


tfm.exec.newGame("0")


