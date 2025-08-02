
--[[
If you are doing telemetry from webcam, twitch or discord screenshare you will need to find the border of the game screen.
This code draws line around the game screen space to be found.
]]

local thickness = 40
local color = {1, 1, 0, 1}


-- in world of warcraft api lua addon
function display_line_around_screen_with_auto_update()

    local frame = CreateFrame("Frame", "DisplayLineAroundScreenFrame", UIParent)
    frame:SetAllPoints(UIParent)

    
    local line_top = frame:CreateLine()
    local line_bottom = frame:CreateLine()
    local line_left = frame:CreateLine()
    local line_right = frame:CreateLine()

    local create_line = function(line, startPoint, endPoint)
        line:SetDrawLayer("OVERLAY")
        line:SetColorTexture(unpack(color))
        line:SetThickness(thickness)
        line:SetStartPoint(startPoint, UIParent, "TOPLEFT")
        line:SetEndPoint(endPoint, UIParent, "TOPRIGHT")
    end
    --create_line(line_top, "TOPLEFT", "TOPRIGHT")
    --create_line(line_bottom, "BOTTOMLEFT", "BOTTOMRIGHT")
    create_line(line_left, "TOPLEFT", "BOTTOMLEFT")
    create_line(line_right, "TOPRIGHT", "BOTTOMRIGHT")
    

    local line = frame:CreateLine()
    line:SetColorTexture(1, 1, 0, 1) -- Yellow color
    line:SetThickness(10)

    return frame


end

-- COMMENT THIS LINE IF YOUR DONT WANT TO SEE THE LINE AROUND SCREEN
display_line_around_screen_with_auto_update()