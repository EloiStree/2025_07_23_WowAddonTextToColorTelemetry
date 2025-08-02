G_BARCODE_BACKGROUND_COLOR = {1, 1, 1, 1}
G_BARCODE_TEXT_COLOR = {0, 0, 0, 1}

function get_text_to_display()

    local result = ""

-- BASE 64
--     local result = [[
-- a b c d e  f g h  i j k l  m n o p q r s t u v w x  y z 
-- 1 2 3 4 5 6 7 8 9 0 $ . % * + - / 
--     ]]
    

-- ALL POSSIBLES UTF8 on the first bits
-- local result = "!\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~"



 
    result = result .. get_time_as_several_5chars()
    result = result .. get_player_map_x_one_char()
    result = result .. get_player_map_y_one_char()
    result = result .. get_player_angle360_one_char()
    result = result .. get_player_mobility_state_as_one_char()
    result = result .. get_target_combat_state_as_one_char_part1()
    result = result .. get_player_life_one_char()
    result = result .. get_player_mana_or_energy_one_char()
    result = result .. get_player_xp_percent_one_char()
    result = result .. get_player_current_level_as_one_char()
    result = result .. get_player_world_map_x_several_3char()
    result = result .. get_player_world_map_y_several_3char()
    result = result .. get_allies12_life_on_4bits()
    result = result .. get_allies24_life_on_4bits()
    result = result .. turn_guid_target_to_char()

    return result
end




function turn_guid_target_to_char()
    local has_target = UnitGUID("target")
    local has_mouse_over = UnitGUID("mouseover")

    local c1r, c1g, c1b, c2r, c2g, c2b = 0,0,0,0,0,0
    if has_target then
        c1r, c1g, c1b, c2r, c2g, c2b = getPlayerAsColor("target")
    elseif has_mouse_over then
        c1r, c1g, c1b, c2r, c2g, c2b = getPlayerAsColor("mouseover")
    end

    return int_to_char(c1r * 255) .. int_to_char(c1g * 255) .. int_to_char(c1b * 255)
        .. int_to_char(c2r * 255) .. int_to_char(c2g * 255) .. int_to_char(c2b * 255)
end




function int_to_char(value)
    if value == nil then
        return 'A'
    end
    local intValue = math.floor(value)
    if intValue < 0 then
        intValue = 0
    elseif intValue > 255 then
        intValue = 255
    end
    return string.char(intValue)
end


local binary_10000000_128 = 128
local binary_01000000_64 = 64
local binary_00100000_32 = 32
local binary_00010000_16 = 16
local binary_00001000_8 = 8
local binary_00000100_4 = 4
local binary_00000010_2 = 2
local binary_00000001_1 = 1


function get_player_current_level_as_one_char()
    local playerLevel = UnitLevel("player")
    if playerLevel == nil then
        return int_to_char(0)
    end
    return int_to_char(playerLevel)
end

function get_player_mobility_state_as_one_char()

    local hasGround = IsOnGround()
    local isFalling = IsPlayerFalling()
    local isSwimming = IsPlayerSwimming()
    local isMounted = IsPlayerMounted()
    local isFlying = IsPlayerFlying()
    local isSteathing = IsPlayerSteathing()
    local isInTaxi = IsInTaxi()
    local isPlayerInCombat = IsPlayerInCombat()


    return TurnBooleanToChar(hasGround, isFalling, isSwimming, isMounted, isFlying, isSteathing, isInTaxi, isPlayerInCombat)
end
function get_player_combat_state_as_one_char()

   
    return TurnBooleanToChar(isPlayerDeath, isInCombat, isCasting)
end


-- DID NOT USE BUT CAN BE USEFUL
--  local isPlayerDeath = IsPlayerDeath()
--     local isInCombat = IsPlayerInCombat()
--     local isCasting = IsCasting()

        -- IsUnderPercentBreathing(98) and 1 or 0,     -- 13 DONT CHANGE
        -- IsUnderPercentBreathing(20) and 1 or 0,     -- 14 DONT CHANGE
        -- IsUnderPercentFatigue(98) and 1 or 0,      -- 15 DONT CHANGE
        -- IsUnderPercentFatigue(20) and 1 or 0,      -- 16 DONT CHANGE
        -- IsTargetFullLife() and 1 or 0,   --7 DONT CHANGE
        -- IsTargetWithin10Yards() and 1 or 0,   --8 DONT CHANGE
        -- IsTargetWithin30Yards() and 1 or 0,   --9 DONT CHANGE
        -- IsTargetHasCorruption() and 1 or 0,   
        -- IsTargetHasAgony() and 1 or 0,  


