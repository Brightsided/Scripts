local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wizard"))()

local MainWindow = Library:NewWindow("Lucky Block")
local AutoFarmSection = MainWindow:NewSection("Auto Farm")
local AutoHatchSection = MainWindow:NewSection("Auto Hatch")
local UtilidadesSection = MainWindow:NewSection("Utilidades")

-- Table to keep track of toggle states for Auto Farm
local toggleStates = {}

-- Coordinates for each area
local areaCoordinates = {
    [1] = Vector3.new(24.1456089, -34.8214111, 9.15202427),
    [2] = Vector3.new(24.1456089, -34.8214111, -60.775486),
    [3] = Vector3.new(24.1456089, -34.8214111, -130.703033),
    [4] = Vector3.new(24.1456089, -34.8214111, -200.630798),
    [5] = Vector3.new(24.1456089, -34.8214111, -270.558441),
    [6] = Vector3.new(4.18446541, -34.2809563, -344.920197)
}

for area = 1, 6 do
    local buttonName = "Area " .. area
    toggleStates[area] = false
    
    AutoFarmSection:CreateToggle(buttonName, function(state)
        toggleStates[area] = state
        if state then
            -- Start a new thread to continuously click
            spawn(function()
                local player = game:GetService("Players").LocalPlayer
                -- Teleport the player to the area coordinates
                player.Character.HumanoidRootPart.CFrame = CFrame.new(areaCoordinates[area])
                while toggleStates[area] do
                    for block = 1, 10 do
                        local path = workspace:FindFirstChild("BreakablesByArea"):FindFirstChild("Breakables" .. area):FindFirstChild("LuckyBlock" .. block):FindFirstChild("ClickDetector")
                        if path then
                            fireclickdetector(path)
                        else
                            print("ClickDetector not found for " .. buttonName .. " - LuckyBlock" .. block)
                        end
                    end
                    -- Add a small delay to prevent excessive load on the server
                    wait(0.1)
                end
            end)
        end
    end)
end

-- Table to keep track of toggle states for Auto Hatch
local hatchToggleStates = {
    ["Basic Egg"] = false,
    ["Candy Egg"] = false,
    ["Crowned Egg"] = false,
    ["ForceField Egg"] = false,
    ["Neon Egg"] = false,
    ["Rare Egg"] = false
}

local function hatchEgg(eggName)
    local args = {
        [1] = workspace:WaitForChild("Eggs"):WaitForChild(eggName)
    }
    game:GetService("ReplicatedStorage"):WaitForChild("EggHatchingRemotes"):WaitForChild("HatchServer"):InvokeServer(unpack(args))
end

for eggName, _ in pairs(hatchToggleStates) do
    AutoHatchSection:CreateToggle(eggName, function(state)
        hatchToggleStates[eggName] = state
        if state then
            spawn(function()
                while hatchToggleStates[eggName] do
                    hatchEgg(eggName)
                    -- Add a small delay to prevent excessive load on the server
                    wait(0.1)
                end
            end)
        end
    end)
end

-- Add the "Rejoin" button in UtilidadesSection
UtilidadesSection:CreateButton("Rejoin", function()
    game:GetService("TeleportService"):Teleport(game.PlaceId, game:GetService("Players").LocalPlayer)
end)
