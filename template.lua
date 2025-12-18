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

-- Logitech G-Series Baisc Mouse Buttons
--- Left Mouse Button is not reported by defaultUse ‘EnablePrimaryMouseButtonEvents’ to override this.
local LG_MOUSE_BUTTON = {
 LG_LEFT = 1,   -- Left Mouse Button
 LG_RIGHT = 2,  -- Right Mouse Button
 LG_MIDDLE = 3, -- Middle Mouse Button
 LG_BACK = 4,   -- Back Button (X1)
 LG_FORWARD = 5 -- Forward Button (X2)
}