function get_target_combat_state_as_one_char_part1()
    return TurnBooleanToChar(
        HasTarget() and 1 or 0,                   --1 DONT CHANGE
        IsTargetPlayer() and 1 or 0,              --2 DONT CHANGE
        IsTargetEnemy() and 1 or 0,               --3 DONT CHANGE
        IsTargetInCombat() and 1 or 0,            --4 DONT CHANGE
        IsTargetCasting() and 1 or 0,             --5 DONT CHANGE
        IsTargetDeath() and 1 or 0,               --6 DONT CHANGE
        IsTargetFullLife() and 1 or 0,            --7 DONT CHANGE
        IsTargetFocusingPlayer() and 1 or 0       --10 DONT CHANGE
    )
end


function get_time_as_several_5chars()
    local now = time()  -- Use real-world timestamp instead of GetTime()
    local year = tonumber(date("%Y", now))
    local month = tonumber(date("%m", now))
    local day = tonumber(date("%d", now))
    local hour = tonumber(date("%H", now))
    local minute = tonumber(date("%M", now))
    local second = tonumber(date("%S", now))

    local classicHardcoreDigit = 0
    local isWowClassic = false
    if WOW_PROJECT_ID == WOW_PROJECT_CLASSIC or
        WOW_PROJECT_ID == WOW_PROJECT_BURNING_CRUSADE_CLASSIC or
        WOW_PROJECT_ID == WOW_PROJECT_WRATH_CLASSIC then
           classicHardcoreDigit = classicHardcoreDigit + 1
    end

    local isWowHardcore = is_on_hardcore_mode_server()
    if isWowHardcore then
        classicHardcoreDigit = classicHardcoreDigit + 1
    end

    
    local hasDiscoverZone = HasDiscoveredZoneLastSeconds(5)
    local hasPlayerTarget= HasPlayerTargetNotCurrentOrPartyMember()
    
    if hasDiscoverZone then
        minute = minute + binary_10000000_128
    end  
    if hasPlayerTarget then
        minute = minute + binary_01000000_64
    end

    if IsGatheringHerbs()  then
        second = second + binary_10000000_128
    end
    if IsGatheringMining()  then
        second = second + binary_01000000_64
    end

    local yearDecate = math.floor(year / 10) -- decade
    local yearUnit = year % 10 -- unit

    local char_monthAndYearDecate = int_to_char(month * 10 + yearDecate )
    local char_day = int_to_char(day +classicHardcoreDigit*100)
    local char_hourAndYearUnit = int_to_char( hour*10 +yearUnit)
    local char_seconds = int_to_char(second)
    local char_minutes = int_to_char(minute)


    -- print(string.format("Year: %d, Month: %d, Day: %d, Hour: %02d, Minute: %02d, Second: %02d",
    --     year, month, day, hour, minute, second))
    return char_monthAndYearDecate .. char_day .. char_hourAndYearUnit .. char_minutes .. char_seconds
end





function get_target_life_percent(unit)
    -- Does not work , I dont know why wiht party1 and party2
    if not UnitExists(unit) or UnitIsDeadOrGhost(unit) == 1 then
        return 0
    end
    local maxHP = UnitHealthMax(unit)
    if maxHP == 0 then
        return 0
    end
    return UnitHealth(unit) / maxHP
end

function get_allies12_life_on_4bits()
    local life1 = get_target_life_percent("party1")
    local life2 = get_target_life_percent("party2")

    local ff = getPercentToF(life2).. getPercentToF(life1)
    return int_to_char(FF_To_Decimal(ff))

end


function get_allies24_life_on_4bits()
    local life1 = get_target_life_percent("party3")
    local life2 = get_target_life_percent("party4")

    local ff = getPercentToF(life2) .. getPercentToF(life1)
    return int_to_char(FF_To_Decimal(ff))

end



function get_player_life_one_char()

    if not UnitExists("player") or UnitIsDeadOrGhost("player") == 1 then
        return int_to_char(0)
    end

    local percentHealth = UnitHealth("player") / UnitHealthMax("player")
    if percentHealth == nil then
        return int_to_char(0)
    end
    return int_to_char(percentHealth * 255)
end


