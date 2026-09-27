-- SilentAimHook.lua
local function InitSilentAimHook()
    local OldNamecall
    OldNamecall = hookmetamethod(game, "__namecall", function(Self, ...)
        local Method = getnamecallmethod()
        local Args = {...}
        local Aiming = getgenv().Aiming

        -- ดักจับคำสั่งยิง/ส่ง Raycast ของเกม
        if not checkcaller() and Aiming.Enabled and Aiming.SelectedPart then
            if Method == "Raycast" or Method == "FindPartOnRayWithIgnoreList" or Method == "FindPartOnRay" then
                if Args[1] and typeof(Args[1]) == "Vector3" and Args[2] and typeof(Args[2]) == "Vector3" then
                    local Origin = Args[1]
                    -- คำนวณทิศทางใหม่ให้พุ่งตรงไปหา SelectedPart[cite: 2]
                    local Direction = (Aiming.SelectedPart.Position - Origin).Unit * Args[2].Magnitude
                    Args[2] = Direction
                    return OldNamecall(Self, unpack(Args))
                end
            end
        end

        return OldNamecall(Self, ...)
    end)
end

return InitSilentAimHook
