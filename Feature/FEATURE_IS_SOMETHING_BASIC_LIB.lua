
--[[ This file contains functions that I am pretty sure you will need if you are using color telemetry.
All the function in this file must return a boolean as they are going to be turn in byte.]]


function HasPlayerTargetNotCurrentOrPartyMember()
    if not UnitExists("target") then return false end

    local targetGUID = UnitGUID("target")
    local playerGUID = UnitGUID("player")

    -- Check if the target is not the player or a party member
    if targetGUID ~= playerGUID then
        for i = 1, 4 do
            local partyMemberGUID = UnitGUID("party" .. i)
            if partyMemberGUID and targetGUID == partyMemberGUID then
                return false -- Target is a party member
            end
        end
        return true -- Target is not the player or a party member
    end

    return false -- Target is the player
end



function TurnBooleansToByte(b1, b2, b3, b4, b5, b6, b7, b8)

    local byte = 0
    if b1 then byte = byte + 1 end
    if b2 then byte = byte + 2 end
    if b3 then byte = byte + 4 end
    if b4 then byte = byte + 8 end
    if b5 then byte = byte + 16 end
    if b6 then byte = byte + 32 end
    if b7 then byte = byte + 64 end
    if b8 then byte = byte + 128 end
    return byte
end

function TurnBooleanToChar(b1, b2, b3, b4, b5, b6, b7, b8)
    local  value= TurnBooleansToByte(b1, b2, b3, b4, b5, b6, b7, b8)
     if value == nil then
        return "0"
    end
    local intValue = math.floor(value)
    if intValue < 0 then
        intValue = 0
    elseif intValue > 255 then
        intValue = 255
    end
    return string.char(intValue)
end


function trimString(str)
    return str:match("^%s*(.-)%s*$")
end

function IsCastingEquals(s)
    local castName, _, _, _, _, _, spellID = UnitCastingInfo("player")
    -- trim
    s = trimString(s)
    castName = castName and trimString(castName) or ""

    if castName == s then
        return true
    end
    return false
end



function IsOnGround()
    return not IsFlying() and not IsFalling() and not IsSwimming() and not IsSubmerged()
end

function IsInTaxi()
    return UnitOnTaxi("player")
end

function IsGatheringHerbs()
    return IsCastingEquals("Herb Gathering ") -- Replace with actual herb gathering spell names/IDs
end

function IsGatheringMining()
    return IsCastingEquals("Mining") -- Replace with actual mining spell names/IDs
end

function IsFishing()
    return IsCastingEquals("Fishing") -- Replace with actual fishing spell names/IDs
end


function IsPlayerInCombat()
    return UnitAffectingCombat("player")
end


function IsPlayerSwimming()
    return IsSwimming() or IsSubmerged()
end

function IsPlayerFalling()
    return IsFalling()

end

function IsPlayerMounted()
    return IsMounted()
end

function IsPlayerFlying()
    return IsFlying() 
end


function HasTarget()
    return UnitExists("target") and not UnitIsDeadOrGhost("target")
end



function IsPlayerSteathing()
    return IsStealthed()
end

function IsUnderWater()
    return IsSwimming() and IsSubmerged()
end

function IsPlayerDeath()
    return UnitIsDeadOrGhost("player")
end

function IsCasting()
    return UnitCastingInfo("player") ~= nil
end

 function IsPetAlive()
    return UnitExists("pet") and not UnitIsDeadOrGhost("pet")
end




-- Check if target has a debuff called "Corruption" using AuraUtil.FindAuraByName
function IsTargetHasDebuff(debuffName)
    if not UnitExists("target") then return false end
    local aura = AuraUtil.FindAuraByName(debuffName, "target", "HARMFUL")
    return aura ~= nil
end


function HasTarget()
    return UnitExists("target") and not UnitIsDeadOrGhost("target")
end

function IsTargetPlayer()
    return UnitIsPlayer("target")
end
function IsTargetEnemy()
    return UnitCanAttack("player", "target")
end


function IsTargetHasCorruption()
    return IsTargetHasDebuff("Corruption")
end

function IsTargetHasAgony()
    return IsTargetHasDebuff("Agony") 
end


function IsTargetInCombat()
    return UnitAffectingCombat("target")
end
function IsTargetCasting()
    return UnitCastingInfo("target") ~= nil
end
function IsTargetDeath()
    return UnitIsDeadOrGhost("target")
end

function IsTargetFullLife()

    if not UnitExists("target") then return false end
    if not UnitHealthMax("target") or not UnitHealth("target") then return false end                                                                                                                    

    return UnitHealth("target") == UnitHealthMax("target")
end


function IsTargetInRange()                                                                          
    return UnitInRange("target") 
end

 function IsTargetWithinYards(value)
    local unit = "target"
    if UnitExists(unit) then
        return CheckInteractDistance(unit, value) -- 2 means ~10 yards
    else
        return false
    end
end
 function IsTargetWithin10Yards()
    return IsTargetWithinYards(2) or IsTargetWithinYards(3) 
end
 function IsTargetWithin30Yards()
    return IsTargetWithinYards(1) or IsTargetWithinYards(4)
end


function IsTargetFocusingPlayer()  

    if not UnitExists("target") then return false end
    local targetGUID = UnitGUID("target")
    local playerGUID = UnitGUID("player")
    if not targetGUID or not playerGUID then return false end

    local focusUnit = "focus"
    if UnitExists(focusUnit) and UnitGUID(focusUnit) == targetGUID then
        return true
    end                                                                                                                                                                     

    return false
end

