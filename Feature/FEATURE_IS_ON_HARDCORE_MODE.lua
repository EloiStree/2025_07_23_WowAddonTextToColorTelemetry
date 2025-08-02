
function is_on_hardcore_mode_server()
    local hardcore_realms = {
        "Hardcore",
        "Hardcore Era",
        "Hardcore Classic",
        "Hardcore Season of Discovery"
    }
    local current_realm = GetRealmName() or ""
    current_realm = current_realm:lower()
    for _, realm in ipairs(hardcore_realms) do
        if current_realm:find(realm:lower(), 1, true) then
            return true
        end
    end
    return false
end

