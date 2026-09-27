-- [[ MAIN LOADER SCRIPT ]] --

-- 1. โหลด UI Library หลัก
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/cvgftyrpo861-beep/V5/refs/heads/main/lib.lua"))()

-- 2. โหลด Config & Services
loadstring(game:HttpGet("https://raw.githubusercontent.com/cvgftyrpo861-beep/V5/refs/heads/main/Services%20%26%20Config.lua"))()

-- 3. โหลด ฟังก์ชัน Wall Check
local IsVisible = loadstring(game:HttpGet("https://raw.githubusercontent.com/cvgftyrpo861-beep/V5/refs/heads/main/Wall%20Check%20Function.lua"))()

-- 4. โหลด ฟังก์ชันหาเป้าหมาย
local GetClosestTarget = loadstring(game:HttpGet("https://raw.githubusercontent.com/cvgftyrpo861-beep/V5/refs/heads/main/Get%20Closest%20Target.lua"))()

-- 5. โหลด Silent Aim Engine (Hooking)
local InitSilentAimHook = loadstring(game:HttpGet("https://raw.githubusercontent.com/cvgftyrpo861-beep/V5/refs/heads/main/Silent%20Aim%20Hooking%20Engine.lua"))()
if type(InitSilentAimHook) == "function" then
    InitSilentAimHook()
end

-- 6. โหลด UI Connector (สร้างเมนู UI และจับคู่อิเวนต์)
local SetupUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/cvgftyrpo861-beep/V5/refs/heads/main/UI%20Connector.lua"))()
if type(SetupUI) == "function" then
    SetupUI(Library)
end

-- 7. ลูปอัปเดตตำแหน่งเป้าหมายตลอดเวลา (Main Loop)
local RunService = game:GetService("RunService")
RunService.RenderStepped:Connect(function()
    if getgenv().Aiming and getgenv().Aiming.Enabled then
        getgenv().Aiming.SelectedPart = GetClosestTarget()
    else
        if getgenv().Aiming then
            getgenv().Aiming.SelectedPart = nil
        end
    end
end)

print("◈ GGEZ HUB V5: Loaded All Modules Successfully! ◈")
