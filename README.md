# UE_Project

## 仓库OutLine

此仓库用于保存UnLua脚本：

1. Mylift

   UE练手项目，包括对象碰撞事件，物体位移，时间轴

2. ShootUI

   UI项目，包含射箭游戏计分，跨类变量继承

3. WeatherSystem

   天气系统以及UI，UDS脚本实现，滑条组件

## 样例代码

### 绑定键盘按键

设置与键盘输入的监听事件

- "Key" == 待监听的Key, Ctrl, Alt, Shift 区分左右空格，且写法与源码一致，与蓝图不同
- Extra Key == Clrt Alt Shift， 用于同时键绑定

```lua
local BindKey = UnLua.Input.BindKey
-- 定义绑定对象

function M:ReceiveActorBeginOverlap(OtherActor)
    self:EnableInput(UE.UGameplayStatics.GetPlayerControllerFromID(self:GetWorld(),0))
    -- Enable controller Input
end

Bindkey(M, "Key", "State", function(self,key)
    ...
end,{ExtraKey = true})
```

### 物体移动与旋转

```lua
self.Object:K2_SetRelativeRotation(UE.FRotator(x, y, z), false, nil, false)

self.Platf:K2_SetRelativeLocation(UE.FVector(x, y, z), false, nil, false)
```