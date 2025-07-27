
--------------------------------------------------------------------------[[
local fontPath = "Interface\\AddOns\\EloiLab\\Fonts\\free3of9.ttf"

-- Create the frame
local frameCode = CreateFrame("Frame", "BarcodeFrame", UIParent)
frameCode:SetSize(300, 60) -- 30% of screen width
frameCode:SetPoint("TOPLEFT", 30, -5) -- Position at top-left corner with 10px offset
frameCode:Show()

-- -- Background (optional)
frameCode.bg = frameCode:CreateTexture(nil, "BACKGROUND")
frameCode.bg:SetAllPoints()
frameCode.bg:SetColorTexture(1, 1, 1, 1) -- Slightly transparent white background

-- -- Create the text
frameCode.text = frameCode:CreateFontString(nil, "OVERLAY")
frameCode.text:SetFont(fontPath, 48, "") -- Use the font without additional effects
frameCode.text:SetText("Hello World 42 2501")
frameCode.text:SetTextColor(0, 0, 0) -- Set text color to black
frameCode.text:SetPoint("CENTER")

-- -- Add text in frameCode with total width and 5-pixel height
local textHeight = 12 -- Adjusted for better readability
local textWidth = frameCode:GetWidth()
local textString = frameCode:CreateFontString(nil, "OVERLAY")
textString:SetFont("Fonts\\ARIALN.TTF", textHeight) -- Using a more readable font
textString:SetPoint("TOP", frameCode, "TOP", 0, -5)
textString:SetText("Sample Text")
textString:SetTextColor(0, 0, 0, 1) -- Black color for the text



-- Adjust text width to fit within the frame
frameCode.text:SetWidth(frameCode:GetWidth() - 20) -- Add padding
frameCode.text:SetWordWrap(false) -- Disable word wrapping

-- Function to encode text into Code 128 format
local function encodeToBarcodeTFB(input)
    input = input:gsub(" ", "") -- Remove spaces from the input string
    input = input:gsub("-", "") -- Remove hyphens from the input string
    
    return '*'..input..'*'
end

-- Update the text every 0.5 seconds with the target's GUID info
C_Timer.NewTicker(0.5, function()
    if not frameCode or not frameCode.text then
        print("Error: frameCode or frameCode.text is not initialized.")
        return
    end
    local playerId = UnitGUID("player")
targetGUID = UnitGUID("mouseover") or UnitGUID("target")
    local isPlayer = UnitIsPlayer("mouseover") or UnitIsPlayer("target")

    

    if targetGUID and playerId ~= targetGUID and isPlayer then
        local encodedText = encodeToBarcodeTFB(targetGUID:gsub("Player%-", ""))

        textString:SetText("Code 39: " .. targetGUID) 

        frameCode.text:SetText(encodedText) 
        frameCode:Show()
    else
        frameCode:Hide()
    end
end)
