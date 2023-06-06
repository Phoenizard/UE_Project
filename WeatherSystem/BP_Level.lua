--
-- DESCRIPTION
--
-- @COMPANY **
-- @AUTHOR **
-- @DATE ${date} ${time}
--

---@type MainMap_C

local Screen = require "Screen"

local M = UnLua.Class()

function M:Initialize()
    local msg = [[Hello World]]
    print(msg)
    Screen.Print(msg)
end

-- function M:UserConstructionScript()
-- end

function M:ReceiveBeginPlay()
    local msg = [[Weather System]]
    Screen.Print(msg)
    
    local actors = UE.TArray(UE.AActor)
    UE.UGameplayStatics.GetAllActorsOfClass(self:GetWorld(), UE.UClass.Load("/Game/UltraDynamicSky/Blueprints/Ultra_Dynamic_Sky.Ultra_Dynamic_Sky_C"), actors)
    self.Sky = actors:GetRef(1)
    UE.UGameplayStatics.GetAllActorsOfClass(self:GetWorld(), UE.UClass.Load("/Game/UltraDynamicSky/Blueprints/Ultra_Dynamic_Weather.Ultra_Dynamic_Weather_C"), actors)
    self.Weather = actors:GetRef(1)

    self.Sky["Time of Day"] = 1200
    self.Weather["Weather Type"] = "Sunny"

    local widget_class = UE.UClass.Load("/Game/Sc_MainPlayerUI.Sc_MainPlayerUI_C")
    local widget_root = NewObject(widget_class, self)
    widget_root:AddToViewport()
end

-- 两种读取键盘输入的方法
-- Function 1
local function SetupKeyBindings()
    local key_names = {
        "E", "One", "Up", "Fire", "Aim"
    }
    for _, key_name in ipairs(key_names) do
        M[key_name .. "_Pressed"] = function(self, key)
            Screen.Print(string.format("Pressed%s", key.keyName)) 
        -- body
        end
    end
end

SetupKeyBindings()

-- Function 2

local BindKey = UnLua.Input.BindKey

BindKey(M, "C", "Pressed", function(self, key)
    Screen.Print("复制")
end, { Ctrl = true })
-- function M:ReceiveEndPlay()
-- end

-- function M:ReceiveTick(DeltaSeconds)
-- end

-- function M:ReceiveAnyDamage(Damage, DamageType, InstigatedBy, DamageCauser)
-- end

-- function M:ReceiveActorBeginOverlap(OtherActor)
-- end

-- function M:ReceiveActorEndOverlap(OtherActor)
-- end

return M
