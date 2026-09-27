-- Main.lua
local RunService = game:GetService("RunService")

-- 1. โหลด UI Library จาก GitHub[cite: 1]
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/cvgftyrpo861-beep/V5/refs/heads/main/lib.lua"))()

-- 2. เรียกใช้ระบบ Hook Silent Aim[cite: 2]
local InitSilentAimHook = loadstring(game:HttpGet(".../SilentAimHook.lua"))() -- หรือวางฟังก์ชันไว้ตรงนี้
InitSilentAimHook()

-- 3. ติดตั้ง Loop สำหรับค้นหาเป้าหมายตลอดเวลา
local GetClosestTarget = loadstring(game:HttpGet(".../TargetFinder.lua"))() -- หรือวางฟังก์ชันไว้ตรงนี้
RunService.RenderStepped:Connect(function()
    if getgenv().Aiming.Enabled then
        getgenv().Aiming.SelectedPart = GetClosestTarget()
    else
        getgenv().Aiming.SelectedPart = nil
    end
end)

-- 4. สร้าง UI
local SetupUI = loadstring(game:HttpGet(".../UIBuilder.lua"))() -- หรือวางฟังก์ชันไว้ตรงนี้
SetupUI(Library)

print("◈ ALL MODULES LOADED SUCCESSFULLY ◈")
