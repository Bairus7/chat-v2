RegisterServerEvent('chat:init')
RegisterServerEvent('chat:addTemplate')
RegisterServerEvent('chat:addMessage')
RegisterServerEvent('chat:addSuggestion')
RegisterServerEvent('chat:removeSuggestion')
RegisterServerEvent('_chat:messageEntered')
RegisterServerEvent('chat:clear')
RegisterServerEvent('__cfx_internal:commandFallback')

AddEventHandler('__cfx_internal:commandFallback', function(command)
    local name = GetPlayerName(source)

    TriggerEvent('chatMessage', source, name, '/' .. command)

    CancelEvent()
end)

-- player join messages
AddEventHandler('chat:init', function()
    TriggerClientEvent('chatMessage', -1, '', { 0, 255, 0 }, '' .. GetPlayerName(source) .. ' se ha unido')
end)

AddEventHandler('playerDropped', function(reason)
    TriggerClientEvent('chatMessage', -1, '', { 255, 0, 0 }, '' .. GetPlayerName(source) .. ' se ha ido (' .. reason .. ')')
end)

RegisterCommand('say', function(source, args, rawCommand)
    TriggerClientEvent('chatMessage', -1, (source == 0) and 'Server: ' or GetPlayerName(source), { 255, 0, 0 }, rawCommand:sub(5))
end)

-- command suggestions for clients
local function refreshCommands(player)
    if GetRegisteredCommands then
        local registeredCommands = GetRegisteredCommands()

        local suggestions = {}

        for _, command in ipairs(registeredCommands) do
            if IsPlayerAceAllowed(player, ('command.%s'):format(command.name)) then
                table.insert(suggestions, {
                    name = '/' .. command.name,
                    help = ''
                })
            end
        end

        TriggerClientEvent('chat:addSuggestions', player, suggestions)
    end
end

AddEventHandler('chat:init', function()
    refreshCommands(source)
end)

AddEventHandler('onServerResourceStart', function(resName)
    Wait(500)

    for _, player in ipairs(GetPlayers()) do
        refreshCommands(player)
    end
end)