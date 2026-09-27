-- TargetFinder.lua
local Players          = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local Camera           = workspace.CurrentCamera
local LocalPlayer      = Players.LocalPlayer

local function GetClosestTarget()
    local Aiming = getgenv().Aiming
    if not Aiming.Enabled then return nil end

    local MousePos = UserInputService:GetMouseLocation()
    local NearestTarget = nil
    local ShortestDistance = Aiming.FOV

    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            -- 1. ตรวจสอบทีม (Team Check)
            if Aiming.TeamCheck and player.Team == LocalPlayer.Team then
                continue
            end

            local char = player.Character
            local hum = char:FindFirstChildOfClass("Humanoid")
            local part = char:FindFirstChild(Aiming.TargetPart) or char:FindFirstChild("Head")

            if hum and hum.Health > 0 and part then
                local ScreenPos, OnScreen = Camera:WorldToViewportPoint(part.Position)
                
                if OnScreen then
                    local Dist2D = (Vector2.new(ScreenPos.X, ScreenPos.Y) - MousePos).Magnitude
                    local Dist3D = (part.Position - Camera.CFrame.Position).Magnitude

                    -- 2. ตรวจสอบระยะทาง และ FOV
                    if Dist3D <= Aiming.MaxDistance and Dist2D < ShortestDistance then
                        
                        -- 3. ตรวจสอบสิ่งกีดขวาง (Wall Check)
                        if Aiming.WallCheck then
                            local rayParams = RaycastParams.new()
                            rayParams.FilterDescendantsInstances = {LocalPlayer.Character, char}
                            rayParams.FilterType = Enum.RaycastFilterType.Exclude
                            
                            local res = workspace:Raycast(Camera.CFrame.Position, part.Position - Camera.CFrame.Position, rayParams)
                            if res then continue end
                        end

                        ShortestDistance = Dist2D
                        NearestTarget = part
                    end
                end
            end
        end
    end

    return NearestTarget
end

return GetClosestTarget
