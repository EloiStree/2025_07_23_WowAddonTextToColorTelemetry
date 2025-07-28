

local long_clock_frame_count = 0

function add_frame_to_clock_frame_count()
    long_clock_frame_count = long_clock_frame_count + 1
end

function print_5_seconds_tick()
    print ("Tick: " .. long_clock_frame_count)
end

local text_telemetry_to_display = ""
function refresh_what_to_display_text()
    text_telemetry_to_display= get_text_to_display()
end

--- TRIGGER A CUSTUM CODE WHEN PLAYER ARRIVES IN GAME ---
local function OnGameReady()
    -- Your code to run when the game is ready
    print("Game is ready!")
    event_call_when_in_game()

    add_to_clock_10_frames(add_frame_to_clock_frame_count)
    add_to_clock_10_frames(refresh_what_to_display_text)
    -- add_to_clock_1_second(hello_world)
    add_to_clock_5_seconds(print_5_seconds_tick)
end

local FRAME_PLAYER_ENTERING_WORLD = CreateFrame("Frame")
FRAME_PLAYER_ENTERING_WORLD:RegisterEvent("PLAYER_ENTERING_WORLD")
FRAME_PLAYER_ENTERING_WORLD:SetScript("OnEvent", function(self, event, ...)
    if event == "PLAYER_ENTERING_WORLD" then
        OnGameReady()
    end
end)



--------------------------------------------------------------------------
local fontPath = "Interface\\AddOns\\ColorTelemetry\\Fonts\\VerticalB58.ttf"
-- Create the main frame to take all the space
local frameCode = CreateFrame("Frame", "BarcodeFrame", UIParent, "BackdropTemplate")
frameCode:SetPoint("TOPLEFT", UIParent, "TOPLEFT", 0, 0)
frameCode:SetPoint("TOPRIGHT", UIParent, "TOPRIGHT", 0, 0)
frameCode:SetHeight(UIParent:GetHeight() * 0.2)
frameCode:Show()

-- Remove resizing and moving
frameCode:SetMovable(false)
frameCode:EnableMouse(false)
frameCode:SetResizable(false)

-- Background (optional)
frameCode.bg = frameCode:CreateTexture(nil, "BACKGROUND")
frameCode.bg:SetAllPoints()
frameCode.bg:SetColorTexture(0.1,0.1,0.1, 1)

-- Barcode font size and spacing
local function getBarHeight()
    -- Use almost all available height, leaving a small margin at the top
    return frameCode:GetHeight() - 6
end

local function createBarcodeFontString(parent, color)
    local fs = parent:CreateFontString(nil, "OVERLAY")
    fs:SetFont(fontPath, getBarHeight(), "")
    fs:SetText("")
    fs:SetTextColor(unpack(color))
    fs:SetSpacing(0)
    fs:SetHeight(getBarHeight())
    fs:SetJustifyH("LEFT")
    -- Shift down a few pixels to remove top space
    fs:SetPoint("TOPLEFT", parent, "TOPLEFT", 0, -3)
    return fs
end

local brightness = 0.5
-- Create barcode font strings stacked vertically
frameCode.text_black   = createBarcodeFontString(frameCode, {0, 0, 0, 1})
frameCode.text_red     = createBarcodeFontString(frameCode, {brightness, 0, 0, 1})
frameCode.text_green   = createBarcodeFontString(frameCode, {0, brightness, 0, 1})
frameCode.text_blue    = createBarcodeFontString(frameCode, {0, 0, brightness, 1})
frameCode.text_magenta = createBarcodeFontString(frameCode, {brightness, 0, brightness, 1})


-- Set random 128-byte text for each color barcode
local function randomText(len)
    local chars = {}
    for i = 1, len do
        
        chars[i] = string.char(math.random(1, 127))
        if i == 1 or i == len then
            chars[i] = string.char(127)
        end
    end
    return table.concat(chars)
end



local function setRandomColorBarcodes()
    frameCode.text_black:SetText(randomText(128))
    frameCode.text_red:SetText(randomText(128))
    frameCode.text_green:SetText(randomText(128))
    frameCode.text_blue:SetText(randomText(128))
    frameCode.text_magenta:SetText(randomText(128))
