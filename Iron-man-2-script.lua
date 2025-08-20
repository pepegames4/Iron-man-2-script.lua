local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Gui Iron Man 2 Simulator",
   Icon = 0, 
   LoadingTitle = "Iron Man 2 Script",
   LoadingSubtitle = "by anonymous#0019",
   ShowText = "Rayfield",
   Theme = "Default", 

   ToggleUIKeybind = "K", 

   DisableRayfieldPrompts = false,
   DisableBuildWarnings = false, 

   ConfigurationSaving = {
      Enabled = true,
      FolderName = nil, 
      FileName = "Big Hub"
   },

   Discord = {
      Enabled = true,
      Invite = "noinvitelink",
      RememberJoins = true 
   },

   KeySystem = true,
   KeySettings = {
      Title = "Key System",
      Subtitle = "Key System",
      Note = "No method of obtaining the key is provided", 
      FileName = "Key", 
      SaveKey = true,
      GrabKeyFromSite = false, 
      Key = {"admin"}
   }
})

-- Pestañas
local PlayerTab = Window:CreateTab("Player", 4483362458)
local SuitTab = Window:CreateTab("Traje", 6323423718)
local MovementTab = Window:CreateTab("Movimiento", 6323423718)
local TeleportTab = Window:CreateTab("Teletransporte", 204354226)

-- VARIABLES
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

local GodModePlayer = false
local GodModeArmor = false
local NoCooldownEnabled = false
local InfiniteEnergyEnabled = false
local InfiniteArmorHealthEnabled = false

local speedEnabled = false
local flyEnabled = false
local jumpEnabled = false
local flySpeed = 50
local jumpPower = 100

local isInvisible = false

-- FUNCIONES

-- GODMODE JUGADOR
local function applyGodModePlayer()
    spawn(function()
        while GodModePlayer do
            local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
            for _, h in ipairs(char:GetDescendants()) do
                if h:IsA("Humanoid") then
                    h.Health = math.huge
                    h.MaxHealth = math.huge
                end
            end
            task.wait(0.1)
        end
    end)
end

-- GODMODE TRAJE (Armor)
local function applyGodModeArmor()
    spawn(function()
        while GodModeArmor do
            local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
            for _, model in ipairs(char:GetChildren()) do
                if model:IsA("Model") then
                    local h = model:FindFirstChildOfClass("Humanoid")
                    if h then
                        h.Health = math.huge
                        h.MaxHealth = math.huge
                    end
                end
            end
            task.wait(0.1)
        end
    end)
end

-- NOCOOLDOWN (FUNCIÓN MEJORADA)
local function removeCooldowns()
    spawn(function()
        while NoCooldownEnabled do
            local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
            -- Buscar valores de cooldown en todo el personaje y su mochila
            for _, obj in ipairs(char:GetDescendants()) do
                if (obj:IsA("NumberValue") or obj:IsA("IntValue")) and string.find(string.lower(obj.Name), "cool") or string.find(string.lower(obj.Name), "delay") or string.find(string.lower(obj.Name), "rate") then
                    obj.Value = 0
                end
                -- También buscar atributos
                if pcall(function() return obj:GetAttributes() end) then
                    for attr, val in pairs(obj:GetAttributes()) do
                        if type(val) == "number" and (string.find(string.lower(attr), "cool") or string.find(string.lower(attr), "delay") or string.find(string.lower(attr), "rate")) then
                            obj:SetAttribute(attr, 0)
                        end
                    end
                end
            end
            task.wait(0.01) -- Revisa y reinicia los valores muy rápido
        end
    end)
end

-- ENERGÍA INFINITA
local function applyInfiniteEnergy()
    spawn(function()
        while InfiniteEnergyEnabled do
            local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
            
            for _, e in ipairs(char:GetDescendants()) do
                if (e:IsA("NumberValue") or e:IsA("IntValue")) and string.find(string.lower(e.Name),"energy") then
                    e.Value = e.MaxValue or math.huge
                end
            end

            for _, obj in ipairs(char:GetDescendants()) do
                if pcall(function() return obj:GetAttributes() end) then
                    for attr, val in pairs(obj:GetAttributes()) do
                        if type(val)=="number" and string.find(string.lower(attr),"energy") then
                            obj:SetAttribute(attr, math.huge)
                        end
                    end
                end
            end

            task.wait(0.05)
        end
    end)
