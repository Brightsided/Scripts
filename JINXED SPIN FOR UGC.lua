local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wizard"))()

local MainWindow = Library:NewWindow("JINXED SPIN FOR UGC")
local AutoSpinSection = MainWindow:NewSection("Auto-Spin")
local UtilitiesSection = MainWindow:NewSection("Utilities")

local autoSpinToggleState = false
local antiAFKActive = false

-- Function to perform the spin action
local function autoSpin()
    spawn(function()
        while autoSpinToggleState do
            local player = game:GetService("Players").LocalPlayer
            local spins = player:WaitForChild("Stats"):WaitForChild("Spins")

            if spins.Value > 0 then
                local args = {
                    [1] = false
                }
                game:GetService("ReplicatedStorage"):WaitForChild("RemoteFunctions"):WaitForChild("SpinFunction"):InvokeServer(unpack(args))
            else
                print("Esperando Spins 👀-Made By:brightside6975")
            end

            wait(1)  -- Wait 10 seconds before checking again
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
