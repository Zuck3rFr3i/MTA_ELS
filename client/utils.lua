-------------------------------------------------------------------------------------------
-- MTA ELS System
-- Author: MasterM, Zuck3rFr3i
-- Lizenz: Opensource
-- Disclaimer: Do not reupload and pls use Github Repository to Push changes.
-------------------------------------------------------------------------------------------


--//
--||    getPositionFromElementOffset
--\\

function getPositionFromElementOffset(element,offX,offY,offZ)
    local m = getElementMatrix ( element )  -- Get the matrix
    local x = offX * m[1][1] + offY * m[2][1] + offZ * m[3][1] + m[4][1]  -- Apply transform
    local y = offX * m[1][2] + offY * m[2][2] + offZ * m[3][2] + m[4][2]
    local z = offX * m[1][3] + offY * m[2][3] + offZ * m[3][3] + m[4][3]
    return x, y, z                               -- Return the transformed point
end


--//
--||    isVehicle
--\\

function isVehicle(uElement)
    return isElement(uElement) and getElementType(uElement) == "vehicle"
end


--//
--||    isPlayer
--\\

function isPlayer(uElement)
    return isElement(uElement) and getElementType(uElement) == "player"
end
