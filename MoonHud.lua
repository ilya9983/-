local hook = require "samp.events"
local velo = false
local state = false
local antipos = false
local dall = false
local aall = false
local nall = false

function main()
	repeat wait(0) until isSampAvailable()
	wait(50)
	sampRegisterChatCommand("pnh", start)
	sampRegisterChatCommand("dpnh", startd)
	sampRegisterChatCommand("npnh", startn)
	sampRegisterChatCommand("rfix", function() antipos = not antipos msg(antipos and "Fix âêëþ÷åí" or "Fix âûêëþ÷åí", -1) end)
	sampRegisterChatCommand("dpnh_all", function() dall = not dall msg(dall and "Íà âñåõ âêëþ÷åí, ñåðâåð Äàéìîíä" or "Íà âñåõ âûêëþ÷åí", -1) end)
	sampRegisterChatCommand("pnh_all", function() aall = not aall msg(aall and "Íà âñåõ âêëþ÷åí, ñåðâåð Àðèçîíà" or "Íà âñåõ âûêëþ÷åí", -1) end)
	sampRegisterChatCommand("npnh_all", function() nall = not nall msg(nall and "Íà âñåõ âêëþ÷åí, ñåðâåð ÍóáîÐÏ" or "Íà âñåõ âûêëþ÷åí", -1) end)
	while true do wait(0)
		if dall then
			if not isCharInAnyCar(1) then
				dall = false
				msg("Ñÿäü â ìàøèíó äîëáàåá")
			elseif getDriverOfCar(storeCarCharIsInNoSave(1)) ~= 1 then
				dall = false
				msg("Òû áåðåãà ïîïóòàë ÷òîëå? Çà ðóëü áåãîì ñåë")
			end
			for _, handle in ipairs(getAllChars()) do
				if doesCharExist(handle)then
					local _, id = sampGetPlayerIdByCharHandle(handle)
					local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
                    if id ~= myid and id >= 0 and id <= 999 then
						local tX,tY,tZ = getCharCoordinates(handle)
						local pX,pY,pZ = getCharCoordinates(PLAYER_PED)
						if getDistanceBetweenCoords3d(pX,pY,pZ,tX,tY,tZ) < 50 then
							if not sampIsPlayerPaused(id) then 
								if dall and isCharInAnyCar(1) then
									if getDriverOfCar(storeCarCharIsInNoSave(1)) == 1 then
										printStringNow("~y~[D] Kicking:"..sampGetPlayerNickname(id).."("..id..")", 2000)
										fired(id)
										wait(500)
									end
								end
							end
						end
					end
				end
			end
		end
		if aall then
			if not isCharInAnyCar(1) then
				aall = false
				msg("Ñÿäü â ìàøèíó äîëáàåá")
			elseif getDriverOfCar(storeCarCharIsInNoSave(1)) ~= 1 then
				aall = false
				msg("Òû áåðåãà ïîïóòàë ÷òîëå? Çà ðóëü áåãîì ñåë")
			elseif not isThisModelACar(getCarModel(storeCarCharIsInNoSave(PLAYER_PED))) then
				aall = false
				msg("Âûëåçè ñ ýòîé õóéíè è ñÿäü â íîðì áóòûëêó!")
			end		
			for _, handle in ipairs(getAllChars()) do
				if doesCharExist(handle)then
					local _, id = sampGetPlayerIdByCharHandle(handle)
					local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
                    if id ~= myid and id >= 0 and id <= 999 then
						local tX,tY,tZ = getCharCoordinates(handle)
						local pX,pY,pZ = getCharCoordinates(PLAYER_PED)
						if getDistanceBetweenCoords3d(pX,pY,pZ,tX,tY,tZ) < 40 then
							if not sampIsPlayerPaused(id) then 
								if aall and isCharInAnyCar(1) then
									if getDriverOfCar(storeCarCharIsInNoSave(1)) == 1 then
										printStringNow("~y~[A] Kicking:"..sampGetPlayerNickname(id).."("..id..")", 2000)
										fire(id)
										wait(500)
									end
								end
							end
						end
					end
				end
			end
		end
		if nall then
			if not isCharInAnyCar(1) then
				nall = false
				msg("Ñÿäü â ìàøèíó äîëáàåá")
			elseif getDriverOfCar(storeCarCharIsInNoSave(1)) ~= 1 then
				nall = false
				msg("Òû áåðåãà ïîïóòàë ÷òîëå? Çà ðóëü áåãîì ñåë")
			end
			for _, handle in ipairs(getAllChars()) do
				if doesCharExist(handle)then
					local _, id = sampGetPlayerIdByCharHandle(handle)
					local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
                    if id ~= myid and id >= 0 and id <= 999 then
						local tX,tY,tZ = getCharCoordinates(handle)
						local pX,pY,pZ = getCharCoordinates(PLAYER_PED)
						if getDistanceBetweenCoords3d(pX,pY,pZ,tX,tY,tZ) < 100 then
							if not sampIsPlayerPaused(id) then 
								if nall and isCharInAnyCar(1) then
									if getDriverOfCar(storeCarCharIsInNoSave(1)) == 1 then
										printStringNow("~y~[N] Kicking:"..sampGetPlayerNickname(id).."("..id..")", 2000)
										firen(id)
										wait(100)
									end
								end
							end
						end
					end
				end
			end
		end
	end
