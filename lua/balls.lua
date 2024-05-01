local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

-- Fungsi untuk membuat pet
local function createPet(color)
    local pet = Instance.new("Part")
    pet.Shape = Enum.PartType.Ball
    pet.Size = Vector3.new(2, 2, 2)
    pet.Color = color
    pet.Material = Enum.Material.Neon
    pet.Anchored = true
    pet.CanCollide = false
    pet.Position = humanoidRootPart.Position + Vector3.new(0, 3, 0)  -- Memulai di atas HumanoidRootPart
    pet.Parent = game.Workspace
    pet.Name = "Pet"  -- Menambahkan nama untuk kemudahan penghapusan
    return pet
end

-- Fungsi untuk menggerakkan pet secara acak
local function movePetRandom(pet)
    while true do
        local angleXZ = math.rad(math.random(360))
        local angleY = math.rad(math.random(-30, 30))  -- Memperbolehkan pergerakan naik dan turun
        local distance = math.random(5, 10)  -- Area bergerak lebih lebar

        local xOffset = math.cos(angleXZ) * distance
        local zOffset = math.sin(angleXZ) * distance
        local yOffset = math.sin(angleY) * distance

        local newPosition = humanoidRootPart.Position + Vector3.new(xOffset, yOffset + 3, zOffset)

        local tween = TweenService:Create(pet, TweenInfo.new(2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = newPosition})
        tween:Play()
        
        wait(0.5)
    end
end

-- Fungsi untuk menangani respawn karakter
local function handleRespawn()
    character = player.Character or player.CharacterAdded:Wait()
    humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    for _, pet in ipairs(game.Workspace:GetChildren()) do
        if pet.Name == "Pet" then
            pet:Destroy()
        end
    end
end

-- Event handler untuk ketika karakter respawn
player.CharacterAdded:Connect(handleRespawn)

-- Menampilkan GUI form untuk input jumlah pet saat dijalankan
local gui = Instance.new("ScreenGui")
gui.Parent = game.Players.LocalPlayer.PlayerGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 200, 0, 150)
frame.Position = UDim2.new(1, -250, 0, 50) -- Pojok kanan atas layar
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BackgroundTransparency = 0.5
frame.BorderSizePixel = 0
frame.Active = true  -- Memungkinkan drag
frame.Draggable = true
frame.Parent = gui

local labelTitle = Instance.new("TextLabel")
labelTitle.Size = UDim2.new(1, 0, 0, 20)
labelTitle.Position = UDim2.new(0, 0, 0, 0)
labelTitle.Text = "Script By Rehan30g"
labelTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
labelTitle.BackgroundTransparency = 1
labelTitle.TextXAlignment = Enum.TextXAlignment.Center
labelTitle.Font = Enum.Font.SourceSansBold
labelTitle.Parent = frame

local labelPetCount = Instance.new("TextLabel")
labelPetCount.Size = UDim2.new(1, 0, 0, 20)
labelPetCount.Position = UDim2.new(0, 0, 0.2, 0)
labelPetCount.Text = "Enter Number of Pets:"
labelPetCount.TextColor3 = Color3.fromRGB(255, 255, 255)
labelPetCount.BackgroundTransparency = 1
labelPetCount.TextXAlignment = Enum.TextXAlignment.Center
labelPetCount.Parent = frame

local textBox = Instance.new("TextBox")
textBox.Size = UDim2.new(0.8, 0, 0, 20)
textBox.Position = UDim2.new(0.1, 0, 0.3, 0)
textBox.PlaceholderText = "Number of Pets"
textBox.Parent = frame

local buttonSpawn = Instance.new("TextButton")
buttonSpawn.Size = UDim2.new(0.8, 0, 0, 30)
buttonSpawn.Position = UDim2.new(0.1, 0, 0.5, 0)
buttonSpawn.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
buttonSpawn.Text = "Spawn Pets"
buttonSpawn.Parent = frame

local buttonRemoveAll = Instance.new("TextButton")
buttonRemoveAll.Size = UDim2.new(0.8, 0, 0, 30)
buttonRemoveAll.Position = UDim2.new(0.1, 0, 0.8, 0)
buttonRemoveAll.BackgroundColor3 = Color3.fromRGB(100, 255, 100)
buttonRemoveAll.Text = "Remove All Pets"
buttonRemoveAll.Parent = frame

-- Event handler untuk buttonSpawn
buttonSpawn.MouseButton1Click:Connect(function()
    local numPets = tonumber(textBox.Text)
    if numPets then
        for i = 1, numPets do
            local pet = createPet(Color3.fromRGB(255, 255, 0))  -- Warna kuning
            coroutine.wrap(movePetRandom)(pet)
        end
    end
end)

-- Event handler untuk buttonRemoveAll
buttonRemoveAll.MouseButton1Click:Connect(function()
    for _, pet in ipairs(game.Workspace:GetChildren()) do
        if pet.Name == "Pet" then
            pet:Destroy()
        end
    end
end)

-- Memastikan skrip berjalan saat permainan dimulai
handleRespawn()
