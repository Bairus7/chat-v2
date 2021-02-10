ESX = nil
local PlayerData		= {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function getIdentity(source)
	local identifier = GetPlayerIdentifiers(source)[1]
	local result = MySQL.Sync.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {['@identifier'] = identifier})
	if result[1] ~= nil then
		local identity = result[1]

		return {
			identifier = identity['identifier'],
			name = identity['name'],
			firstname = identity['firstname'],
			lastname = identity['lastname'],
			dateofbirth = identity['dateofbirth'],
			sex = identity['sex'],
			height = identity['height']
			
		}
	else
		return nil
	end
end

AddEventHandler('chatMessage', function(source, playerName, message)
	if string.sub(message, 1, string.len('/')) ~= '/' then
		CancelEvent()
	end
end)

--- Rol

RegisterCommand('ooc', function(source, args, rawCommand)
	local xPlayer = ESX.GetPlayerFromId(source)

		local playerName = GetPlayerName(source)
		local msg = rawCommand:sub(5)
		local name = getIdentity(source)

		fal = name.firstname .. " " .. name.lastname
		TriggerClientEvent('chat:addMessage', -1, {
			template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(116 , 116, 116, 0.7); border-radius: 6px;"><i class="fas fa-moon-alt"></i> [OOC] {0}:<br> {1}</div>',
			args = { fal, msg }
		})
end, false)

RegisterCommand('twt', function(source, args, rawCommand)
    local playerName = GetPlayerName(source)
    local msg = rawCommand:sub(5)
	local name = getIdentity(source)
    fal = name.firstname .. " " .. name.lastname
    TriggerClientEvent('chat:addMessage', -1, {
        template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(28, 160, 242, 0.6); border-radius: 3px;"><i class="fab fa-twitter"></i> @{0}:<br> {1}</div>',
        args = { fal, msg }
    })
end, false)

RegisterCommand('anontweet', function(source, args, rawCommand)
    local playerName = GetPlayerName(source)
    local msg = rawCommand:sub(11)
    local name = getIdentity(source)
    fal = name.firstname .. " " .. name.lastname
    TriggerClientEvent('chat:addMessage', -1, {
        template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(28, 160, 242, 0.6); border-radius: 3px;"><i class="fab fa-twitter"></i> @ANONIMO:<br> {1}</div>',
        args = { fal, msg }
    })
	
	TriggerEvent("es:getPlayers", function(pl)
		for k,v in pairs(pl) do
			TriggerEvent("es:getPlayerFromId", k, function(user)
				if(user.getPermissions() > 0 and k ~= source)then
					TriggerClientEvent('chat:addMessage', k, {
						args = {"^3EL ANONIMO ES", " (^7" .. GetPlayerName(source) .." | "..source.."^0) " .. table.concat(args, " ")}
					})
				end
			end)
		end
	end)
end, false)

--- Rol Entorno

RegisterCommand('me', function(source, args, rawCommand)
	if source == 0 then
		print('esx_rpchat: you can\'t use this command from rcon!')
		return
	end

	args = table.concat(args, ' ')
	local name = GetPlayerName(source)
	if Config.EnableESXIdentity then name = GetCharacterName(source) end
	DrawOnHead(source, args,{ r = 255, g = 50, b = 0, alpha = 200 })
	TriggerClientEvent('esx_rpchat:sendProximityMessage', -1, source, _U('me_prefix', name), args, { 255, 50, 0 })
	--print(('%s: %s'):format(name, args))
end, false)

RegisterCommand('do', function(source, args, rawCommand)
	if source == 0 then
		print('esx_rpchat: you can\'t use this command from rcon!')
		return
	end

	args = table.concat(args, ' ')
	local name = GetPlayerName(source)
	if Config.EnableESXIdentity then name = GetCharacterName(source) end
    DrawOnHead(source, args, { r = 0, g = 191, b = 255, alpha = 200 })
	TriggerClientEvent('esx_rpchat:sendProximityMessage', -1, source, _U('do_prefix', name), args, { 0, 191, 255 })
	--print(('%s: %s'):format(name, args))
end, false)

--- Trabajos

