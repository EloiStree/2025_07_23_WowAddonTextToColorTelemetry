
function feature_get_target_unique_id(bool_allow_player_in)


      local playerId = UnitGUID("player")
      if not bool_allow_player_in then
          playerId = nil
      end
    
    targetGUID = UnitGUID("mouseover") or UnitGUID("target")
    local isPlayer = UnitIsPlayer("mouseover") or UnitIsPlayer("target")
    if targetGUID and playerId ~= targetGUID and isPlayer then
        local encodedText = (targetGUID:gsub("Player%-", ""))
        return encodedText
    else
        return targetGUID
    end
end