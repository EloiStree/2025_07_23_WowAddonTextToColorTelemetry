--[[

I DON'T WANT TO MAKE 20 clocks in my code and run it every frame.

]]

local frame = CreateFrame("Frame")

local timers = {
    [0.1] = {elapsed = 0, funcs = {}},
    [1] = {elapsed = 0, funcs = {}},
    [5] = {elapsed = 0, funcs = {}},
}

function add_to_clock_10_frames(func)
    table.insert(timers[0.1].funcs, func)
end

function add_to_clock_1_second(func)
    table.insert(timers[1].funcs, func)
end

function add_to_clock_5_seconds(func)
    table.insert(timers[5].funcs, func)
end

frame:SetScript("OnUpdate", function(self, elapsed)
    for interval, data in pairs(timers) do
        data.elapsed = data.elapsed + elapsed
        while data.elapsed >= interval do
            for _, func in ipairs(data.funcs) do
                func()
            end
            data.elapsed = data.elapsed - interval
        end
    end
end)