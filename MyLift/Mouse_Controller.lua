--
-- DESCRIPTION
--
-- @COMPANY **
-- @AUTHOR **
-- @DATE ${date} ${time}
--
-- TODO: Add the size of viewport

---@type Mouse_Controller_C
local M = UnLua.Class()
local Screen = require "Screen"
local y_scale = 0
local p_scale = 0
local BindKey = UnLua.Input.BindKey
local controller

function M:ReceiveBeginPlay()
    -- coroutine.resume(coroutine.create(delayFunc), self:GetWorld(), "A")
    controller = UE.UGameplayStatics.GetPlayerControllerFromID(self:GetWorld(),0)
end

BindKey(M, "LeftAlt", "Pressed", function(self, key)
    -- Screen.Print("Alt Pressed")
    -- CAMERA
    y_scale = controller.InputYawScale
    p_scale = controller.InputPitchScale
    controller.InputYawScale = 0
    controller.InputPitchScale = 0

    self.MouseX = Viewport_x
    self.MouseY = Viewport_y

    self.bShowMouseCursor = true
end)


BindKey(M, "LeftAlt", "Released", function(self, key)
    -- Screen.Print("Alt Release")
    self.bShowMouseCursor = false
    -- CAMERA
    controller.InputYawScale = y_scale
    controller.InputPitchScale = p_scale
end)

return M
