local UILibrary = {}

function UILibrary:CreateScreenGui()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
    return screenGui
end

function UILibrary:CreateMainFrame(parent, title, subtitle)
    local frame = Instance.new("Frame", parent)
    frame.Size = UDim2.new(0, 300, 0, 400)
    frame.Position = UDim2.new(0.5, -150, 0.5, -200)
    frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    frame.BorderSizePixel = 0

    local uICorner = Instance.new("UICorner", frame)
    uICorner.CornerRadius = UDim.new(0, 10)

    local titleLabel = Instance.new("TextLabel", frame)
    titleLabel.Size = UDim2.new(1, 0, 0, 50)
    titleLabel.Text = title
    titleLabel.BackgroundTransparency = 1
    titleLabel.TextColor3 = Color3.new(0, 0, 0)
    titleLabel.Font = Enum.Font.SourceSans
    titleLabel.TextSize = 24

    local subtitleLabel = Instance.new("TextLabel", frame)
    subtitleLabel.Size = UDim2.new(1, 0, 0, 30)
    subtitleLabel.Position = UDim2.new(0, 0, 0, 50)
    subtitleLabel.Text = subtitle
    subtitleLabel.BackgroundTransparency = 1
    subtitleLabel.TextColor3 = Color3.new(0, 0, 0)
    subtitleLabel.Font = Enum.Font.SourceSans
    subtitleLabel.TextSize = 18

    return frame
end

function UILibrary:CreateButton(parent, text, position, size, callback)
    local button = Instance.new("TextButton", parent)
    button.Size = size or UDim2.new(0, 100, 0, 30)
    button.Position = position or UDim2.new(0, 10, 0, 10)
    button.Text = text
    button.BackgroundColor3 = Color3.fromRGB(100, 100, 255)
    button.TextColor3 = Color3.new(1, 1, 1)
    button.BorderSizePixel = 0
    button.Font = Enum.Font.SourceSans
    button.TextSize = 18

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
    toggleFrame.Position = position or UDim2.new(0, 10, 0, 50)
    toggleFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    toggleFrame.BorderSizePixel = 0

    local uICorner = Instance.new("UICorner", toggleFrame)
    uICorner.CornerRadius = UDim.new(0, 10)

    local toggleButton = Instance.new("TextButton", toggleFrame)
    toggleButton.Size = UDim2.new(1, -30, 1, 0)
    toggleButton.Position = UDim2.new(0, 0, 0, 0)
    toggleButton.Text = text
    toggleButton.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
    toggleButton.TextColor3 = Color3.new(0, 0, 0)
    toggleButton.BorderSizePixel = 0
    toggleButton.Font = Enum.Font.SourceSans
    toggleButton.TextSize = 18

    local toggleIndicator = Instance.new("Frame", toggleFrame)
    toggleIndicator.Size = UDim2.new(0, 30, 0, 30)
    toggleIndicator.Position = UDim2.new(1, -30, 0, 0)
    toggleIndicator.BackgroundColor3 = defaultState and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
    toggleIndicator.BorderSizePixel = 0

    toggleButton.MouseButton1Click:Connect(function()
        defaultState = not defaultState
        toggleIndicator.BackgroundColor3 = defaultState and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
        if callback then
            callback(defaultState)
        end
    end)

    return toggleFrame
end

function UILibrary:CreateInputBox(parent, placeholderText, position, size, callback)
    local inputBox = Instance.new("TextBox", parent)
    inputBox.Size = size or UDim2.new(0, 200, 0, 30)
    inputBox.Position = position or UDim2.new(0, 10, 0, 100)
    inputBox.PlaceholderText = placeholderText
    inputBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    inputBox.TextColor3 = Color3.new(0, 0, 0)
    inputBox.BorderSizePixel = 0
    inputBox.Font = Enum.Font.SourceSans
    inputBox.TextSize = 18

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
    label.Position = position or UDim2.new(0, 10, 0, 150)
    label.Text = text
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.new(0, 0, 0)
    label.Font = Enum.Font.SourceSans
    label.TextSize = 18

    return label
end

function UILibrary:CreateSection(parent, text, position, size)
    local section = Instance.new("Frame", parent)
    section.Size = size or UDim2.new(0, 280, 0, 40)
    section.Position = position or UDim2.new(0, 10, 0, 200)
    section.BackgroundColor3 = Color3.fromRGB(240, 240, 240)
    section.BorderSizePixel = 0

    local uICorner = Instance.new("UICorner", section)
    uICorner.CornerRadius = UDim.new(0, 10)

    local sectionLabel = Instance.new("TextLabel", section)
    sectionLabel.Size = UDim2.new(1, 0, 1, 0)
    sectionLabel.Text = text
    sectionLabel.BackgroundTransparency = 1
    sectionLabel.TextColor3 = Color3.new(0, 0, 0)
    sectionLabel.Font = Enum.Font.SourceSans
    sectionLabel.TextSize = 18

    return section
end

