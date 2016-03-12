-------------------------------------------------------------------------------------------
-- MTA ELS System
-- Author: MasterM, Zuck3rFr3i
-- Lizenz: Opensource
-- Disclaimer: Do not reupload and pls use Github Repository to Push changes.
-------------------------------------------------------------------------------------------



local tblELSVehs = {}

addEvent("ELS:onClientJoin", true)
addEvent("ELS:onVehicleStateChange", true)


function removeVehicleELS(uVeh)
	if tblELSVehs[uVeh] then 
		tblELSVehs[uVeh] = nil
		triggerClientEvent("ELS:onVehicleRemove", resourceRoot, uVeh)
	end
end


function hasVehicleELS(uVeh)
	return tblELSVehs[uVeh]
end


local function changeVehicleELSState(bOn)
	if hasVehicleELS(source) then 
		local bCurrent = tblELSVehs[source].bOn
		triggerClientEvent("ELS:onVehicleStateChanged", source, bOn)
		tblELSVehs[source].bOn = bOn
	end
end


function addVehicleELS(uVeh, tblLights)
	if not tblELSVehs[uVeh] then 
		tblELSVehs[uVeh] = tblLights
		addEventHandler("onElementDestroy", uVeh, function() removeVehicleELS(source) end)
		addEventHandler("ELS:onVehicleStateChange", uVeh, changeVehicleELSState)
		triggerClientEvent("ELS:onVehicleAdd", resourceRoot, uVeh, tblLights)
	end
end





addEventHandler("ELS:onClientJoin", resourceRoot, function()
	triggerClientEvent(client, "ELS:onLightRecieve", resourceRoot, tblELSVehs)
end)


local tblLights = {
	duration = 10,
	lights = {
		{x = 1, y = 1, z = 1, color = {255,0,0,255}, start = 5, stop = 7}
	}
}

addEventHandler("onResourceStart", resourceRoot, function()
setTimer(function()
local veh = createVehicle(411, 0, 0, 5)
	addVehicleELS(veh, tblLights)

local veh = createVehicle(411, 5, 0, 5)
	addVehicleELS(veh, tblLights)
end, 100, 1)

end)