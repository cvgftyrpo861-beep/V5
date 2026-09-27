-- UIBuilder.lua
local function SetupUI(Library)
    local Aiming = getgenv().Aiming

    local Window = Library:CreateWindow({
        Title = "GGEZ HUB V5",
        Subtitle = "RIVALS • MODULAR EDITION"
    })

    local AimbotTab  = Window:CreateTab("AIMBOT")
    local VisualsTab = Window:CreateTab("VISUALS")

    -- --- [AIMBOT TAB] ---
    AimbotTab:AddCategory("SILENT AIM", "◈")
    
    AimbotTab:AddBigButton("Silent Aim", "Auto-hit target without moving camera", "◈", function(state)
        Aiming.Enabled = state
    end)

    AimbotTab:AddCategory("SETTINGS", "◈")
    
    AimbotTab:AddSlider("FOV Radius", "Silent Aim FOV Range", "◈", 10, 400, Aiming.FOV, function(val)
        Aiming.FOV = val
    end)

    AimbotTab:AddDropdown("Target Part", "Body part to target", "◈", {"Head", "HumanoidRootPart"}, Aiming.TargetPart, function(selected)
        Aiming.TargetPart = selected
    end)

    AimbotTab:AddSlider("Max Distance", "Maximum target distance", "◈", 50, 1000, Aiming.MaxDistance, function(val)
        Aiming.MaxDistance = val
    end)

    AimbotTab:AddCategory("FILTERS", "◈")
    
    AimbotTab:AddToggle("Wall Check", "Only target visible enemies", "🧱", Aiming.WallCheck, function(state)
        Aiming.WallCheck = state
    end)

    AimbotTab:AddToggle("Team Check", "Don't target teammates", "👥", Aiming.TeamCheck, function(state)
        Aiming.TeamCheck = state
    end)

    return Window
end

return SetupUI
