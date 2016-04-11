-------------------------------------------------------------------------------------------
-- MTA ELS System
-- Author: MasterM, Zuck3rFr3i
-- Lizenz: Opensource
-- Disclaimer: Do not reupload and pls use Github Repository to Push changes.
-------------------------------------------------------------------------------------------



local mv
local bVisible
local scx, scy = guiGetScreenSize()
local uLight
local uLightTimer
local lp = localPlayer
local iX, iY, iZ = 0, 0, 0
--funcs
local openEditor
local closeEditor




local function flashLight()
    if not getPedOccupiedVehicle(lp) then return closeEditor() end
    if isElement(uLight) then
        destroyElement(uLight)
    else
        uLight = createMarker(0, 0, 0, "corona", 0.2)
        attachElements(uLight, getPedOccupiedVehicle(lp), iX, iY, iZ)
    end
end


function closeEditor()
    if isElement(mv) then
        showCursor(false)
        bVisible = false
        if isTimer(uLightTimer) then killTimer(uLightTimer) end
        if isElement(uLight) then
            destroyElement(uLight)
        end
        return destroyElement(mv)
    end
end


--//
--||    openEditor
--\\

function openEditor()
    if isElement(mv) then
        return closeEditor()
    end
    bVisible = true
    iX, iY, iZ = 0, 0, 0
    showCursor(true)
    uLightTimer = setTimer(flashLight, 500, 0)

    mv = guiCreateWindow(5, scy/2-200, 400, 230, "light position editor", false)

    local lbl_x = guiCreateLabel(5, 35, 390, 20, "X : 0", false, mv)
        guiLabelSetHorizontalAlign (lbl_x, "center", true)
    local range_x = guiCreateScrollBar(5, 55, 390, 20, true, false, mv)
        guiScrollBarSetScrollPosition(range_x, 50)

    local lbl_y = guiCreateLabel(5, 85, 390, 20, "Y : 0", false, mv)
        guiLabelSetHorizontalAlign (lbl_y, "center", true)
    local range_y = guiCreateScrollBar(5, 105, 390, 20, true, false, mv)
        guiScrollBarSetScrollPosition(range_y, 50)

    local lbl_z = guiCreateLabel(5, 135, 390, 20, "Z : 0", false, mv)
        guiLabelSetHorizontalAlign (lbl_z, "center", true)
    local range_z = guiCreateScrollBar(5, 155, 390, 20, true, false, mv)
        guiScrollBarSetScrollPosition(range_z, 50)

    local btn_copy = guiCreateButton(5, 185, 100, 35, "copy to clipboard", false, mv)
    local lbl_info = guiCreateLabel(120, 185, 200, 30, "U for toggling the editor\nI for disabling editor", false, mv)

    local check_precise = guiCreateCheckBox(320, 185, 200, 30, "precise", false, false, mv)

    --events
    addEventHandler("onClientGUIScroll", mv, function()
        local bPrecise = guiCheckBoxGetSelected(check_precise)
        iX = (guiScrollBarGetScrollPosition(range_x)-50)/(bPrecise and 20 or 10)
        iY = (guiScrollBarGetScrollPosition(range_y)-50)/(bPrecise and 20 or 10)
        iZ = (guiScrollBarGetScrollPosition(range_z)-50)/(bPrecise and 20 or 10)
        guiSetText(lbl_x, "X : "..iX)
        guiSetText(lbl_y, "Y : "..iY)
        guiSetText(lbl_z, "Z : "..iZ)
        if isElement(uLight) then
            setElementAttachedOffsets(uLight, iX, iY, iZ)
        end
    end)

    addEventHandler("onClientGUIClick", btn_copy, function()
        setClipboard(("{x = %s, y = %s, z = %s},"):format(iX, iY, iZ))
    end, false)
end


--//
--||    toggleVisibility
--\\

local function toggleVisibility()
    if isElement(mv) then
        if bVisible then
            guiSetAlpha(mv, 0.1)
            showCursor(false)
        else
            guiSetAlpha(mv, 0.8)
            showCursor(true)
        end
        bVisible = not bVisible
    end
end


bindKey("u", "down", openEditor)
bindKey("i", "down", toggleVisibility)
