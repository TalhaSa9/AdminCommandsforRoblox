--by TalhaSa
local players = game:GetService("Players") -- Player Service
local prefix = "!" -- Prefix
local finder = function(param, plr) -- A Powerfull function
	local whois = param[1]:lower() -- We getting param's first child and it will be small characters
	if whois == "me" then -- It is detecting "me", it will apply to us
		whois = plr -- It is changing the whois variable to us
	elseif whois == "other" or whois == "others" then -- It is detecting other players, it will collect the others
		whois = {} -- Setting up the table for collect players
		for _, player in ipairs(players:GetPlayers()) do -- This is collect all players and using this data
			task.wait() -- A little wait
			if player == plr then -- It is checking for it is us, we will collect others not us
				continue -- Skips us
			else
				table.insert(whois, player) -- This is adding other players to whois table.
			end
		end
	elseif whois == "all" or whois == "everyone" then -- It is detecting EVERYONE, it will collect everyone in the game
		whois = {} -- Setting up the table for collect everyone
		for _, player in ipairs(players:GetPlayers()) do -- This is collect all players and using this data
			task.wait() -- A little wait
			table.insert(whois, player) -- It is adding every player to whois table
		end
	else -- Its detecting a target user
		local foundPlayer = nil -- Setting up the selected Player
		for _,v in ipairs(players:GetPlayers()) do -- This is collect all players and using this data
			task.wait() -- A little wait
			if v.Name:lower():find(whois) then -- If the whois matching with our player, it will be selected
				foundPlayer = v -- changing the variable
			end
		end
		if foundPlayer == nil then -- If player doesnt in game
			warn("Wanted player doesn't in game") -- It will warn us
		else
			whois = foundPlayer -- Setting up whois
		end
	end
	return whois -- It gives the player(s)
