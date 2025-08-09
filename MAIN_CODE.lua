





display_line_around_screen_with_auto_update()

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
--local fontPath = "Interface\\AddOns\\ColorTelemetry\\Fonts\\VerticalB58.ttf"
local fontPath = "Interface\\AddOns\\ColorTelemetry\\Fonts\\Vertical4BitsSquare.ttf"

--local fontPath = "Interface\\AddOns\\ColorTelemetry\\Fonts\\free3of9.ttf"
-- Create the main frame to take all the space
local frameCode = CreateFrame("Frame", "BarcodeFrame", UIParent, "BackdropTemplate")
frameCode:SetPoint("TOPLEFT", UIParent, "TOPLEFT", 30, -30)
frameCode:SetPoint("TOPRIGHT", UIParent, "TOPRIGHT", 30, -30)
frameCode:SetHeight(UIParent:GetHeight() * 0.1) 
frameCode:Show()

-- Remove resizing and moving
frameCode:SetMovable(false)
frameCode:EnableMouse(false)
frameCode:SetResizable(false)


-- Make frameCode movable by dragging with mouse
frameCode:SetMovable(true)
frameCode:EnableMouse(true)
frameCode:RegisterForDrag("LeftButton")
frameCode:SetScript("OnDragStart", function(self)
    self:StartMoving()
end)
frameCode:SetScript("OnDragStop", function(self)
    self:StopMovingOrSizing()
end)


-- Create a frame for the text below frameCode
local textFrame = CreateFrame("Frame", "NormalTextFrame", frameCode, "BackdropTemplate")
textFrame:SetPoint("TOPLEFT", frameCode, "BOTTOMLEFT", 0, 0)
textFrame:SetPoint("TOPRIGHT", frameCode, "BOTTOMRIGHT", 0, 0)
textFrame:SetHeight(30)
textFrame:Show()

-- Add a font string to display normal text
textFrame.text = textFrame:CreateFontString(nil, "OVERLAY")
textFrame.text:SetFont("Fonts\\FRIZQT__.TTF", 18, "OUTLINE")
textFrame.text:SetPoint("LEFT", textFrame, "LEFT", 10, 0)
textFrame.text:SetPoint("RIGHT", textFrame, "RIGHT", -10, 0)
textFrame.text:SetJustifyH("LEFT")
textFrame.text:SetText("Normal text goes here")

function set_normal_text(text)
    textFrame.text:SetText(text)
end




backgroundColor = {1 , 1 , 1 , 1}
backgroundColor = {1 , 0 , 1 , 1}
backgroundColor = {0,0,0 , 1}
backgroundColor = {0,0,0 , 0}
 

-- Background (optional)
frameCode.bg = frameCode:CreateTexture(nil, "BACKGROUND")
frameCode.bg:SetAllPoints()
frameCode.bg:SetColorTexture(unpack(backgroundColor))

-- Barcode font size and spacing
local function getBarHeight()
    -- Use almost all available height, leaving a small margin at the top
    return frameCode:GetHeight() -- - 6
    --return 600
end

local function createBarcodeFontString(parent, color)
    local fs = parent:CreateFontString(nil, "OVERLAY")
    fs:SetFont(fontPath, getBarHeight(),  "OUTLINE, THICKOUTLINE")
    fs:SetText("")
    fs:SetTextColor(unpack(color))
    fs:SetSpacing(0)
    fs:SetHeight(getBarHeight())
    fs:SetJustifyH("LEFT")
    -- Shift down a few pixels to remove top space
    fs:SetPoint("TOPLEFT", parent, "TOPLEFT", 0, -3)
    return fs
end

local brightness = 0.6
-- Create barcode font strings stacked vertically
frameCode.text_black   = createBarcodeFontString(frameCode, {0, 0, 0, 1})
frameCode.text_red     = createBarcodeFontString(frameCode, {brightness+0.1, 0, 0, 1})
frameCode.text_green   = createBarcodeFontString(frameCode, {0, brightness, 0, 1})
frameCode.text_blue    = createBarcodeFontString(frameCode, {0, 0, brightness, 1})
--frameCode.text_hide_zero    = createBarcodeFontString(frameCode, {0, 0, 0, 1})
--frameCode.text_cyan    = createBarcodeFontString(frameCode, {0, brightness, brightness, 1})
frameCode.text_cyan    = createBarcodeFontString(frameCode, {1,1,1, 1})
-- frameCode.text_yellow  = createBarcodeFontString(frameCode, {brightness, brightness, 0, 1})
-- frameCode.text_magenta = createBarcodeFontString(frameCode, {brightness, 0, brightness, 1})
 -- frameCode.text_white   = createBarcodeFontString(frameCode, {1, 1, 1, 1})