function get_player_mana_or_energy_one_char()
    if not UnitExists("player") or UnitIsDeadOrGhost("player") == 1 then
        return int_to_char(0)
    end

    local percentMana = UnitPower("player") / UnitPowerMax("player")
    if percentMana == nil then
        return int_to_char(0)
    end
    return int_to_char(percentMana * 255)
end

function get_player_xp_percent_one_char()
    local xp = UnitXP("player")
    local percentXp = xp / UnitXPMax("player")
    if percentXp == nil then
        return 0
    end
    return int_to_char(percentXp * 255)
end




function get_player_map_x_one_char()
    local map = C_Map.GetBestMapForUnit("player");
    local pos = C_Map.GetPlayerMapPosition(map,"player");
    local posX,_ = pos:GetXY()
    if posX == nil then
        return 0
    end
    return int_to_char(posX * 255)
end

function get_player_map_y_one_char()
    local map = C_Map.GetBestMapForUnit("player");
    local pos = C_Map.GetPlayerMapPosition(map,"player");
    local _ ,posY = pos:GetXY()
    if posY == nil then
        return 0
    end
    return int_to_char(posY * 255)
end

function get_player_angle360_one_char()
    local facing = (GetPlayerFacing() / (2*3.1418))
    return int_to_char(facing * 255)
end



-------------------------------------

function parse_float_value_to_signed_short_double_bytes(given_float)
    -- Take sign into account: store sign in the highest bit of b3
    local intValue = math.floor(math.abs(given_float) * 10000)
    local sign = given_float < 0 and 1 or 0

    local b1 = intValue % 256
    local b2 = math.floor(intValue / 256) % 256
    local b3 = math.floor(intValue / (256 * 256)) % 128 -- only lower 7 bits
    b3 = b3 + (sign * 128) -- set highest bit if negative

    return b1, b2, b3
end

function get_player_world_map_x_several_3char()
    
    local result =0
    -- local isInDonjon = IsInInstance()
    -- if isInDonjon then
    --     result = 0
    -- else
        local map = C_Map.GetBestMapForUnit("player");
        local pos = C_Map.GetPlayerMapPosition(map,"player");
        local posX,posY = pos:GetXY()
        result = posX 
    -- end
    

    b1 , b2, b3 = parse_float_value_to_signed_short_double_bytes(result)
    return int_to_char(b1) .. int_to_char(b2) .. int_to_char(b3)
end



function get_player_world_map_y_several_3char()
    
    local result =0
    -- local isInDonjon = IsInInstance()
    -- if isInDonjon then
    --     result = 0
    -- else
        local map = C_Map.GetBestMapForUnit("player");
        local pos = C_Map.GetPlayerMapPosition(map,"player");
        local posX,posY = pos:GetXY()
        result = posY 
    --end
    

    b1 , b2, b3 = parse_float_value_to_signed_short_double_bytes(result)
    return int_to_char(b1) .. int_to_char(b2) .. int_to_char(b3)
end


function getPercentToF(valuePercent)
   
    if valuePercent<1.0/15.0 then return '0' end
    if valuePercent<2.0/15.0 then return '1' end
    if valuePercent<3.0/15.0 then return '2' end
    if valuePercent<4.0/15.0 then return '3' end
    if valuePercent<5.0/15.0 then return '4' end
    if valuePercent<6.0/15.0 then return '5' end
    if valuePercent<7.0/15.0 then return '6' end
    if valuePercent<8.0/15.0 then return '7' end
    if valuePercent<9.0/15.0 then return '8' end
    if valuePercent<10.0/15.0 then return '9' end
    if valuePercent<11.0/15.0 then return 'A' end
    if valuePercent<12.0/15.0 then return 'B' end
    if valuePercent<13.0/15.0 then return 'C' end
    if valuePercent<14.0/15.0 then return 'D' end
    if valuePercent<15.0/15.0 then return 'E' end
    return 'F'
end

function FF_To_Decimal(value)
    
 -- turn ff hexa to 255 decimal
    local decimalValue = tonumber(value, 16)
    if decimalValue == nil then
        return 0
    end
    return decimalValue

end

function FF_To_Percent(value)
    local decimalValue = FF_To_Decimal(value)
    return decimalValue / 255.0
end




















