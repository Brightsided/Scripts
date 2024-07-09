local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wizard"))()

local MainWindow = Library:NewWindow("Spin the Wheel iRhy")
local AutoSpinSection = MainWindow:NewSection("Main")
local UtilitiesSection = MainWindow:NewSection("Utilities")

local autoSpinToggleState = false
local antiAFKActive = false
local autoTicketToggleState = false
local ticketTeleportInterval = 1

local function autoSpin()
    local player = game:GetService("Players").LocalPlayer
    local spinsLabel = player:WaitForChild("PlayerGui"):WaitForChild("Spin"):WaitForChild("Frame"):WaitForChild("Spins")

    local function getSpinCount()
        local text = spinsLabel.Text
        local count = tonumber(text:match("%d+"))
        return count
    end

    local function performSpin()
        local args = {
            [1] = {}
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Assets"):WaitForChild("Events"):WaitForChild("roll"):FireServer(unpack(args))
    end

    spinsLabel:GetPropertyChangedSignal("Text"):Connect(function()
        if autoSpinToggleState and getSpinCount() > 0 then
            performSpin()
        end
    end)

    -- Initial check
    if getSpinCount() > 0 then
        performSpin()
    end

    -- Check periodically
    spawn(function()
        while autoSpinToggleState do
            wait(1)
            if getSpinCount() > 0 then
                performSpin()
            end
        end
    end)
end

-- Create toggle button for Auto-Spin
AutoSpinSection:CreateToggle("Auto-Spin", function(state)
    autoSpinToggleState = state
    if state then
        autoSpin()
    end
end)

-- Function to enable Anti-AFK
local function toggleAntiAFK(value)
    antiAFKActive = value
    if antiAFKActive then
        game.StarterGui:SetCore("SendNotification", {
            Title = "Anti-AFK",
            Text = "Anti-AFK activated",
            Duration = 5
        })

        local vu = game:GetService("VirtualUser")
        local player = game:GetService("Players").LocalPlayer

        player.Idled:Connect(function()
            vu:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
            wait(1)
            vu:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        end)
    end
end

-- Create button for Anti-AFK
UtilitiesSection:CreateButton("Anti-AFK", toggleAntiAFK)

-- Function to teleport tickets
local function teleportTickets()
    local player = game:GetService("Players").LocalPlayer
    local function performTeleport()
        local objects = workspace:GetChildren()
        for _, obj in ipairs(objects) do
            if obj:IsA("BasePart") and obj.Name == "Baseplate" then
                obj.CFrame = player.Character.HumanoidRootPart.CFrame
                wait(ticketTeleportInterval) -- Espera el tiempo definido entre cada teletransporte
            end
        end
    end

    spawn(function()
        while autoTicketToggleState do
            performTeleport()
            wait(ticketTeleportInterval) -- Espera el tiempo definido antes de iniciar otra teletransportación
        end
    end)
end

-- Create toggle button for Auto-Ticket
AutoSpinSection:CreateToggle("Auto-Ticket", function(state)
    autoTicketToggleState = state
    if state then
        teleportTickets()
    end
end)

-- Create textbox for ticket teleport interval
AutoSpinSection:CreateTextbox("Segundos", "1", true, function(value)
    local num = tonumber(value)
    if num then
        ticketTeleportInterval = num
    end
end)