end

-- VIDA DEL ARMOR INFINITA
local function applyInfiniteArmorHealth()
    spawn(function()
        while InfiniteArmorHealthEnabled do
            local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
            for _, model in ipairs(char:GetChildren()) do
                if model:IsA("Model") then
                    local h = model:FindFirstChildOfClass("Humanoid")
                    if h then
                        h.Health = math.huge
                        h.MaxHealth = math.huge
                    end
                end
            end
            task.wait(0.1)
        end
    end)
end

-- Llamar piezas del traje
local function callSuitEvent(eventName, partName)
    local EventsFolder = ReplicatedStorage:FindFirstChild("Events")
    if EventsFolder then
        local Event = EventsFolder:FindFirstChild(eventName)
        if Event then
            if Event:IsA("RemoteEvent") then
                Event:FireServer(partName)
            elseif Event:IsA("RemoteFunction") then
                Event:InvokeServer(partName)
            end
        end
    end
end

-- Supervelocidad
local function applySpeed()
    spawn(function()
        while speedEnabled do
            local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
            local humanoid = char:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid.WalkSpeed = 100
            end
            task.wait(0.1)
        end
        local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        local humanoid = char:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.WalkSpeed = 16 -- Valor predeterminado
        end
    end)
end

-- Supersalto
local function applySuperJump()
    spawn(function()
        while jumpEnabled do
            local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
            local humanoid = char:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid.JumpPower = 100
            end
            task.wait(0.1)
        end
        local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        local humanoid = char:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.JumpPower = 50 -- Valor predeterminado
        end
    end)
end

-- Fly
local function applyFly()
    if flyEnabled then
        local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        local root = char:FindFirstChild("HumanoidRootPart")
        if root then
            local bv = Instance.new("BodyVelocity")
            bv.MaxForce = Vector3.new(0, math.huge, 0)
            bv.Velocity = Vector3.new(0, 0, 0)
            bv.Parent = root
            
            local function updateFly()
                if flyEnabled and root and bv then
                    local input = Workspace.CurrentCamera.CFrame.lookVector
                    local vel = Vector3.new(input.X, 0, input.Z) * flySpeed
                    bv.Velocity = vel
                    task.wait()
                else
                    if bv then bv:Destroy() end
                end
            end
            game:GetService("RunService").RenderStepped:Connect(updateFly)
        end
    end
end