end
local function setTextCode(text)
    frameCode.text_black:SetText(text)
    frameCode.text_red:SetText(text)
    frameCode.text_green:SetText(text)
    frameCode.text_blue:SetText(text)
    frameCode.text_magenta:SetText(text)
end
local function setTextCodeTo128()
    local string_all_chat_1_128 = ""
    for i = 1, 127 do
        if i>8 and i<14 then
            string_all_chat_1_128 = string_all_chat_1_128 .. " "
        elseif i>127 and i<170 then
            string_all_chat_1_128 = string_all_chat_1_128 .. " "
        else 
            string_all_chat_1_128 = string_all_chat_1_128 .. string.char(i)
        end
    end
    print("string_all_chat_1_128: " .. string_all_chat_1_128)

    frameCode.text_black:SetText(string_all_chat_1_128)
    frameCode.text_red:SetText(string_all_chat_1_128)
    frameCode.text_green:SetText(string_all_chat_1_128)
    frameCode.text_blue:SetText(string_all_chat_1_128)
    frameCode.text_magenta:SetText(string_all_chat_1_128)
end

--local b60 = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz_-"
local b60 = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz_-"
local function setTextCodeTob60()
    local string_all_chat_1_60 = ""
    for i = 1, #b60 do
        string_all_chat_1_60 = string_all_chat_1_60 .. b60:sub(i, i)
    end
    print("string_all_chat_1_60: " .. string_all_chat_1_60)
    frameCode.text_black:SetText(string_all_chat_1_60)
    frameCode.text_red:SetText(string_all_chat_1_60)
    frameCode.text_green:SetText(string_all_chat_1_60)
    frameCode.text_blue:SetText(string_all_chat_1_60)
    frameCode.text_magenta:SetText(string_all_chat_1_60)
end

local getRandCharOfB60 = function()
    local int_index = math.random(1, 58)
    return b60:sub(int_index, int_index)
end

local getRandomTextOfB60 = function(length)
    local result = ""
    for i = 1, length do
        result = result .. getRandCharOfB60()
    end
    return result 
end

local function setTextRandomB60()
    test_char_count=40
    frameCode.text_black:SetText(getRandomTextOfB60(test_char_count))
    frameCode.text_red:SetText(getRandomTextOfB60(test_char_count))
    frameCode.text_green:SetText(getRandomTextOfB60(test_char_count))
    frameCode.text_blue:SetText(getRandomTextOfB60(test_char_count))
    frameCode.text_magenta:SetText(getRandomTextOfB60(test_char_count))
end


local secondsCounter = 0
local function setTextCodeToFrame()
    local frame_as_char = secondsCounter% 127
   char_to_display = string.char(frame_as_char+1)

    frameCode.text_black:SetText(char_to_display)
    frameCode.text_red:SetText(char_to_display)
    frameCode.text_green:SetText(char_to_display)
    frameCode.text_blue:SetText(char_to_display)
    frameCode.text_magenta:SetText(char_to_display)
    print ("setTextCodeToFrame: " .. char_to_display)
end

setRandomColorBarcodes()

-- -- Normal text
-- local textHeight = 28
-- local textString = frameCode:CreateFontString(nil, "OVERLAY")
-- textString:SetFont("Fonts\\ARIALN.TTF", textHeight)
-- textString:SetPoint("TOP", frameCode, "TOP", 0, -5)
-- textString:SetText("")
-- textString:SetTextColor(0, 0, 0, 1)
-- textString:SetWidth(frameCode:GetWidth() - 20)
-- textString:Show()

-- Update font string width on resize
-- frameCode:SetScript("OnSizeChanged", function(self)
--     textString:SetWidth(self:GetWidth() - 20)
-- end)

local function updateBarcodeAndText()
    local displayText = get_text_to_display()
    -- setTextCode(encode_to_bare_code_tfb(displayText))
    --setRandomColorBarcodes()
    setTextCodeTob60()
   -- setTextRandomB60()
    --setTextCodeToFrame()
    --textString:SetText(experiment_colorize_text(displayText))
    secondsCounter = secondsCounter + 1
end

add_to_clock_1_second(updateBarcodeAndText)
