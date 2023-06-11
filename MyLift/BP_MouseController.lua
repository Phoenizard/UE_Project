-- DESCRIPTION

-- @AUTHOR **
-- @DATE ${date} ${time}

-- The mouse controller system: Press Alt to show the mouse

---@type Mouse_Controller_C

local M = UnLua.Class()
local y_scale = 0
local p_scale = 0
local BindKey = UnLua.Input.BindKey
local controller

function M:ReceiveBeginPlay()
    controller = UE.UGameplayStatics.GetPlayerControllerFromID(self:GetWorld(),0)
    y_scale = controller.InputYawScale
    p_scale = controller.InputPitchScale
end

BindKey(M, "LeftAlt", "Pressed", function(self, key)
    -- CAMERA LOCK
    controller.InputYawScale = 0
    controller.InputPitchScale = 0
    -- Center the Position of Mouse

    local _ViewportSize = UE.FVector2D(0, 0)
    -- Get ViewPort Size to Center 
    _ViewportSize = UE.UWidgetLayoutLibrary.GetViewportSize(self:GetWorld())
    controller:SetMouseLocation(math.floor(_ViewportSize.X / 2), math.floor(_ViewportSize.Y / 2))
    self.bShowMouseCursor = true
end)


BindKey(M, "LeftAlt", "Released", function(self, key)
    self.bShowMouseCursor = false
    -- CAMERA Unlock
    controller.InputYawScale = y_scale
    controller.InputPitchScale = p_scale
end)

return M