-- NUEVAS FUNCIONES PARA EL TRAJE
-- Función de invisibilidad MEJORADA
local function setInvisibility(is_invisible)
    local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local transparency_value = is_invisible and 1 or 0
    
    for _, part in ipairs(char:GetDescendants()) do
        if part:IsA("BasePart") then
            part.Transparency = transparency_value
        end
    end
    
    for _, child in ipairs(char:GetChildren()) do
        if child:IsA("Model") and child:FindFirstChildOfClass("Humanoid") then
            for _, part in ipairs(child:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.Transparency = transparency_value
                end
            end
        end
    end
end

-- Función para reparar la armadura (MEJORADA)
local function repairArmor()
    local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    for _, obj in ipairs(char:GetDescendants()) do
        if obj:IsA("Humanoid") then
            obj.Health = obj.MaxHealth -- Repara la salud del humanoide
        elseif (obj:IsA("NumberValue") or obj:IsA("IntValue")) then
            local name = string.lower(obj.Name)
            if string.find(name, "health") or string.find(name, "armor") or string.find(name, "durability") then
                obj.Value = obj.MaxValue or math.huge
            end
        end
        -- También revisa atributos
        if pcall(function() return obj:GetAttributes() end) then
            for attr, val in pairs(obj:GetAttributes()) do
                if type(val) == "number" and (string.find(string.lower(attr), "health") or string.find(string.lower(attr), "armor") or string.find(string.lower(attr), "durability")) then
                    obj:SetAttribute(attr, math.huge)
                end
            end
        end
    end
end

-- Función para teletransportar
local function teleportPlayer(position)
    local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local humanoidRootPart = char:FindFirstChild("HumanoidRootPart")
    if humanoidRootPart then
        humanoidRootPart.CFrame = CFrame.new(position)
    end
end

-- ===================================
-- CREACIÓN DE LA INTERFAZ
-- ===================================

-- Pestaña Player
PlayerTab:CreateToggle({
    Name = "GodMode Jugador",
    CurrentValue = false,
    Flag = "GodModePlayerToggle",
    Callback = function(Value)
        GodModePlayer = Value
        if GodModePlayer then applyGodModePlayer() end
    end
})

PlayerTab:CreateToggle({
    Name = "GodMode Armor",
    CurrentValue = false,
    Flag = "GodModeArmorToggle",
    Callback = function(Value)
        GodModeArmor = Value
        if GodModeArmor then applyGodModeArmor() end
    end
})

PlayerTab:CreateToggle({
    Name = "NoCooldown",
    CurrentValue = false,
    Flag = "NoCooldownToggle",
    Callback = function(Value)
        NoCooldownEnabled = Value
        if NoCooldownEnabled then removeCooldowns() end
    end
})

PlayerTab:CreateToggle({
    Name = "Energía Infinita",
    CurrentValue = false,
    Flag = "InfiniteEnergyToggle",
    Callback = function(Value)
        InfiniteEnergyEnabled = Value
        if InfiniteEnergyEnabled then applyInfiniteEnergy() end
    end
})

PlayerTab:CreateToggle({
    Name = "Vida Armor Infinita",
    CurrentValue = false,
    Flag = "InfiniteArmorHealthToggle",
    Callback = function(Value)
        InfiniteArmorHealthEnabled = Value
        if InfiniteArmorHealthEnabled then applyInfiniteArmorHealth() end
    end
})

-- Pestaña Traje
local suitParts = {"Torso", "Helmet", "Arms", "Legs", "Traje Completo"}
for _, part in ipairs(suitParts) do
    SuitTab:CreateButton({
        Name = "Llamar "..part,
        Callback = function()
            local eventName = (part == "Traje Completo") and "RequestSuit" or "CallPiece"
            callSuitEvent(eventName, part)
        end
    })
end

-- Nuevas funciones de la armadura añadidas aquí
SuitTab:CreateToggle({
    Name = "Modo Invisible",
    CurrentValue = false,
    Flag = "InvisibleToggle",
    Callback = function(Value)
        isInvisible = Value
        setInvisibility(isInvisible)
    end
})

SuitTab:CreateButton({
    Name = "Reparar Armadura",
    Callback = function()
        repairArmor()
    end
})

-- Pestaña Movimiento
MovementTab:CreateToggle({
    Name = "Supervelocidad",
    CurrentValue = false,
    Callback = function(Value)
        speedEnabled = Value
        applySpeed()
    end
})

MovementTab:CreateToggle({
    Name = "Supersalto",
    CurrentValue = false,
    Callback = function(Value)
        jumpEnabled = Value
        applySuperJump()
    end
})

MovementTab:CreateToggle({
    Name = "Fly",
    CurrentValue = false,
    Callback = function(Value)
        flyEnabled = Value
        applyFly()
    end
})

MovementTab:CreateSlider({
    Name = "Velocidad de Vuelo",
    Min = 10,
    Max = 200,
    Default = 50,
    Callback = function(Value)
        flySpeed = Value
    end
})

-- Pestaña Teletransporte
TeleportTab:CreateButton({
    Name = "Teleport a la Base",
    Callback = function()
        -- Cambia las coordenadas aquí (por ejemplo, a la ubicación de la base del juego)
        local base_coordinates = Vector3.new(0, 100, 0)
        teleportPlayer(base_coordinates)
    end
})
