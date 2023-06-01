--LEAKED BY ALLAHLEAKS
if not isfolder("MemzWare") then
    makefolder("MemzWare")
    makefolder("MemzWare/Assets")
    makefolder("MemzWare/Sound")
    makefolder("MemzWare/Sound/mc")
end

        --defining the UiLib
        local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/AllahbloxLeaks/MemzwareAllahLeak/main/UiLib.lua'))()

        --loading menu
        local Window = Rayfield:CreateWindow({
            Name = "AllahWare | 1.0",
            LoadingTitle = "Loading... (join allahleaks discord https://discord.gg/EYV5j93n)",
            LoadingSubtitle = "by Allah",
            ConfigurationSaving = {
                Enabled = true,
                FolderName = "MemzWare",
                FileName = "ConfigurationBedwars"
            },
            KeySystem = true,
            KeySettings = {
                Title = "Allah | 1.0",
                Subtitle = "Allah System",
                Note = "Enter the key you were whitelisted with!",
                FileName = "KSNlknKLSkw20sKSskmlKSlilSmx",
                SaveKey = true,
                GrabKeyFromSite = false,
                Key = "Allah"
            }
        })

        --notifs
        --examples 
        --[[Notification.new("error", "Disabled", "modules has been disabled!.") -- Args(<string> Type, <string> Heading, <string> Body, <boolean?> AutoRemoveNotif, <number?> AutoRemoveTime, <function?> OnCloseFunction)
        Notification.new("success", "Enabled", "modules has been enabled!.", 1) -- Args(<string> Type, <string> Heading, <string> Body, <boolean?> AutoRemoveNotif, <number?> AutoRemoveTime, <function?> OnCloseFunction)
        Notification.new("info", "Disabling", "Disabling anticheat dont move.") -- Args(<string> Type, <string> Heading, <string> Body, <boolean?> AutoRemoveNotif, <number?> AutoRemoveTime, <function?> OnCloseFunction)
        Notification.new("warning", "YOu died", "Imagine dying bozo.") -- Args(<string> Type, <string> Heading, <string> Body, <boolean?> AutoRemoveNotif, <number?> AutoRemoveTime, <function?> OnCloseFunction)
        Notification.new("message", "Message Heading", "Message body message.") -- Args(<string> Type, <string> Heading, <string> Body, <boolean?> AutoRemoveNotif, <number?> AutoRemoveTime, <function?> OnCloseFunction)
        ]]
        local Notification = loadstring(game:HttpGet('https://raw.githubusercontent.com/AllahbloxLeaks/MemzwareAllahLeak/main/Notifs.lua'))()

        --end of notifications

        --creating tabs
        --examples of tab - local Tab = Window:CreateTab("Tab Example", 4483362458) -- Title, Image
        local Combat = Window:CreateTab("Combat")
        local Blatant = Window:CreateTab("Blatant")
        local Visuals = Window:CreateTab("Visuals")
        --end of creating tabs

        --locals
        local lplr = game:GetService("Players").LocalPlayer
        local cam = game:GetService("Workspace").CurrentCamera
        local uis = game:GetService("UserInputService")
        local KnitClient = debug.getupvalue(require(lplr.PlayerScripts.TS.knit).setup, 6)
        local Client = require(game:GetService("ReplicatedStorage").TS.remotes).default.Client
        local getremote = function(tab)
            for i,v in pairs(tab) do
                if v == "Client" then
                    return tab[i + 1]
                end
            end
            return ""
        end
        local bedwars = {
            ["SprintController"] = KnitClient.Controllers.SprintController,
            ["ClientHandlerStore"] = require(lplr.PlayerScripts.TS.ui.store).ClientStore,
            ["KnockbackUtil"] = require(game:GetService("ReplicatedStorage").TS.damage["knockback-util"]).KnockbackUtil,
            ["PingController"] = require(lplr.PlayerScripts.TS.controllers.game.ping["ping-controller"]).PingController,
            ["DamageIndicator"] = KnitClient.Controllers.DamageIndicatorController.spawnDamageIndicator,
            ["SwordController"] = KnitClient.Controllers.SwordController,
            ["ViewmodelController"] = KnitClient.Controllers.ViewmodelController,
            ["SwordRemote"] = getremote(debug.getconstants((KnitClient.Controllers.SwordController).attackEntity)),
        }

        --functions
        function isalive(plr)
            plr = plr or lplr
            if not plr.Character then return false end
            if not plr.Character:FindFirstChild("Head") then return false end
            if not plr.Character:FindFirstChild("Humanoid") then return false end
            return true
        end
        function canwalk(plr)
            plr = plr or lplr
            if not plr.Character then return false end
            if not plr.Character:FindFirstChild("Humanoid") then return false end
            local state = plr.Character:FindFirstChild("Humanoid"):GetState()
            if state == Enum.HumanoidStateType.Dead then
                return false
            end
            if state == Enum.HumanoidStateType.Ragdoll then
                return false
            end
            return true
        end
        function getbeds()
            local beds = {}
            for i,v in pairs(game:GetService("Workspace"):GetChildren()) do
                if string.lower(v.Name) == "bed" and v:FindFirstChild("Covers") ~= nil and v:FindFirstChild("Covers").Color ~= lplr.Team.TeamColor then
                    table.insert(beds,v)
                end
            end
            return beds
        end
        function getplayers()
            local players = {}
            for i,v in pairs(game:GetService("Players"):GetPlayers()) do
                if v.Team ~= lplr.Team and isalive(v) and v.Character:FindFirstChild("Humanoid").Health > 0.11 then
                    table.insert(players,v)
                end
            end
            return players
        end
        function getserverpos(Position)
            local x = math.round(Position.X/3)
            local y = math.round(Position.Y/3)
            local z = math.round(Position.Z/3)
            return Vector3.new(x,y,z)
        end
        function getnearestplayer(maxdist)
            local obj = lplr
            local dist = math.huge
            for i,v in pairs(game:GetService("Players"):GetChildren()) do
                if v.Team ~= lplr.Team and v ~= lplr and isalive(v) and isalive(lplr) then
                    local mag = (v.Character:FindFirstChild("HumanoidRootPart").Position - lplr.Character:FindFirstChild("HumanoidRootPart").Position).Magnitude
                    if (mag < dist) and (mag < maxdist) then
                        dist = mag
                        obj = v
                    end
                end
            end
            return obj
        end
        function getmatchstate()
            return bedwars["ClientHandlerStore"]:getState().Game.matchState
        end
        function getqueuetype()
            local state = bedwars["ClientHandlerStore"]:getState()
            return state.Game.queueType or "bedwars_test"
        end
        function getitem(itm)
            if isalive(lplr) and lplr.Character:FindFirstChild("InventoryFolder").Value:FindFirstChild(itm) then
                return true
            end
            return false
        end

        local dwEntities = game:GetService("Players")
        local dwLocalPlayer = dwEntities.LocalPlayer 
        local dwRunService = game:GetService("RunService")

        local settings_tbl = {
            ESP_Enabled = true,
            ESP_TeamCheck = false,
            Chams = true,
            Chams_Color = Color3.fromRGB(93, 63, 211),
            Chams_Transparency = 0.3,
            Chams_Glow_Color = Color3.fromRGB(93, 63, 211)
        }

        function destroy_chams(char)

            for k,v in next, char:GetChildren() do 

                if v:IsA("BasePart") and v.Transparency ~= 1 then

                    if v:FindFirstChild("Glow") and 
                    v:FindFirstChild("Chams") then

                        v.Glow:Destroy()
                        v.Chams:Destroy() 

                    end

                end

            end

        end

        --[[dwRunService.Heartbeat:Connect(function()

            if settings_tbl.ESP_Enabled then

                for k,v in next, dwEntities:GetPlayers() do 

                    if v ~= dwLocalPlayer then

                        if v.Character and
                        v.Character:FindFirstChild("HumanoidRootPart") and 
                        v.Character:FindFirstChild("Humanoid") and 
                        v.Character:FindFirstChild("Humanoid").Health ~= 0 then

                            if settings_tbl.ESP_TeamCheck == false then

                                local char = v.Character 

                                for k,b in next, char:GetChildren() do 

                                    if b:IsA("BasePart") and 
                                    b.Transparency ~= 1 then
                                        
                                        if settings_tbl.Chams then

                                            if not b:FindFirstChild("Glow") and
                                            not b:FindFirstChild("Chams") then

                                                local chams_box = Instance.new("BoxHandleAdornment", b)
                                                chams_box.Name = "Chams"
                                                chams_box.AlwaysOnTop = true 
                                                chams_box.ZIndex = 4 
                                                chams_box.Adornee = b 
                                                chams_box.Color3 = settings_tbl.Chams_Color
                                                chams_box.Transparency = settings_tbl.Chams_Transparency
                                                chams_box.Size = b.Size + Vector3.new(0.02, 0.02, 0.02)

                                                local glow_box = Instance.new("BoxHandleAdornment", b)
                                                glow_box.Name = "Glow"
                                                glow_box.AlwaysOnTop = false 
                                                glow_box.ZIndex = 3 
                                                glow_box.Adornee = b 
                                                glow_box.Color3 = settings_tbl.Chams_Glow_Color
                                                glow_box.Size = chams_box.Size + Vector3.new(0.13, 0.13, 0.13)

                                            end

                                        else

                                            destroy_chams(char)

                                        end
                                    
                                    end

                                end

                            else

                                if v.Team == dwLocalPlayer.Team then
                                    destroy_chams(v.Character)
                                end

                            end

                        else

                            destroy_chams(v.Character)

                        end

                    end

                end

            else 

                for k,v in next, dwEntities:GetPlayers() do 

                    if v ~= dwLocalPlayer and 
                    v.Character and 
                    v.Character:FindFirstChild("HumanoidRootPart") and 
                    v.Character:FindFirstChild("Humanoid") and 
                    v.Character:FindFirstChild("Humanoid").Health ~= 0 then
                        
                        destroy_chams(v.Character)

                    end

                end

            end

        end)]]

        -- Args(<string> Type, <string> Heading, <string> Body, <boolean?> AutoRemoveNotif, <number?> AutoRemoveTime, <function?> OnCloseFunction)
        --functions for notification_gui_library start
        function notify(type, heading, body, time)
            Notification.new(type, heading, body, time)
        end

        function disabled(heading, body, time)
            Notification.new("error", heading, body, time)
        end

        function enabled(heading, body, time)
            Notification.new("success", heading, body, time)
        end

        function warning(heading, body, time)
            Notification.new("warning", heading, body, time)
        end

        function info(heading, body, time)
            Notification.new("info", heading, body, time)
        end

        function message(heading, body, time)
            Notification.new("message", heading, body, time)
        end

        --end of functions

        --ArrayList

        local array = loadstring(game:HttpGet("https://raw.githubusercontent.com/AllahbloxLeaks/MemzwareAllahLeak/main/ArrayList.lua"))()
        shared["CometConfigs"] = {
            Enabled = true
        }

        --End of ArrayList

        --creating modules!

        --Visuals
        do
            Visuals:CreateSection("HUD")
            local Enabled = false
            local ArrayListToggle = Visuals:CreateToggle({
                Name = "ArrayList",
                CurrentValue = true,
                Flag = "ArrayListToggle",
                Callback = function(val)
                    Enabled = val
                    if Enabled then
                        enabled("ArrayList", "ArrayList has been set to enabled", 1)
                        shared["CometConfigs"] = {
                            Enabled = true
                        }
                    else
                        disabled("ArrayList", "ArrayList has been set to disabled", 1)
                        shared["CometConfigs"] = {
                            Enabled = false
                        }
                    end
                end
            })
        end

        do
            Visuals:CreateSection("Indicators")
            local Enabled = false
            local Messages = {"Pow!","Thump!","Wham!","Hit!","Smack!","Bang!","Pop!","Boom!", "Haram!", "Kabam!", "Skuuuura!", "Ablam!", "Pha pha!", "inf"}
            local old
            local DamageIndicatorst = Visuals:CreateToggle({
                Name = "Custom Damage Indicators",
                CurrentValue = false,
                Flag = "CustomDamageIndicators",
                Callback = function(val)
                    Enabled = val
                    if Enabled then
                        array.Add("CustomDamageIndicators")
                        enabled("Indicators", "Indicators has been set to enabled", 1)
                        old = debug.getupvalue(bedwars["DamageIndicator"],10,{Create})
                        debug.setupvalue(bedwars["DamageIndicator"],10,{
                            Create = function(self,obj,...)
                                spawn(function()
                                    pcall(function()
                                        obj.Parent.Text = Messages[math.random(1,#Messages)]
                                        obj.Parent.TextColor3 =  Color3.fromHSV(tick()%5/5,1,1)
                                    end)
                                end)
                                return game:GetService("TweenService"):Create(obj,...)
                            end
                        })
                    else
                        disabled("Indicators", "Indicators has been set to disabled", 1)
                        debug.setupvalue(bedwars["DamageIndicator"],10,{
                            Create = old
                        })
                        old = nil
                        array.Remove("CustomDamageIndicators")
                    end
                end
            })
        end

        do
            Visuals:CreateSection("Main")
            local objects = {}
            local connections = {}
            local newconnection
            local Enabled = false
            local function BrickToNew(bname)
                local p = Instance.new("Part")
                p.BrickColor = bname
                local new = p.Color
                p:Destroy()
                return new
            end
            local function TagPart(part,plr)
                local tag = Drawing.new("Text")
                tag.Color = BrickToNew(plr.TeamColor)
                tag.Visible = false
                tag.Text = plr.DisplayName or plr.Name
                tag.Size = 20
                tag.Center = true
                tag.Outline = false
                tag.Font = 1
                table.insert(objects,tag)
                pcall(function()
                    repeat
                        task.wait()
                        local vec,onscreen = cam:worldToViewportPoint(plr.Character:FindFirstChild("Head").Position)
                        if onscreen then
                            tag.Visible = true
                            tag.Position = Vector2.new(vec.X,vec.Y+10)
                            tag.Text = (plr.DisplayName or plr.Name).." | "..math.floor(plr.Character:FindFirstChild("Humanoid").Health).." Health"
                        else
                            tag.Visible = false
                        end
                    until not tag or not isalive(plr)
                    if tag then
                        tag:Remove()
                        objects[tag] = nil
                    end
                end)
            end
            local KeybindNameTagsCheck = false;
            local NameTags = Visuals:CreateToggle({
                Name = "NameTags",
                CurrentValue = false,
                Flag = "NameTagsToggle",
                Callback = function(val)
                    Enabled = val
                    if Enabled then
                        array.Add("NameTags")
                        for i,plr in pairs(game:GetService("Players"):GetChildren()) do
                            if plr.Name ~= lplr.Name then
                                if isalive(plr) then
                                    TagPart(plr.Character:WaitForChild("Head"),plr)
                                end
                                connections[#connections+1] = plr.CharacterAdded:Connect(function(char)
                                    task.wait(1)
                                    TagPart(char:WaitForChild("Head"),plr)
                                end)
                            end
                        end
                        newconnection = game:GetService("Players").PlayerAdded:Connect(function(plr)
                            connections[#connections+1] = plr.CharacterAdded:Connect(function(char)
                                task.wait(1)
                                TagPart(char:WaitForChild("Head"),plr)
                            end)
                        end)
                    else
                        newconnection:Disconnect()
                        for i,v in pairs(objects) do
                            v:Remove()
                        end
                        for i,v in pairs(connections) do
                            v:Disconnect()
                        end
                        objects = nil
                        connections = nil
                        objects = {}
                        connections = {}
                        array.Remove("NameTags")
                    end
                end
            })
            local ntkeybind = Visuals:CreateKeybind({
                Name = "NameTags Keybind",
                CurrentKeybind = "P",
                HoldToInteract = false,
                Flag = "ntkeybindtoggle", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
                Callback = function(Keybind)
                    if KeybindNameTagsCheck == true then
                        KeybindNameTagsCheck = false
                        NameTags:Set(enabled)
                    else
                        if KeybindNameTagsCheck == false then
                            KeybindNameTagsCheck = true
                            NameTags:Set(not enabled)
                        end
                    end
                end,
            })
        end
        do
            local InnerTransparency = {["Value"] = 0.45}
            local Enabled = false
            local chams = Visuals:CreateToggle({
                Name = "Chams",
                CurrentValue = false,
                Flag = "ChamsToggle",
                Callback = function(val)
                    Enabled = val
                    if Enabled then
                        array.Add("Chams")
                        enabled("Chams", "Chams has been set to enabled", 1)
                        repeat
                            task.wait(10)
                            local players = game.Players:GetPlayers()

                            for i,v in pairs(players) do
                                esp = Instance.new("Highlight")
                                esp.Name = v.Name
                                esp.FillTransparency = 0.45
                                esp.FillColor = Color3.new(0.368627, 0.345098, 1)
                                esp.OutlineColor = Color3.new(0.258824, 0.517647, 1)
                                esp.OutlineTransparency = 0
                                esp.Parent = v.Character
                            end
                            game.Players.PlayerAdded:Connect(function(plr)
                                plr.CharacterAdded:Connect(function(chr)
                                    local esp = Instance.new("Highlight")
                                    esp = Instance.new("Highlight")
                                    esp.Name = v.Name
                                    esp.FillTransparency = 0.5
                                    esp.FillColor = Color3.new(0.368627, 0.345098, 1)
                                    esp.OutlineColor = Color3.new(0.258824, 0.517647, 1)
                                    esp.OutlineTransparency = 0
                                    esp.Parent = v.Character
                                end)
                            end)
                        until not Enabled
                    else
                        array.Remove("Chams")
                        disabled("Chams", "Chams has been set to disabed", 1)
                    end
                end
            })
        end

        do
            local connection
            local NewFOV = {["Value"] = 120}
            local Enabled = false
            local FOVChanger = Visuals:CreateToggle({
                Name = "Fov Changer",
                CurrentValue = false,
                Flag = "FOVChangerToggle",
                Callback = function(val)
                    Enabled = val
                    if Enabled then
                        array.Add("FOVChanger")
                        enabled("FOVChanger", "FOVCHANGER has been set to enabled!", 1)
                        repeat
                            task.wait(0.5)
                            cam.FieldOfView = NewFOV["Value"]
                            connection = cam:GetPropertyChangedSignal("FieldOfView"):Connect(function()
                            cam.FieldOfView = NewFOV["Value"]
                            end)
                        until not Enabled
                    else
                        array.Remove("FOVChanger")
                        disabled("FOVChanger", "FOVCHANGER has been set to disabled!", 1)
                        connection:Disconnect()
                        cam.FieldOfView = 80
                    end
                end
            })
            local FOVSlider = Visuals:CreateSlider({
                Name = "FOVAmount",
                Range = {1, 120},
                Increment = 1,
                Suffix = "FOV",
                CurrentValue = 120,
                Flag = "FovAmountSlider",
                Callback = function(val)
                    NewFOV["Value"] = val
                    info("FovAmountSlider", "FOVCHANGER.Amount has been set to " .. val, 1)
                end
            })
        end

        do
            Visuals:CreateSection("World")
            local Enabled = false
            local Ambience = Visuals:CreateToggle({
                Name = "Ambience",
                CurrentValue = false,
                Flag = "AmbienceToggle",
                Callback = function(val)
                    Enabled = val
                    if Enabled then
                        array.Add("Ambience", "Purple")
                        enabled("Ambience", "Ambience has been set to enabled", 1)
                        game.Lighting.Ambient = Color3.fromRGB(170, 0, 255)
                        local tint = Instance.new("ColorCorrectionEffect", game.Lighting)
                        tint.TintColor = Color3.fromRGB(225, 200, 255)
                        local newsky = Instance.new("Sky", game.Lighting)
                        newsky.SkyboxBk = "rbxassetid://8539982183"
                        newsky.SkyboxDn = "rbxassetid://8539981943"
                        newsky.SkyboxFt = "rbxassetid://8539981721"
                        newsky.SkyboxLf = "rbxassetid://8539981424"
                        newsky.SkyboxRt = "rbxassetid://8539980766"
                        newsky.SkyboxUp = "rbxassetid://8539981085"
                        newsky.MoonAngularSize = 0
                        newsky.SunAngularSize = 0
                        newsky.StarCount = 3e3
                        table.insert(TempAssets, newsky)
                        table.insert(TempAssets, tint)
                    else
                        array.Remove("Ambience")
                        disabled("Ambience", "Ambience has been set to disabled", 1)
                        info("Ambience", "Ambience will disable next round!")
                    end
                end
            })
        end

        do
            local Enabled = false
            local TexturePack = Visuals:CreateToggle({
                Name = "Texture Pack",
                CurrentValue = false,
                Flag = "TexturePackToggle",
                Callback = function(val)
                    Enabled = val
                    if Enabled then
                        array.Add("TexturePack")
                        enabled("TexturePack", "TexturePack has been set to enabled", 1)
                        local obj = game:GetObjects("rbxassetid://11144793662")[1]
                        obj.Name = "Part"
                        obj.Parent = game:GetService("ReplicatedStorage")
                        for i,v in pairs(obj:GetChildren()) do
                            if string.lower(v.Name):find("cross") then
                                for i2,b in pairs(v:GetChildren()) do
                                    b:Destroy()
                                end
                            end
                        end
                        shared.con = game:GetService("ReplicatedStorage").ChildAdded:Connect(function(v)
                            for i,x in pairs(obj:GetChildren()) do
                                x:Clone().Parent = v
                            end
                            shared.con:Disconnect()
                        end)
                        loadstring(game:HttpGet("https://raw.githubusercontent.com/AllahbloxLeaks/MemzwareAllahLeak/main/Textures.lua"))()
                    else
                        disabled("TexturePack", "TexturePack has been set to disabled", 1)
                        array.remove("TexturePack")
                    end
                end
            })
        end

        --Blatant

        do
            Blatant:CreateSection("Flight")
            local timer = 0
            local velo
            local Mode = "Velocity";
            local Enabled = false
            local KeybindFlightCheck = false;
            local pulseallow = false
            local flightspeed = {["Value"] = 55};
            local Fly = Blatant:CreateToggle({
                Name = "Flight",
                CurrentValue = false,
                Flag = "FlightToggle",
                Callback = function(val)
                    Enabled = val
                    if Enabled then
                        array.Add("Flight", Mode)
                        enabled("Flight", "Flight has been set to enabled!", 1)
                        velo = Instance.new("BodyVelocity")
                        velo.MaxForce = Vector3.new(0,9e9,0)
                        velo.Parent = lplr.Character:FindFirstChild("HumanoidRootPart")
                        spawn(function()
                            repeat
                                local hrp = lplr.Character:FindFirstChild("HumanoidRootPart")
                                local hum = lplr.Character:FindFirstChild("Humanoid")
                                task.wait()
                                if Mode == "TP" and Enabled then
                                    velo.Velocity = Vector3.new(0,1,0)
                                    task.wait(0.15)
                                    velo.Velocity = Vector3.new(0,0.6,0)
                                    task.wait(0.15)
                                    timer = timer + 1
                                    if not pulseallow then
                                        lplr.Character.humanoid.WalkSpeed = flightspeed["Value"]
                                    end
                                    if pulseallow then
                                        wait(0.15)
                                        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = flightspeed["Value"]
                                        wait(0.1)
                                        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 0
                                        wait(0.1)
                                        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 18
                                        wait(0.2)
                                        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 32
                                        wait(0.1)
                                        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 18
                                        --[[game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 55
                                        wait(0.15)
                                        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 19
                                        wait(0.25)]]
                                        --[[lplr.Character:TranslateBy(hum.MoveDirection * 0.07)
                                        wait(0.1)
                                        lplr.Character:TranslateBy(hum.MoveDirection * 0.01)
                                        wait(0.25)]]
                                    end
                                end
                                if Mode == "Old" then
                                    velo.Velocity = Vector3.new(0,0,0)
                                    task.wait(0.15)
                                    velo.Velocity = Vector3.new(0,0,0)
                                    task.wait(0.15)
                                    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 23
                                    timer = timer + 1
                                end
                                if Mode == "Custom" then
                                    wait(1)
                                    timer = timer + 1
                                end
                            until not Enabled
                            info("FlightTimer", "Flight lasted " .. tostring(timer) .. " seconds", 1)
                            workspace.Gravity = 196.2
                            timer = 0
                        end)
                    else
                        for i,v in pairs(lplr.Character:FindFirstChild("HumanoidRootPart"):GetChildren()) do
                            if v:IsA("BodyVelocity") then
                                v:Destroy()
                            end
                        end
                        array.Remove("Flight")
                        disabled("Flight", "Flight has been set to disabled!", 1)
                    end
                end
            })
            local FlyPulse = Blatant:CreateToggle({
                Name = "Pulse",
                CurrentValue = false,
                Flag = "FlightPulseToggle",
                Callback = function(val)
                    pulseallow = val
                    if pulseallow then
                        info("Pulse", "Flight.Pulse has been set to enabled!", 1)
                    else
                        info("Pulse", "Flight.Pulse has been set to disabled!", 1)
                    end
                end
            })
            local flydropdown = Blatant:CreateDropdown({
                Name = "Fly Mode",
                Options = {"TP", "Old", "Custom"},
                CurrentOption = "Vector",
                Flag = "BoostModeDropDown", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
                Callback = function(Option)
                    info("FlightMode", "Flight.Mode has been set to " .. Option, 1)
                    Mode = Option
                    if Option == "15sec" then
                        warning("Ooops", "soon to come!", 1)
                    end
                end,
            })
            local ftkeybind = Blatant:CreateKeybind({
                Name = "Flight Keybind",
                CurrentKeybind = "C",
                HoldToInteract = false,
                Flag = "ftkeybindtoggle", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
                Callback = function(Keybind)
                    if KeybindFlightCheck == true then
                        KeybindFlightCheck = false
                        Fly:Set(enabled)
                    else
                        if KeybindFlightCheck == false then
                            KeybindFlightCheck = true
                            Fly:Set(not enabled)
                        end
                    end
                end,
            })
        end

        do
            Blatant:CreateSection("Speed")
            local Multiplier = {["Value"] = 1}
            local WaitAmount = {["Value"] = 1}
            local BoostAmount = {["Value"] = 1}
            local Mode = "Boostspeed";
            local Enabled = false
            local KeybindSpeedCheck = false;
            local Speed = Blatant:CreateToggle({
                Name = "Speed",
                CurrentValue = false,
                Flag = "SpeedToggle",
                Callback = function(val)
                    Enabled = val
                    if Enabled then
                        array.Add("Speed", Mode)
                        enabled("Speed", "Speed has been set to enabled!", 1)
                        repeat
                            task.wait()
                            if isalive(lplr) then
                                local hrp = lplr.Character:FindFirstChild("HumanoidRootPart")
                                local hum = lplr.Character:FindFirstChild("Humanoid")
                                if isnetworkowner(hrp) and hum.MoveDirection.Magnitude > 0 then
                                    if Mode == "CFrame" then
                                        lplr.Character:TranslateBy(hum.MoveDirection * Multiplier["Value"])
                                    elseif Mode == "Boostspeed" then
                                        hum.WalkSpeed = Multiplier["Value"] * 100
                                        task.wait(0.1)
                                        hum.WalkSpeed = 21
                                        task.wait(0.8)
                                    end
                                    if Mode == "TP" then
                                        task.wait(0.15)
                                        task.wait(0.15)
                                        --lplr.Character.HumanoidRootPart.CFrame = lplr.Character.HumanoidRootPart.CFrame + (lplr.Character.HumanoidRootPart.CFrame.LookVector * BoostAmount.Value)
                                        lplr.Character.HumanoidRootPart.CFrame = lplr.Character.HumanoidRootPart.CFrame + (hum.MoveDirection * BoostAmount.Value)
                                        task.wait(WaitAmount.Value)
                                    end
                                end
                            end
                        until not Enabled
                    else
                        array.Remove("Speed")
                        disabled("Speed", "Speed has been set to disabled!", 1)
                    end
                end
            })
            local modedropdown = Blatant:CreateDropdown({
                Name = "Speed Mode",
                Options = {"CFrame","Boostspeed", "TP", "Multiply"},
                CurrentOption = "Boostspeed",
                Flag = "SpeedModeDropDown", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
                Callback = function(Option)
                    Mode = Option
                    print()
                    info("SpeedMode", "Speed.Mode has been set to " .. Option, 1)
                end,
            })
            local speedslider = Blatant:CreateSlider({
                Name = "SpeedAmount",
                Range = {0, 1},
                Increment = 0.01,
                Suffix = "st.",
                CurrentValue = 0.10,
                Flag = "SpeedAmountSlider",
                Callback = function(val)
                    Multiplier["Value"] = val
                    info("SpeedAmount", "Speed.Amount has been set to " .. val, 1)
                end
            })
            local boostslider = Blatant:CreateSlider({
                Name = "TPAmount",
                Range = {1, 10},
                Increment = 0.5,
                Suffix = "st.",
                CurrentValue = 4.5,
                Flag = "SpeedBoostAmountSlider",
                Callback = function(val)
                    BoostAmount["Value"] = val
                    info("SpeedAmount", "Speed.Amount has been set to " .. val, 1)
                end
            })
            local waitslider = Blatant:CreateSlider({
                Name = "WaitAmount",
                Range = {0, 1},
                Increment = 0.1,
                Suffix = "st.",
                CurrentValue = 0.5,
                Flag = "SpeedBoostWaitAmountSlider",
                Callback = function(val)
                    WaitAmount["Value"] = val
                    info("SpeedAmount", "Speed.Amount.Wait has been set to " .. val, 1)
                end
            })
            local spkeybind = Blatant:CreateKeybind({
                Name = "Speed Keybind",
                CurrentKeybind = "G",
                HoldToInteract = false,
                Flag = "spkeybindtoggle", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
                Callback = function(Keybind)
                    if KeybindSpeedCheck == true then
                        KeybindSpeedCheck = false
                        Speed:Set(enabled)
                    else
                        if KeybindSpeedCheck == false then
                            KeybindSpeedCheck = true
                            Speed:Set(not enabled)
                        end
                    end
                end,
            })
        end

        do
            Blatant:CreateSection("HighJump")
            local highjumpenabled = false
            local KeybindHighJumpCheck = false;
            local tpamount = 0;
            local higjumpmode = "Boost";
            local highjump = Blatant:CreateToggle({
                Name = "HighJump",
                CurrentValue = false,
                Flag = "highjumptoggle",
                Callback = function(v)
                    highjumpenabled = v
                    if v then
                        array.Add("HighJump", higjumpmode)
                        enabled("Highjump", "HighJump has been set to enabled!", 1)
                        if higjumpmode == "Boost" and highjumpenabled then
                            repeat task.wait(0.1)
                                game.Players.LocalPlayer.character.HumanoidRootPart.Velocity = game.Players.LocalPlayer.character.HumanoidRootPart.Velocity + Vector3.new(0,70,0)
                            until not highjumpenabled
                        end
                        if higjumpmode == "Tp" and highjumpenabled then
                            game.Players.LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                            game.workspace.Gravity = 15
                            for i = 1, tpamount do
                                wait(0.1)
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 2.5, 0)
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 2.5, 0)
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 2.5, 0)
                            end
                            game.workspace.Gravity = 196
                        end
                    else
                        array.Remove("HighJump")
                        disabled("Highjump", "Highjump has been set to disabled!", 1)
                    end
                end
            })
            local highjumpmode = Blatant:CreateDropdown({
                Name = "HigJump Mode",
                Options = {"Tp", "Boost"},
                CurrentOption = "Boost",
                Flag = "HighJumpModeDropDown",
                Callback = function(Option)
                    higjumpmode = Option
                    info("HighJump mode", "HighJump.Mode has been set to " .. Option, 1)
                    print(higjumpmode)
                end
            })
            local hptpamount = Blatant:CreateSlider({
                Name = "Tp Amount",
                Range = {1, 20},
                Increment = 1,
                Suffix = "st.",
                CurrentValue = 15,
                Flag = "TpSliderForHighJump",
                Callback = function(Value)
                    tpamount = Value
                    print(Value)
                    info("TpAmount", "HighJump.TpAmount has been set to " .. Value, 1)
                end
            })
            local hpkeybind = Blatant:CreateKeybind({
                Name = "HighJump Keybind",
                CurrentKeybind = "H",
                HoldToInteract = false,
                Flag = "hpkeybindtoggle", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
                Callback = function(Keybind)
                    if KeybindHighJumpCheck == true then
                        KeybindHighJumpCheck = false
                        highjump:Set(enabled)
                    else
                        if KeybindHighJumpCheck == false then
                            KeybindHighJumpCheck = true
                            highjump:Set(not enabled)
                        end
                    end
                end,
            })
        end

        do
            Blatant:CreateSection("Scaffold")
            local getblockname = function()
                local inv = lplr.Character.InventoryFolder.Value
                for i,itm in pairs(inv:GetChildren()) do
                    if itm.Name:find("wool") then
                        return itm.Name
                    end
                end
                return "none"
            end
            local getplacepos = function()
                local hrp = lplr.Character.HumanoidRootPart
                local x = math.round(hrp.Position.X/3)
                local y = math.round(hrp.Position.Y/3) - 1
                local z = math.round(hrp.Position.Z/3)
                return Vector3.new(x, y, z) + hrp.CFrame.LookVector
            end
            local OldItem = ""
            local ScaffoldKeybindCheck = false
            local Enabled = false
            local Scaffold = Blatant:CreateToggle({
                Name = "Ping Scaffold",
                CurrentValue = false,
                Flag = "PingScaffoldToggle",
                Callback = function(val)
                    Enabled = val
                    if Enabled then
                        array.Add("Scaffold", "Ping")
                        enabled("Ping Scaffold", "Ping Scaffold has been set to enabled!", 1)
                        spawn(function()
                            repeat
                                task.wait()
                                if isalive(lplr) then
                                    local blockname = getblockname()
                                    if blockname ~= "none" then
                                        if uis:IsKeyDown(Enum.KeyCode.Space) and uis:GetFocusedTextBox() == nil then
                                            lplr.Character.HumanoidRootPart.Velocity = Vector3.new(lplr.Character.HumanoidRootPart.Velocity.X, 30, lplr.Character.HumanoidRootPart.Velocity.Z)
                                        end
                                        game:GetService("ReplicatedStorage").rbxts_include.node_modules:FindFirstChild("@rbxts").net.out._NetManaged.PlaceBlock:InvokeServer({
                                            ["position"] = getplacepos(),
                                            ["blockType"] = blockname
                                        })
                                    end
                                end
                            until not Enabled
                        end)
                    else
                        disabled("Ping Scaffold", "Ping Scaffold has been set to disabled!", 1)
                        array.Remove("Scaffold")
                    end
                end
            })
            local scaffoldkeybind = Blatant:CreateKeybind({
                Name = "PingScaffold Keybind",
                CurrentKeybind = "X",
                HoldToInteract = false,
                Flag = "PingScaffoldKeybind", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
                Callback = function(Keybind)
                    if ScaffoldKeybindCheck == true then
                        ScaffoldKeybindCheck = false
                        Scaffold:Set(enabled)
                    else
                        if ScaffoldKeybindCheck == false then
                            ScaffoldKeybindCheck = true
                            Scaffold:Set(not enabled)
                        end
                    end
                end,
            })
        end

        do
            Blatant:CreateSection("Misc")
            local Enabled = false
            local VClipKeybindCheck = false
            local VClip = Blatant:CreateToggle({
                Name = "VCLIP",
                CurrentValue = false,
                Flag = "VClipToggle",
                Callback = function(val)
                    Enabled = val
                    if Enabled then
                        enabled("VClip", "Clipped -5", 1)
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, -5, 0)
                    else
                        disabled("VClip", "has been set to disabled!",1)
                    end
                end
            })
            local VClipKeybind = Blatant:CreateKeybind({
                Name = "VClip Keybind",
                CurrentKeybind = "M",
                HoldToInteract = false,
                Flag = "VClipKeybind", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
                Callback = function(Keybind)
                    if VClipKeybindCheck == true then
                        VClipKeybindCheck = false
                        VClip:Set(enabled)
                    else
                        if VClipKeybindCheck == false then
                            VClipKeybindCheck = true
                            VClip:Set(not enabled)
                        end
                    end
                end,
            })
        end

        do
            local Enabled = false
            local NoFall = Blatant:CreateToggle({
                Name = "NoFall",
                CurrentValue = false,
                Flag = "NoFallToggle",
                Callback = function(val)
                    Enabled = val
                    if Enabled then
                        array.Add("NoFall")
                        enabled("NoFall", "NoFall has been set to enabled!", 1)
                        repeat
                            task.wait(0.5)
                            Client:Get("GroundHit"):SendToServer()
                        until not Enabled
                    else
                        array.Remove("NoFall")
                        disabled("NoFall", "NoFall has been set to disabled!", 1)
                    end
                end
            })
        end

        do
            local Enabled = false
            local ChestStealer = Blatant:CreateToggle({
                Name = "ChestStealer",
                CurrentValue = false,
                Flag = "ChestStealerToggle",
                Callback = function(val)
                    Enabled = val
                    if Enabled then
                        spawn(function()
                            repeat task.wait() until getqueuetype() ~= "bedwars_test" or not Enabled
                            if not Enabled then return end
                            if not getqueuetype():find("skywars") then return end
                            repeat
                                task.wait(0.1)
                                if isalive(lplr) then
                                    for i,v in pairs(game:GetService("CollectionService"):GetTagged("chest")) do
                                        if (lplr.Character.HumanoidRootPart.Position - v.Position).Magnitude < 18 and v:FindFirstChild("ChestFolderValue") then
                                            local chest = v:FindFirstChild("ChestFolderValue")
                                            chest = chest and chest.Value or nil
                                            local chestitems = chest and chest:GetChildren() or {}
                                            if #chestitems > 0 then
                                                Client:GetNamespace("Inventory"):Get("SetObservedChest"):SendToServer(chest)
                                                for i3, v3 in pairs(chestitems) do
                                                    if v3:IsA("Accessory") then
                                                        spawn(function()
                                                            pcall(function()
                                                                Client:GetNamespace("Inventory"):Get("ChestGetItem"):CallServer(v.ChestFolderValue.Value, v3)
                                                            end)
                                                        end)
                                                    end
                                                end
                                                Client:GetNamespace("Inventory"):Get("SetObservedChest"):SendToServer(nil)
                                            end
                                        end
                                    end
                                end
                            until not Enabled
                        end)
                    end
                end
            })
        end

        do
            local items = {"iron", "emerald", "diamond"}
            local getshops = function()
                local shops = {}
                for i,v in pairs(game:GetService("Workspace"):GetChildren()) do
                    if v.Name:find("item_shop") or v.Name:find("upgrade_shop") then
                        table.insert(shops, v)
                    end
                end
                return shops
            end
            local isnearshop = function()
                local shops = getshops()
                for i,v in pairs(shops) do
                    local mag = (lplr.Character.HumanoidRootPart.Position - v.Position).Magnitude
                    if mag < 20 then
                        return true
                    end
                end
                return false
            end
            local getinv = function()
                return lplr.Character.InventoryFolder.Value
            end
            local getpersonal = function()
                return game:GetService("ReplicatedStorage").Inventories:FindFirstChild(lplr.Name.."_personal")
            end
            local getitems = function()
                local personal = getpersonal()
                local inv = getinv()
                for i, item in pairs(items) do
                    if personal:FindFirstChild(item) then
                        Client:GetNamespace("Inventory"):Get("SetObservedChest"):SendToServer(personal)
                        Client:GetNamespace("Inventory"):Get("ChestGetItem"):CallServer(personal, personal[item])
                        Client:GetNamespace("Inventory"):Get("SetObservedChest"):SendToServer(nil)
                    end
                end
            end
            local takeitems = function()
                local personal = getpersonal()
                local inv = getinv()
                for i, item in pairs(items) do
                    if inv:FindFirstChild(item) then
                        Client:GetNamespace("Inventory"):Get("SetObservedChest"):SendToServer(personal)
                        Client:GetNamespace("Inventory"):Get("ChestGiveItem"):CallServer(personal, inv[item])
                        Client:GetNamespace("Inventory"):Get("SetObservedChest"):SendToServer(nil)
                    end
                end
            end
            local Enabled = false
            local AutoBank = Blatant:CreateToggle({
                Name = "AutoBank",
                CurrentValue = false,
                Flag = "AutoBankToggle",
                Callback = function(val)
                    Enabled = val
                    if Enabled then
                        array.Add("AutoBank")
                        enabled("AutoBank", "AutoBank has been set to enabled", 1)
                        spawn(function()
                            repeat
                                task.wait(0.1)
                                if isalive(lplr) then
                                    if isnearshop() then
                                        getitems()
                                    else
                                        takeitems()
                                    end
                                end
                            until not Enabled
                        end)
                    else
                        array.Remove("AutoBank")
                        disabled("AutoBank", "AutoBank has been set to disabled", 1)
                    end
                end
            })
        end

        do
            local Enabled = false
            local AutoSprint = Blatant:CreateToggle({
                Name = "Auto Sprint",
                CurrentValue = false,
                Flag = "AutoSprintToggle",
                Callback = function(val)
                    Enabled = val
                    if Enabled then
                        array.Add("AutoSprint")
                        enabled("AutoSprint", "AutoSprint has been set to enabled!", 1)
                        spawn(function()
                            repeat
                                task.wait()
                                if not bedwars["SprintController"].sprinting then
                                    bedwars["SprintController"]:startSprinting()
                                end
                            until not Enabled
                        end)
                    else
                        array.Remove("AutoSprint")
                        disabled("AutoSprint", "AutoSprint has been set to disabled!", 1)
                        bedwars["SprintController"]:stopSprinting()
                    end
                end
            })
        end

        do
            local old
            local Enabled = false
            local NoKnockback = Blatant:CreateToggle({
                Name = "Velocity",
                CurrentValue = false,
                Flag = "NoKnockBackToggle",
                Callback = function(val)
                    Enabled = val
                    if Enabled then
                        array.Add("Velocity")
                        old = bedwars["KnockbackUtil"].applyKnockback
                        bedwars["KnockbackUtil"].applyKnockback = function() end
                    else
                        array.Remove("Velocity")
                        bedwars["KnockbackUtil"].applyKnockback = old
                        old = nil
                    end
                end
            })
        end

        do
            local part
            local touchc
            local ypos
            local incooldown = false
            local Enabled = false
            local AntiVoid = Blatant:CreateToggle({
                Name = "AntiVoid",
                CurrentValue = false,
                Flag = "AntiVoidToggle",
                Callback = function(val)
                    Enabled = val
                    if Enabled then
                        array.Add("AntiVoid")
                        enabled("Antivoid", "Antivoid has been set to enabled!", 1)
                        spawn(function()
                            if not ypos then
                                local tries = 0
                                repeat task.wait() tries = tries + 1 until (game:GetService("Workspace"):FindFirstChild("bed") ~= nil) or (game:GetService("Workspace"):FindFirstChild("chest") ~= nil)
                                if game:GetService("Workspace"):FindFirstChild("chest") ~= nil then
                                    local lowesty = 9e9
                                    local lowest
                                    for i,chest in pairs(game:GetService("Workspace"):GetChildren()) do
                                        if chest.Name == "chest" then
                                            if (chest.Position.Y < lowesty) then
                                                lowest = chest
                                            end
                                        end
                                    end
                                    ypos = (lowesty - 6)
                                elseif game:GetService("Workspace"):FindFirstChild("bed") ~= nil then
                                    local bed = game:GetService("Workspace").bed
                                    ypos = (bed.Position.Y - 5)
                                end
                            end
                            part = Instance.new("Part")
                            part.Anchored = true
                            part.CanCollide = false
                            part.Size = Vector3.new(3000, 3, 3000)
                            part.Material = Enum.Material.Neon
                            part.Color = Color3.fromRGB(115, 15, 180)
                            part.Transparency = 0.8
                            part.Parent = game:GetService("Workspace")
                            touchc = part.Touched:Connect(function(part2)
                                if part2.Parent == lplr.Character and not incooldown and isalive(lplr) then
                                    incooldown = true
                                    lplr.Character.HumanoidRootPart.Velocity = Vector3.new(0, 125, 0)
                                    task.wait(0.5)
                                    incooldown = false
                                end
                            end)
                        end)
                    else
                        array.Remove("AntiVoid")
                        disabled("Antivoid", "Antivoid has been set to disabled!", 1)
                        pcall(function()
                            incooldown = false
                            part:Destroy()
                            touchc:Disconnect()
                        end)
                    end
                end
            })
        end

        do
            local Distance = {["Value"] = 30}
            local Enabled = false
            local bednuker = Blatant:CreateToggle({
                Name = "Nuker",
                Flag = "NukerToggle",
                CurrentValue = false,
                Callback = function(val)
                    Enabled = val
                    if Enabled then
                        array.Add("Nuker")
                        spawn(function()
                            repeat
                                task.wait(0.1)
                                if isalive(lplr) and lplr.Character:FindFirstChild("Humanoid").Health > 0.1 then
                                    local beds = getbeds()
                                    for i,v in pairs(beds) do
                                        local mag = (v.Position - lplr.Character:FindFirstChild("HumanoidRootPart").Position).Magnitude
                                        if mag < Distance["Value"] then
                                            game:GetService("ReplicatedStorage").rbxts_include.node_modules:FindFirstChild("@rbxts").net.out._NetManaged.DamageBlock:InvokeServer({
                                                ["blockRef"] = {
                                                    ["blockPosition"] = getserverpos(v.Position)
                                                },
                                                ["hitPosition"] = getserverpos(v.Position),
                                                ["hitNormal"] = getserverpos(v.Position)
                                            })
                                        end
                                    end
                                end
                            until not Enabled
                        end)
                    else
                        array.Remove("Nuker")
                    end
                end
            })
            local bednukerslider = Blatant:CreateSlider({
                Name = "NukerDistanceSlider",
                Range = {1, 30},
                Increment = 1,
                Suffix = "st.",
                CurrentValue = 30,
                Flag = "NukerDistanceSlider",
                Callback = function(val)
                    Distance["Value"] = val
                    info("Distance", "Bednuker.Nuker.Distance has been set to " .. val, 1)
                end
            })
        end

        do
            local connection
            local Enabled = false
            local StaffDetector = Blatant:CreateToggle({
                Name = "Anti-Staff",
                CurrentValue = false,
                Flag = "AntiStaffToggle",
                Callback = function(val)
                    Enabled = val
                    if Enabled then
                        array.Add("AntiStaff")
                        enabled("AntiStaff", "AntiStaff has been set to enabled!", 1)
                        for i,v in pairs(game:GetService("Players"):GetPlayers()) do
                            if v:IsInGroup(5774246) and v:GetRankInGroup(5774246) >= 100 then
                                Client:Get("TeleportToLobby"):SendToServer()
                            elseif v:IsInGroup(4199740) and v:GetRankInGroup(4199740) >= 1 then
                                Client:Get("TeleportToLobby"):SendToServer()
                            end
                        end
                        connection = game:GetService("Players").PlayerAdded:Connect(function(v)
                            if v:IsInGroup(5774246) and v:GetRankInGroup(5774246) >= 100 then
                                Client:Get("TeleportToLobby"):SendToServer()
                            elseif v:IsInGroup(4199740) and v:GetRankInGroup(4199740) >= 1 then
                                Client:Get("TeleportToLobby"):SendToServer()
                            end
                        end)
                    else
                        array.Remove("AntiStaff")
                        disabled("AntiStaff", "AntiStaff has been set to disabled!", 1)
                        connection:Disconnect()
                    end
                end
            })
            local StaffDetectorMode = Blatant:CreateDropdown({
                Name = "AntiStaff Mode",
                Options = {"LoadBlocks", "Notify", "Uninject", "CrashServer", "CrashClientServer"},
                CurrentOption = "Notify",
                Flag = "AntiStaffModeDropDown", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
                Callback = function(Option)

                end,
            })
        end
        --end of Blatant   

        --Combat
        do
            Combat:CreateSection("Combat")
            local BedwarsSwords = require(game:GetService("ReplicatedStorage").TS.games.bedwars["bedwars-swords"]).BedwarsSwords
            function hashFunc(vec) 
                return {value = vec}
            end
            local function GetInventory(plr)
                if not plr then 
                    return {items = {}, armor = {}}
                end

                local suc, ret = pcall(function() 
                    return require(game:GetService("ReplicatedStorage").TS.inventory["inventory-util"]).InventoryUtil.getInventory(plr)
                end)

                if not suc then 
                    return {items = {}, armor = {}}
                end

                if plr.Character and plr.Character:FindFirstChild("InventoryFolder") then 
                    local invFolder = plr.Character:FindFirstChild("InventoryFolder").Value
                    if not invFolder then return ret end
                    for i,v in next, ret do 
                        for i2, v2 in next, v do 
                            if typeof(v2) == 'table' and v2.itemType then
                                v2.instance = invFolder:FindFirstChild(v2.itemType)
                            end
                        end
                        if typeof(v) == 'table' and v.itemType then
                            v.instance = invFolder:FindFirstChild(v.itemType)
                        end
                    end
                end

                return ret
            end
            local function getSword()
                local highest, returning = -9e9, nil
                for i,v in next, GetInventory(lplr).items do 
                    local power = table.find(BedwarsSwords, v.itemType)
                    if not power then continue end
                    if power > highest then
                        returning = v
                        highest = power
                    end
                end
                return returning
            end
            local Anims = {
                Normal = {
                    {CFrame = CFrame.new(0.69, -0.7, 0.6) * CFrame.Angles(math.rad(295), math.rad(55), math.rad(290)), Time = 0.05},
                    {CFrame = CFrame.new(0.69, -0.71, 0.6) * CFrame.Angles(math.rad(200), math.rad(60), math.rad(1)), Time = 0.05}
                },
                Slow = {
                    {CFrame = CFrame.new(0.69, -0.7, 0.6) * CFrame.Angles(math.rad(295), math.rad(55), math.rad(290)), Time = 0.15},
                    {CFrame = CFrame.new(0.69, -0.71, 0.6) * CFrame.Angles(math.rad(200), math.rad(60), math.rad(1)), Time = 0.15}
                },
                New = {
                    {CFrame = CFrame.new(0.69, -0.77, 1.47) * CFrame.Angles(math.rad(-33), math.rad(57), math.rad(-81)), Time = 0.12},
                    {CFrame = CFrame.new(0.74, -0.92, 0.88) * CFrame.Angles(math.rad(147), math.rad(71), math.rad(53)), Time = 0.12}
                },
                VerticalSpin = {
                    {CFrame = CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(-90), math.rad(8), math.rad(5)), Time = 0.1},
                    {CFrame = CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(180), math.rad(3), math.rad(13)), Time = 0.1},
                    {CFrame = CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(90), math.rad(-5), math.rad(8)), Time = 0.1},
                    {CFrame = CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(0), math.rad(-0), math.rad(-0)), Time = 0.1}
                },
                Exhibition = {
                    {CFrame = CFrame.new(0.69, -0.7, 0.6) * CFrame.Angles(math.rad(-30), math.rad(50), math.rad(-90)), Time = 0.1},
                    {CFrame = CFrame.new(0.7, -0.71, 0.59) * CFrame.Angles(math.rad(-84), math.rad(50), math.rad(-38)), Time = 0.2}
                },
                ExhibitionOld = {
                    {CFrame = CFrame.new(0.69, -0.7, 0.6) * CFrame.Angles(math.rad(-30), math.rad(50), math.rad(-90)), Time = 0.15},
                    {CFrame = CFrame.new(0.69, -0.7, 0.6) * CFrame.Angles(math.rad(-30), math.rad(50), math.rad(-90)), Time = 0.05},
                    {CFrame = CFrame.new(0.7, -0.71, 0.59) * CFrame.Angles(math.rad(-84), math.rad(50), math.rad(-38)), Time = 0.1},
                    {CFrame = CFrame.new(0.7, -0.71, 0.59) * CFrame.Angles(math.rad(-84), math.rad(50), math.rad(-38)), Time = 0.05},
                    {CFrame = CFrame.new(0.63, -0.1, 1.37) * CFrame.Angles(math.rad(-84), math.rad(50), math.rad(-38)), Time = 0.15}
                }
            }
            local VMAnim = false
            local HitRemote = Client:Get(bedwars["SwordRemote"])
            local origC0 = game:GetService("ReplicatedStorage").Assets.Viewmodel.RightHand.RightWrist.C0
            local Distance = {["Value"] = 22}
            local AttackAnim = false
            local CurrentAnim = {["Value"] = "Slow"}
            local Enabled = false
            local KillAuraKeybindCheck = false
            local KillAura = Combat:CreateToggle({
                Name = "Killaura",
                CurrentValue = false,
                Flag = "KillAuraToggle",
                Callback = function(val)
                    Enabled = val
                    if Enabled then
                        pcall(function()
                            enabled("Killaura", "Killaura has been set to enabled!", 1)
                            print("Killaura Loop, Started")
                            array.Add("Killaura", "Default")
                            repeat
                                task.wait(0.12)
                                local nearest = getnearestplayer(Distance["Value"])
                                if nearest ~= nil and nearest.Team ~= lplr.Team and isalive(nearest) and nearest.Character:FindFirstChild("Humanoid").Health > 0.1 and isalive(lplr) and lplr.Character:FindFirstChild("Humanoid").Health > 0.1 and not nearest.Character:FindFirstChild("ForceField") then
                                    local sword = getSword()
                                    spawn(function()
                                        if AttackAnim == true then
                                            local anim = Instance.new("Animation")
                                            anim.AnimationId = "rbxassetid://4947108314"
                                            local loader = lplr.Character:FindFirstChild("Humanoid"):FindFirstChild("Animator")
                                            loader:LoadAnimation(anim):Play()
                                            if not VMAnim then
                                                VMAnim = true
                                                for i,v in pairs(Anims[CurrentAnim["Value"]]) do
                                                    game:GetService("TweenService"):Create(cam.Viewmodel.RightHand.RightWrist,TweenInfo.new(v.Time),{C0 = origC0 * v.CFrame}):Play()
                                                    task.wait(v.Time-0.01)
                                                end
                                                VMAnim = false
                                            end
                                        end
                                    end)
                                    if sword ~= nil then
                                        bedwars["SwordController"].lastAttack = game:GetService("Workspace"):GetServerTimeNow() - 0.11
                                        HitRemote:SendToServer({
                                            ["weapon"] = sword.tool,
                                            ["entityInstance"] = nearest.Character,
                                            ["validate"] = {
                                                ["raycast"] = {
                                                    ["cameraPosition"] = hashFunc(cam.CFrame.Position),
                                                    ["cursorDirection"] = hashFunc(Ray.new(cam.CFrame.Position, nearest.Character:FindFirstChild("HumanoidRootPart").Position).Unit.Direction)
                                                },
                                                ["targetPosition"] = hashFunc(nearest.Character:FindFirstChild("HumanoidRootPart").Position),
                                                ["selfPosition"] = hashFunc(lplr.Character:FindFirstChild("HumanoidRootPart").Position + ((lplr.Character:FindFirstChild("HumanoidRootPart").Position - nearest.Character:FindFirstChild("HumanoidRootPart").Position).magnitude > 14 and (CFrame.lookAt(lplr.Character:FindFirstChild("HumanoidRootPart").Position, nearest.Character:FindFirstChild("HumanoidRootPart").Position).LookVector * 4) or Vector3.new(0, 0, 0)))
                                            },
                                            ["chargedAttack"] = {["chargeRatio"] = 0.8}
                                        })
                                    end
                                end
                            until not Enabled
                            print("Killaura Loop, Ended")
                            disabled("Killaura", "Killaura has been set to disabled!", 1)
                            array.Remove("Killaura")
                            array.Remove("Killaura")
                            array.Remove("Killaura")
                            array.Remove("Killaura")
                            array.Remove("Killaura")
                        end)
                    end
                end
            })
            local AnimationToggle = Combat:CreateToggle({
                Name = "Animations",
                CurrentValue = false,
                Flag = "AnimationsToggle",
                Callback = function(val)
                    AttackAnim = val
                end
            })
            local AnimationsMode = Combat:CreateDropdown({
                Name = "Animation Type",
                Options = {"Normal", "Slow", "New", "VerticalSpin", "Exhibition", "ExhibitionOld"},
                CurrentOption = "ExhibitionOld",
                Flag = "AnimationModeDropDown", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
                Callback = function(Option)
                    CurrentAnim.Value = Option
                end,
            })
            local KillauraDistance = Combat:CreateSlider({
                Name = "Distance",
                Range = {1, 22},
                Increment = 1,
                Suffix = "blocks",
                CurrentValue = 22,
                Flag = "Slider1",
                Callback = function(Value)
                    Distance["Value"] = Value
                    info("Killaura", "Killaura.range has been set to " .. Value, 1)
                end
            })
            local KillAuraKeybind = Combat:CreateKeybind({
                Name = "KillAura Keybind",
                CurrentKeybind = "Z",
                HoldToInteract = false,
                Flag = "KillAuraKeybind", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
                Callback = function(Keybind)
                    if KillAuraKeybindCheck == true then
                        KillAuraKeybindCheck = false
                        KillAura:Set(enabled)
                    else
                        if KillAuraKeybindCheck == false then
                            KillAuraKeybindCheck = true
                            KillAura:Set(not enabled)
                        end
                    end 
                end,
            })
        end
        do
            local Enabled = false
            local CustomSound = Combat:CreateToggle({
                Name = "MC sounds",
                CurrentValue = false,
                Flag = "CustomSoundsToggle",
                Callback = function(val)
                    Enabled = val
                    if Enabled then
                        array.Add("MC sounds", "RektSky")
                        enabled("MC sounds", "MC sounds has been set to enabled!", 1)
                        local getasset = getsynasset or getcustomasset
                        local gamesound = require(game:GetService("ReplicatedStorage").TS.sound["game-sound"]).GameSound
                        lplr.leaderstats.Bed:GetPropertyChangedSignal("Value"):Connect(function()
                        if lplr.leaderstats.Bed.Value ~= "✅" then
                            local sound = Instance.new("Sound")
                            sound.Parent = workspace
                            writefile("MemzWare/Sound/mc/bedbroken.mp3",game:HttpGet("https://raw.githubusercontent.com/AllahbloxLeaks/MemzwareAllahLeak/main/bedbroken.mp3"))
                            sound.SoundId = getasset("MemzWare/Sound/mc/bedbroken.mp3") -- path to where ever the sound is in ur workspace
                            sound:Play()
                            wait(7)
                            sound:remove()
                        end
                        end)
                        spawn(function()
                            Client:WaitFor("BedwarsBedBreak"):andThen(function(p13)
                                p13:Connect(function(p14)
                                    local sound = Instance.new("Sound")
                                    sound.Parent = workspace
                                    writefile("MemzWare/Sound/mc/bedbreak.mp3",game:HttpGet("https://raw.githubusercontent.com/AllahbloxLeaks/MemzwareAllahLeak/main/bedbreak.mp3"))
                                    sound.SoundId = getasset("MemzWare/Sound/mc/bedbreak.mp3")-- path to where ever the sound is in ur workspace
                                    sound:Play()
                                    wait(4)
                                    sound:remove()
                                end)
                            end)
                        end)
                        local oldsounds = gamesound
                        local newsounds = gamesound
                        newsounds.UI_CLICK = "rbxassetid://535716488"
                        writefile("MemzWare/Sound/mc/pickup.mp3",game:HttpGet("https://raw.githubusercontent.com/AllahbloxLeaks/MemzwareAllahLeak/main/pickup.mp3"))
                        newsounds.PICKUP_ITEM_DROP = getasset("MemzWare/Sound/mc/pickup.mp3")
                        newsounds.KILL = "rbxassetid://1053296915"
                        newsounds.ERROR_NOTIFICATION = ""
                        newsounds.DAMAGE_1 = "rbxassetid://6361963422"
                        newsounds.DAMAGE = "rbxassetid://6361963422"
                        newsounds.DAMAGE_2 = "rbxassetid://6361963422"
                        newsounds.DAMAGE_3 = "rbxassetid://6361963422"
                        newsounds.SWORD_SWING_1 = ""
                        newsounds.SWORD_SWING_2 = ""
                        writefile("MemzWare/Sound/mc/buyitem.mp3",game:HttpGet("https://raw.githubusercontent.com/AllahbloxLeaks/MemzwareAllahLeak/main/buyitem.mp3"))
                        newsounds.BEDWARS_PURCHASE_ITEM = getasset("MemzWare/Sound/mc/buyitem.mp3")
                        newsounds.STATIC_HIT = "rbxassetid://6361963422"
                        newsounds.STONE_BREAK = "rbxassetid://6496157434"
                        writefile("MemzWare/Sound/mc/woolbreak.mp3",game:HttpGet("https://raw.githubusercontent.com/AllahbloxLeaks/MemzwareAllahLeak/main/woolbreak.mp3"))
                        newsounds.WOOL_BREAK = getasset("MemzWare/Sound/mc/woolbreak.mp3")
                        writefile("MemzWare/Sound/mc/breakwood.mp3",game:HttpGet("https://raw.githubusercontent.com/AllahbloxLeaks/MemzwareAllahLeak/main/breakwood.mp3"))
                        newsounds.WOOD_BREAK = getasset("MemzWare/Sound/mc/breakwood.mp3")
                        writefile("MemzWare/Sound/mc/glassbreak.mp3",game:HttpGet("https://raw.githubusercontent.com/AllahbloxLeaks/MemzwareAllahLeak/main/glassbreak.mp3"))
                        newsounds.GLASS_BREAK = getasset("MemzWare/Sound/mc/glassbreak.mp3")
                        writefile("MemzWare/Sound/mc/tnthiss.mp3",game:HttpGet("https://raw.githubusercontent.com/AllahbloxLeaks/MemzwareAllahLeak/main/tnthiss.mp3"))
                        newsounds.TNT_HISS_1 = getasset("MemzWare/Sound/mc/tnthiss.mp3")
                        writefile("MemzWare/Sound/mc/tntexplode.mp3",game:HttpGet("https://raw.githubusercontent.com/AllahbloxLeaks/MemzwareAllahLeak/main/tntexplode.mp3"))
                        newsounds.TNT_EXPLODE_1 = getasset("MemzWare/Sound/mc/tntexplode.mp3")
                        gamesound = newsounds
                    else
                        array.Remove("MC sounds")
                        disabled("MC sounds", "MC sounds has been set to disabled", 1)
                    end
                end
            })
        end
        --end of Combat

        --loading configurations
        Rayfield:LoadConfiguration()

        --anticheat thing
        --anticheat thing end

        --end of creating modules!