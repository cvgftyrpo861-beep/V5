-- Services.lua
local Services = {
    Players          = game:GetService("Players"),
    UserInputService = game:GetService("UserInputService"),
    RunService       = game:GetService("RunService"),
    Workspace        = game:GetService("Workspace"),
    Lighting         = game:GetService("Lighting")
}

Services.LocalPlayer = Services.Players.LocalPlayer
Services.Camera      = Services.Workspace.CurrentCamera

-- Global State Management
getgenv().Aiming = {
    Enabled      = false,
    FOV          = 150,
    TargetPart   = "Head",
    MaxDistance  = 500,
    WallCheck    = false,
    TeamCheck    = false,
    SelectedPart = nil
}

return Services