RegisterCommand('gc', function(source, args, rawCommand)
	local xPlayer = ESX.GetPlayerFromId(source)
	
	if xPlayer.job.name == 'police' then
		local playerName = GetPlayerName(source)
		local msg = rawCommand:sub(3)
		local name = getIdentity(source)

		fal = name.firstname .. " " .. name.lastname
		TriggerClientEvent('chat:addMessage', -1, {
			template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgb(0, 82, 7); border-radius: 6px;"><i class="fas fa-shield-alt"></i> [GUARDIA CIVIL INFORMA] {0}:<br> {1}</div>',
			args = { fal, msg }
		})
	else
		print('No eres un oficial de policía')
	end
end, false)

RegisterCommand('taxi', function(source, args, rawCommand)
	local xPlayer = ESX.GetPlayerFromId(source)
	
	if xPlayer.job.name == 'taxi' then
		local playerName = GetPlayerName(source)
		local msg = rawCommand:sub(6)
		local name = getIdentity(source)

		fal = name.firstname .. " " .. name.lastname
		TriggerClientEvent('chat:addMessage', -1, {
			template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgb(253, 232, 1); border-radius: 6px; color: rgb(60, 1, 102)"><i class="fas fa-taxi"></i> [TAXI] {0}:<br> {1}</div>',
			args = { fal, msg }
		})
	else
		print('No eres taxista')
	end
end, false)



RegisterCommand('mecanico', function(source, args, rawCommand)
	local xPlayer = ESX.GetPlayerFromId(source)
	
	if xPlayer.job.name == 'mechanic' then
		local playerName = GetPlayerName(source)
		local msg = rawCommand:sub(9)
		local name = getIdentity(source)

		fal = name.firstname .. " " .. name.lastname
		TriggerClientEvent('chat:addMessage', -1, {
			template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgb(212, 0, 255); border-radius: 6px;"><i class="fas fa-car-battery"></i> [MECANICO] {0}:<br> {1}</div>',
			args = { fal, msg }
		})
	else
		print('No eres mecánico')
	end
end, false)

RegisterCommand('ems', function(source, args, rawCommand)
	local xPlayer = ESX.GetPlayerFromId(source)
	
	if xPlayer.job.name == 'ambulance' then
		local playerName = GetPlayerName(source)
		local msg = rawCommand:sub(4)
		local name = getIdentity(source)

		fal = name.firstname .. " " .. name.lastname
		TriggerClientEvent('chat:addMessage', -1, {
			template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgb(255, 0, 0); border-radius: 6px;"><i class="fas fa-medkit"></i> [EMS] {0}:<br> {1}</div>',
			args = { fal, msg }
		})
	else
		print('No eres medico')
	end
end, false)

RegisterCommand('priv', function(source, args, user)
    if GetPlayerName(tonumber(args[1])) then
        local player = tonumber(args[1])
        table.remove(args, 1)

        TriggerClientEvent('chat:addMessage', player, {args = {"^2PRIVADO | "..GetPlayerName(source).. " (" .. source .. "): ^7" ..table.concat(args, " ")}, color = {52, 156, 0}})
        TriggerClientEvent('chat:addMessage', source, {args = {"^2PRIVADO | "..GetPlayerName(player).. "(" .. source .. "): ^7" ..table.concat(args, " ")}, color = {52, 156, 0}})

    else
        TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "ID de jugador incorrecta!")
    end

end,false)

function GetRealPlayerName(playerId)
	local xPlayer = ESX.GetPlayerFromId(playerId)

	if xPlayer then
		if Config.EnableESXIdentity then
			if Config.OnlyFirstname then
				return xPlayer.get('firstName')
			else
				return xPlayer.getName()
			end
		else
			return xPlayer.getName()
		end
	else
		return GetPlayerName(playerId)
	end
end

function GetCharacterName(source)
	local result = MySQL.Sync.fetchAll('SELECT firstname, lastname FROM users WHERE identifier = @identifier', {
		['@identifier'] = GetPlayerIdentifiers(source)[1]
	})

	if result[1] and result[1].firstname and result[1].lastname then
		if Config.OnlyFirstname then
			return result[1].firstname
		else
			return ('%s %s'):format(result[1].firstname, result[1].lastname)
		end
	else
		return GetPlayerName(source)
	end
end
local logEnabled = true

function DrawOnHead(playerid, text, color)
	TriggerClientEvent('esx_rpchat:drawOnHead', -1, text, color, playerid)
end