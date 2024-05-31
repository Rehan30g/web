-- UI Library
local UILibrary = {}
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

function UILibrary:CreateScreenGui()
    local screenGui = Instance.new("ScreenGui", PlayerGui)
    screenGui.Name = "CustomUILibrary"
    screenGui.ResetOnSpawn = false
    return screenGui
end

function UILibrary:CreateMainFrame(screenGui, title, subtitle)
    local mainFrame = Instance.new("Frame", screenGui)
    mainFrame.Size = UDim2.new(0, 300, 0, 60)
    mainFrame.Position = UDim2.new(0.5, -150, 0.5, -30)
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
    titleLabel.Size = UDim2.new(0, 280, 0, 20)
    titleLabel.Position = UDim2.new(0.5, -140, 0, 5)
    titleLabel.Text = title
    titleLabel.TextColor3 = Color3.new(0, 0, 0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.TextXAlignment = Enum.TextXAlignment.Center
    titleLabel.Font = Enum.Font.SourceSans
    titleLabel.TextSize = 18
    titleLabel.ZIndex = 11

    local subTitleLabel = Instance.new("TextLabel", mainFrame)
    subTitleLabel.Size = UDim2.new(0, 280, 0, 15)
    subTitleLabel.Position = UDim2.new(0.5, -140, 0, 25)
    subTitleLabel.Text = subtitle
    subTitleLabel.TextColor3 = Color3.new(0.5, 0.5, 0.5)
    subTitleLabel.BackgroundTransparency = 1
    subTitleLabel.TextXAlignment = Enum.TextXAlignment.Center
    subTitleLabel.Font = Enum.Font.SourceSans
    subTitleLabel.TextSize = 14
    subTitleLabel.ZIndex = 11

    return mainFrame
end

function UILibrary:CreateButton(parent, text, position, size, callback)
    local button = Instance.new("TextButton", parent)
    button.Size = size or UDim2.new(0, 100, 0, 30)
    button.Position = position or UDim2.new(0.5, -50, 0.5, -15)
    button.Text = text
    button.BackgroundColor3 = Color3.fromRGB(100, 100, 255)
    button.TextColor3 = Color3.new(1, 1, 1)
    button.BorderSizePixel = 0
    button.AutoButtonColor = true
    button.Font = Enum.Font.SourceSans
    button.TextSize = 18
    button.ZIndex = 11

    local uICorner = Instance.new("UICorner", button)
    uICorner.CornerRadius = UDim.new(0, 10)

    button.MouseButton1Click:Connect(function()
        if callback then
            callback()
        end
    end)

    return button
end

function UILibrary:CreateToggle(parent, text, position, size, defaultState, callback)
    local toggleFrame = Instance.new("Frame", parent)
    toggleFrame.Size = size or UDim2.new(0, 100, 0, 30)
    toggleFrame.Position = position or UDim2.new(0.5, -50, 0.5, -15)
    toggleFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    toggleFrame.BackgroundTransparency = 0.5
    toggleFrame.BorderSizePixel = 0

    local toggleButton = Instance.new("TextButton", toggleFrame)
    toggleButton.Size = UDim2.new(1, 0, 1, 0)
    toggleButton.Text = defaultState and "ON" or "OFF"
    toggleButton.BackgroundColor3 = defaultState and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
    toggleButton.TextColor3 = Color3.new(1, 1, 1)
    toggleButton.BorderSizePixel = 0
    toggleButton.Font = Enum.Font.SourceSans
    toggleButton.TextSize = 18

    local uICorner = Instance.new("UICorner", toggleButton)
    uICorner.CornerRadius = UDim.new(0, 10)

    toggleButton.MouseButton1Click:Connect(function()
        defaultState = not defaultState
        toggleButton.Text = defaultState and "ON" or "OFF"
        toggleButton.BackgroundColor3 = defaultState and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
        if callback then
            callback(defaultState)
        end
    end)

    return toggleButton
end

function UILibrary:CreateInputBox(parent, placeholderText, position, size, callback)
    local inputBox = Instance.new("TextBox", parent)
    inputBox.Size = size or UDim2.new(0, 200, 0, 30)
    inputBox.Position = position or UDim2.new(0.5, -100, 0.5, -15)
    inputBox.PlaceholderText = placeholderText
    inputBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    inputBox.TextColor3 = Color3.new(0, 0, 0)
    inputBox.BorderSizePixel = 0
    inputBox.Font = Enum.Font.SourceSans
    inputBox.TextSize = 18
    inputBox.ClearTextOnFocus = false

    local uICorner = Instance.new("UICorner", inputBox)
    uICorner.CornerRadius = UDim.new(0, 10)

    inputBox.FocusLost:Connect(function(enterPressed)
        if enterPressed and callback then
            callback(inputBox.Text)
        end
    end)

    return inputBox
end

function UILibrary:CreateLabel(parent, text, position, size)
    local label = Instance.new("TextLabel", parent)
    label.Size = size or UDim2.new(0, 200, 0, 30)
    label.Position = position or UDim2.new(0.5, -100, 0.5, -15)
    label.Text = text
    label.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    label.TextColor3 = Color3.new(0, 0, 0)
    label.BorderSizePixel = 0
    label.Font = Enum.Font.SourceSans
    label.TextSize = 18
    label.BackgroundTransparency = 1

    return label
end

function UILibrary:CreateSection(parent, text, position, size)
    local section = Instance.new("Frame", parent)
    section.Size = size or UDim2.new(0, 280, 0, 40)
    section.Position = position or UDim2.new(0.5, -140, 0.5, -20)
    section.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
    section.BorderSizePixel = 0
    section.BackgroundTransparency = 0.5

    local sectionLabel = Instance.new("TextLabel", section)
    sectionLabel.Size = UDim2.new(1, 0, 0, 20)
    sectionLabel.Position = UDim2.new(0, 0, 0, 0)
    sectionLabel.Text = text
    sectionLabel.TextColor3 = Color3.new(0, 0, 0)
    sectionLabel.BackgroundTransparency = 1
    sectionLabel.Font = Enum.Font.SourceSans
    sectionLabel.TextSize = 18

    local uICorner = Instance.new("UICorner", section)
    uICorner.CornerRadius = UDim.new(0, 10)

    return section
end

function UILibrary:CreateDropdown(parent, text, options, position, size, callback)
    local dropdownFrame = Instance.new("Frame", parent)
    dropdownFrame.Size = size or UDim2.new(0, 200, 0, 30)
    dropdownFrame.Position = position or UDim2.new(0.5, -100, 0.5, -15)
    dropdownFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    dropdownFrame.BorderSizePixel = 0
    dropdownFrame.ClipsDescendants = true

    function UILibrary:CreateDropdown(parent, text, options, position, size, callback)
    local dropdownFrame = Instance.new("Frame", parent)
    dropdownFrame.Size = size or UDim2.new(0, 200, 0, 30)
    dropdownFrame.Position = position or UDim2.new(0.5, -100, 0.5, -15)
    dropdownFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    dropdownFrame.BorderSizePixel = 0
    dropdownFrame.ClipsDescendants = true

    local uICorner = Instance.new("UICorner", dropdownFrame)
    uICorner.CornerRadius = UDim.new(0, 10)

    local dropdownButton = Instance.new("TextButton", dropdownFrame)
    dropdownButton.Size = UDim2.new(1, 0, 1, 0)
    dropdownButton.Text = text
    dropdownButton.BackgroundColor3 = Color3.fromRGB(100, 100, 255)
    dropdownButton.TextColor3 = Color3.new(1, 1, 1)
    dropdownButton.BorderSizePixel = 0
    dropdownButton.Font = Enum.Font.SourceSans
    dropdownButton.TextSize = 18

    local optionFrame = Instance.new("Frame", dropdownFrame)
    optionFrame.Size = UDim2.new(1, 0, 0, 0)
    optionFrame.Position = UDim2.new(0, 0, 1, 0)
    optionFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    optionFrame.BorderSizePixel = 0
    optionFrame.Visible = false

    local uICornerOption = Instance.new("UICorner", optionFrame)
    uICornerOption.CornerRadius = UDim.new(0, 10)

    local function updateDropdown()
        for _, child in ipairs(optionFrame:GetChildren()) do
            if child:IsA("TextButton") then
                child:Destroy()
            end
        end

        for i, option in ipairs(options) do
            local optionButton = Instance.new("TextButton", optionFrame)
            optionButton.Size = UDim2.new(1, 0, 0, 30)
            optionButton.Position = UDim2.new(0, 0, 0, (i - 1) * 30)
            optionButton.Text = option
            optionButton.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
            optionButton.TextColor3 = Color3.new(0, 0, 0)
            optionButton.BorderSizePixel = 0
            optionButton.Font = Enum.Font.SourceSans
            optionButton.TextSize = 18
            optionButton.MouseButton1Click:Connect(function()
                dropdownButton.Text = option
                if callback then
                    callback(option)
                end
                optionFrame.Visible = false
                optionFrame.Size = UDim2.new(1, 0, 0, 0)
            end)
        end

        optionFrame.Size = UDim2.new(1, 0, 0, #options * 30)
    end

    dropdownButton.MouseButton1Click:Connect(function()
        optionFrame.Visible = not optionFrame.Visible
        if optionFrame.Visible then
            optionFrame:TweenSize(UDim2.new(1, 0, 0, #options * 30), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.3, true)
        else
            optionFrame:TweenSize(UDim2.new(1, 0, 0, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.3, true)
        end
    end)

    updateDropdown()

    return dropdownFrame
end

function UILibrary:CreateSlider(parent, text, min, max, default, position, size, callback)
    local sliderFrame = Instance.new("Frame", parent)
    sliderFrame.Size = size or UDim2.new(0, 200, 0, 60)
    sliderFrame.Position = position or UDim2.new(0.5, -100, 0.5, -30)
    sliderFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    sliderFrame.BorderSizePixel = 0

    local uICorner = Instance.new("UICorner", sliderFrame)
    uICorner.CornerRadius = UDim.new(0, 10)

    local titleLabel = Instance.new("TextLabel", sliderFrame)
    titleLabel.Size = UDim2.new(1, 0, 0, 20)
    titleLabel.Position = UDim2.new(0, 0, 0, 0)
    titleLabel.Text = text
    titleLabel.BackgroundTransparency = 1
    titleLabel.TextColor3 = Color3.new(0, 0, 0)
    titleLabel.Font = Enum.Font.SourceSans
    titleLabel.TextSize = 18

    local sliderBar = Instance.new("Frame", sliderFrame)
    sliderBar.Size = UDim2.new(0.8, 0, 0, 10)
    sliderBar.Position = UDim2.new(0.1, 0, 0.5, -5)
    sliderBar.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
    sliderBar.BorderSizePixel = 0

    local sliderButton = Instance.new("ImageButton", sliderBar)
    sliderButton.Size = UDim2.new(0, 20, 0, 20)
    sliderButton.Position = UDim2.new((default - min) / (max - min), -10, 0.5, -10)
    sliderButton.BackgroundTransparency = 1
    sliderButton.Image = "rbxassetid://3570695787"
    sliderButton.ImageColor3 = Color3.fromRGB(100, 100, 255)
    sliderButton.ScaleType = Enum.ScaleType.Slice
    sliderButton.SliceCenter = Rect.new(100, 100, 100, 100)

    local function updateSlider(input)
        local sliderSize = sliderBar.AbsoluteSize.X
        local buttonPosition = math.clamp(input.Position.X - sliderBar.AbsolutePosition.X, 0, sliderSize)
        local value = min + (buttonPosition / sliderSize) * (max - min)
        sliderButton.Position = UDim2.new(buttonPosition / sliderSize, -10, 0.5, -10)
        if callback then
            callback(value)
        end
    end

    sliderButton.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            local moveConn
            local releaseConn
            moveConn = input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    moveConn:Disconnect()
                    releaseConn:Disconnect()
                end
            end)
            releaseConn = UserInputService.InputChanged:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
                    updateSlider(input)
                end
            end)
        end
    end)

    return sliderFrame
end

return CustomUILibrary
