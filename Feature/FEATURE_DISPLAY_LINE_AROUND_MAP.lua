--[[
The code in this file draws a colored border around the minimap.
Useful for telemetry: scan for the color to isolate the minimap.
--]]

local thickness = 3
local color_map_border = { r = 1, g = 0.2, b = 0.6, a = 1 } -- Pink color

function display_border_around_minimap()
    local border = CreateFrame("Frame", "PinkMinimapBorder", Minimap)
    border:SetAllPoints(Minimap)
    border:SetFrameStrata("MEDIUM")

    -- Top
    local top = border:CreateTexture(nil, "OVERLAY")
    top:SetColorTexture(color_map_border.r, color_map_border.g, color_map_border.b, color_map_border.a)
    top:SetPoint("TOPLEFT", -thickness, thickness)
    top:SetPoint("TOPRIGHT", thickness, thickness)
    top:SetHeight(thickness)

    -- Bottom
    local bottom = border:CreateTexture(nil, "OVERLAY")
    bottom:SetColorTexture(color_map_border.r, color_map_border.g, color_map_border.b, color_map_border.a)
    bottom:SetPoint("BOTTOMLEFT", -thickness, -thickness)
    bottom:SetPoint("BOTTOMRIGHT", thickness, -thickness)
    bottom:SetHeight(thickness)

    -- Left
    local left = border:CreateTexture(nil, "OVERLAY")
    left:SetColorTexture(color_map_border.r, color_map_border.g, color_map_border.b, color_map_border.a)
    left:SetPoint("TOPLEFT", -thickness, thickness)
    left:SetPoint("BOTTOMLEFT", -thickness, -thickness)
    left:SetWidth(thickness)

    -- Right
    local right = border:CreateTexture(nil, "OVERLAY")
    right:SetColorTexture(color_map_border.r, color_map_border.g, color_map_border.b, color_map_border.a)
    right:SetPoint("TOPRIGHT", thickness, thickness)
    right:SetPoint("BOTTOMRIGHT", thickness, -thickness)
    right:SetWidth(thickness)

    -- Pink square in the center
    local pinkSquare = CreateFrame("Frame", "PinkMinimapSquare", Minimap)
    pinkSquare:SetSize(5, 5)
    pinkSquare:SetPoint("CENTER", Minimap, "CENTER")
    local pinkSquareTexture = pinkSquare:CreateTexture(nil, "OVERLAY")
    pinkSquareTexture:SetColorTexture(color_map_border.r, color_map_border.g, color_map_border.b, color_map_border.a)
    pinkSquareTexture:SetAllPoints(pinkSquare)
end

display_border_around_minimap()