function UILibrary:CreateKeybind(parent, text, position, size, defaultKey, callback)
    local keybindFrame = Instance.new("Frame", parent)
    keybindFrame.Size = size or UDim2.new(0, 200, 0, 30)
    keybindFrame.Position = position or UDim2.new(0, 10, 0, 250)
    keybindFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    keybindFrame.BorderSizePixel = 0

    local uICorner = Instance.new("UICorner", keybindFrame)
    uICorner.CornerRadius = UDim.new(0, 10)

    local keybindButton = Instance.new("TextButton", keybindFrame)
    keybindButton.Size = UDim2.new(0.8, 0, 1, 0)
    keybindButton.Position = UDim2.new(0, 0, 0, 0)
    keybindButton.Text = text .. ": " .. defaultKey
    keybindButton.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
    keybindButton.TextColor3 = Color3.new(0, 0, 0)
    keybindButton.BorderSizePixel = 0
    keybindButton.Font = Enum.Font.SourceSans
    keybindButton.TextSize = 18

    local currentKey = defaultKey
    keybindButton.MouseButton1Click:Connect(function()
        keybindButton.Text = text .. ": ..."
        local inputConnection
        inputConnection = game:GetService("UserInputService").InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.Keyboard then
                currentKey = input.KeyCode.Name
                keybindButton.Text = text .. ": " .. currentKey
                inputConnection:Disconnect()
                if callback then
                    callback(currentKey)
                end
                end
            end
        end)
    end)

    game:GetService("UserInputService").InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode.Name == currentKey then
            if callback then
                callback(currentKey)
            end
        end
    end)

    return keybindFrame
end

function UILibrary:CreateDropdown(parent, text, options, position, size, callback)
    local dropdownFrame = Instance.new("Frame", parent)
    dropdownFrame.Size = size or UDim2.new(0, 200, 0, 30)
    dropdownFrame.Position = position or UDim2.new(0, 10, 0, 300)
    dropdownFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    dropdownFrame.BorderSizePixel = 0

    local uICorner = Instance.new("UICorner", dropdownFrame)
    uICorner.CornerRadius = UDim.new(0, 10)

    local dropdownButton = Instance.new("TextButton", dropdownFrame)
    dropdownButton.Size = UDim2.new(1, 0, 1, 0)
    dropdownButton.Text = text
    dropdownButton.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
    dropdownButton.TextColor3 = Color3.new(0, 0, 0)
    dropdownButton.BorderSizePixel = 0
    dropdownButton.Font = Enum.Font.SourceSans
    dropdownButton.TextSize = 18

    local isOpen = false
    local optionButtons = {}

    dropdownButton.MouseButton1Click:Connect(function()
        isOpen = not isOpen
        for _, optionButton in pairs(optionButtons) do
            optionButton.Visible = isOpen
        end
    end)

    for i, option in pairs(options) do
        local optionButton = Instance.new("TextButton", parent)
        optionButton.Size = size or UDim2.new(0, 200, 0, 30)
        optionButton.Position = UDim2.new(position.X.Scale, position.X.Offset, position.Y.Scale, position.Y.Offset + i * 35)
        optionButton.Text = option
        optionButton.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
        optionButton.TextColor3 = Color3.new(0, 0, 0)
        optionButton.BorderSizePixel = 0
        optionButton.Font = Enum.Font.SourceSans
        optionButton.TextSize = 18
        optionButton.Visible = false

        optionButton.MouseButton1Click:Connect(function()
            dropdownButton.Text = option
            if callback then
                callback(option)
            end
            isOpen = false
            for _, btn in pairs(optionButtons) do
                btn.Visible = false
            end
        end)

        table.insert(optionButtons, optionButton)
    end

    return dropdownFrame
end

function UILibrary:CreateSlider(parent, text, minValue, maxValue, defaultValue, position, size, callback)
    local sliderFrame = Instance.new("Frame", parent)
    sliderFrame.Size = size or UDim2.new(0, 200, 0, 60)
    sliderFrame.Position = position or UDim2.new(0, 10, 0, 350)
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
    sliderBar.Size = UDim2.new(1, -20, 0, 5)
    sliderBar.Position = UDim2.new(0.5, -((size or UDim2.new(0, 200, 0, 60)).X.Offset - 20) / 2, 0, 30)
    sliderBar.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
    sliderBar.BorderSizePixel = 0

    local sliderKnob = Instance.new("Frame", sliderBar)
    sliderKnob.Size = UDim2.new(0, 10, 2, 0)
    sliderKnob.Position = UDim2.new((defaultValue - minValue) / (maxValue - minValue), -5, -0.5, 0)
    sliderKnob.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
    sliderKnob.BorderSizePixel = 0

    local dragging = false

    local function updateSlider(input)
        local delta = input.Position.X - sliderBar.AbsolutePosition.X
        local value = math.clamp(delta / sliderBar.AbsoluteSize.X, 0, 1) * (maxValue - minValue) + minValue
        sliderKnob.Position = UDim2.new(math.clamp(delta / sliderBar.AbsoluteSize.X, 0, 1), -5, -0.5, 0)
        if callback then
            callback(value)
        end
    end

    sliderKnob.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
        end
    end)

    sliderKnob.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)

    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            updateSlider(input)
        end
    end)

    sliderBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            updateSlider(input)
        end
    end)

    return sliderFrame
end

return UILibrary
