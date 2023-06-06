--
-- DESCRIPTION
--
-- @COMPANY **
-- @AUTHOR **
-- @DATE ${date} ${time}
--

local M = UnLua.Class()
local BindKey=UnLua.Input.BindKey
local Screen = require "Screen"
local Lerp = UE.UKismetMathLibrary.VLerp
local src = UE.FVector(0,0,0)
local dst = UE.FVector(0,0,0)

function M:ReceiveBeginPlay()
    local InterpFloats=self.Lift.TheTimeline.InterpFloats --replace "Door_Timeline" with the actual timeline name
    local FloatTrack=InterpFloats:GetRef(1)
    FloatTrack.InterpFunc:Bind(self, M.LiftMove) --replace M.func with your actual func
end

function M:ReceiveActorBeginOverlap(OtherActor)
    src = self.Platf:K2_GetComponentLocation()
    self:EnableInput(UE.UGameplayStatics.GetPlayerControllerFromID(self:GetWorld(),0))
    -- Enable controller Input
end
    
function M:ReceiveActorEndOverlap(OtherActor)
    self:DisableInput(UE.UGameplayStatics.GetPlayerControllerFromID(self:GetWorld(),0))
    -- Disable Input
end

function M:LiftMove(alpha)
    local Pos = Lerp(src, dst, alpha)
    self.Platf:K2_SetRelativeLocation(Pos, false, nil, false)
end

BindKey(M,"Two", "Pressed", function(self,key)
    Screen.Print("Go to 2 floor")
    src = UE.FVector(0,0,self.Platf:K2_GetComponentLocation().Z)
    dst = UE.FVector(0,0,1000)
    self.Lift:PlayFromStart()
end)

BindKey(M,"Three", "Pressed", function(self,key)
    Screen.Print("Go to 3 floor")
    src = UE.FVector(0,0,self.Platf:K2_GetComponentLocation().Z)
    dst = UE.FVector(0,0,2000)
    self.Lift:PlayFromStart()
end)

BindKey(M,"One", "Pressed", function(self,key)
    src = UE.FVector(0,0,self.Platf:K2_GetComponentLocation().Z)
    dst = UE.FVector(0,0,0)
    self.Lift:PlayFromStart()
end)

return M
