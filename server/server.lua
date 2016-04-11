-------------------------------------------------------------------------------------------
-- MTA ELS System
-- Author: MasterM, Zuck3rFr3i
-- Lizenz: Opensource
-- Disclaimer: Do not reupload and pls use Github Repository to Push changes.
-------------------------------------------------------------------------------------------



local tblELSVehs = {}

--local functions that get called all over the place
local changeVehicleELSState

--events
addEvent("ELS:onClientJoin", true)
addEvent("ELS:onVehicleStateChange", true)
addEvent("ELS:onVehicleAddByPreset", true) -- if a vehicle has a preset (shared/presets.lua), but no lights added yet, just add them


--//
--||	removeVehicleELS
--\\

function removeVehicleELS(uVeh)
	if tblELSVehs[uVeh] then
		tblELSVehs[uVeh] = nil
		triggerClientEvent("ELS:onVehicleRemove", resourceRoot, uVeh)
		removeEventHandler("onVehicleExplode", uVeh, changeVehicleELSState)
	end
end


--//
--||	hasVehicleELS
--\\

function hasVehicleELS(uVeh)
	return tblELSVehs[uVeh]
end


--//
--||	changeVehicleELSState
--\\

function changeVehicleELSState(bOn, uVeh)
	if isVehicle(uVeh) then source = uVeh end
	if hasVehicleELS(source) then
		local bCurrent = tblELSVehs[source].bOn
		triggerClientEvent("ELS:onVehicleStateChanged", source, bOn)
		tblELSVehs[source].bOn = bOn
	end
end


--//
--||	addVehicleELS
--\\

function addVehicleELS(uVeh, tblLights, bOn)
	if isVehicle(uVeh) then
		if not tblELSVehs[uVeh] then
			if not tblLights then
				if tblELSPresets[getElementModel(uVeh)] then
					tblELSVehs[uVeh] = tblELSPresets[getElementModel(uVeh)]
					tblELSVehs[uVeh].bPreset = true
					tblELSVehs[uVeh].bOn = bOn
				else
					return false
				end
			else
				tblELSVehs[uVeh] = tblLights
			end
			addEventHandler("onElementDestroy", uVeh, function() removeVehicleELS(source) end)
			addEventHandler("onVehicleExplode", uVeh, changeVehicleELSState)
			addEventHandler("ELS:onVehicleStateChange", uVeh, changeVehicleELSState)
			triggerClientEvent("ELS:onVehicleAdd", resourceRoot, uVeh, tblELSVehs[uVeh])
		end
	end
end


--//
--||	getVehicleELSPresets
--\\

function getVehicleELSPresets(uVeh)
	if isVehicle(uVeh) then
		if tblELSPresets[getElementModel(uVeh)] then
			return tblELSPresets[getElementModel(uVeh)]
		end
	end
	return false
end


--//
--||	send the ELS table to a client when he joins the game
--\\

addEventHandler("ELS:onClientJoin", resourceRoot, function()
	triggerLatentClientEvent(client, "ELS:onLightRecieve", resourceRoot, tblELSVehs) -- latent to reduce bandwidth
end)


--//
--||	add ELS to vehicles with preset
--\\

addEventHandler("ELS:onVehicleAddByPreset", resourceRoot, function(uVeh, bOn)
	if getVehicleELSPresets(uVeh) then
		addVehicleELS(uVeh, nil, bOn)
	end
end)

--//
--||	debug!
--\\