local brgb_color ={
    {0, 0, 0, 1}, -- black
    {1, 0, 0, 1}, -- red
    {0, 1, 0, 1}, -- green
    {0, 0, 1, 1}, -- blue
    -- IF YOU WANT MORE BITS 
    -- {0, 1, 1, 1}, -- cyan
    -- {1, 1, 0, 1}, -- yellow
    -- {1, 0, 1, 1}, -- magenta
    -- {1, 1, 1, 1}  -- white
}

-- create enum back  red green blue
local black = 0
local red = 1
local green = 2
local blue = 3
local cyan = 4
local yellow = 5
local magenta = 6
local white = 7
    
function get_brgb_from_index(hh)
    local bit1Frequence = hh % #brgb_color
    local bit2Frequence = math.floor(hh / #brgb_color) % #brgb_color
    local bit3Frequence = (math.floor(hh / (#brgb_color * #brgb_color)) % #brgb_color)
    local bit4Frequence = (math.floor(hh / (#brgb_color * #brgb_color * #brgb_color)) % #brgb_color)
    return bit1Frequence, bit2Frequence, bit3Frequence, bit4Frequence
end

function get_utf8_from_brgb_index(gg, colorid)
    local b1, b2, b3, b4 = get_brgb_from_index(gg)

        if b1 ~= colorid and b2 ~= colorid and b3 ~= colorid and b4 ~= colorid then
        return "a"
    elseif b1 == colorid and b2 ~= colorid and b3 ~= colorid and b4 ~= colorid then
        return "b"
    elseif b1 ~= colorid and b2 == colorid and b3 ~= colorid and b4 ~= colorid then
        return "c"
    elseif b1 == colorid and b2 == colorid and b3 ~= colorid and b4 ~= colorid then
        return "d"
    elseif b1 ~= colorid and b2 ~= colorid and b3 == colorid and b4 ~= colorid then
        return "e"
    elseif b1 == colorid and b2 ~= colorid and b3 == colorid and b4 ~= colorid then
        return "f"
    elseif b1 ~= colorid and b2 == colorid and b3 == colorid and b4 ~= colorid then
        return "g"
    elseif b1 == colorid and b2 == colorid and b3 == colorid and b4 ~= colorid then
        return "h"
    elseif b1 ~= colorid and b2 ~= colorid and b3 ~= colorid and b4 == colorid then
        return "i"
    elseif b1 == colorid and b2 ~= colorid and b3 ~= colorid and b4 == colorid then
        return "j"
    elseif b1 ~= colorid and b2 == colorid and b3 ~= colorid and b4 == colorid then
        return "k"
    elseif b1 == colorid and b2 == colorid and b3 ~= colorid and b4 == colorid then
        return "l"
    elseif b1 ~= colorid and b2 ~= colorid and b3 == colorid and b4 == colorid then
        return "m"
    elseif b1 == colorid and b2 ~= colorid and b3 == colorid and b4 == colorid then
        return "n"
    elseif b1 ~= colorid and b2 == colorid and b3 == colorid and b4 == colorid then
        return "o"
    elseif b1 == colorid and b2 == colorid and b3 == colorid and b4 == colorid then
        return "p"
    end

    return "a" -- Default case, should not happen
end

function set_text_to_display_brgb(text)
    local black_string = "p"
    local red_string = "p"
    local green_string = "p"
    local blue_string = "p"
    local cyan_string = "p"
    local yellow_string = "p"
    local magenta_string = "p"
    local white_string = "p"
    local hide_zero = "p"
    for i = 1, #text do
        local char = text:sub(i, i)
        local jj = string.byte(char)
            local black_char = get_utf8_from_brgb_index(jj, black)
            local red_char = get_utf8_from_brgb_index(jj, red)
            local green_char = get_utf8_from_brgb_index(jj, green)
            local blue_char = get_utf8_from_brgb_index(jj, blue)
        black_string   = black_string   .. black_char
        red_string     = red_string     .. red_char
        green_string   = green_string   .. green_char
        blue_string    = blue_string    .. blue_char
        cyan_string    = cyan_string    .. get_utf8_from_brgb_index(jj, cyan)
        -- yellow_string  = yellow_string  .. get_utf8_from_brgb_index(jj, yellow)
        -- magenta_string = magenta_string .. get_utf8_from_brgb_index(jj, magenta)
        white_string   = white_string   .. get_utf8_from_brgb_index(jj, white)
        hide_zero      = hide_zero      .. "0"
    end

    cyan_string = cyan_string .. "p"
    frameCode.text_black:SetText(black_string)
    frameCode.text_red:SetText(red_string)
    frameCode.text_green:SetText(green_string)
    frameCode.text_blue:SetText(blue_string)
    frameCode.text_cyan:SetText(cyan_string)
    -- frameCode.text_yellow:SetText(yellow_string)
    -- frameCode.text_magenta:SetText(magenta_string)
    --frameCode.text_white:SetText(white_string)
    -- frameCode.text_hide_zero:SetText(hide_zero)
end

local function set_text_to_display_all_index()
    local black_string = ""
    local red_string = ""
    local green_string = ""
    local blue_string = ""
    local cyan_string = ""
    local yellow_string = ""
    local magenta_string = ""
    local white_string = ""
    local hide_zero     = ""
    local ll = 0
    for i = 1, 256 do
        if i == 2 then
            ll = secondsCounter
        else
            ll = i - 1 -- Convert to 0-based index
        end
        -- Get brgb character for each color
        local char_black = get_utf8_from_brgb_index(ll, black)
        local char_red = get_utf8_from_brgb_index(ll, red)
        local char_green = get_utf8_from_brgb_index(ll, green)
        local char_blue = get_utf8_from_brgb_index(ll, blue)
        -- local char_cyan = get_utf8_from_brgb_index(ll, cyan)
        -- local char_yellow = get_utf8_from_brgb_index(ll, yellow)
        -- local char_magenta = get_utf8_from_brgb_index(ll, magenta)
        local char_white = get_utf8_from_brgb_index(ll, white)
        -- Always use '7' for black string
        black_string = black_string .. char_black
        red_string = red_string .. char_red
        green_string = green_string .. char_green
        blue_string = blue_string .. char_blue
        cyan_string = cyan_string .. char_cyan
        yellow_string = yellow_string .. char_yellow
        magenta_string = magenta_string .. char_magenta
        white_string = white_string .. char_white
        hide_zero = hide_zero .. "0"
    end
    frameCode.text_black:SetText(black_string)
    frameCode.text_red:SetText(red_string)
    frameCode.text_green:SetText(green_string)
    frameCode.text_blue:SetText(blue_string)
    frameCode.text_cyan:SetText(cyan_string)
    -- frameCode.text_yellow:SetText(yellow_string)
    -- frameCode.text_magenta:SetText(magenta_string)
    frameCode.text_white:SetText(white_string)
    frameCode.text_hide_zero:SetText(hide_zero)
    print("Displaying all indices:".. secondsCounter)
    -- print("B " .. black_string:sub(1, 40))
    -- print("R " .. red_string:sub(1, 40))
    -- print("G " .. green_string:sub(1, 40))
    -- print("B " .. blue_string:sub(1, 40))
    
end


local base64 = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
local utf8_charable = "!\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~"
local brgb_char = "012345678"

local get_random_brgb_char = function()
    local int_index = math.random(1, 1)
    return brgb_char:sub(int_index, int_index)
end

local get_random_text_from_brgb_char = function(length)
    local result = ""
    for i = 1, length do
        result = result .. get_random_brgb_char()
    end
    return result 
end

local function set_as_random_brgb_char()
    test_char_count = 60
    frameCode.text_red:SetText(get_random_text_from_brgb_char(test_char_count))
    frameCode.text_green:SetText(get_random_text_from_brgb_char(test_char_count))
    frameCode.text_blue:SetText(get_random_text_from_brgb_char(test_char_count))
    frameCode.text_black:SetText(b60Black)
end



 secondsCounter = 0
local brgb_index_ = 0

local function updateBarcodeAndText()
    brgb_index_ = brgb_index_ + 1
    if brgb_index_ >= #brgb_color then
        brgb_index_ = 0
    end

    local displayText = get_text_to_display()
    set_normal_text(displayText)
    set_text_to_display_brgb(displayText)
    --set_text_to_display_all_index()
    secondsCounter = secondsCounter + 1
end

--add_to_clock_1_second(updateBarcodeAndText)
add_to_clock_10_frames(updateBarcodeAndText)


function display_custom_text_size()
    
    local displayText = get_text_to_display()
    print("Display text: " .. #displayText)
end

add_to_clock_5_seconds(display_custom_text_size )