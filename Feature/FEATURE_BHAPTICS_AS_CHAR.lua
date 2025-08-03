-- More info https://www.bhaptics.com/

-- 0 no vibration          Black
-- 1 a bit of vibration    Red
-- 2 normal vibration      Green
-- 3 full vibration        Blue

bHaptics_2D_8x4 = {
    {3, 0, 0, 0,0,3, 1, 0}, -- 0 no vibration
    {0, 3, 0, 0,0,3, 1, 3}, -- 1 a bit of vibration
    {0, 0, 3, 0,0,3, 1, 3}, -- 2 normal vibration
    {0, 0, 0, 3,0,3, 1, 0}  -- 3 full vibration
}




function bhaptic_set_front_lrtd(index_1_4_x, index_1_4_y, value)
    if index_1_4_x < 1 or index_1_4_x > 4 or index_1_4_y < 1 or index_1_4_y > 8 then
        return
    end
    if value == nil then
        value = 0
    end
    bHaptics_2D_8x4[index_1_4_x][index_1_4_y] = value
end

function bhaptic_set_back_lrtd(index_1_4_x, index_1_4_y, value)
    if index_1_4_x < 1 or index_1_4_x > 4 or index_1_4_y < 1 or index_1_4_y > 4 then
        return
    end
    if value == nil then
        value = 0
    end
    bHaptics_2D_8x4[index_1_4_x][4+index_1_4_y] = value
end




function bhaptic_set_all_random()
    for i = 1, 4 do
        for j = 1, 8 do
            bHaptics_2D_8x4[i][j] = math.random(0, 3)
        end
    end
end


function bhaptic_set_all(value)
    if value == nil then
        value = 0
    end
    for i = 1, 4 do
        for j = 1, 8 do
            bHaptics_2D_8x4[i][j] = value
        end
    end
end
function bhaptic_set_all_on() bhaptic_set_all(3) end
function bhaptic_set_all_off() bhaptic_set_all(0) end


function bhaptic_set_all_front(value)
    if value == nil then
        value = 0
    end
    for i = 1, 4 do
        for j = 1, 4 do
            bHaptics_2D_8x4[i][j] = value
        end
    end
end
function bhaptic_set_all_front_on() bhaptic_set_all_front(3) end
function bhaptic_set_all_front_off() bhaptic_set_all_front(0) end

function bhaptic_set_all_back(value)
    if value == nil then
        value = 0
    end
    for i = 1, 4 do
        for j = 5, 8 do
            bHaptics_2D_8x4[i][j] = value
        end
    end
end
function bhaptic_set_all_back_on() bhaptic_set_all_back(3) end
function bhaptic_set_all_back_off() bhaptic_set_all_back(0) end




-- do a code every 3 seconds in a loop
local bhaptic_test_count = 0
bhapticclockframe = CreateFrame("Frame")
bhapticclockframe:SetScript("OnUpdate", function(self, elapsed)
    self.elapsed = (self.elapsed or 0) + elapsed
    if self.elapsed >= 3 then
        self.elapsed = 0
        if bhaptic_test_count == 0 then
            bhaptic_set_all_front_on()
        elseif bhaptic_test_count == 1 then
            bhaptic_set_all_front_off()
        elseif bhaptic_test_count == 2 then
            bhaptic_set_all_back_on()
        elseif bhaptic_test_count == 3 then
            bhaptic_set_all_back_off()
        elseif bhaptic_test_count == 4 then
            bhaptic_set_all_on()
        elseif bhaptic_test_count == 5 then
            bhaptic_set_all_random()
        else
            bhaptic_set_all_off()

        end
        
        bhaptic_test_count = (bhaptic_test_count + 1) % 6
        --print ("bHaptics test count: " .. bhaptic_test_count)
    end
end)


local function local_int_to_char(value)
    if value == nil then
        return 'a'
    end
    local intValue = math.floor(value)
    if intValue < 0 then
        intValue = 0
    elseif intValue > 255 then
        intValue = 255
    end
    return string.char(intValue)
end
function get_bhaptics_as_left_to_right_8chars()
    local result = ""
    -- There are 8 columns, so iterate columns 1 to 8
    for col = 1, 8 do
        -- For each column, build the value from all 4 rows
        local b0 = bHaptics_2D_8x4[1][col]
        local b1 = bHaptics_2D_8x4[2][col]
        local b2 = bHaptics_2D_8x4[3][col]
        local b3 = bHaptics_2D_8x4[4][col]
        local value = b0 + b1 * 4 + b2 * 16 + b3 * 64
        result = result .. local_int_to_char(value)

    end
    return result
end