--[[local tblLights = {
	duration = 1000,
	lights = {
		{x = -0.5, y = 0, z = 0.7, rz = 90, color = {255,0,0}, start = 0, stop = 250},
		{x = -0.4, y = 0, z = 0.7, rz = 90, color = {255,0,0}, start = 500, stop = 750},
		{x = -0.3, y = 0, z = 0.7, rz = 90, color = {255,0,0}, start = 250, stop = 500},
		{x = -0.2, y = 0, z = 0.7, rz = 90, color = {255,0,0}, start = 750, stop = 1000},
		{x = 0.5, y = 0, z = 0.7, rz = -90, color = {0,0,255}, start = 0, stop = 250},
		{x = 0.4, y = 0, z = 0.7, rz = -90, color = {0,0,255}, start = 500, stop = 750},
		{x = 0.3, y = 0, z = 0.7, rz = -90, color = {0,0,255}, start = 250, stop = 500},
		{x = 0.2, y = 0, z = 0.7, rz = -90, color = {0,0,255}, start = 750, stop = 1000},

		--front
		{x = -0.2, y = 2.9, z = -0.2, rx = -10, rz = 10, angle = 40, color = {255,0,0}, start = 250, stop = 300, size = 2},
		{x = 0.2, y = 2.9, z = -0.2, rx = -10, rz = -10, angle = 40, color = {0,0,255}, start = 250, stop = 300, size = 2},

	}
}



local tblFBILights = {
	duration = 1000,
	lights = {
		--front flash
		{x = -0.9, y = 3.3, z = -0.45, rx = -10, rz = 10, angle = 40, color = {255,255,255}, start = 50, stop = 100, size = 2},
		{x = 0.9, y = 3.3, z = -0.45, rx = -10, rz = -10, angle = 40, color = {255,255,255}, start = 50, stop = 100, size = 2},
		{x = -0.9, y = 3.3, z = -0.45, rx = -10, rz = 10, angle = 40, color = {255,255,255}, start = 150, stop = 200, size = 2},
		{x = 0.9, y = 3.3, z = -0.45, rx = -10, rz = -10, angle = 40, color = {255,255,255}, start = 150, stop = 200, size = 2},
		--back
		{x = -0.7, y = -3.1, z = 0.45, rx = -30, rz = 110, color = {255,0,0,255}, start = 250, stop = 500, size = 1},
		{x = 0.7, y = -3.1, z = 0.45, rx = -30, rz = 250, color = {0,0,255,255}, start = 250, stop = 500, size = 1},
		{x = -0.5, y = -3.1, z = 0.45, rx = -30, rz = 170, angle = 80, color = {255,0,0,255}, start = 700, stop = 950, size = 1},
		{x = 0.5, y = -3.1, z = 0.45, rx = -30, rz = 200, angle = 80, color = {0,0,255,255}, start = 700, stop = 950, size = 1},
		--front
		{x = 0.3, y = 1.4, z = 0.55, rx = -30, rz = -10, color = {255,0,0,255}, start = 200, stop = 400, size = 1},
		{x = 0.6, y = 1.4, z = 0.55, rx = -30, rz = -50, color = {0,0,255,255}, start = 300, stop = 500, size = 1},
	}
}

addEventHandler("onResourceStart", resourceRoot, function()
setTimer(function()
local veh = createVehicle(411, 0, 0, 5)
	addVehicleELS(veh, tblLights)
	triggerEvent("ELS:onVehicleStateChange", veh, true)
	local veh = createVehicle(411, 5, 0, 5)
		addVehicleELS(veh, tblLights)
		triggerEvent("ELS:onVehicleStateChange", veh, true)
		local veh = createVehicle(411, 10, 0, 5)
			addVehicleELS(veh, tblLights)
			triggerEvent("ELS:onVehicleStateChange", veh, true)
			local veh = createVehicle(411, 15, 0, 5)
				addVehicleELS(veh, tblLights)
				triggerEvent("ELS:onVehicleStateChange", veh, true)
				local veh = createVehicle(411, 20, 0, 5)
					addVehicleELS(veh, tblLights)
					triggerEvent("ELS:onVehicleStateChange", veh, true)
					local veh = createVehicle(411, 25, 0, 5)
						addVehicleELS(veh, tblLights)
						triggerEvent("ELS:onVehicleStateChange", veh, true)
						local veh = createVehicle(411, 30, 0, 5)
							addVehicleELS(veh, tblLights)
							triggerEvent("ELS:onVehicleStateChange", veh, true)
							local veh = createVehicle(490, 35, 0, 5)
								--addVehicleELS(veh, tblFBILights)
								--triggerEvent("ELS:onVehicleStateChange", veh, true)
end, 500, 1)

end)]]
