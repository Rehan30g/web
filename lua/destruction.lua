-- Localscript (execute it in ur Executor)
-- Touch any part and the part will Destroyed with cool way ^^
-- I made this script cuz im bored 

-- This script is open source so you can edit it or copy it *please give credits :D*
-- This still has lots of bugs and is not responsive to mobile users ;(
-- Script made by rehan30g


local Players = game:GetService("Players")
local player = Players.LocalPlayer
local mouse = player:GetMouse()
local TweenService = game:GetService("TweenService")
local debris = game:GetService("Debris")

-- AAA~ My best ui >-<
local screenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
screenGui.Name = "DestructionGui"
screenGui.ResetOnSpawn = false

local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Size = UDim2.new(0, 220, 0, 60)
mainFrame.Position = UDim2.new(0.5, -110, 0, 10)
mainFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
mainFrame.BorderSizePixel = 0
mainFrame.ClipsDescendants = true
mainFrame.ZIndex = 10
mainFrame.BackgroundTransparency = 0.3
mainFrame.Active = true
mainFrame.Draggable = true

local uICorner = Instance.new("UICorner", mainFrame)
uICorner.CornerRadius = UDim.new(0, 15)

local titleLabel = Instance.new("TextLabel", mainFrame)
titleLabel.Size = UDim2.new(0, 180, 0, 20)
titleLabel.Position = UDim2.new(0.5, -90, 0, 5)
titleLabel.Text = "Destruction (BETA)"
titleLabel.TextColor3 = Color3.new(0, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.TextXAlignment = Enum.TextXAlignment.Center
titleLabel.Font = Enum.Font.SourceSans
titleLabel.TextSize = 18
titleLabel.ZIndex = 11

local subTitleLabel = Instance.new("TextLabel", mainFrame)
subTitleLabel.Size = UDim2.new(0, 180, 0, 15)
subTitleLabel.Position = UDim2.new(0.5, -90, 0, 25)
subTitleLabel.Text = "by Rehan30g"
subTitleLabel.TextColor3 = Color3.new(0.5, 0.5, 0.5)
subTitleLabel.BackgroundTransparency = 1
subTitleLabel.TextXAlignment = Enum.TextXAlignment.Center
subTitleLabel.Font = Enum.Font.SourceSans
subTitleLabel.TextSize = 14
subTitleLabel.ZIndex = 11

-- I don't know what this is called but Expandable button✨
local toggleButton = Instance.new("TextButton", mainFrame)
toggleButton.Size = UDim2.new(0, 30, 0, 30)
toggleButton.Position = UDim2.new(0.5, -15, 0, 40)
toggleButton.Text = "↓"
toggleButton.BackgroundColor3 = Color3.fromRGB(100, 100, 255)
toggleButton.TextColor3 = Color3.new(1, 1, 1)
toggleButton.BorderSizePixel = 0
toggleButton.AutoButtonColor = true
toggleButton.Font = Enum.Font.SourceSans
toggleButton.TextSize = 24
toggleButton.ZIndex = 11

local isExpanded = false

-- ✨ Expandable Section ✨
local optionsFrame = Instance.new("Frame", mainFrame)
optionsFrame.Size = UDim2.new(1, 0, 0, 0)
optionsFrame.Position = UDim2.new(0, 0, 0, 60)
optionsFrame.BackgroundTransparency = 1
optionsFrame.ClipsDescendants = true
optionsFrame.ZIndex = 10

-- Toogle On/off for 💥 effect
local forgeLabel = Instance.new("TextLabel", optionsFrame)
forgeLabel.Size = UDim2.new(0, 180, 0, 30)
forgeLabel.Position = UDim2.new(0.5, -90, 0, 0)
forgeLabel.Text = "isExplode:"
forgeLabel.TextColor3 = Color3.new(0, 0, 0)
forgeLabel.BackgroundTransparency = 1
forgeLabel.TextXAlignment = Enum.TextXAlignment.Left
forgeLabel.ZIndex = 11

local forgeToggle = Instance.new("TextButton", optionsFrame)
forgeToggle.Size = UDim2.new(0, 180, 0, 30)
forgeToggle.Position = UDim2.new(0.5, -90, 0, 30)
forgeToggle.Text = "Yes! Why not"
forgeToggle.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
forgeToggle.TextColor3 = Color3.new(1, 1, 1)
forgeToggle.BorderSizePixel = 0
forgeToggle.Font = Enum.Font.SourceSans
forgeToggle.TextSize = 18
forgeToggle.ZIndex = 11

local forgeEnabled = true

local function createFragments(part)
    local fragments = {}
    local size = part.Size
    local fragmentSize = size / 3
    local partColor = part.Color
    local partMaterial = part.Material

    for x = -1, 1 do
        for y = -1, 1 do
            for z = -1, 1 do
                local fragment = Instance.new("Part")
                fragment.Size = fragmentSize
                fragment.Position = part.Position + Vector3.new(x, y, z) * fragmentSize
                fragment.Anchored = false
                fragment.Color = partColor
                fragment.Material = partMaterial
                fragment.TopSurface = Enum.SurfaceType.Smooth
                fragment.BottomSurface = Enum.SurfaceType.Smooth
                fragment.Parent = workspace
                table.insert(fragments, fragment)
            end
        end
    end

    part:Destroy()

    if forgeEnabled then
        for _, fragment in ipairs(fragments) do
            fragment.Velocity = Vector3.new(math.random(-50, 50), math.random(-50, 50), math.random(-50, 50))
        end
    end

    for _, fragment in ipairs(fragments) do
        local tweenInfo = TweenInfo.new(10, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local tween = TweenService:Create(fragment, tweenInfo, {Transparency = 1, Size = Vector3.new(0, 0, 0)})
        tween:Play()
        tween.Completed:Connect(function()
            fragment:Destroy()
        end)
    end
end

mouse.Button1Down:Connect(function()
    local target = mouse.Target
    if target and target:IsA("BasePart") then
        createFragments(target)
    end
end)

toggleButton.MouseButton1Click:Connect(function()
    isExpanded = not isExpanded
    toggleButton.Text = isExpanded and "↑" or "↓"

    if isExpanded then
        -- Expand ✨✨✨ your life
        optionsFrame:TweenSize(UDim2.new(1, 0, 0, 70), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.3, true)
        mainFrame:TweenSize(UDim2.new(0, 220, 0, 130), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.3, true)
    else
        -- Collapse opt 🧱
        optionsFrame:TweenSize(UDim2.new(1, 0, 0, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.3, true)
        mainFrame:TweenSize(UDim2.new(0, 220, 0, 60), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.3, true)
    end
end)

forgeToggle.MouseButton1Click:Connect(function()
    forgeEnabled = not forgeEnabled
    forgeToggle.Text = forgeEnabled and "ON" or "OFF"
    forgeToggle.BackgroundColor3 = forgeEnabled and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
end)

-- Thanks for reading my script lol :3
