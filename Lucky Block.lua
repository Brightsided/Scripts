local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wizard"))()

local MainWindow = Library:NewWindow("Lucky Block")
local AutoFarmSection = MainWindow:NewSection("Auto Farm")
local AutoHatchSection = MainWindow:NewSection("Auto Hatch")
local UtilidadesSection = MainWindow:NewSection("Utilidades")

-- Coordinates for each area
local areaCoordinates = {
    ["Area 1"] = Vector3.new(24.1456089, -34.8214111, 9.15202427),
    ["Area 2"] = Vector3.new(24.1456089, -34.8214111, -60.775486),
    ["Area 3"] = Vector3.new(24.1456089, -34.8214111, -130.703033),
    ["Area 4"] = Vector3.new(24.1456089, -34.8214111, -200.630798),
    ["Area 5"] = Vector3.new(24.1456089, -34.8214111, -270.558441),
    ["Area 6"] = Vector3.new(4.18446541, -34.2809563, -344.920197),
    ["Area 7"] = Vector3.new(4.18446541, -34.2809563, -414.847748),
    ["Area 8"] = Vector3.new(3.49069142, -33.8389282, -481.339081),
    ["Area 9"] = Vector3.new(0.179259002, -33.8389282, -550.071106),
}

local selectedArea = "Area 1"  -- Set a default area
local farmToggleState = false

-- Create dropdown for area selection
AutoFarmSection:CreateDropdown("Select Area", {"Area 1", "Area 2", "Area 3", "Area 4", "Area 5", "Area 6", "Area 7", "Area 8", "Area 9"}, 1, function(selected)
    selectedArea = selected
end)

-- Create toggle button for farming
AutoFarmSection:CreateToggle("Farm", function(state)
    farmToggleState = state
    if state then
        -- Start a new thread to continuously click
        spawn(function()
            local player = game:GetService("Players").LocalPlayer
            -- Teleport the player to the area coordinates
            local areaPosition = areaCoordinates[selectedArea]
            if areaPosition then
                player.Character.HumanoidRootPart.CFrame = CFrame.new(areaPosition)
                while farmToggleState do
                    for block = 1, 10 do
                        local path = workspace:FindFirstChild("BreakablesByArea"):FindFirstChild("Breakables" .. selectedArea:match("%d+")):FindFirstChild("LuckyBlock" .. block):FindFirstChild("ClickDetector")
                        if path then
                            fireclickdetector(path)
                        else
                            print("ClickDetector not found for " .. selectedArea .. " - LuckyBlock" .. block)
                        end
                    end
                    -- Click the Lucky Block Boss in Areas 8 and 9
                    local areaNumber = tonumber(selectedArea:match("%d+"))
                    if areaNumber == 8 or areaNumber == 9 then
                        local bossPath = workspace:FindFirstChild("BreakablesByArea"):FindFirstChild("Breakables" .. areaNumber):FindFirstChild("LuckyBlockBoss"):FindFirstChild("ClickDetector")
                        if bossPath then
                            fireclickdetector(bossPath)
                        else
                            print("ClickDetector not found for " .. selectedArea .. " - LuckyBlockBoss")
                        end
                    end
                    -- Add a small delay to prevent excessive load on the server
                    wait(0.1)
                end
            else
                print("Invalid area selected: " .. selectedArea)
            end
        end)
    end
end)

-- Table to keep track of available eggs
local availableEggs = {
    "Basic Egg",
    "Candy Egg",
    "Crowned Egg",
    "ForceField Egg",
    "Neon Egg",
    "Rare Egg",
    "Rich Egg",
    "Snow Egg",
    "Golden Snow Egg",
    "Hell Egg"
}

local selectedEgg = "Basic Egg"  -- Set a default egg

-- Create dropdown for egg selection
AutoHatchSection:CreateDropdown("Select Egg", availableEggs, 1, function(selected)
    selectedEgg = selected
end)

-- Create button for hatching the selected egg
AutoHatchSection:CreateButton("Hatch Egg", function()
    spawn(function()
        local args = {
            [1] = workspace:WaitForChild("Eggs"):WaitForChild(selectedEgg)
        }
        game:GetService("ReplicatedStorage"):WaitForChild("EggHatchingRemotes"):WaitForChild("HatchServer"):InvokeServer(unpack(args))
        wait(0.1)
    end)
end)

-- Add the "Rejoin" button in UtilidadesSection
UtilidadesSection:CreateButton("Rejoin", function()
    game:GetService("TeleportService"):Teleport(game.PlaceId, game:GetService("Players").LocalPlayer)
end)
