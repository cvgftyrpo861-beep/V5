-- WallCheck.lua
local function IsVisible(targetPart, localChar)
    local Camera = workspace.CurrentCamera
    local rayParams = RaycastParams.new()
    rayParams.FilterDescendantsInstances = {localChar, targetPart.Parent}
    rayParams.FilterType = Enum.RaycastFilterType.Exclude

    local origin = Camera.CFrame.Position
    local direction = targetPart.Position - origin
    local result = workspace:Raycast(origin, direction, rayParams)

    -- ถ้าไม่มีสิ่งกีดขวาง แสดงว่ามองเห็นเป้าหมาย
    return result == nil
end

return IsVisible