end

function fire(id)
	id = tonumber(id)
	sampSendChat("/limit 30")
	state = false
	velo = true
	wait(100)
	sendVelo()
	local time = os.clock()
	while not state and velo do wait(0)
		if os.clock() - time >= 5 then
			msg("×òîòî ïîøëî íå òàê, âûêëþ÷èë")
			velo = false
			state = false
		end
	end
	if state then
		for i= 0,3 do
			wait(100)
			sendRvanka(id)
		end
		wait(200)
		sendVelo()
		wait(100)
		velo = false
		state = false
		sampSendChat("/limit 0") 
		msg("Îòïðàâëåí â àä")
	end
end

function start(id)
	if not state and not velo then
		if dall or aall or nall then return msg("Ñåé÷àñ âêëþ÷åíî íà âñåõ, êóäà òû ëåçåøü åáàòü") end
		if not isCharInAnyCar(1) then
			return msg("Ñÿäü â ìàøèíó äîëáàåá")
		end
		if getDriverOfCar(storeCarCharIsInNoSave(1)) ~= 1 then
			return msg("Òû áåðåãà ïîïóòàë ÷òîëå? Çà ðóëü áåãîì ñåë")
		end
		if not isThisModelACar(getCarModel(storeCarCharIsInNoSave(PLAYER_PED))) then	
			return msg("Âûëåçè ñ ýòîé õóéíè è ñÿäü â íîðì áóòûëêó!")
		end
		if tonumber(id) ~= nil and id ~= nil and id ~= "" and tonumber(id) < 1000 and tonumber(id) >= 0 then
			id = tonumber(id)
			local res, handle = sampGetCharHandleBySampPlayerId(id)
			if res and doesCharExist(handle) then
				local tX,tY,tZ = getCharCoordinates(handle)
				local pX,pY,pZ = getCharCoordinates(PLAYER_PED)
				if getDistanceBetweenCoords3d(pX,pY,pZ,tX,tY,tZ) < 40 then
					if not sampIsPlayerPaused(id) then
						msg("Âûáðàííàÿ öåëü "..sampGetPlayerNickname(id).." ("..id..")")
						lua_thread.create(fire, id)
					else
						msg("Öåëü â AFK!")
					end
				else
					msg("Öåëü äàëåêî!")
				end
			else
				msg("Öåëü íå â çîíå ñòðèìà!")
			end
		else
			msg("Ââåäèòå ïðàâèëüíî ID!")
		end
	else
		msg("Ïîäîæäèòå!")
	end
end

function firen(id)
	id = tonumber(id)
	sampSendChat("/limit 30")
	state = false
	velo = true
	wait(100)
	sendVelo()
	local time = os.clock()
	local state = true
	for i= 0,5 do
		wait(100)
		sendRvankaD(id)
	end
	wait(200)
	velo = false
	state = false
	sampSendChat("/limit 0") 
	sampSendChat("/limit") 
	msg("Îòïðàâëåí â àä")
end

