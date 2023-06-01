local heatseeker = COB("Blatant", {
    ["Name"]  = "heatseeker",
    ["Function"] = function(callback)
        if callback then
            ScriptSettings.heatseeker = true
            pcall(function()
                while task.wait(0.1) do
                    if not ScriptSettings.heatseeker == true then return end
                    local Players = game:GetService("Players")
                    local LocalPlayer = Players.LocalPlayer
                    local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()

                    local Humanoid = Character:WaitForChild("Humanoid")

                    Humanoid.WalkSpeed = 23
                    task.wait(1.8)
                    local Players = game:GetService("Players")
                    local LocalPlayer = Players.LocalPlayer
                    local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()

                    local Humanoid = Character:WaitForChild("Humanoid")

                    Humanoid.WalkSpeed = 65
                    task.wait(0.06)
                    local Players = game:GetService("Players")
                    local LocalPlayer = Players.LocalPlayer
                    local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()

                    local Humanoid = Character:WaitForChild("Humanoid")

                    Humanoid.WalkSpeed = 0
                    task.wait(0.2)
                    ScriptSettings.heatseeker = false
                    break
                end
            end)
        else
            pcall(function()
            end)
        end
    end,
    ["Default"] = false,
    ["HoverText"] = "idk made it personal it kinda funky lol BTW RUSHED WORK NOT PERFECT STILL TRYING TO WORK ON IT"
})