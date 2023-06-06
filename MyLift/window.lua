--
-- DESCRIPTION
--
-- @COMPANY **
-- @AUTHOR **
-- @DATE ${date} ${time}
--

---@type windows_C
local M = UnLua.Class()
local BindKey=UnLua.Input.BindKey
local Screen = require "Screen"
local cnt = 0

-- function M:Initialize(Initializer)
-- end

-- function M:UserConstructionScript()
-- end

-- function M:ReceiveBeginPlay()
-- end

-- function M:ReceiveEndPlay()
-- end

-- function M:ReceiveTick(DeltaSeconds)
-- end

-- function M:ReceiveAnyDamage(Damage, DamageType, InstigatedBy, DamageCauser)
-- end
function M:ReceiveActorBeginOverlap(OtherActor)
    self:EnableInput(UE.UGameplayStatics.GetPlayerControllerFromID(self:GetWorld(),0))
    -- Enable controller Input
end
    
function M:ReceiveActorEndOverlap(OtherActor)
    self:DisableInput(UE.UGameplayStatics.GetPlayerControllerFromID(self:GetWorld(),0))
end

function M:OpenWindows(open_w)
    self.Scene_W:K2_SetRelativeRotation(UE.FRotator(0,0,open_w), false, nil, false)
end

function M:CloseWindows(open_w)
    self.Scene_W:K2_SetRelativeRotation(UE.FRotator(0,0,open_w), false, nil, false)
end

BindKey(M,"X", "Pressed", function(self,key)
    local InterpFloats=self.window.TheTimeline.InterpFloats --replace "Door_Timeline" with the actual timeline name
    local FloatTrack=InterpFloats:GetRef(1)
    if (cnt % 2 == 0) then
        FloatTrack.InterpFunc:Bind(self, M.OpenWindows) --replace M.func with your actual func
        self.window:PlayFromStart()
        cnt = cnt + 1
    else
        FloatTrack.InterpFunc:Bind(self, M.CloseWindows) --replace M.func with your actual func
        self.window:Reverse()
        cnt = cnt + 1
    end
end)

return M