function startn(id)
	if not state and not velo then
		if dall or aall or nall then return msg("Ñåé÷àñ âêëþ÷åíî íà âñåõ, êóäà òû ëåçåøü åáàòü") end
		if not isCharInAnyCar(1) then
			return msg("Ñÿäü â ìàøèíó äîëáàåá")
		end
		if getDriverOfCar(storeCarCharIsInNoSave(1)) ~= 1 then
			return msg("Òû áåðåãà ïîïóòàë ÷òîëå? Çà ðóëü áåãîì ñåë")
		end
		if tonumber(id) ~= nil and id ~= nil and id ~= "" and tonumber(id) < 1000 and tonumber(id) >= 0 then
			id = tonumber(id)
			local res, handle = sampGetCharHandleBySampPlayerId(id)
			if res and doesCharExist(handle) then
				local tX,tY,tZ = getCharCoordinates(handle)
				local pX,pY,pZ = getCharCoordinates(PLAYER_PED)
				if getDistanceBetweenCoords3d(pX,pY,pZ,tX,tY,tZ) < 100 then
					if not sampIsPlayerPaused(id) then
						msg("Âûáðàííàÿ öåëü "..sampGetPlayerNickname(id).." ("..id..")")
						lua_thread.create(firen, id)
					else
						msg("Öåëü â AFK!")
					end
				else
					msg("Öåëü äàëåêî!")
				end
			else
				msg("Öåëü íå â çîíå ñòðèìà!")
			end
		else
			msg("Ââåäèòå ïðàâèëüíî ID!")
		end
	else
		msg("Ïîäîæäèòå!")
	end
end

function fired(id)
	id = tonumber(id)
	sampSendChat("/limit 10")
	state = false
	velo = true
	wait(100)
	sendVelo()
	local time = os.clock()
	while not state and velo do wait(0)
		if os.clock() - time >= 5 then
			msg("×òîòî ïîøëî íå òàê, âûêëþ÷èë")
			velo = false
			state = false
		end
	end
	if state then
		for i= 0,3 do
			wait(100)
			sendRvanka(id)
		end
		wait(100)
		sendVelo()
		wait(100)
		velo = false
		state = false
		sampSendChat("/limit") 
		sampSendChat("/limit 0") 
		msg("Îòïðàâëåí â àä")
	end
end

function startd(id)
	if not state and not velo then
		if dall or aall or nall then return msg("Ñåé÷àñ âêëþ÷åíî íà âñåõ, êóäà òû ëåçåøü åáàòü") end
		if not isCharInAnyCar(1) then
			return msg("Ñÿäü â ìàøèíó äîëáàåá")
		end
		if getDriverOfCar(storeCarCharIsInNoSave(1)) ~= 1 then
			return msg("Òû áåðåãà ïîïóòàë ÷òîëå? Çà ðóëü áåãîì ñåë")
		end
		if tonumber(id) ~= nil and id ~= nil and id ~= "" and tonumber(id) < 1000 and tonumber(id) >= 0 then
			id = tonumber(id)
			local res, handle = sampGetCharHandleBySampPlayerId(id)
			if res and doesCharExist(handle) then
				local tX,tY,tZ = getCharCoordinates(handle)
				local pX,pY,pZ = getCharCoordinates(PLAYER_PED)
				if getDistanceBetweenCoords3d(pX,pY,pZ,tX,tY,tZ) < 40 then
					if not sampIsPlayerPaused(id) then
						msg("Âûáðàííàÿ öåëü "..sampGetPlayerNickname(id).." ("..id..")")
						lua_thread.create(fired, id)
					else
						msg("Öåëü â AFK!")
					end
				else
					msg("Öåëü äàëåêî!")
				end
			else
				msg("Öåëü íå â çîíå ñòðèìà!")
			end
		else
			msg("Ââåäèòå ïðàâèëüíî ID!")
		end
	else
		msg("Ïîäîæäèòå!")
	end
end

function sendRvanka(id) 
	local id = tonumber(id)
	local res, ped = sampGetCharHandleBySampPlayerId(id)
	if res then
		local x,y,z = getCharCoordinates(ped)
		local move = 95
		local data = samp_create_sync_data('vehicle')
		data.position = {x, y, z-1}
		data.keysData = data.keysData + 8
		data.moveSpeed = {move, move, move}
		data.send()
	end
end

function sendRvankaD(id) 
	local id = tonumber(id)
	local res, ped = sampGetCharHandleBySampPlayerId(id)
	if res then
		local x,y,z = getCharCoordinates(ped)
		local move = 95
		local data = samp_create_sync_data('vehicle')
		data.position = {x, y, z-1}
		data.moveSpeed = {move, move, move}
		data.send()
	end
end

function sendVelo()
	local pX,pY,pZ = getCharCoordinates(PLAYER_PED)
	local x,y,z = pX+5,pY-5,pZ
	local move = 0.1
	local data = samp_create_sync_data('vehicle')
	data.keysData = data.keysData + 8
	data.position = {x, y, z-0.3}
	data.moveSpeed = {move, move, move}
	data.send()
end

function hook.onSetVehicleVelocity(turn, pos)
	if velo then
		state = true
		return false
	end
	if antipos then return false end
end

