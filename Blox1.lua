-- [[ KA HUB | VERSÃO REFEITA PARA DELTA ]]
local function LoadScript()
    local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Rayfield/main/source'))()

    local Window = Rayfield:CreateWindow({
       Name = "KA HUB | SEA 1",
       LoadingTitle = "Iniciando...",
       ConfigurationSaving = {Enabled = false}
    })

    -- CONFIGS
    _G.AutoFarm = false
    _G.Weapon = "Melee"

    local Tab = Window:CreateTab("Farm")

    Tab:CreateToggle({
       Name = "ATIVAR AUTO FARM",
       CurrentValue = false,
       Callback = function(Value) _G.AutoFarm = Value end,
    })

    Tab:CreateDropdown({
       Name = "Arma",
       Options = {"Melee","Sword","Fruit"},
       CurrentOption = "Melee",
       Callback = function(v) _G.Weapon = v end,
    })

    -- LOOP SIMPLIFICADO (MENOS LAG)
    task.spawn(function()
        while task.wait(0.5) do
            if _G.AutoFarm then
                pcall(function()
                    local lp = game.Players.LocalPlayer
                    local level = lp.Data.Level.Value
                    local questName, questLvl, monName, monPos, questPos
                    
                    -- Lógica de Quest reduzida para teste
                    if level < 10 then
                        questName = "BanditQuest1"; questLvl = 1; monName = "Bandit"
                        questPos = CFrame.new(1059, 15, 1550); monPos = CFrame.new(1045, 27, 1560)
                    else
                        questName = "JungleQuest"; questLvl = 1; monName = "Monkey"
                        questPos = CFrame.new(-1598, 35, 153); monPos = CFrame.new(-1448, 67, 11)
                    end

                    if not lp.PlayerGui.Main.Quest.Visible then
                        lp.Character.HumanoidRootPart.CFrame = questPos
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest", questName, questLvl)
                    else
                        local enemy = workspace.Enemies:FindFirstChild(monName)
                        if enemy and enemy:FindFirstChild("Humanoid") and enemy.Humanoid.Health > 0 then
                            -- Equipar
                            local tool = lp.Backpack:FindFirstChild(_G.Weapon) or lp.Character:FindFirstChild(_G.Weapon)
                            if tool then lp.Character.Humanoid:EquipTool(tool) end
                            -- Teleport e Ataque
                            lp.Character.HumanoidRootPart.CFrame = enemy.HumanoidRootPart.CFrame * CFrame.new(0, 8, 0)
                            game:GetService("VirtualInputManager"):SendMouseButtonEvent(500, 500, 0, true, game, 0)
                            game:GetService("VirtualInputManager"):SendMouseButtonEvent(500, 500, 0, false, game, 0)
                        else
                            lp.Character.HumanoidRootPart.CFrame = monPos
                        end
                    end
                end)
            end
        end
    end)
end

-- Executa com proteção
local success, err = pcall(LoadScript)
if not success then
    warn("Erro ao carregar KA HUB: " .. tostring(err))
end
