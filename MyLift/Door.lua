--
-- DESCRIPTION
--
-- @COMPANY **
-- @AUTHOR **
-- @DATE ${date} ${time}
--

---@type MyDoor_C
local M = UnLua.Class()
local BindKey=UnLua.Input.BindKey
local cnt = 0

-- function M:Initialize(Initializer)
--     Screen.Print("Reset")
--     self.Door:K2_SetRelativeLocation(UE.FVector(0 ,0 ,0), false, nil, false)
-- end

-- function M:UserConstructionScript()
--    self.Door:K2_SetRelativeLocation(UE.FVector(0 ,0 ,0), false, nil, false)
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
    -- Disable Input
    if(cnt % 2 == 1) then
        local InterpFloats=self.Door_Timeline.TheTimeline.InterpFloats 
        --Door_Timeline == timeline name
        local FloatTrack=InterpFloats:GetRef(1)
        FloatTrack.InterpFunc:Bind(self, M.CloseDoor) --replace M.func with your actual func
        self.Door_Timeline:Reverse()
        cnt = cnt + 1
    end
end

function M:OpenDoor(open)
    self.Door:K2_SetRelativeRotation(UE.FRotator(0,open,0), false, nil, false)
end

function M:CloseDoor(open)
    self.Door:K2_SetRelativeRotation(UE.FRotator(0,open,0), false, nil, false)
end

BindKey(M,"F", "Pressed", function(self,key)
    local InterpFloats=self.Door_Timeline.TheTimeline.InterpFloats --replace "Door_Timeline" with the actual timeline name
    local FloatTrack=InterpFloats:GetRef(1)
    FloatTrack.InterpFunc:Bind(self, M.OpenDoor) --replace M.func with your actual func
    self.Door_Timeline:PlayFromStart()
    cnt = cnt + 1
end)

return M
