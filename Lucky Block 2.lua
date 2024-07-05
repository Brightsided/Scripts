local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wizard"))()

local MainWindow = Library:NewWindow("Lucky Block 2")
local AutoFarmSection = MainWindow:NewSection("Auto Farm")
local AutoHatchSection = MainWindow:NewSection("Auto Hatch")
local UtilidadesSection = MainWindow:NewSection("Utilidades")

-- Coordinates for each area
local areaCoordinates = {
    ["Area 1"] = Vector3.new(-194.661118, 11.9455223, -120.924423),
    ["Area 2"] = Vector3.new(-198.76480102539062, 11.94552230834961, 27.807723999023438),
    ["Area 3"] = Vector3.new(-202.383423, 11.9455223, 148.348022),
    ["Area 4"] = Vector3.new(-195.9127960205078, 11.94552230834961, 287.0411071777344),
    ["Area 5"] = Vector3.new(-197.22796630859375, 11.94552230834961, 416.60159301757819),
    ["Area 6"] = Vector3.new(-198.5159149169922, 11.94552230834961, 544.7833251953125),
    ["Area 7"] = Vector3.new(-197.2288360595703, 11.94552230834961, 682.9889526367188),
    ["Area 8"] = Vector3.new(-199.7462158203125, 11.94552230834961, 815.8792114257812),
    ["Area 9"] = Vector3.new(-199.4909210205078,11.945526123046875,960.5406494140625),
    ["Area 10"] = Vector3.new(-194.37466430664062,11.94552230834961,1086.7386474609375)
}

local selectedArea = "Area 1"  -- Set a default area
local farmToggleState = false

-- Create dropdown for area selection
AutoFarmSection:CreateDropdown("Select Area", {"Area 1", "Area 2", "Area 3", "Area 4", "Area 5", "Area 6", "Area 7", "Area 8", "Area 9", "Area 10"}, 1, function(selected)
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
                    for block = 1, 15 do
                        local path = workspace:FindFirstChild("BreakablesByArea"):FindFirstChild("Breakables" .. selectedArea:match("%d+")):FindFirstChild("LuckyBlock" .. block):FindFirstChild("ClickDetector")
                        if path then
                            fireclickdetector(path)
                        else
                            print("ClickDetector not found for " .. selectedArea .. " - LuckyBlock" .. block)
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

AutoFarmSection:CreateTextbox("Max Damage", function(text)
    local player = game:GetService("Players").LocalPlayer
    local newDamageValue = tonumber(text)
    if newDamageValue then
        player.Data.PlayerData.Damage.Value = newDamageValue
    else
        print("Invalid input. Please enter a number.")
    end
end)

-- Table to keep track of available eggs
local availableEggs = {
    "Starter Egg",
    "Dessert Egg",
    "Neon Egg",
    "Candy Egg",
    "ForceField Egg",
    "Crowned Egg",
    "Rich Egg",
    "Snow Egg",
    "Hell Egg",
    "Angel Egg"
}

local selectedEgg = "Starter Egg"  -- Set a default egg
local hatchToggleState = false

-- Create dropdown for egg selection
AutoHatchSection:CreateDropdown("Select Egg", availableEggs, 1, function(selected)
    selectedEgg = selected
end)

-- Create toggle button for hatching the selected egg
AutoHatchSection:CreateToggle("Hatch Egg", function(state)
    hatchToggleState = state
    if state then
        spawn(function()
            while hatchToggleState do
                local args = {
                    [1] = selectedEgg,
                    [2] = 1
                }
                game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Egg"):InvokeServer(unpack(args))
                wait(0.1)
            end
        end)
    end
end)

-- Add the "Rejoin" button in UtilidadesSection
UtilidadesSection:CreateButton("Rejoin", function()
    game:GetService("TeleportService"):Teleport(game.PlaceId, game:GetService("Players").LocalPlayer)
end)

UtilidadesSection:CreateToggle("Rebirth", function(state)
    rebirthToggleState = state
    if state then
        spawn(function()
            while rebirthToggleState do
                game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Rebirth"):FireServer()
                wait(1)
            end
        end)
    end
end)