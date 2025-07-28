G_BARCODE_BACKGROUND_COLOR = {1, 1, 1, 1}
G_BARCODE_TEXT_COLOR = {0, 0, 0, 1}

function get_text_to_display()
    local result = [[
a b c d e  f g h  i j k l  m n o p q r s t u v w x  y z 
1 2 3 4 5 6 7 8 9 0 $ . % * + - / 
    ]]
    result = result .. (feature_get_target_unique_id(false) or "No target")
    return result
end
