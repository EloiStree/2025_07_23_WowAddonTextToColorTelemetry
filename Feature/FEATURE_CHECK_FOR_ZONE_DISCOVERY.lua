bool_display_in_console_discovered_zone = true

time_new_discovered_found = 0
function GetTimeSinceLastDiscovered()
    return GetTime() - time_new_discovered_found
end

function HasDiscoveredZoneLastSeconds(seconds)
    if time_new_discovered_found == 0 then return false end
    return GetTimeSinceLastDiscovered() < seconds
end


discovered_area_id = 0
discovered_zone_text = "Zone Discovered"
discovered_sub_zone_text = "Zone Discovered"


local f = CreateFrame("Frame")
f:RegisterEvent("CHAT_MSG_SYSTEM")

f:SetScript("OnEvent", function(self, event, msg)
    -- Check if the message contains "Discovered"
    if msg:find("Discovered") then
        local areaID = C_Map.GetBestMapForUnit("player")
        if areaID then
            local areaName = C_Map.GetAreaInfo(areaID)
            local subZoneName = GetSubZoneText()
            if bool_display_in_console_discovered_zone then
                print("Discovered Area ID: " .. tostring(areaID))
                print("Discovered Area Name: " .. tostring(areaName))
                print("Current Sub Zone Name: " .. tostring(subZoneName))
            end
            discovered_area_id = areaID
            discovered_zone_text = areaName or "Unknown Zone"
            discovered_sub_zone_text = subZoneName or "Unknown Sub Zone"
            time_new_discovered_found = GetTime()
        else
            if bool_display_in_console_discovered_zone then
                print("Discovered Area ID: Unknown")
                print("Discovered Area Name: Unknown Zone")
                print("Current Sub Zone Name: Unknown Sub Zone")
            end
        end
    end
end)
