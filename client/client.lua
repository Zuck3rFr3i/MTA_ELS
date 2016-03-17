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
local uLightImage


local function renderELS()
	local iStartStamp = getTickCount()
	for veh,light in pairs(tblELSVehs) do
		if light.bOn then
			if light.lights then
				local iCurPhase = (getTickCount()+light.iRnd) % light.duration
				for i=1, #light.lights do
					local data = light.lights[i]
					if iCurPhase > data.start and iCurPhase < data.stop then
						local iX, iY, iZ = getPositionFromElementOffset(veh, data.x, data.y, data.z)
						if uLightImage then
							local iDim = 0.2*(data.size or 1)
							local ix, iy, iz = getElementPosition(getCamera())
							local irx, iry, irz = getElementRotation(getCamera())

							--calculate the position based to the camera angle (so that the image is always facing to the camera)
							--we cannot use dxDrawImage with getScreenFromWorldPosition because this would glitch around the car
							local iRotDiff = (math.abs(irx-180)%270)-90 -- get an angle of 0 (facing from top) to 90 (facing from side)
							local iX1 = iX+iDim*(1-(iRotDiff/90))*math.sin(math.rad(-irz))
							local iY1 = iY+iDim*(1-(iRotDiff/90))*math.cos(math.rad(-irz))
							local iZ1 = iZ+iDim*iRotDiff/90
							local iX2 = iX-iDim*(1-(iRotDiff/90))*math.sin(math.rad(-irz))
							local iY2 = iY-iDim*(1-(iRotDiff/90))*math.cos(math.rad(-irz))
							local iZ2 = iZ-iDim*iRotDiff/90
							--dxDrawLine3D(iX1, iY1, iZ1, iX2, iY2, iZ2, white, 5)
							--dxDrawText(iX1.."\n"..iY1.."\n"..iZ1.."\n"..iX2.."\n"..iY2.."\n"..iZ2, 0, 0, 500, 500)
							--dxDrawLine3D(iX2, iY2, iZ2, iX2, iY2, iZ2+0.1, 10)
							dxDrawMaterialLine3D(iX1, iY1, iZ1, iX2, iY2, iZ2, uLightImage, iDim*2, tocolor(unpack(data.color)),ix, iy, iz)
						end
					end
				end
			end
		end
	end
	dxDrawText(getTickCount()-iStartStamp,0,0,500,500)
end
addEventHandler("onClientPreRender", root, renderELS)

local function removeVehicleELS(uVeh)
	if tblELSVehs[uVeh] then
		tblELSVehs[uVeh] = nil
	end
end
addEventHandler("ELS:onVehicleRemove", resourceRoot, removeVehicleELS)

local function changeVehicleELSState(bOn)
	if hasVehicleELS(source) then
		tblELSVehs[source].iRnd = math.random(0, tblELSVehs[source].duration) -- so vehicles with the same sync don't flash in the same order
		tblELSVehs[source].bOn = bOn
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
	uLightImage = dxCreateTexture("res/light_source.png")
end)
-------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------
