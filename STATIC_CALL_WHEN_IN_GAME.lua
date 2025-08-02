function event_call_when_in_game()
    print("Event call when in game triggered.")
end

function hello_world()
    print("Hello World function called.")
    local current_realm = GetRealmName() or "Unknown Realm"
    print("Current realm: " .. current_realm)
    --print("Realm unique ID: " .. GetRealmID())
end

-- List of future functions to call
local on_game_ready_function_call_list = {
    "hello_world",
}

function add_to_on_game_ready_function_call_list(func_name)
    table.insert(on_game_ready_function_call_list, func_name)
end


for _, func_name in ipairs(on_game_ready_function_call_list) do
    if _G[func_name] then
        _G[func_name]()
    end
end
