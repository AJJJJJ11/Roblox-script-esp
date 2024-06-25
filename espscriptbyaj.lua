local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local function updatePlayerInfo(player)
  local character = player.Character
  if character then
    local humanoid = character:WaitForChild("Humanoid")
    if humanoid then
      local head = humanoid:FindFirstChild("Head")
      if head then
        local infoDisplay = character:FindFirstChild("InfoDisplay")
        if not infoDisplay then
          infoDisplay = script.Parent:Clone()
          infoDisplay.Parent = character
        end

        local textLabel = infoDisplay.TextLabel
        textLabel.Text = player.Name
        infoDisplay.LocalTransparency = 0.5 -- Adjust transparency here

        infoDisplay.CamSpacePosition = head.Position + head.UpVector * 2 -- Adjust offset here
        infoDisplay.BillboardGui.StudsOffset = Vector3.new(0, 0.5, 0) -- Adjust billboard offset
      end
    end
  end
end

Players.PlayerAdded:Connect(function(player)
  updatePlayerInfo(player)
end)

Players.PlayerRemoving:Connect(function(player)
  local character = player.Character
  if character then
    local infoDisplay = character:FindFirstChild("InfoDisplay")
    if infoDisplay then
      infoDisplay:Destroy()
    end
  end
end)

RunService.Heartbeat:Connect(function()
  for _, player in pairs(Players:GetPlayers()) do
    updatePlayerInfo(player)
  end
end)
