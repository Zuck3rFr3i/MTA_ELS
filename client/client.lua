-------------------------------------------------------------------------------------------
-- MTA ELS System
-- Author: MasterM, Zuck3rFr3i
-- Lizenz: Opensource
-- Disclaimer: Do not reupload and pls use Github Repository to Push changes.
-------------------------------------------------------------------------------------------
-- Setup ELS Stuff
-------------------------------------------------------------------------------------------

addEvent("ELS:onVehicleAdd", true)
addEvent("ELS:onVehicleRemove", true)
addEvent("ELS:onLightRecieve", true)
addEvent("ELS:onVehicleStateChanged", true)

local tblELSVehs = {}



local function renderELS()
	for veh,light in pairs(tblELSVehs) do
		if light.bOn then
			local c = getVehicleOverrideLights(veh)
			if c == 2 then 
				setVehicleOverrideLights(veh, 1)
			elseif c ~= 2 then 
				setVehicleOverrideLights(veh, 2)
			end	
		end
	end
end
addEventHandler("onClientRender", root, renderELS)

local function removeVehicleELS(uVeh)
	if tblELSVehs[uVeh] then 
		tblELSVehs[uVeh] = nil
	end
end
addEventHandler("ELS:onVehicleRemove", resourceRoot, removeVehicleELS)

local function changeVehicleELSState(bOn)
	if hasVehicleELS(source) then 
		tblELSVehs[source].bOn = bOn
		outputChatBox(tostring(tblELSVehs[source].bOn))
	end
end



function hasVehicleELS(uVeh)
	return tblELSVehs[uVeh]
end


local function addVehicleELS(uVeh, tblLights)
	if not tblELSVehs[uVeh] then 
		tblELSVehs[uVeh] = tblLights
		addEventHandler("ELS:onVehicleStateChanged", uVeh, changeVehicleELSState)
	end
end
addEventHandler("ELS:onVehicleAdd", resourceRoot, addVehicleELS)



addEventHandler("ELS:onLightRecieve", resourceRoot, function(tblServerLights)
	tblELSVehs = tblServerLights
end)


-------------------------------------------------------------------------------------------
-- Toggle Els
-------------------------------------------------------------------------------------------
function InitLighting()
	local vehicle = getPedOccupiedVehicle(localPlayer)
	if vehicle then
		local bCurrent = tblELSVehs[vehicle].bOn
		triggerServerEvent("ELS:onVehicleStateChange", vehicle, not bCurrent)
	end
end
bindKey("L", "down", InitLighting)



addEventHandler("onClientResourceStart", resourceRoot, function()
	triggerServerEvent("ELS:onClientJoin", resourceRoot)
end)
-------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------