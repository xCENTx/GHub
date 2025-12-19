-- Logitech G-series Events
local LG_EVENT = {
 LG_ACTIVATED = "PROFILE_ACTIVATED",
 LG_DEACTIVATED = "PROFILE_DEACTIVATED",
 LG_G_DOWN = "G_PRESSED",
 LG_G_UP = "G_RELEASED",
 LG_M_DOWN = "M_PRESSED",
 LG_M_UP = "M_RELEASED",
 LG_MOUSE_DOWN = "MOUSE_BUTTON_PRESSED",
 LG_MOUSE_UP = "MOUSE_BUTTON_RELEASED"
}

local LG_KEY_LOCK = {
 LG_LOCK_NUM = "numlock",
 LG_LOCK_CAPS = "capslock",
 LG_LOCK_SCROLL = "scrolllock"
}

-- Logitech G-Series Baisc Mouse Buttons
--- Left Mouse Button is not reported by defaultUse ‘EnablePrimaryMouseButtonEvents’ to override this.
local LG_MOUSE_BUTTON = {
 LG_LEFT            = 1,     -- Left Mouse Button
 LG_RIGHT           = 2,     -- Right Mouse Button
 LG_MIDDLE          = 3,     -- Middle Mouse Button
 LG_BACK            = 4,     -- Back Button (X1)
 LG_FORWARD         = 5,     -- Forward Button (X2)
 LG_DPI_SCALE       = 6,     -- DPI Shift Button
 LG_DPI_DOWN        = 7,     -- DPI Down Button
 LG_DPI_UP          = 8,     -- DPI Up Button
 LG_PROFILE_CYCLE   = 9,     -- Profile Cycle Button
 LG_SCROLL_LEFT     = 10,    -- Scroll Wheel Left
 LG_SCROLL_RIGHT    = 11,    -- Scroll Wheel Right
}

local g_firing = false

-- Sample times for burst fire in milliseconds for input derived humanization
--- down - up - pause - down - up
--- randomization seeds will be created based on these values
local g_samples = {
    {69, 54, 95, 38, 86},
    {64, 59, 80, 45, 84},
    {61, 58, 79, 51, 86},
    {66, 60, 85, 44, 82},
    {56, 67, 83, 44, 83},
    {63, 62, 81, 42, 78}
}
math.randomseed(GetRunningTime()) -- seed random number generator

-- Logitech G-series Event Handler
function OnEvent(event, arg)

    if IsKeyLockOn(LG_KEY_LOCK.LG_LOCK_NUM) == false then
        OutputLogMessage("end\n")
         return -- do nothing if num lock is off
    end

    if event == LG_EVENT.LG_DEACTIVATED then -- safety shutdown
        g_firing = false
        ReleaseMouseButton(LG_MOUSE_BUTTON.LG_LEFT)
    end

    if event == LG_EVENT.LG_MOUSE_DOWN then
        OnMousePressed(arg)
    elseif event == LG_EVENT.LG_MOUSE_UP then
        OnMouseReleased(arg)
    end
end

-- Mouse Button Handler
function OnMousePressed(btn)
    if btn == LG_MOUSE_BUTTON.LG_DPI_SCALE and not g_firing then
        BurstFire()
    end
end

-- Mouse Button Handler
function OnMouseReleased(btn)
    if btn == LG_MOUSE_BUTTON.LG_DPI_SCALE then
        g_firing = false
    end
end

-- Execute a burst fire sequence
-- down - up - down - up - down - up
function BurstFire()
    local rand = math.random(#g_samples) -- pick a random sample set
    local seed = g_samples[rand] -- get a seed
    
    -- log 
    OutputLogMessage("Performing Burst Fire Event with Seed: "..rand.." \n")
    for i = 1, #seed  do
        OutputLogMessage("%d ", seed[i])
    end
    OutputLogMessage("\n")
    
    for i = 1, #seed  do
        local t = seed[i]
        OutputLogMessage("Fire Event: "..i.." \n")
        
        if i % 2 == 1 then
            -- press
            t = t + math.random(-4, 4)
            if t < 1 then t = 1 end
            PressMouseButton(LG_MOUSE_BUTTON.LG_LEFT)
            Sleep(t)
            OutputLogMessage("- DOWN "..t.."\n")

        else
            -- release
            t = t + math.random(-4, 4)
            if t < 1 then t = 1 end
            ReleaseMouseButton(LG_MOUSE_BUTTON.LG_LEFT)
            Sleep(t)
            OutputLogMessage("- UP "..t.."\n")
        end
    end
    ReleaseMouseButton(LG_MOUSE_BUTTON.LG_LEFT)
end