



bool_display_in_console_gathered_registered = true
bool_display_in_console_gathered_unknown = true


-- Feel free to stack more object IDs here At least the one you are looking for
local miningNodeIDs = {
    [1731] = { index = 1, name = "Copper Vein" },
    [1732] = { index = 2, name = "Tin Vein" },
    [2040] = { index = 3, name = "Mithril Deposit" },
    [175404] = { index = 4, name = "Rich Thorium Vein" },
}

local herbNodeIDs = {
    [1617] = { index = 128, name = "Silverleaf" },
    [1618] = { index = 129, name = "Peacebloom" },
    [2041] = { index = 130, name = "Liferoot" },
    [142142] = { index = 131, name = "Sungrass" },
}



time_new_gathered_found = 0
function GetTimeSinceLastGathered()
    return GetTime() - time_new_gathered_found
end


function HasGatheredHerbsOrMiningLastSeconds(seconds)
    if time_new_gathered_found == 0 then return false end
    return GetTimeSinceLastGathered() < seconds
end







local last_loot_opened_object_id_list={}
local last_loot_opened_object_id_focus = nil
local last_loot_opened_object_id_focus_index_255 = 0

local last_loot_opened_object_id_next_change =15

-- every second, check if object id in list to dequeue in focus
C_Timer.NewTicker(0.1, function()

    if last_loot_opened_object_id_next_change > 0 then
            last_loot_opened_object_id_next_change = last_loot_opened_object_id_next_change - 1
            return
    end

    local length = #last_loot_opened_object_id_list
    if length > 0 then
            last_loot_opened_object_id_focus = last_loot_opened_object_id_list[1]
            table.remove(last_loot_opened_object_id_list, 1) -- Remove the first element
            last_loot_opened_object_id_next_change= 15 -- Reset the next change timer
            
        else 
            last_loot_opened_object_id_focus = nil -- Reset focus if list is empty
            last_loot_opened_object_id_next_change=0
            last_loot_opened_object_id_focus_index_255 = 0 -- Reset focus index
    end
end)



local f = CreateFrame("Frame")
f:RegisterEvent("LOOT_OPENED")



local function getObjectIDFromGUID(guid)
    local parts = { strsplit("-", guid) }
    return tonumber(parts[6]) -- 6th part is the objectID
end

f:SetScript("OnEvent", function(self, event, ...)
    if event == "LOOT_OPENED" then
        for i = 1, GetNumLootItems() do
            local guid = GetLootSourceInfo(i)
            if guid then
                local guidType = strsplit("-", guid)
                if guidType == "GameObject" then
                    local objectID = getObjectIDFromGUID(guid)

                    
                    table.insert(last_loot_opened_object_id_list, objectID)
                    time_new_gathered_found = GetTime()
                    if miningNodeIDs[objectID] and miningNodeIDs[objectID].index > 0 then
                        if bool_display_in_console_gathered_registered then
                            print("Mined node (ID:", objectID, "):", miningNodeIDs[objectID].name)

                        end
                        last_loot_opened_object_id_focus_index_255 = miningNodeIDs[objectID].index
                    elseif herbNodeIDs[objectID] and herbNodeIDs[objectID].index > 0 then
                        
                        if bool_display_in_console_gathered_registered then
                            print("Herb gathered (ID:", objectID, "):", herbNodeIDs[objectID].name)
                        end
                        last_loot_opened_object_id_focus_index_255 = herbNodeIDs[objectID].index
                    else
                        if bool_display_in_console_gathered_unknown then
                            print("Gathered unknown object (ID:", objectID, ")")
                        end
                        last_loot_opened_object_id_focus_index_255 = 255 -- Unknown object
                    end
                end
            end
        end
    end
end)





