-- [[ KA HUB | BLOX FRUITS PRO - FULL SEA 1 + AUTO HAKI ]]
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- // CONFIGURAÇÕES
local Config = {
    AutoFarm = false,
    AutoStats = false,
    AutoBuso = false,
    Weapon = "Melee",
    StatFocus = "Melee",
    Distance = 8
}

local LP = game:GetService("Players").LocalPlayer
local RS = game:GetService("ReplicatedStorage")
local VIM = game:GetService("VirtualInputManager")

-- // ANTI-AFK
local VirtualUser = game:GetService("VirtualUser")
LP.Idled:Connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new())
end)

-- // BOTÃO FLUTUANTE
local ScreenGui = Instance.new("ScreenGui")
local OpenBtn = Instance.new("ImageButton")
local Corner = Instance.new("UICorner")
ScreenGui.Parent = game:GetService("CoreGui")
OpenBtn.Parent = ScreenGui
OpenBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
OpenBtn.Position = UDim2.new(0.12, 0, 0.15, 0)
OpenBtn.Size = UDim2.new(0, 45, 0, 45)
OpenBtn.Image = "rbxassetid://6031280993"
OpenBtn.Draggable = true
OpenBtn.Active = true
Corner.CornerRadius = UDim.new(0, 50)
Corner.Parent = OpenBtn
OpenBtn.MouseButton1Click:Connect(function()
    VIM:SendKeyEvent(true, Enum.KeyCode.RightControl, false, game)
    task.wait(0.05)
    VIM:SendKeyEvent(false, Enum.KeyCode.RightControl, false, game)
end)

-- // TABELA DE MISSÕES COMPLETA (SEA 1)
local function GetQuest()
    local lvl = LP.Data.Level.Value
    if lvl < 10 then
        return "BanditQuest1", 1, "Bandit", CFrame.new(1059, 15, 1550), CFrame.new(1045, 27, 1560)
    elseif lvl < 15 then
        return "JungleQuest", 1, "Monkey", CFrame.new(-1598, 35, 153), CFrame.new(-1448, 67, 11)
    elseif lvl < 30 then
        return "JungleQuest", 2, "Gorilla", CFrame.new(-1598, 35, 153), CFrame.new(-1129, 40, -525)
    elseif lvl < 40 then
        return "BuggyQuest1", 1, "Pirate", CFrame.new(-1141, 4, 3831), CFrame.new(-1103, 13, 3896)
    elseif lvl < 60 then
        return "BuggyQuest1", 2, "Brute", CFrame.new(-1141, 4, 3831), CFrame.new(-1140, 15, 4322)
    elseif lvl < 75 then
        return "DesertQuest", 1, "Desert Bandit", CFrame.new(894, 5, 4392), CFrame.new(924, 6, 4481)
    elseif lvl < 90 then
        return "DesertQuest", 2, "Desert Officer", CFrame.new(894, 5, 4392), CFrame.new(1608, 8, 4371)
    elseif lvl < 100 then
        return "SnowQuest", 1, "Snow Bandit", CFrame.new(1389, 88, -1298), CFrame.new(1354, 87, -1393)
    elseif lvl < 120 then
        return "SnowQuest", 2, "Snowman", CFrame.new(1389, 88, -1298), CFrame.new(1201, 144, -1550)
    elseif lvl < 150 then
        return "MarineQuest2", 1, "Chief Petty Officer", CFrame.new(-5039, 27, 4324), CFrame.new(-4881, 22, 4273)
    elseif lvl < 175 then
        return "SkyQuest", 1, "Sky Bandit", CFrame.new(-4839, 716, -2619), CFrame.new(-4953, 295, -2899)
    elseif lvl < 190 then
        return "SkyQuest", 2, "Dark Master", CFrame.new(-4839, 716, -2619), CFrame.new(-5259, 391, -2229)
    elseif lvl < 210 then
        return "PrisonerQuest", 1, "Prisoner", CFrame.new(5308, 1, 475), CFrame.new(5098, 0, 474)
    elseif lvl < 250 then
        return "PrisonerQuest", 2, "Dangerous Prisoner", CFrame.new(5308, 1, 475), CFrame.new(5654, 15, 866)
    elseif lvl < 275 then
        return "ColosseumQuest", 1, "Toga Warrior", CFrame.new(-1580, 6, -2986), CFrame.new(-1820, 51, -2740)
    elseif lvl < 300 then
        return "ColosseumQuest", 2, "Gladiator", CFrame.new(-1580, 6, -2986), CFrame.new(-1292, 56, -3339)
    else
        return "FountainQuest", 1, "Galley Pirate", CFrame.new(5259, 37, 4050), CFrame.new(5551, 78, 3930)
    end
