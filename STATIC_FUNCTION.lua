

local allows_in_barcode = "abcdefghijklmnopqrstuvwxyz1234567890$.%*+-/"
function replace_unauthorized_char_to_space(input)
    input = input:gsub(" ", ""):gsub("-", "")
    return input:gsub("[^" .. allows_in_barcode .. "]", "")
end

-- Function to encode text into Code 128 format
function encode_to_bare_code_tfb(input)
    input = input:gsub(" ", "") -- Remove spaces from the input string
    input = input:gsub("-", "") -- Remove hyphens from the input string

    input = replace_unauthorized_char_to_space(input) -- Replace unauthorized characters with spaces
    return '*'..input..'*'
end


function experiment_colorize_text(text)
    local colors = {
        "FFFF0000", -- Red
        "FFFF7F00", -- Orange
        "FFFFFF00", -- Yellow
        "FF00FF00", -- Green
        "FF0000FF", -- Blue
        "FF4B0082", -- Indigo
        "FF8F00FF", -- Violet
    }
    local result = ""
    local colorIndex = 1

    for i = 1, #text do
        local char = text:sub(i, i)
        local color = colors[colorIndex]
        result = result .. "|c" .. color .. char .. "|r"
        colorIndex = colorIndex + 1
        if colorIndex > #colors then colorIndex = 1 end
    end

    return result
end

