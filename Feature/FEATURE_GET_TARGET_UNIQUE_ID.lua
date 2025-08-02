local function local_get_percent_to_F(valuePercent)
    if valuePercent < 1.0 / 15.0 then return '0' end
    if valuePercent < 2.0 / 15.0 then return '1' end
    if valuePercent < 3.0 / 15.0 then return '2' end
    if valuePercent < 4.0 / 15.0 then return '3' end
    if valuePercent < 5.0 / 15.0 then return '4' end
    if valuePercent < 6.0 / 15.0 then return '5' end
    if valuePercent < 7.0 / 15.0 then return '6' end
    if valuePercent < 8.0 / 15.0 then return '7' end
    if valuePercent < 9.0 / 15.0 then return '8' end
    if valuePercent < 10.0 / 15.0 then return '9' end
    if valuePercent < 11.0 / 15.0 then return 'A' end
    if valuePercent < 12.0 / 15.0 then return 'B' end
    if valuePercent < 13.0 / 15.0 then return 'C' end
    if valuePercent < 14.0 / 15.0 then return 'D' end
    if valuePercent < 15.0 / 15.0 then return 'E' end
    return 'F'
end

local function local_FF_To_Decimal(value)
    local decimalValue = tonumber(value, 16)
    if decimalValue == nil then
        return 0
    end
    return decimalValue
end

local function local_FF_To_Percent(value)
    local decimalValue = local_FF_To_Decimal(value)
    return decimalValue / 255.0
end


local bool_display_guid_changed = true
local previous_guid = nil


function get_player_as_color(selection)
    local targetGUID = UnitGUID(selection)

    if targetGUID and targetGUID ~= previous_guid then
        previous_guid = targetGUID
        if bool_display_guid_changed then
            print("Target GUID changed: " .. targetGUID)
        end
    end

    if not targetGUID then
        return 1, 1, 1, 1, 1, 1 -- white
    else
        local string_ffffffffffff = "000000000000"
        if not UnitIsPlayer(selection) then
            if targetGUID and targetGUID:find("Creature") then
                string_ffffffffffff = "FF0000000000"
                local unitType, zero, serverId, instanceId, zoneUid, npcId, spawnUid = strsplit("-", targetGUID)
                local idAsDecimal = tonumber(npcId, 10) or 0
                local hex = string.format("%x", idAsDecimal)
                local hexLength = string.len(hex)
                local startIndex = 12 - hexLength
                string_ffffffffffff = string.sub(string_ffffffffffff, 1, startIndex) .. hex .. string.sub(string_ffffffffffff, startIndex + hexLength + 1)
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
        local c1r = local_FF_To_Decimal(string.sub(hex, 1, 2))
        local c1g = local_FF_To_Decimal(string.sub(hex, 3, 4))
        local c1b = local_FF_To_Decimal(string.sub(hex, 5, 6))
        local c2r = local_FF_To_Decimal(string.sub(hex, 7, 8))
        local c2g = local_FF_To_Decimal(string.sub(hex, 9, 10))
        local c2b = local_FF_To_Decimal(string.sub(hex, 11, 12))
        return c1r, c1g, c1b, c2r, c2g, c2b
    end
    return 1, 1, 1, 1, 1, 1 -- white
end