function hook.onServerMessage(color, text)
	if text:find("Èñïîëüçóéòå .* äëÿ óñòàíîâêè îãðàíè÷èòåëÿ ñêîðîñòè") or text:find(".* 0, îòêëþ÷èòü îãðàíè÷èòåëü") then
		return false
	end
	if text:find("Ýòà ôóíêöèÿ äîñòóïíà òîëüêî â àâòî") then
		velo = false
		state = false
		msg("Ïåðåñÿäü â àâòî, íà ýòîì äðàïèçäîíå íèõóÿ íå ñäåëàåøü!") 
	end
	if text:find("Îãðàíè÷åíèå ñêîðîñòè ñíÿòî") or text:find("Óñòàíîâëåíî îãðàíè÷åíèå ñêîðîñòè") or text:find("/limit %[ñêîðîñòü%]") then
		return false
	end
end

function hook.onDisplayGameText(style, time, text)
	if text:find("Limit") or text:find("limit") or text:find("LIMIT") then return false end
end

function hook.onRemovePlayerFromVehicle()
    if state then return false end
    if antipos then return false end
end

function hook.onSetVehiclePos(vid, pos)
    if state then return false end
    if antipos then return false end
end

function hook.onSendVehicleSync(data)
    if state or velo then return false end
end

function hook.onSetPlayerPos(pos)
    if state then return false end
    if antipos then return false end
end

function hook.onSendPlayerSync(data)
    if state then return false end
end

function hook.onVehicleSync(playerId, vehicleId, data)
    if data.moveSpeed.x > 1 and data.moveSpeed.y > 1 and data.moveSpeed.z > 1 then
		sampAddChatMessage("AntiRvanka by GoxaShow > "..playerId.." íà ñâîåé áóòûëêå "..vehicleId.." ïûòàåòñÿ ðâàíèòü, óñïîêîé åãî",-1)
		return false
	end
end

function samp_create_sync_data(sync_type, copy_from_player)
    local ffi = require 'ffi'
    local sampfuncs = require 'sampfuncs'
    -- from SAMP.Lua
    local raknet = require 'samp.raknet'
    --require 'samp.synchronization'

    copy_from_player = copy_from_player or true
    local sync_traits = {
        player = {'PlayerSyncData', raknet.PACKET.PLAYER_SYNC, sampStorePlayerOnfootData},
        vehicle = {'VehicleSyncData', raknet.PACKET.VEHICLE_SYNC, sampStorePlayerIncarData},
        passenger = {'PassengerSyncData', raknet.PACKET.PASSENGER_SYNC, sampStorePlayerPassengerData},
        aim = {'AimSyncData', raknet.PACKET.AIM_SYNC, sampStorePlayerAimData},
        trailer = {'TrailerSyncData', raknet.PACKET.TRAILER_SYNC, sampStorePlayerTrailerData},
        unoccupied = {'UnoccupiedSyncData', raknet.PACKET.UNOCCUPIED_SYNC, nil},
        bullet = {'BulletSyncData', raknet.PACKET.BULLET_SYNC, nil},
        spectator = {'SpectatorSyncData', raknet.PACKET.SPECTATOR_SYNC, nil}
    }
    local sync_info = sync_traits[sync_type]
    local data_type = 'struct ' .. sync_info[1]
    local data = ffi.new(data_type, {})
    local raw_data_ptr = tonumber(ffi.cast('uintptr_t', ffi.new(data_type .. '*', data)))
    -- copy player's sync data to the allocated memory
    if copy_from_player then
        local copy_func = sync_info[3]
        if copy_func then
            local _, player_id
            if copy_from_player == true then
                _, player_id = sampGetPlayerIdByCharHandle(PLAYER_PED)
            else
                player_id = tonumber(copy_from_player)
            end
            copy_func(player_id, raw_data_ptr)
        end
    end
    -- function to send packet
    local func_send = function()
        local bs = raknetNewBitStream()
        raknetBitStreamWriteInt8(bs, sync_info[2])
        raknetBitStreamWriteBuffer(bs, raw_data_ptr, ffi.sizeof(data))
        raknetSendBitStreamEx(bs, sampfuncs.HIGH_PRIORITY, sampfuncs.UNRELIABLE_SEQUENCED, 1)
        raknetDeleteBitStream(bs)
    end
    -- metatable to access sync data and 'send' function
    local mt = {
        __index = function(t, index)
            return data[index]
        end,
        __newindex = function(t, index, value)
            data[index] = value
        end
    }
    return setmetatable({send = func_send}, mt)
end