end
local commands = { -- The commands
	kill = function(param, plr) -- This is killing us
		local entitys = finder(param, plr) -- We collecting player(s)
		if typeof(entitys) == "Instance" then -- If it is a player
			local Character = entitys.Character -- We getting player's character
			if Character then -- If player doesn't died
				local Humanoid = Character:FindFirstChildOfClass("Humanoid") -- Getting Humanoid
				if Humanoid then -- Checking if it available
					Humanoid.Health = 0 -- Killing
				end
			end
		else -- If it is a bunch of players
			for _,Player in pairs(entitys) do -- This is collect all players and using this data
				task.wait() -- A little bit wait
				local Character = Player.Character -- Getting Character
				if Character then -- Checking if its alive
					local Humanoid = Character:FindFirstChildOfClass("Humanoid") -- Getting humanoid
					if Humanoid then -- Checking it is available
						Humanoid.Health = 0 -- Killing
					end
				end
			end
		end
	end,
	kick = function(param, plr) -- This kick us
		local entitys = finder(param, plr) -- Collecting player(s)
		local Generated = "" -- This is kick message
		for i=2, #param do -- Starting from second of param's
			Generated ..= param[i].." " -- combining
		end
		if typeof(entitys) == "Instance" then -- It is check for if is an player
			entitys:Kick(Generated) -- Its kicking the player with kick reason
		else -- If it is a bunch of players
			for _, player in pairs(entitys) do -- Collecting bunch of players and using this data
				task.wait() -- A little bit wait
				player:Kick(Generated) -- Its kicking selected player with kick reason
			end
		end
	end,
	speed = function(param, plr) -- This is giving speed to us
		local entitys = finder(param, plr) -- Collecting player(s)
		if typeof(entitys) == "Instance" then -- It is check for if is an player
			local Character = entitys.Character -- Getting Character
			if Character then -- Checking if its alive
				local Humanoid = Character:FindFirstChildOfClass("Humanoid") -- Getting humanoid
				if Humanoid then -- Checking it is available
					Humanoid.WalkSpeed = tonumber(param[2]) -- Giving speed
				end
			end
		else -- If it is a bunch of players
			for _, player in pairs(entitys) do -- Collecting bunch of players and using this data
				task.wait()
				local Character = player.Character -- Getting Character
				if Character then -- Checking if its alive
					local Humanoid = Character:FindFirstChildOfClass("Humanoid") -- Getting humanoid
					if Humanoid then -- Checking it is available
						Humanoid.WalkSpeed = tonumber(param[2]) -- Giving speed
					end
				end
			end
		end
	end,
	jumppower = function(param, plr) -- This is giving jumppower to us
		local entitys = finder(param, plr) -- Collecting player(s)
		if typeof(entitys) == "Instance" then -- It is check for if is an player
			local Character = entitys.Character -- Getting Character
			if Character then -- Checking if its alive
				local Humanoid = Character:FindFirstChildOfClass("Humanoid") -- Getting Humanoid
				if Humanoid then -- Checking if its available
					Humanoid.JumpHeight = tonumber(param[2]) -- Giving Jump power
				end
			end
		else -- If it is a bunch of players
			for _, player in pairs(entitys) do -- Collecting bunch of players and using this data
				task.wait() -- A little bit wait
				local Character = player.Character -- Getting character
				if Character then -- Checking if its alive
					local Humanoid = Character:FindFirstChildOfClass("Humanoid") -- Getting Humanoid
					if Humanoid then -- Checking if its available
						Humanoid.JumpHeight = tonumber(param[2]) -- Giving Jump power
					end
				end
			end
		end
	end,
	gravity = function(param) -- This changes world gravity
		game.Workspace.Gravity = tonumber(param[1]) -- Changes world Gravity
	end,
	music = function(param, plr) -- This adding music into game
		if param[1] then -- If ID is available
			local audio = Instance.new("Sound") -- creating a Sound
			audio.SoundId = ("rbxassetid://%d"):format(param[1]) -- Replacing with ID
			audio.Name = plr.Name.."Music/" -- Setting name
			audio.Parent = game:GetService("Workspace") -- Sending to Workspace
			audio:Play() -- Playing it
			audio.Ended:Connect(function() -- If it is ended
				audio:Destroy() -- Removing the Audio
			end)
		end
	end,
	stopmusic = function(param, plr) -- This stopping the right-now playing audios
		local entitys = finder(param, plr) -- Getting player(s)
		if typeof(entitys) == "Instance" then -- Checking if its player's audio
			local musicstring = entitys.Name.."Music/" -- generating Name
			local sound = game.Workspace:FindFirstChild(musicstring) -- Finding
			if sound then -- If its available then
				sound:Destroy() -- Removes the audio
			end
		else -- Checking if its a bunch of player
			for _, player in pairs(entitys) do -- Collecting bunch of players and using this data
				task.wait() -- A little bit wait
				local musicstring = player.Name.."Music/" -- generating Name
				local sound = game.Workspace:FindFirstChild(musicstring) -- Finding
				if sound then -- If its available then
					sound:Destroy() -- Removes the audio
				end
			end
		end
	end,
	explode = function(param, plr) -- This is exploding a player
		local entitys = finder(param, plr) -- Getting player(s)
		if typeof(entitys) == "Instance" then -- Checking if its a player
			local Character = entitys.Character -- Getting character
			if Character then -- Checking if its alive
				local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart") -- Getting HRP
				local Humanoid = Character:FindFirstChildOfClass("Humanoid") -- Getting Humanoid
				if HumanoidRootPart then -- Checking if its available
					if Humanoid then -- Checking if its available
						local explosion = Instance.new("Explosion") -- creating explode
						explosion.DestroyJointRadiusPercent = 0
						explosion.Position = HumanoidRootPart.CFrame.Position -- Setting Position
						Humanoid.Health = 0 -- Killing player
						explosion.Parent = HumanoidRootPart -- Setting up parent
					end
				end
			end
		else -- Checking if its bunch of players
			for _, player in pairs(entitys) do
				task.wait() -- A little bit
				local Character = player.Character -- Getting character
				if Character then -- Checking if its alive
					local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart") -- Getting HRP
					local Humanoid = Character:FindFirstChildOfClass("Humanoid") -- Getting Humanoid
					if HumanoidRootPart then -- Checking if its available
						if Humanoid then -- Checking if its available
							local explosion = Instance.new("Explosion") -- creating explode
							explosion.DestroyJointRadiusPercent = 0
							explosion.Position = HumanoidRootPart.CFrame.Position -- Setting Position
							Humanoid.Health = 0 -- Killing player
							explosion.Parent = HumanoidRootPart -- Setting up parent
						end
					end
				end
			end
		end
	end
}
players.PlayerAdded:Connect(function(plr) -- Detecting when player joins
	plr.Chatted:Connect(function(msg) -- Check message adds
		if msg:find(prefix) <= 1 then -- If prefix at first, its continue
			local unpacked = msg:gsub(prefix, ""):lower():split(" ") -- replacing prefix with "" and smalling the words and splitting while using " "
			local Generated = "" -- a Generate for params
			for i = 2, #unpacked do -- Starting from second of unpacked words
				task.wait() -- A little bit wait
				Generated ..= unpacked[i].." " -- Combining the words
			end
			local splitted = Generated:split(" ") -- Splitting the generated message
			splitted[#splitted] = nil -- removes the last one because it is empty
			if commands[unpacked[1]] then -- Finding command
				commands[unpacked[1]](splitted, plr) -- usage of command
			else -- If it doesn't available
				warn("Command not found.") -- It will warn us
			end
		end
	end)
end)
