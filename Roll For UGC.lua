local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wizard"))()

local CoinFlipRNGWindow = Library:NewWindow("CoinFlip RNG")
local CoinFlipRNGSection = CoinFlipRNGWindow:NewSection("Main Options")

-- Variable para controlar el bucle de clic de dinero
local clickMoneyActive = false

-- Función para activar/desactivar el clic de dinero
local function toggleClickMoney(value)
    clickMoneyActive = value
    while clickMoneyActive do
        game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("SendClickForCash"):InvokeServer()
        wait(0.1)  -- Ajusta este valor para cambiar la velocidad del clic
    end
end

-- Crear Toggle para clic de dinero
CoinFlipRNGSection:CreateToggle("Auto Click Money", toggleClickMoney)

-- Variable para controlar el bucle de Auto-Dado
local autoRollActive = false

-- Función para activar/desactivar el Auto-Dado
local function toggleAutoRoll(value)
    autoRollActive = value
    while autoRollActive do
        game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("InitiateRoll"):InvokeServer()
        wait(0.1)  -- Ajusta este valor para cambiar la velocidad del comando
    end
end

-- Crear Toggle para Auto-Dado
CoinFlipRNGSection:CreateToggle("Auto-Dado", toggleAutoRoll)

-- Variable para controlar el bucle de Auto Vender Items
local autoSellItemsActive = false

-- Función para activar/desactivar el Auto Vender Items
local function toggleAutoSellItems(value)
    autoSellItemsActive = value
    while autoSellItemsActive do
        local args = {
            [1] = {
                [1] = "Common",
                [2] = "Uncommon",
                [3] = "Epic",
                [4] = "Rare",
                [5] = "Legendary",
                [6] = "Mythical",
                [7] = "Unique",
                [8] = "Cosmic",
                [9] = "Godly"
            },
            [2] = false
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("MassSellRarities"):InvokeServer(unpack(args))
        wait(60)  -- Ejecutar cada 60 segundos
    end
end

-- Crear Toggle para Auto Vender Items
CoinFlipRNGSection:CreateToggle("Auto vender items", toggleAutoSellItems)

-- Función para evitar la inactividad (Anti-AFK)
local antiAFKActive = false
local vu = game:GetService("VirtualUser")
local player = game:GetService("Players").LocalPlayer

local function toggleAntiAFK(value)
    antiAFKActive = value
    if antiAFKActive then
        player.Idled:Connect(function()
            vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
            wait(1)
            vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
        end)
    end
end

-- Crear botón para Anti-AFK
CoinFlipRNGSection:CreateButton("Anti-AFK", toggleAntiAFK)