function getPlayerAsColor(selection)
    local targetGUID = UnitGUID(selection)
    
    if not targetGUID then
        return 1, 1, 1, 1, 1, 1 -- white
    else
        local string_ffffffffffff = "000000000000"
        if not UnitIsPlayer(selection) then
            if targetGUID and targetGUID:find("Creature") then
                string_ffffffffffff = "FF0000000000"
                local unitType, zero, serverId, instanceId, zoneUid, npcId, spawnUid = strsplit("-", targetGUID)

                -- convert npcid in decimal to hexadecimal
                local idAsDecimal = tonumber(npcId, 10) or 0
                local hex = string.format("%x", idAsDecimal)

                -- copy from right to left characters to fill the string_ffffffffffff
                local hexLength = string.len(hex)
                local startIndex = 12 - hexLength
                string_ffffffffffff = string.sub(string_ffffffffffff, 1, startIndex) .. hex .. string.sub(string_ffffffffffff, startIndex + hexLength + 1)
                --print("GUID: " .. targetGUID .. " Hex: " .. string_ffffffffffff)
            end
            if targetGUID and targetGUID:find("Vehicle") then
                string_ffffffffffff = "FD0000000000"
            end
            if targetGUID and targetGUID:find("Pet") then
                string_ffffffffffff = "FE0000000000"
            end
        else
            string_ffffffffffff = string.lower(string.gsub(string.gsub(targetGUID, "-", ""), "Player", ""))
        end
        local hex = string.sub(string_ffffffffffff, 1, 12)
        local c1r = FF_To_Percent(string.sub(hex, 1, 2))
        local c1g = FF_To_Percent(string.sub(hex, 3, 4))
        local c1b = FF_To_Percent(string.sub(hex, 5, 6))
        local c2r = FF_To_Percent(string.sub(hex, 7, 8))
        local c2g = FF_To_Percent(string.sub(hex, 9, 10))
        local c2b = FF_To_Percent(string.sub(hex, 11, 12))

        return c1r, c1g, c1b, c2r, c2g, c2b
    end

    return 1, 1, 1, 1, 1, 1 -- white
end




function getPlayerAsColorFocus()

    local has_mouse_over = UnityId("target")
    if has_mouse_over then
        return getPlayerAsColor("target")
    end
    local has_mouse_over = UnityId("mouseover")
    if has_mouse_over then
        return getPlayerAsColor("mouseover")
    end
    
    return 0,0,0,0,0,0
end

function getPlayerAsColorCurrent()
    return getPlayerAsColor("player")
end


function getHealAndXp()
    
    local percentHealth = UnitHealth("player") / UnitHealthMax("player")

    local playerLevel = UnitLevel("player")/255.0 or 0 

    local xp = UnitXP("player")
    local percentXp = xp / UnitXPMax("player")
    
    return percentHealth, playerLevel   , percentXp
end

function getWorldPosition(trueXFalseY)
    local isInDonjon = IsInInstance()
    local px, py, pz = 0, 0, 0

    -- Fetch player position if not in an instance
    if not isInDonjon then
        py, px, pz = UnitPosition("player")
    end

    -- Choose the coordinate to encode (x or y)
    local coordinate = trueXFalseY and px or py
    local r, g, b = 0, 0, 0
    -- -347321 
    -- r =34
    -- g = 73
    -- b = 21
    -- if is negative r = r+100
    local isNegative = coordinate < 0
    --print ("Coordinate "..coordinate)
    coordinate = math.abs(coordinate)
    local b = math.floor(coordinate) %100 
    local g = math.floor(coordinate / 100.0)%100
    local r = math.floor(coordinate / 10000.0)%100
    if isNegative then
        r = r + 100
    end
    -- print ("RGB "..r.." "..g.." "..b)
    return r/255.0, g/255.0, b/255.0
end


function get_target_guid_as_bytes()
    local target_guid_int = get_target_unique_id(true, true)
    if not target_guid_int then
        return int_to_char(0), int_to_char(0), int_to_char(0)
    end

    local first_digit =string.sub(tostring(target_guid_int), 1, 1)
    if first_digit == "0" then
        target_guid_int = 1 -- Ensure we don't return zero
    end    

    if target_guid_int%10==1 then
        target_guid_int = math.floor(target_guid_int /10)
    end

    local b1 = target_guid_int % 256
    local b2 = math.floor(target_guid_int / 256) % 256
    local b3 = math.floor(target_guid_int / (256 * 256)) % 256
    return int_to_char(b1), int_to_char(b2), int_to_char(b3)
end
