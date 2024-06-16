local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")

local BASE_HEIGHT = 70 -- The main height factor for the terrain.
local CHUNK_SCALE = 10 -- The grid scale for terrain generation. Should be kept relatively low if used in real-time.
local INITIAL_RENDER_DISTANCE = 2 -- The initial render distance in chunks.
local RENDER_INCREMENT = 1 -- How much to increase render distance each step.
local X_SCALE = 90 -- How much we should stretch the X scale of the generation noise.
local Z_SCALE = 90 -- How much we should stretch the Z scale of the generation noise.
local GENERATION_SEED = math.random() -- Seed for determining the main height map of the terrain.
local TERRAIN_TYPE = Enum.Material.Grass -- Terrain Type
local LOD_DISTANCE = 200 -- Distance beyond which we use LOD impostors
local CHUNK_BATCH_SIZE = 5 -- Number of chunks to generate per batch

local chunks = {} -- Table to store chunk locations.
local renderDistance = INITIAL_RENDER_DISTANCE -- Current render distance.

-- Disable fog
Lighting.FogEnd = 1000000

-- Checks if a chunk exists at the specified location.
local function chunkExists(chunkX, chunkZ)
    if not chunks[chunkX] then
        chunks[chunkX] = {}
    end
    return chunks[chunkX][chunkZ]
end

-- Generates terrain for a single layer.
local function mountLayer(x, heightY, z, material)
    local beginY = -BASE_HEIGHT
    local endY = heightY
    local cframe = CFrame.new(x * 4 + 2, (beginY + endY) * 4 / 2, z * 4 + 2)
    local size = Vector3.new(4, (endY - beginY) * 4, 4)
    workspace.Terrain:FillBlock(cframe, size, material)
end

-- Prepares values for terrain generation.
function makeChunk(chunkX, chunkZ)
    local rootPosition = Vector3.new(chunkX * CHUNK_SCALE, 0, chunkZ * CHUNK_SCALE)
    chunks[chunkX][chunkZ] = true -- Acknowledge the chunk's existence.
    for x = 0, CHUNK_SCALE - 1 do
        for z = 0, CHUNK_SCALE - 1 do
            local cx = (chunkX * CHUNK_SCALE) + x
            local cz = (chunkZ * CHUNK_SCALE) + z
            local noise = math.noise(GENERATION_SEED, cx / X_SCALE, cz / Z_SCALE)
            local cy = noise * BASE_HEIGHT
            mountLayer(cx, cy, cz, TERRAIN_TYPE) -- Sends values to mountLayer function.
        end
    end
end

-- Generates a simple LOD impostor
local function makeLOD(chunkX, chunkZ)
    local cframe = CFrame.new(chunkX * CHUNK_SCALE * 4 + 2, 0, chunkZ * CHUNK_SCALE * 4 + 2)
    local size = Vector3.new(CHUNK_SCALE * 4, BASE_HEIGHT * 2, CHUNK_SCALE * 4)
    workspace.Terrain:FillBlock(cframe, size, Enum.Material.Slate) -- Simple placeholder material
end

-- Generates chunks in a spiral pattern.
local function generateChunksInSpiral(playerPosition)
    local chunkX, chunkZ = math.floor(playerPosition.X / 4 / CHUNK_SCALE), math.floor(playerPosition.Z / 4 / CHUNK_SCALE)
    local radius = 0
    while true do
        local batch = {}
        for dx = -radius, radius do
            for dz = -radius, radius do
                if math.abs(dx) == radius or math.abs(dz) == radius then
                    local cx = chunkX + dx
                    local cz = chunkZ + dz
                    if not chunkExists(cx, cz) then
                        table.insert(batch, {cx, cz})
                    end
                end
            end
        end
        for _, chunk in pairs(batch) do
            local cx, cz = unpack(chunk)
            if (cx - chunkX)^2 + (cz - chunkZ)^2 > LOD_DISTANCE^2 then
                makeLOD(cx, cz)
            else
                makeChunk(cx, cz)
            end
        end
        wait(0.1) -- Slight delay to prevent lag.
        radius = radius + 1
    end
end

-- Main Loop
while true do
    for _, player in pairs(Players:GetPlayers()) do
        if player.Character then
            local humanoidRootPart = player.Character:FindFirstChild("HumanoidRootPart")
            if humanoidRootPart then
                -- Generate chunks in a spiral pattern around the player.
                coroutine.wrap(generateChunksInSpiral)(humanoidRootPart.Position)
            end
        end
    end
    wait(1)
end
