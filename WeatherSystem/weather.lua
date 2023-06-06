--
-- DESCRIPTION
--
-- @COMPANY **
-- @AUTHOR **
-- @DATE ${date} ${time}
--

---@type Sc_MainPlayerUI_C
local M = UnLua.Class()

local Screen = require "Screen"

--function M:Initialize(Initializer)
--end

function M:PreConstruct(IsDesignTime)
    local __actors = UE.TArray(UE.AActor)
    UE.UGameplayStatics.GetAllActorsOfClass(self:GetWorld(), UE.UClass.Load("/Game/UltraDynamicSky/Blueprints/Ultra_Dynamic_Sky.Ultra_Dynamic_Sky_C"), __actors)
    if __actors:Length() ~= 1 then
        -- This should report error.
        Screen.Print("__actors.length() != 1")
    else
        Screen.Print("OK")
        self.Sky = __actors:GetRef(1)
    end
    
    UE.UGameplayStatics.GetAllActorsOfClass(self:GetWorld(), UE.UClass.Load("/Game/UltraDynamicSky/Blueprints/Ultra_Dynamic_Weather.Ultra_Dynamic_Weather_C"), __actors)
    if __actors:Length() ~= 1 then
        Screen.Print("__actors.length() != 1")
        -- report error here
    else
        self.Weather = __actors:GetRef(1)
    end

    time_value = self.Sky["Time Of Day"]
    self.Slider_Time:SetValue(time_value)
end

function M:Construct()
    print(self.Title)

    -- 添加按钮事件
    self.Morning.OnPressed:Add(self, self.OnTappedT1)
    self.Afternoon.OnPressed:Add(self, self.OnTappedT2)
    self.Night.OnPressed:Add(self, self.OnTappedT3)
    self.Rainy.OnPressed:Add(self, self.OnTappedW1)
    self.Sunny.OnPressed:Add(self, self.OnTappedW2)
    self.Foggy.OnPressed:Add(self, self.OnTappedW3)

    -- 添加Slide事件
    self.Slider_Time.OnValueChanged:Add(self, self.ValueChange)

    self.Slider_Time:SetValue(self.Sky["Time Of Day"])
end


function M:ValueChange(value)
    -- body
    self.Sky["Time Of Day"] = value
end

--function M:Tick(MyGeometry, InDeltaTime)
--end

function M:OnTappedT1()
    -- Morning
    self.Sky["Time Of Day"] = 700
    Screen.Print(string.format("result: %s", self.Sky["Time Of Day"]))
end

function M:OnTappedT2()
    -- Afternoon
    self.Sky["Time Of Day"] = 1500
    Screen.Print(string.format("result: %s", self.Sky["Time Of Day"]))
end

function M:OnTappedT3()
    -- Night
    self.Sky["Time Of Day"] = 2000
    Screen.Print(string.format("result: %s", self.Sky["Time Of Day"]))
end

function M:OnTappedW1()
    self.Weather["Weather Type"] = "Rain"
    self.Weather["Weather Intensity"] = 7
    self.Weather["Cloud Coverage"] = 7.5
    self.Weather["Rain"] = 0
    self.Weather["Wind Intensity"] = 3
    Screen.Print(string.format("result: %s", self.Weather["Weather Type"]))
    --  字典调用参数
end

function M:OnTappedW2()
    self.Weather["Weather Type"] = "Sunny"
    self.Weather["Weather Intensity"] = 0
    self.Weather["Cloud Coverage"] = 2
    self.Weather["Rain"] = 0
    self.Weather["Wind Intensity"] = 2
    self.Weather["Cloud Speed Multiplier"] = 1
    Screen.Print(string.format("result: %s", self.Weather["Weather Type"]))
    --  字典调用参数
end

function M:OnTappedW3()
    self.Weather["Weather Type"] = "Sunny"
    self.Weather["Weather Intensity"] = 0
    self.Weather["Cloud Coverage"] = 2
    self.Weather["Rain"] = 0
    self.Weather["Wind Intensity"] = 2
    self.Weather["Cloud Speed Multiplier"] = 1
    Screen.Print(string.format("result: %s", self.Weather["Weather Type"]))
    --  字典调用参数
end

function M:OnTappedW3()
    self.Weather["Weather Type"] = "Foggy"
    self.Weather["Weather Intensity"] = 0
    self.Weather["Cloud Coverage"] = 10
    self.Weather["Rain"] = 0
    self.Weather["Wind Intensity"] = 1
    self.Weather["Cloud Speed Multiplier"] = 1
    Screen.Print(string.format("result: %s", self.Weather["Weather Type"]))
    --  字典调用参数
end

return M