end

-- // JANELA RAYFIELD
local Window = Rayfield:CreateWindow({
   Name = "KA HUB | Blox Fruits PRO V8",
   LoadingTitle = "Iniciando Sea 1 Edition...",
   ConfigurationSaving = { Enabled = false }
})

local TabFarm = Window:CreateTab("Auto Farm")
local TabCombat = Window:CreateTab("Combate")
local TabStats = Window:CreateTab("Stats")

-- FARM
TabFarm:CreateToggle({
   Name = "AUTO FARM LEVEL",
   CurrentValue = false,
   Callback = function(v) Config.AutoFarm = v end,
})

TabFarm:CreateDropdown({
   Name = "Arma Principal",
   Options = {"Melee", "Sword", "Fruit"},
   CurrentOption = "Melee",
   Callback = function(v) Config.Weapon = v end,
})

-- COMBATE
TabCombat:CreateToggle({
   Name = "Auto Haki (Buso)",
   CurrentValue = false,
   Callback = function(v) Config.AutoBuso = v end,
})

-- STATS
TabStats:CreateToggle({
   Name = "Auto Stats",
   CurrentValue = false,
   Callback = function(v) Config.AutoStats = v end,
})

TabStats:CreateDropdown({
   Name = "Focar em:",
   Options = {"Melee", "Defense", "Sword", "Blox Fruit"},
   CurrentOption = "Melee",
   Callback = function(v) Config.StatFocus = v end,
})

-- // LOOP CORE
task.spawn(function()
    while task.wait() do
        if Config.AutoFarm then
            pcall(function()
                -- Ativa Haki se configurado
                if Config.AutoBuso and not LP.Character:FindFirstChild("HasBuso") then
                    RS.Remotes.CommF_:InvokeServer("Buso")
                end
                
                local qName, qLvl, mName, qPos, mPos = GetQuest()
                if not LP.PlayerGui.Main.Quest.Visible then
                    LP.Character.HumanoidRootPart.CFrame = qPos
                    RS.Remotes.CommF_:InvokeServer("StartQuest", qName, qLvl)
                else
                    local enemy = workspace.Enemies:FindFirstChild(mName)
                    if enemy and enemy:FindFirstChild("Humanoid") and enemy.Humanoid.Health > 0 then
                        local tool = LP.Backpack:FindFirstChild(Config.Weapon) or LP.Character:FindFirstChild(Config.Weapon)
                        if tool then LP.Character.Humanoid:EquipTool(tool) end
                        LP.Character.HumanoidRootPart.CFrame = enemy.HumanoidRootPart.CFrame * CFrame.new(0, Config.Distance, 0) * CFrame.Angles(math.rad(-90), 0, 0)
                        VIM:SendMouseButtonEvent(500, 500, 0, true, game, 0)
                        VIM:SendMouseButtonEvent(500, 500, 0, false, game, 0)
                    else
                        LP.Character.HumanoidRootPart.CFrame = mPos
                    end
                end
            end)
        end
    end
end)

-- LOOP STATS
task.spawn(function()
    while task.wait(1.5) do
        if Config.AutoStats then
            local p = LP.Data.StatsPoints.Value
            if p > 0 then
                RS.Remotes.CommF_:InvokeServer("AddPoint", Config.StatFocus, p)
            end
        end
    end
end)

Rayfield:Notify({Title = "KA HUB PRO", Content = "Script Pronto para Farmar Sea 1!", Duration = 5})
