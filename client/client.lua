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
local tblRenderedELSVehs = {}
local uLightImage


--//
--||	the light cache stores all pixel lights, we have to destroy them manually when the resource stops
--\\

local tblLightCache = {}
addEventHandler("onClientResourceStop", resourceRoot, function()
	for uVeh, v in pairs(tblLightCache) do
		for i, light in pairs(v) do
			exports["dynamic_lighting"]:destroyLight(light)
		end
	end
end)


--//
--||	renderELS
--\\

local function renderELS()
	local iStartStamp = getTickCount()
	for veh in pairs(tblRenderedELSVehs) do
		local light = tblELSVehs[veh]
		local iVehX, iVehY, iVehZ = getElementPosition(veh)
		local iScreenVehX, iScreenVehY = getScreenFromWorldPosition(iVehX, iVehY, iVehZ, 100) -- 100 for 100px tolerance
		if iScreenVehX and iScreenVehY then -- the vehicle is seen on the player's screen
			if light.bOn then
				if light.lights then
					if not light.iRnd then
						tblELSVehs[veh].iRnd = math.random(0, tblELSVehs[veh].duration) or 0
					end

					local iCurPhase = (getTickCount()+light.iRnd) % light.duration
					for i=1, #light.lights do
						local data = light.lights[i]
						if iCurPhase > data.start and iCurPhase < data.stop then
							local iX, iY, iZ = getPositionFromElementOffset(veh, data.x, data.y, data.z)
							if uLightImage then
								local iDim = 0.2*(data.size or 1)
								--draw a light source
								if exports["dynamic_lighting"] then
									if not tblLightCache[veh][i] then
											local r,g,b,a = unpack(data.color)
											r,g,b,a = r/255, g/255, b/255/0.7
											if data.rx or data.ry or data.rz then
												local iVehRX, iVehRY, iVehRZ = getElementRotation(veh)
												local iToX, iToY, iToZ = (data.rx or 0)+iVehRX, (data.ry or 0)+iVehRY, (data.rz or 0)+iVehRZ
												local iAngle = data.angle and data.angle/2 or 70
												tblLightCache[veh][i] = exports["dynamic_lighting"]:createSpotLight(iX, iY, iZ, r, g, b, 1, iToX, iToY, iToZ, true, 40*iDim, math.rad(iAngle/1.5), math.rad(iAngle), 50*iDim)
											else
												tblLightCache[veh][i] = exports["dynamic_lighting"]:createPointLight(iX, iY, iZ,r,g,b,1,50*iDim)
											end
									else
										exports["dynamic_lighting"]:setLightPosition(tblLightCache[veh][i], iX, iY, iZ)
										if data.rx or data.ry or data.rz then
											local iVehRX, iVehRY, iVehRZ = getElementRotation(veh)
											local iToX, iToY, iToZ = (data.rx or 0)+iVehRX, (data.ry or 0)+iVehRY, (data.rz or 0)+iVehRZ
											exports["dynamic_lighting"]:setLightDirection(tblLightCache[veh][i], iToX, iToY, iToZ, true)
										end
									end
								end

								--draw the visible center point
								--calculate the position based to the camera angle (so that the image is always facing to the camera)
								--we cannot use dxDrawImage with getScreenFromWorldPosition because this would glitch around the car
								local ix, iy, iz = getElementPosition(getCamera())
								local irx, iry, irz = getElementRotation(getCamera())
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
						else -- light is not active, destroy possible light sources
							if exports["dynamic_lighting"] then
								if tblLightCache[veh][i] then
									exports["dynamic_lighting"]:destroyLight(tblLightCache[veh][i])
									tblLightCache[veh][i] = nil
								end
							end
						end
					end
				end
			end
		end
	end
	dxDrawText(getTickCount()-iStartStamp,0,0,500,500) --debug
end
addEventHandler("onClientPreRender", root, renderELS)


--//
--||	removeVehicleELS
--\\

local function removeVehicleELS(uVeh)
	if tblELSVehs[uVeh] then
		tblELSVehs[uVeh] = nil
		for i, v in pairs(tblLightCache[uVeh]) do
			exports["dynamic_lighting"]:destroyLight(tblLightCache[uVeh][i])
		end
		tblLightCache[uVeh] = nil
	end
end
addEventHandler("ELS:onVehicleRemove", resourceRoot, removeVehicleELS)


--//
--||	changeVehicleELSState
--\\

local function changeVehicleELSState(bOn, uVeh)
	if uVeh then source = uVeh end
	if hasVehicleELS(source) then
		tblELSVehs[source].iRnd = math.random(0, tblELSVehs[source].duration) or 0 -- so vehicles with the same sync don't flash in the same order
		tblELSVehs[source].bOn = bOn
		if not bOn and tblLightCache[source] then
			for i, v in pairs(tblLightCache[source]) do
				exports["dynamic_lighting"]:destroyLight(tblLightCache[source][i])
			end
		end
		if isElementStreamedIn(source) and bOn then
			tblRenderedELSVehs[source] = true
		end
	end
end


--//
--||	hasVehicleELS
--\\

function hasVehicleELS(uVeh)
	return tblELSVehs[uVeh]
end


--//
--||	addVehicleELS
--\\

local function addVehicleELS(uVeh, tblLights)
	if not tblELSVehs[uVeh] then
		tblELSVehs[uVeh] = tblLights
		tblLightCache[uVeh] = {}
		addEventHandler("ELS:onVehicleStateChanged", uVeh, changeVehicleELSState)
	end
end
addEventHandler("ELS:onVehicleAdd", resourceRoot, addVehicleELS)


--//
--||	get ELS vehicles from server
--\\

addEventHandler("ELS:onLightRecieve", resourceRoot, function(tblServerLights)
	tblELSVehs = tblServerLights
	for i, v in pairs(tblELSVehs) do
		if tblELSVehs[i].bOn then
			changeVehicleELSState(true, i)
		end
	end
end)


-------------------------------------------------------------------------------------------
-- determine which vehicles are rendered
-------------------------------------------------------------------------------------------
addEventHandler("onClientElementStreamIn", resourceRoot, function()
	if isVehicle(source) and tblELSVehs[source] then
		tblRenderedELSVehs[source] = true
	end

end)

addEventHandler("onClientElementStreamOut", resourceRoot, function()
	if isVehicle(source) and tblELSVehs[source] then
		tblRenderedELSVehs[source] = nil
		if tblELSVehs[source].bOn then
			changeVehicleELSState(false, source)
			tblELSVehs[source].bOn = true -- yeah, it's a funny solution, but we have to delete all light elements
		end
	end
end)



-------------------------------------------------------------------------------------------
-- Toggle ELS
-------------------------------------------------------------------------------------------
function InitLighting()
	local vehicle = getPedOccupiedVehicle(localPlayer)
	if vehicle and getPedOccupiedVehicleSeat(localPlayer) == 0 then
		local bCurrent = tblELSVehs[vehicle].bOn
		triggerServerEvent("ELS:onVehicleStateChange", vehicle, not bCurrent)
	end
end
bindKey("L", "down", InitLighting)


--//
--||	get all ELS vehicles
--\\

addEventHandler("onClientResourceStart", resourceRoot, function()
	triggerServerEvent("ELS:onClientJoin", resourceRoot)
	uLightImage = dxCreateTexture("res/light_source.png")
end)
-------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------
