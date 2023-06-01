local lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/std-cin/Bedwars-Archive/main/SkiddedVapeCustoms/Snoopy/Hub/shit/GuiLibary.lua"))()
local getasset = getsynasset or getcustomasset
local ScreenGuitwo = game:GetService("CoreGui").RektskyNotificationGui
local lplr = game:GetService("Players").LocalPlayer
local cam = game:GetService("Workspace").CurrentCamera
function runcode(func)
    func()
end

lib:CreateWindow()
local Tabs = {
    ["Combat"] = lib:CreateTab("Combat",Color3.fromRGB(252,80,68),"combat"),
    ["Blatant"] = lib:CreateTab("Blatant",Color3.fromRGB(255,148,36),"movement"),
    ["Render"] = lib:CreateTab("Render",Color3.fromRGB(59,170,222),"render"),
    ["Utility"] = lib:CreateTab("Utility",Color3.fromRGB(83,214,110),"player"),
    ["World"] = lib:CreateTab("World",Color3.fromRGB(52,28,228),"world"),
    ["Exploits"] = lib:CreateTab("Exploits",Color3.fromRGB(157,39,41),"exploit")
}
local KnitClient = debug.getupvalue(require(lplr.PlayerScripts.TS.knit).setup, 6)
local Client = require(game:GetService("ReplicatedStorage").TS.remotes).default.Client
local cam = game:GetService("Workspace").CurrentCamera
local uis = game:GetService("UserInputService")
function getremote(tab)
    for i,v in pairs(tab) do
        if v == "Client" then
            return tab[i + 1]
        end
    end
    return ""
end



local bedwars = {
    ["Projectile"] = Client:Get(getremote(debug.getconstants(debug.getupvalues(getmetatable(KnitClient.Controllers.ProjectileController)["launchProjectileWithValues"])[2]))),
	["KnockbackTable"] = debug.getupvalue(require(game:GetService("ReplicatedStorage").TS.damage["knockback-util"]).KnockbackUtil.calculateKnockbackVelocity, 1),
	["CombatConstant"] = require(game:GetService("ReplicatedStorage").TS.combat["combat-constant"]).CombatConstant,
	["SprintController"] = KnitClient.Controllers.SprintController,
	["ShopItems"] = debug.getupvalue(require(game:GetService("ReplicatedStorage").TS.games.bedwars.shop["bedwars-shop"]).BedwarsShop.getShopItem, 2),
	["PickupRemote"] = getremote(debug.getconstants(getmetatable(KnitClient.Controllers.ItemDropController).checkForPickup)),
	["DamageController"] = require(lplr.PlayerScripts.TS.controllers.global.damage["damage-controller"]).DamageController,
	["DamageTypes"] = require(game:GetService("ReplicatedStorage").TS.damage["damage-type"]).DamageType,
    ["SwordRemote"] = getremote(debug.getconstants((KnitClient.Controllers.SwordController).attackEntity)),
    ["PingController"] = require(lplr.PlayerScripts.TS.controllers.game.ping["ping-controller"]).PingController,
    ["DamageIndicator"] = KnitClient.Controllers.DamageIndicatorController.spawnDamageIndicator,
    ["ClientHandlerStore"] = require(lplr.PlayerScripts.TS.ui.store).ClientStore,
    ["SwordController"] = KnitClient.Controllers.SwordController,
    ["BlockCPSConstants"] = require(game:GetService("ReplicatedStorage").TS["shared-constants"]).CpsConstants,
    ["BalloonController"] = KnitClient.Controllers.BalloonController,
    ["ViewmodelController"] = KnitClient.Controllers.ViewmodelController,
}
function getQueueType()
    local state = bedwars["ClientHandlerStore"]:getState()
    return state.Game.queueType or "bedwars_test"
end
function CreateNotification(title,text,delay2)
    spawn(function()
        if ScreenGuitwo:FindFirstChild("Background") then ScreenGuitwo:FindFirstChild("Background"):Destroy() end
        local frame = Instance.new("Frame")
        frame.Size = UDim2.new(0, 100, 0, 115)
        frame.Position = UDim2.new(0.5, 0, 0, -115)
        frame.BorderSizePixel = 0
        frame.AnchorPoint = Vector2.new(0.5, 0)
        frame.BackgroundTransparency = 0.5
        frame.BackgroundColor3 = Color3.new(0, 0, 0)
        frame.Name = "Background"
        frame.Parent = ScreenGuitwo
        local frameborder = Instance.new("Frame")
        frameborder.Size = UDim2.new(1, 0, 0, 8)
        frameborder.BorderSizePixel = 0
        frameborder.BackgroundColor3 = Color3.fromRGB(205, 64, 78)
        frameborder.Parent = frame
        local frametitle = Instance.new("TextLabel")
        frametitle.Font = Enum.Font.SourceSansLight
        frametitle.BackgroundTransparency = 1
        frametitle.Position = UDim2.new(0, 0, 0, 30)
        frametitle.TextColor3 = Color3.fromRGB(205, 64, 78)
        frametitle.Size = UDim2.new(1, 0, 0, 28)
        frametitle.Text = "          "..title
        frametitle.TextSize = 24
        frametitle.TextXAlignment = Enum.TextXAlignment.Left
        frametitle.TextYAlignment = Enum.TextYAlignment.Top
        frametitle.Parent = frame
        local frametext = Instance.new("TextLabel")
        frametext.Font = Enum.Font.SourceSansLight
        frametext.BackgroundTransparency = 1
        frametext.Position = UDim2.new(0, 0, 0, 68)
        frametext.TextColor3 = Color3.new(1, 1, 1)
        frametext.Size = UDim2.new(1, 0, 0, 28)
        frametext.Text = "          "..text
        frametext.TextSize = 24
        frametext.TextXAlignment = Enum.TextXAlignment.Left
        frametext.TextYAlignment = Enum.TextYAlignment.Top
        frametext.Parent = frame
        local textsize = game:GetService("TextService"):GetTextSize(frametitle.Text, frametitle.TextSize, frametitle.Font, Vector2.new(100000, 100000))
        local textsize2 = game:GetService("TextService"):GetTextSize(frametext.Text, frametext.TextSize, frametext.Font, Vector2.new(100000, 100000))
        if textsize2.X > textsize.X then textsize = textsize2 end
        frame.Size = UDim2.new(0, textsize.X + 38, 0, 115)
        pcall(function()
            frame:TweenPosition(UDim2.new(0.5, 0, 0, 20), Enum.EasingDirection.InOut, Enum.EasingStyle.Quad, 0.15)
            game:GetService("Debris"):AddItem(frame, delay2 + 0.15)
        end)
    end)
end
function IsAlive(plr)
    plr = plr or lplr
    if not plr.Character then return false end
    if not plr.Character:FindFirstChild("Head") then return false end
    if not plr.Character:FindFirstChild("Humanoid") then return false end
    if plr.Character:FindFirstChild("Humanoid").Health < 0.11 then return false end
    return true
end
function CanWalk(plr)
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
function GetMatchState()
	return bedwars["ClientHandlerStore"]:getState().Game.matchState
end
 
runcode(function()
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
        ["Slow"] = {
            {CFrame = CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(220), math.rad(100), math.rad(100)),Time = 0.25},
            {CFrame = CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0)), Time = 0.25}
        },
        ["Weird"] = {
            {CFrame = CFrame.new(0, 0, 1.5) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0)),Time = 0.25},
            {CFrame = CFrame.new(0, 0, -1.5) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0)),Time = 0.25},
            {CFrame = CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0)), Time = 0.25}
        },
        ["Self"] = {
            {CFrame = CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(-90), math.rad(90), math.rad(90)),Time = 0.25},
            {CFrame = CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0)), Time = 0.25}
        },
        ["Butcher"] = {
            {CFrame = CFrame.new(0, -1, 0) * CFrame.Angles(math.rad(0), math.rad(90), math.rad(0)),Time = 0.3},
            {CFrame = CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0)), Time = 0.3}
        },
        ["VerticalSpin"] = {
			{CFrame = CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(-90), math.rad(8), math.rad(5)), Time = 0.25},
			{CFrame = CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(180), math.rad(3), math.rad(13)), Time = 0.25},
			{CFrame = CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(90), math.rad(-5), math.rad(8)), Time = 0.25},
			{CFrame = CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0)), Time = 0.25}
		}
    }
    local VMAnim = false
    local HitRemote = Client:Get(bedwars["SwordRemote"])
    local origC0 = game:GetService("ReplicatedStorage").Assets.Viewmodel.RightHand.RightWrist.C0
    local DistVal = {["Value"] = 21}
    local Tick = {["Value"] = 0.03}
    local AttackAnim = {["Enabled"] = true}
    local CurrentAnim = {["Value"] = "Slow"}
    local Enabled = false
    local KillAura = Tabs["Combat"]:CreateToggle({
        ["Name"] = "Aura",
        ["Callback"] = function(Callback)
            Enabled = Callback
            if Enabled then
                spawn(function()
                    repeat task.wait() until GetMatchState() ~= 0
                    if not Enabled then return end
                    while task.wait(Tick["Value"]) do
                        if not Enabled then return end
                        for i,v in pairs(game:GetService("Players"):GetChildren()) do
                            if v.Team ~= lplr.Team and IsAlive(v) and IsAlive(lplr) and not v.Character:FindFirstChildOfClass("ForceField") then
                                local mag = (v.Character:FindFirstChild("HumanoidRootPart").Position - lplr.Character:FindFirstChild("HumanoidRootPart").Position).Magnitude
                                if mag < DistVal["Value"] then
                                    local sword = getSword()
                                    spawn(function()
                                        if AttackAnim["Enabled"] then
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
                                            ["entityInstance"] = v.Character,
                                            ["validate"] = {
                                                ["raycast"] = {
                                                    ["cameraPosition"] = hashFunc(cam.CFrame.Position), 
                                                    ["cursorDirection"] = hashFunc(Ray.new(cam.CFrame.Position, v.Character:FindFirstChild("HumanoidRootPart").Position).Unit.Direction)
                                                },
                                                ["targetPosition"] = hashFunc(v.Character:FindFirstChild("HumanoidRootPart").Position),
                                                ["selfPosition"] = hashFunc(lplr.Character:FindFirstChild("HumanoidRootPart").Position + ((lplr.Character:FindFirstChild("HumanoidRootPart").Position - v.Character:FindFirstChild("HumanoidRootPart").Position).magnitude > 14 and (CFrame.lookAt(lplr.Character:FindFirstChild("HumanoidRootPart").Position, v.Character:FindFirstChild("HumanoidRootPart").Position).LookVector * 4) or Vector3.new(0, 0, 0))),
                                            }, 
                                            ["chargedAttack"] = {["chargeRatio"] = 1},
                                        })
                                    end
                                end
                            end
                        end
                    end
                end)
            end
        end
    })
    DistVal = KillAura:CreateSlider({
        ["Name"] = "Range",
        ["Function"] = function() end,
        ["Min"] = 0,
        ["Max"] = 30,
        ["Default"] = 18,
        ["Round"] = 1
    })
    Tick = KillAura:CreateSlider({
        ["Name"] = "Slowness",
        ["Function"] = function() end,
        ["Min"] = 0,
        ["Max"] = 1,
        ["Default"] = 0.38
    })
    CurrentAnim = KillAura:CreateDropDown({
        ["Name"] = "VMAnimation",
        ["Function"] = function(v) 
            CurrentAnim["Value"] = v
        end,
        ["List"] = {"Slow","VerticalSpin"},
        ["Default"] = "Slow"
    })
    AttackAnim = KillAura:CreateOptionTog({
        ["Name"] = "Animation",
        ["Default"] = true,
        ["Func"] = function(v)
            AttackAnim["Enabled"] = v
        end
    })
end)

local function findplayers(arg)
	for i,v in pairs(game:GetService("Players"):GetChildren()) do if v.Name:lower():sub(1, arg:len()) == arg:lower() then return v end end
	return nil
end

local PlayerCrasher = {["Enabled"] = false}
local PlayerCrasherPower = {["Value"] = 50}
local PlayerCrasherDelay = {["Value"] = 0}
local targetedplayer
local RunService = game:GetService("RunService")
runcode(function()
    local Enabled = false
    local Crash = Tabs["Exploits"]:CreateToggle({
        ["Name"] = "PartialCrasher",
        ["Callback"] = function(Callback)
            Enabled = Callback
            if Enabled then
            getgenv().FunnyCrash = true

            for i,v in pairs(game.Players:GetChildren()) do
                if v.Name == game.Players.LocalPlayer.Name then
                    else
                        local args = {[1] = {["player"] = v}}
                        game:GetService("ReplicatedStorage"):FindFirstChild("events-@easy-games/lobby:shared/event/lobby-events@getEvents.Events").inviteToParty:FireServer(unpack(args))
                    end
                end

            for i,v in pairs(game:GetService("ReplicatedStorage"):GetDescendants()) do
                if (v.Name:find("arty") or v.Name:find("otification"))and v:IsA("RemoteEvent") then
                    for i2,v2 in pairs(getconnections(v.OnClientEvent)) do
                        v2:Disable()
                    end
                end
            end

            spawn(function()
                while FunnyCrash == true do
                    for i = 135, 9999999  do
                    local args = {[1] = {["queueType"] = "bedwars_to1"}}
                    game:GetService("ReplicatedStorage"):FindFirstChild("events-@easy-games/lobby:shared/event/lobby-events@getEvents.Events").joinQueue:FireServer(unpack(args))
                    game:GetService("ReplicatedStorage"):FindFirstChild("events-@easy-games/lobby:shared/event/lobby-events@getEvents.Events").leaveQueue:FireServer()
                    wait()
                    end
                end
            end)
            else
            FunnyCrash = false
            end
        end
    })
end)

 
runcode(function()
    local Enabled = false
    local Sprint = Tabs["Combat"]:CreateToggle({
        ["Name"] = "Sprint",
        ["Callback"] = function(Callback)
            Enabled = Callback
            if Enabled then
                spawn(function()
                    repeat
                        task.wait()
                        if not bedwars["SprintController"].sprinting then
                            bedwars["SprintController"]:startSprinting()
                        end
                    until not Enabled
                end)
            else
                bedwars["SprintController"]:stopSprinting()
            end
        end
    })
end)
 
runcode(function()
    local Value = {["Value"] = 18}
    local Enabled = false
    local Reach = Tabs["Combat"]:CreateToggle({
        ["Name"] = "Reach",
        ["Callback"] = function(Callback)
            Enabled = Callback
            if Enabled then
                bedwars["CombatConstant"].RAYCAST_SWORD_CHARACTER_DISTANCE = Value["Value"] - 0.001
            else
                bedwars["CombatConstant"].RAYCAST_SWORD_CHARACTER_DISTANCE = 14.4
            end
        end
    })
    Value = Reach:CreateSlider({
        ["Name"] = "Amount",
        ["Function"] = function() end,
        ["Min"] = 1,
        ["Max"] = 25,
        ["Default"] = 25,
    })
end)
 
runcode(function()
    local Value = {["Value"] = 0}
    local Enabled = false
    local Velocity = Tabs["Combat"]:CreateToggle({
        ["Name"] = "Velocity",
        ["Callback"] = function(Callback)
            Enabled = Callback
            if Enabled then
                bedwars["KnockbackTable"]["kbDirectionStrength"] = 0
				bedwars["KnockbackTable"]["kbUpwardStrength"] = 0
            else
                bedwars["KnockbackTable"]["kbDirectionStrength"] = 100
				bedwars["KnockbackTable"]["kbUpwardStrength"] = 100
            end
        end
    })
end)
 
runcode(function()
    local Enabled = false
    local NoFall = Tabs["Combat"]:CreateToggle({
        ["Name"] = "NoFall",
        ["Callback"] = function(Callback)
            Enabled = Callback
            if Enabled then
                spawn(function()
                    repeat
                        task.wait(0.5)
                        Client:Get("GroundHit"):SendToServer()
                    until not Enabled
                end)
            end
        end
    })
end)
 
 runcode(function()
    local Enabled = false
    local NoFall = Tabs["World"]:CreateToggle({
        ["Name"] = "Lighting",
        ["Callback"] = function(Callback)
            Enabled = Callback
            if Enabled then
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
                print("Disabled next round")
            end
        end
    })
end)
 
runcode(function()
    local Connection
    local FOV = {["Value"] = 120}
    local Enabled = false
    local FOVChanger = Tabs["Render"]:CreateToggle({
        ["Name"] = "FOVChanger",
        ["Callback"] = function(Callback)
            Enabled = Callback
            if Enabled then
                cam.FieldOfView = FOV["Value"]
                Connection = cam:GetPropertyChangedSignal("FieldOfView"):Connect(function()
                    cam.FieldOfView = FOV["Value"]
                end)
            else
                Connection:Disconnect()
                cam.FieldOfView = 80
            end
        end
    })
    FOV = FOVChanger:CreateSlider({
        ["Name"] = "FOV",
        ["Function"] = function() end,
        ["Min"] = 30,
        ["Max"] = 120,
        ["Default"] = 100,
        ["Round"] = 1
    })
end)

runcode(function()
    local Enabled = false
    local TexturePack = Tabs["Render"]:CreateToggle({
        ["Name"] = "TexturePack",
        ["Callback"] = function(Callback)
            Enabled = Callback
            if Enabled then
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
                loadstring(game:HttpGet("https://raw.githubusercontent.com/eLeCtRaDoMiNuS/milkwareclient/main/texture.lua"))()
            end
        end
    })
end)

runcode(function()
    local Messages = {"Pow!","Thump!","Wham!","Hit!","Smack!","Bang!","Pop!","Boom!"}
    local old
    local Enabled = false
    local FunnyIndicator = Tabs["Render"]:CreateToggle({
        ["Name"] = "MeteorIndicator",
        ["Callback"] = function(Callback)
            Enabled = Callback
            if Enabled then
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
                debug.setupvalue(bedwars["DamageIndicator"],10,{
                    Create = old
                })
                old = nil
            end
        end
    })
end)

runcode(function()
    local Enabled = false
    function texturemainfunction()
        local blocks = game:GetService("CollectionService"):GetTagged("block")
        for i,v in pairs(blocks) do
            if v:GetAttribute("PlacedByUserId") == 0 then
                v.Material = (Enabled and Enum.Material.SmoothPlastic or (v.Name:find("glass") and enum.Material.SmoothPlastic or Enum.Material.Fabric))
                for i2,v2 in pairs(v:GetChildren()) do
                    if v2:IsA("Texture") then
                        v2.Transparency = (Enabled and 1) or 0
                    end
                end
            end
        end
    end
    local FPSBoost = Tabs["World"]:CreateToggle({
        ["Name"] = "FPSBoost",
        ["Callback"] = function(Callback)
            Enabled = Callback
            if Enabled then
                texturemainfunction()
            else
                texturemainfunction()
            end
        end
    })
end)

runcode(function()
    local Enabled = false
    local CameraFix = Tabs["Render"]:CreateToggle({
        ["Name"] = "CameraFix",
        ["Callback"] = function(Callback)
            Enabled = Callback
            if Enabled then
                spawn(function()
                    repeat
                        task.wait()
                        UserSettings():GetService("UserGameSettings").RotationType = ((cam.CFrame.Position - cam.Focus.Position).Magnitude <= 0.5 and Enum.RotationType.CameraRelative or Enum.RotationType.MovementRelative)
                    until not Enabled
                end)
            end
        end
    })
end)
 
runcode(function()
    local Connection
    local Enabled = false
    local Smaller = {["Value"] = 3}
    local SmallItems = Tabs["Render"]:CreateToggle({
        ["Name"] = "SmallWeapons",
        ["Callback"] = function(Callback)
            Enabled = Callback
            if Enabled then
                Connection = cam.Viewmodel.ChildAdded:Connect(function(v)
                    if v:FindFirstChild("Handle") then
                        pcall(function()
                            v:FindFirstChild("Handle").Size = v:FindFirstChild("Handle").Size / tostring(Smaller["Value"])
                        end)
                    end
                end)
            else
                Connection:Disconnect()
            end
        end
    })
    Smaller = SmallItems:CreateSlider({
        ["Name"] = "Value",
        ["Function"] = function() end,
        ["Min"] = 0,
        ["Max"] = 10,
        ["Default"] = 3,
        ["Round"] = 1
    })
end)
 
runcode(function()
    local SpeedVal = {["Value"] = 0.11}
    local Enabled = false
    local Mode = {["Value"] = "CFrame"}
    local Speed = Tabs["Blatant"]:CreateToggle({
        ["Name"] = "Speed",
        ["Callback"] = function(Callback)
            Enabled = Callback
            if Enabled then
                spawn(function()
                    repeat task.wait() until GetMatchState() ~= 0
                    while task.wait() do
                        if not Enabled then return end
                        if IsAlive(lplr) and isnetworkowner(lplr.Character:FindFirstChild("HumanoidRootPart")) then
                            local hum = lplr.Character:FindFirstChild("Humanoid")
                            if hum.MoveDirection.Magnitude > 0 then
                                lplr.Character:TranslateBy(hum.MoveDirection * SpeedVal["Value"])
                            end
                        end
                    end
                end)
            end
        end
    })
    SpeedVal = Speed:CreateSlider({
        ["Name"] = "Speed",
        ["Function"] = function() end,
        ["Min"] = 0,
        ["Max"] = 0.1,
        ["Default"] = 0.08,
    })
end)
 
runcode(function()
    local Connection
    local Connection2
    local flydown = false
    local flyup = false
    local usedballoon = false
    local usedfireball = false
    local olddeflate
    local velo
    local Enabled = false
    local Mode = {["Value"] = "Normal", "Long"}
    local Fly = Tabs["Blatant"]:CreateToggle({
        ["Name"] = "Fly",
        ["Callback"] = function(Callback)
            Enabled = Callback
            if Enabled then
                spawn(function()
                    if lplr.Character:FindFirstChild("InventoryFolder").Value:FindFirstChild("balloon") then
                        usedballoon = true
                        olddeflate = bedwars["BalloonController"].deflateBalloon
                        bedwars["BalloonController"].inflateBalloon()
                        bedwars["BalloonController"].deflateBalloon = function() end
                    end
                    
                    velo = Instance.new("BodyVelocity")
                    velo.MaxForce = Vector3.new(0,9e9,0)
                    velo.Parent = lplr.Character:FindFirstChild("HumanoidRootPart")
                    Connection = uis.InputBegan:Connect(function(input)
                        if input.KeyCode == Enum.KeyCode.Space then
                            flyup = true
                        end
                        if input.KeyCode == Enum.KeyCode.LeftShift then
                            flydown = true
                        end
                    end)
                    Connection2 = uis.InputEnded:Connect(function(input)
                        if input.KeyCode == Enum.KeyCode.Space then
                            flyup = false
                        end
                        if input.KeyCode == Enum.KeyCode.LeftShift then
                            flydown = false
                        end
                    end)
                    spawn(function()
                        while task.wait() do
                            if not Enabled then return end
                            if Mode["Value"] == "Long" then
                                for i = 1,7 do
                                    task.wait()
                                    if not Enabled then return end
                                    velo.Velocity = Vector3.new(0,i*1.25+(flyup and 40 or 0)+(flydown and -40 or 0),0)
                                end
                                for i = 1,7 do
                                    task.wait()
                                    if not Enabled then return end
                                    velo.Velocity = Vector3.new(0,-i*1+(flyup and 40 or 0)+(flydown and -40 or 0),0)
                                end
                            elseif Mode["Value"] == "FunnyOld" then
                                for i = 1,15 do
                                    task.wait(0.01)
                                    if not Enabled then return end
                                    velo.Velocity = Vector3.new(0,i*1,0)
                                end
                            elseif Mode["Value"] == "Funny" then
                                for i = 2,30,2 do
                                    task.wait(0.01)
                                    if not Enabled then return end
                                    velo.Velocity = Vector3.new(0,25 + i,0)
                                end
                            elseif Mode["Value"] == "Moonsoon" then
                                for i = 1,10 do
                                    task.wait()
                                    if not Enabled then return end
                                    velo.Velocity = Vector3.new(0,-i*0.7,0)
                                end
                            elseif Mode["Value"] == "Bounce" then
                                for i = 1,15 do
                                    task.wait()
                                    if not Enabled then return end
                                    velo.Velocity = Vector3.new(0,i*1.25+(flyup and 40 or 0)+(flydown and -40 or 0),0)
                                end
                                for i = 1,15 do
                                    task.wait()
                                    if not Enabled then return end
                                    velo.Velocity = Vector3.new(0,-i*1+(flyup and 40 or 0)+(flydown and -40 or 0),0)
                                end
                            elseif Mode["Value"] == "Bounce2" then
                                for i = 1,15 do
                                    task.wait()
                                    if not Enabled then return end
                                    velo.Velocity = Vector3.new(0,i*1.25+(flyup and 40 or 0)+(flydown and -40 or 0),0)
                                end
                                velo.Velocity = Vector3.new(0,0,0)
                                task.wait(0.05)
                                for i = 1,15 do
                                    task.wait()
                                    if not Enabled then return end
                                    velo.Velocity = Vector3.new(0,-i*1+(flyup and 40 or 0)+(flydown and -40 or 0),0)
                                end
                                task.wait(0.05)
                                velo.Velocity = Vector3.new(0,0,0)
                            else
                                Mode["Value"] = "Long"
                                lib["ToggleFuncs"]["Fly"](true)
                                task.wait(0.1)
                                lib["ToggleFuncs"]["Fly"](true)
                            end
                        end
                    end)
                end)
            else
                velo:Destroy()
                Connection:Disconnect()
                Connection2:Disconnect()
                flyup = false
                flydown = false
                if usedballoon == true then
                    usedballoon = false
                    bedwars["BalloonController"].deflateBalloon = olddeflate
                    bedwars["BalloonController"].deflateBalloon()
                    olddeflate = nil
                end
            end
        end
    })
end)

runcode(function()
    local Expand = {["Value"] = 1}
    local function getwool()
        for i,v in pairs(lplr.Character:FindFirstChild("InventoryFolder").Value:GetChildren()) do
            if string.lower(v.Name):find("wool") then
                return {
                    Obj = v,
                    Amount = v:GetAttribute("Amount")
                }
            end
        end
        return nil
    end
    local function getwoolamount()
        local value = 0
        for i,v in pairs(lplr.Character:FindFirstChild("InventoryFolder").Value:GetChildren()) do
            if string.lower(v.Name):find("wool") then
                value = value + v:GetAttribute("Amount")
            end
        end
        return value
    end
    local function getpos()
        local primpart = lplr.Character.PrimaryPart
        local x = math.round(primpart.Position.X/3)
        local y = math.round(primpart.Position.Y/3)
        local z = math.round(primpart.Position.Z/3)
        local realexpand = Expand["Value"] + 1
        return Vector3.new(x,y-1,z) + (lplr.Character:FindFirstChild("HumanoidRootPart").CFrame.LookVector * math.round(Expand["Value"]))
    end
    local ui
    spawn(function()
        ui = Instance.new("ScreenGui",game:GetService("CoreGui"))
        ui.Name = "ScaffoldUI"
        ui.Enabled = false
        if syn then syn.protect_gui(ui) end
        local label = Instance.new("TextLabel")
        label.TextSize = 16
        label.Position = UDim2.new(0.4404,0,0.4700,0)
        label.Size = UDim2.new(0.1181,0,0.1374,0)
        label.BackgroundColor3 = Color3.fromRGB(255,255,255)
        label.BackgroundTransparency = 1
        label.Text = "Blocks Left: 0"
        label.TextColor3 = Color3.fromRGB(65,65,255)
        label.Parent = ui
    end)
    local old
    local Enabled = false
    local ShowAmount = {["Enabled"] = false}
    local Scaffold = Tabs["Blatant"]:CreateToggle({
        ["Name"] = "Scaffold",
        ["Callback"] = function(Callback)
            Enabled = Callback
            if Enabled then
                ui.Enabled = true
                spawn(function()
                    old = bedwars["BlockCPSConstants"].BLOCK_PLACE_CPS
                    bedwars["BlockCPSConstants"].BLOCK_PLACE_CPS = 9999
                    while task.wait() do
                        if not Enabled then return end
                        if IsAlive(lplr) then
                            spawn(function()
                                ui.TextLabel.Text = "BlocksLeft: "..getwoolamount()
                            end)
                            if getwool() ~= nil then
                                game:GetService("ReplicatedStorage").rbxts_include.node_modules:FindFirstChild("@rbxts").net.out._NetManaged.PlaceBlock:InvokeServer({
                                    ["position"] = getpos(),
                                    ["blockType"] = getwool().Obj.Name
                                })
                            end
                        end
                    end
                end)
            else
                ui.Enabled = false
                bedwars["BlockCPSConstants"].BLOCK_PLACE_CPS = old
            end
        end
    })
    ShowAmount = Scaffold:CreateOptionTog({
        ["Name"] = "ShowAmount",
        ["Default"] = true,
        ["Func"] = function(v)
            ShowAmount["Enabled"] = v
            if Enabled then
                ui.Enabled = v
            end
        end
    })
end)

runcode(function()
    local velo
    local Enabled = false
    local HighJump = Tabs["Blatant"]:CreateToggle({
        ["Name"] = "HighJump",
        ["Callback"] = function(Callback)
            Enabled = Callback
            if Enabled then
                local hrp = lplr.Character:FindFirstChild("HumanoidRootPart")
                velo = Instance.new("BodyVelocity")
                velo.Velocity = Vector3.new(0,0,0)
                velo.MaxForce = Vector3.new(0,9e9,0)
                velo.Parent = hrp
                spawn(function()
                    while task.wait() do
                        if not Enabled then return end
                        for i = 1,30 do
                            task.wait()
                            if not Enabled then return end
                            velo.Velocity = velo.Velocity + Vector3.new(0,i*0.25,0)
                        end
                    end
                end)
            else
                if velo then
                    velo:Destroy()
                    velo = nil
                end
            end
        end
    })
end)

 runcode(function()
    local ui
    spawn(function()
        ui = Instance.new("ScreenGui",game:GetService("CoreGui"))
        ui.Name = "BetterFlyUI"
        ui.Enabled = false
        if syn then syn.protect_gui(ui) end
        local label = Instance.new("TextLabel")
        label.TextSize = 16
        label.Position = UDim2.new(0.4404,0,0.4700,0)
        label.Size = UDim2.new(0.1181,0,0.1374,0)
        label.BackgroundColor3 = Color3.fromRGB(255,255,255)
        label.BackgroundTransparency = 1
        label.Text = "Safe\nStuds: 0\nY: 0\nTime: 0"
        label.TextColor3 = Color3.fromRGB(65,255,65)
        label.Parent = ui
    end)
    local velo
    local part
    local clone
    local Enabled = false
    local BetterFly = Tabs["Blatant"]:CreateToggle({
        ["Name"] = "GhostFly",
        ["Callback"] = function(Callback)
            Enabled = Callback
            if Enabled then
                spawn(function()
                    local char = lplr.Character
                    local starttick = tick()
                    local startpos = char:FindFirstChild("HumanoidRootPart").Position
                    ui.Enabled = true
                    char.Archivable = true
                    clone = char:Clone()
                    velo = Instance.new("BodyVelocity")
                    velo.MaxForce = Vector3.new(9e9,9e9,9e9)
                    velo.Parent = char:FindFirstChild("HumanoidRootPart")
                    clone.Parent = game:GetService("Workspace")
                    cam.CameraSubject = clone:FindFirstChild("Humanoid")
                    part = Instance.new("Part")
                    part.Anchored = true
                    part.Size = Vector3.new(10,1,10)
                    part.Transparency = 1
                    part.CFrame = clone:FindFirstChild("HumanoidRootPart").CFrame - Vector3.new(0,5,0)
                    part.Parent = game:GetService("Workspace")
                    for i,v in pairs(char:GetChildren()) do
                        if string.lower(v.ClassName):find("part") and v.Name ~= "HumanoidRootPart" then
                            v.Transparency = 1
                        end
                        if v:IsA("Accessory") then
                            v:FindFirstChild("Handle").Transparency = 1
                        end
                    end
                    char:FindFirstChild("Head"):FindFirstChild("face").Transparency = 1
                    spawn(function()
                        while task.wait() do
                            if not Enabled then
                                local studs = (startpos - char:FindFirstChild("HumanoidRootPart").Position).Magnitude
                                local time_ = math.abs(starttick - tick())
                                
                                return
                            end
                            local studs = (startpos - char:FindFirstChild("HumanoidRootPart").Position).Magnitude
                            local Y = char:FindFirstChild("HumanoidRootPart").Position.Y
                            local calctime = math.abs(starttick - tick())
                            if isnetworkowner(char:FindFirstChild("HumanoidRootPart")) then
                                ui.TextLabel.TextColor3 = Color3.fromRGB(65,255,65)
                                ui.TextLabel.Text = "Safe\nStuds: "..math.floor(studs).."\nY: "..math.floor(Y).."\nTime: "..math.floor(calctime)
                            else
                                ui.TextLabel.TextColor3 = Color3.fromRGB(255,65,65)
                                ui.TextLabel.Text = "Unsafe\nStuds: "..math.floor(studs).."\nY: "..math.floor(Y).."\nTime: "..math.floor(calctime)
                            end
                        end
                    end)
                    spawn(function()
                        while task.wait() do
                            if not Enabled then return end
                            for i = 2,30,2 do
                                task.wait(0.01)
                                if not Enabled then return end
                                part.CFrame = CFrame.new(clone:FindFirstChild("HumanoidRootPart").CFrame.X,part.CFrame.Y,clone:FindFirstChild("HumanoidRootPart").CFrame.Z)
                                clone:FindFirstChild("HumanoidRootPart").CFrame = CFrame.new(char:FindFirstChild("HumanoidRootPart").CFrame.X,clone:FindFirstChild("HumanoidRootPart").CFrame.Y,char:FindFirstChild("HumanoidRootPart").CFrame.Z)
                                clone:FindFirstChild("HumanoidRootPart").Rotation = char:FindFirstChild("HumanoidRootPart").Rotation
                                if char:FindFirstChild("Humanoid").MoveDirection.Magnitude > 0 then
                                    velo.Velocity = lplr.Character:FindFirstChild("HumanoidRootPart").CFrame.LookVector * char:FindFirstChild("Humanoid").WalkSpeed + Vector3.new(0,150 + i,0)
                                else
                                    velo.Velocity = Vector3.new(0,150 + i,0)
                                end
                            end
                        end
                    end)
                end)
            else
                for i,v in pairs(lplr.Character:GetChildren()) do
                    if string.lower(v.ClassName):find("part") and v.Name ~= "HumanoidRootPart" then
                        v.Transparency = 0
                    end
                    if v:IsA("Accessory") then
                        v:FindFirstChild("Handle").Transparency = 0
                    end
                end
                lplr.Character:FindFirstChild("Head"):FindFirstChild("face").Transparency = 0
                cam.CameraSubject = lplr.Character:FindFirstChild("Humanoid")
                task.delay(0.1, function() velo:Destroy() end)
                velo.Velocity = Vector3.new(0,-100,0)
                velo:Destroy()
                part:Destroy()
                clone:Destroy()
                ui.Enabled = false
            end
        end
    })
end)

runcode(function()
    local Speed = {["Value"] = 30}
    local Enabled = false
    local Spider = Tabs["Blatant"]:CreateToggle({
        ["Name"] = "Spider",
        ["Callback"] = function(Callback)
            Enabled = Callback
            if Enabled then
                spawn(function()
                    while task.wait() do
                        if not Enabled then return end
                        if IsAlive(lplr) then
                            local param = RaycastParams.new()
                            param.FilterDescendantsInstances = {game:GetService("CollectionService"):GetTagged("block")}
                            param.FilterType = Enum.RaycastFilterType.Whitelist
                            local ray = game:GetService("Workspace"):Raycast(lplr.Character:FindFirstChild("Head").Position-Vector3.new(0,3,0),lplr.Character:FindFirstChild("Humanoid").MoveDirection*3,param)
                            local ray2 = game:GetService("Workspace"):Raycast(lplr.Character:FindFirstChild("Head").Position,lplr.Character:FindFirstChild("Humanoid").MoveDirection*3,param)
                            if ray or ray2 then
                                local velo = Vector3.new(0,Speed["Value"]/100,0)
                                lplr.Character:TranslateBy(velo)
                                local old = lplr.Character:FindFirstChild("HumanoidRootPart").Velocity
                                lplr.Character:FindFirstChild("HumanoidRootPart").Velocity = Vector3.new(old.X,velo.Y*70,old.Z)
                            end
                        else
                            task.wait()
                        end
                    end
                end)
            end
        end
    })
    Speed = Spider:CreateSlider({
        ["Name"] = "Speed",
        ["Function"] = function() end,
        ["Min"] = 0,
        ["Max"] = 30,
        ["Default"] = 30,
        ["Round"] = 1
    })
end)
 
runcode(function()
    local Enabled = false
    local AutoPlayAgain = Tabs["Utility"]:CreateToggle({
        ["Name"] = "AutoPlay",
        ["Callback"] = function(Callback)
            Enabled = Callback
            if Enabled then
                spawn(function()
                    repeat task.wait(3) until GetMatchState() == 2 or not Enabled
                    if not Enabled then return end
                    game:GetService("ReplicatedStorage"):FindFirstChild("events-@easy-games/lobby:shared/event/lobby-events@getEvents.Events").joinQueue:FireServer({["queueType"] = getQueueType()})
                    return
                end)
            end
        end
    })
end)

runcode(function()
    local Connection
    local Enabled = false
    local NoClickDelay = Tabs["Utility"]:CreateToggle({
        ["Name"] = "RemoveName",
        ["Callback"] = function(Callback)
            Enabled = Callback
            if Enabled then
                lplr.Character:WaitForChild("Head"):WaitForChild("NameTag"):Destroy()
                Connection = lplr.CharacterAdded:Connect(function(v)
                    v:WaitForChild("Head"):WaitForChild("NameTag"):Destroy()
                end)
            else
                Connection:Disconnect()
            end
        end
    })
end)

runcode(function()
    local Enabled = false
    local Skywars = Tabs["Utility"]:CreateToggle({
        ["Name"] = "AutoFish",
        ["Callback"] = function(Callback)
            Enabled = Callback
            if Enabled then
				oldfish = bedwars["FishermanTable"].startMinigame
			bedwars["FishermanTable"].startMinigame = function(Self, dropdata, func) func({win = true}) end
            else
               bedwars["FishermanTable"].startMinigame = oldfish
			oldfish = nil
            end
        end
    })
end)

runcode(function()
    local Connection
    local Enabled = false
    local ShopTierBypass = Tabs["Utility"]:CreateToggle({
        ["Name"] = "ShopTierBypass",
        ["Callback"] = function(Callback)
            Enabled = Callback
            if Enabled then
				for i,v in pairs(bedwars["ShopItems"]) do
					v["tiered"] = nil
					v["nextTier"] = nil
				end
            end
        end
    })
end)

runcode(function()
    local AntiVoiding = false
    local Connection
    local part
    local YPos
    local Enabled = false
    local Mode = {["Value"] = "VeloHop"}
    local AntiVoid = Tabs["World"]:CreateToggle({
        ["Name"] = "AntiVoid",
        ["Callback"] = function(Callback)
            Enabled = Callback
            if Enabled then
                if not YPos then
                    local blocks = game:GetService("CollectionService"):GetTagged("block")
                    local blockraycast = RaycastParams.new()
                    blockraycast.FilterType = Enum.RaycastFilterType.Whitelist
					blockraycast.FilterDescendantsInstances = blocks
                    local lowestpos = 99999
                    for i,v in pairs(blocks) do
                        local newray = game:GetService("Workspace"):Raycast(v.Position+Vector3.new(0,800,0),Vector3.new(0,-1000,0),blockraycast)
                        if i % 200 == 0 then
                            task.wait(0.06)
                        end
                        if newray and newray.Position.Y < lowestpos then
                            lowestpos = newray.Position.Y
                        end
                    end
                    YPos = lowestpos - 8
                end
                part = Instance.new("Part")
                part.Anchored = true
                part.Size = Vector3.new(5000,3,5000)
                part.Material = Enum.Material.Neon
                part.Color = Color3.fromRGB(191, 64, 191)
                part.Transparency = 0.5
                part.Position = Vector3.new(0,YPos,0)
                part.Parent = game:GetService("Workspace")
                Connection = part.Touched:Connect(function(v)
                    if v.Parent.Name == lplr.Name and IsAlive(lplr) and not AntiVoiding then
                        AntiVoiding = true
                        if Mode["Value"] == "Velocity" then
                            for i = 1,25 do
                                task.wait()
                                lplr.Character:FindFirstChild("HumanoidRootPart").Velocity = lplr.Character:FindFirstChild("HumanoidRootPart").Velocity + Vector3.new(0,7,0)
                            end
                        elseif Mode["Value"] == "Normal" then
                            for i = 1,3 do
                                task.wait(0.3)
                                lplr.Character:FindFirstChild("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping)
                            end
                        end
                        task.wait(0.25)
                        AntiVoiding = false
                    end
                end)
            else
                part:Destroy()
                Connection:Disconnect()
                AntiVoiding = false
            end
        end
    })
    Mode = AntiVoid:CreateDropDown({
        ["Name"] = "Mode",
        ["Function"] = function() end,
        ["List"] = {"Normal"},
        ["Default"] = "Normal"
    })
end)

runcode(function()
    local MaxStuds = {["Value"] = 30}
    local function ChestStealerFunc()
        for i,v in pairs(game:GetService("CollectionService"):GetTagged("chest")) do
            local mag = (lplr.Character:FindFirstChild("HumanoidRootPart").Position - v.Position).Magnitude
            if mag < MaxStuds["Value"] then
                local chest = v:FindFirstChild("ChestFolderValue")
                chest = chest and chest.Value or nil
                local chestitems = chest and chest:GetChildren() or {}
                if #chestitems > 0 then
                    Client:GetNamespace("Inventory"):Get("SetObservedChest"):SendToServer(chest)
                    for i3,v3 in pairs(chestitems) do
                        if v3:IsA("Accessory") then
                            pcall(function()
                                Client:GetNamespace("Inventory"):Get("ChestGetItem"):CallServer(v.ChestFolderValue.Value,v3)
                            end)
                        end
                    end
                    Client:GetNamespace("Inventory"):Get("SetObservedChest"):SendToServer(nil)
                end
            end
        end
    end
    local Enabled = false
    local ChestStealer = Tabs["World"]:CreateToggle({
        ["Name"] = "ChestStealer",
        ["Callback"] = function(Callback)
            Enabled = Callback
            if Enabled then
                spawn(function()
                    while task.wait(0.01) do
                        if Enabled == false then return end
                        if IsAlive(lplr) then
                            ChestStealerFunc()
                        end
                    end
                end)
            end
        end
    })
    MaxStuds = ChestStealer:CreateSlider({
        ["Name"] = "Distance",
        ["Function"] = function() end,
        ["Min"] = 0,
        ["Max"] = 30,
        ["Default"] = 30,
        ["Round"] = 1
    })
end)
 
runcode(function()
    local Enabled = false
    local StoneExploit = Tabs["Exploits"]:CreateToggle({
        ["Name"] = "SwordExploit",
        ["Callback"] = function(Callback)
            Enabled = Callback
            if Enabled then
                spawn(function()
                    if GetMatchState() ~= 0 then
                        return
                    end
                    lplr.Character:WaitForChild("InventoryFolder").Value:WaitForChild("stone_sword")
                    Client:GetNamespace("Inventory"):Get("SetObservedChest"):SendToServer(game:GetService("ReplicatedStorage").Inventories:FindFirstChild(lplr.Name.."_personal"))
                    Client:GetNamespace("Inventory"):Get("ChestGiveItem"):CallServer(
                        game:GetService("ReplicatedStorage").Inventories:FindFirstChild(lplr.Name.."_personal"),
                        lplr.Character:FindFirstChild("InventoryFolder").Value:FindFirstChild("stone_sword")
                    )
                    Client:GetNamespace("Inventory"):Get("SetObservedChest"):SendToServer(nil)
                    repeat task.wait() until GetMatchState() == 1
                    task.wait(1)
                    Client:GetNamespace("Inventory"):Get("SetObservedChest"):SendToServer(game:GetService("ReplicatedStorage").Inventories:FindFirstChild(lplr.Name.."_personal"))
                    Client:GetNamespace("Inventory"):Get("ChestGetItem"):CallServer(
                        game:GetService("ReplicatedStorage").Inventories:FindFirstChild(lplr.Name.."_personal"),
                        game:GetService("ReplicatedStorage").Inventories:FindFirstChild(lplr.Name.."_personal").stone_sword
                    )
                    Client:GetNamespace("Inventory"):Get("SetObservedChest"):SendToServer(nil)
                end)
            end
        end
    })
end)
 
 runcode(function()
    local BreakingMsg = false
    local params = RaycastParams.new()
    params.IgnoreWater = true
    function NukerFunction(part)
        local raycastResult = game:GetService("Workspace"):Raycast(part.Position + Vector3.new(0,24,0),Vector3.new(0,-27,0),params)
        if raycastResult then
            local targetblock = raycastResult.Instance
            for i,v in pairs(targetblock:GetChildren()) do
                if v:IsA("Texture") then
                    v:Destroy()
                end
            end
            targetblock.Color = Color3.fromRGB(255,65,65)
            targetblock.Material = Enum.Material.Neon
            game:GetService("ReplicatedStorage").rbxts_include.node_modules:FindFirstChild("@rbxts").net.out._NetManaged.DamageBlock:InvokeServer({
                ["blockRef"] = {
                    ["blockPosition"] = Vector3.new(math.round(targetblock.Position.X/3),math.round(targetblock.Position.Y/3),math.round(targetblock.Position.Z/3))
                },
                ["hitPosition"] = Vector3.new(math.round(targetblock.Position.X/3),math.round(targetblock.Position.Y/3),math.round(targetblock.Position.Z/3)),
                ["hitNormal"] = Vector3.new(math.round(targetblock.Position.X/3),math.round(targetblock.Position.Y/3),math.round(targetblock.Position.Z/3))
            })
            if BreakingMsg == false then
                BreakingMsg = true
                print("Breaking bed")
                spawn(function()
                    task.wait(3)
                    BreakingMsg = false
                end)
            end
        end
    end
    function GetBeds()
        local beds = {}
        for i,v in pairs(game:GetService("Workspace"):GetChildren()) do
            if string.lower(v.Name) == "bed" and v:FindFirstChild("Covers") ~= nil and v:FindFirstChild("Covers").BrickColor ~= lplr.Team.TeamColor then
                table.insert(beds,v)
            end
        end
        return beds
    end
    local Enabled = false
    local Distance = {["Value"] = 30}
    local Animation = {["Enabled"] = false}
    local Nuker = Tabs["World"]:CreateToggle({
        ["Name"] = "Nuker",
        ["Callback"] = function(Callback)
            Enabled = Callback
            if Enabled then
                spawn(function()
                    while task.wait(0.1) do
                        if not Enabled then return end
                        spawn(function()
                            if lplr:GetAttribute("DenyBlockBreak") == true then
                                lplr:SetAttribute("DenyBlockBreak",nil)
                            end
                        end)
                        if IsAlive(lplr) then
                            local beds = GetBeds()
                            for i,v in pairs(beds) do
                                local mag = (v.Position - lplr.Character.PrimaryPart.Position).Magnitude
                                if mag < Distance["Value"] then
                                    NukerFunction(v)
                                end
                            end
                        end
                    end
                end)
            end
        end
    })
    Distance = Nuker:CreateSlider({
        ["Name"] = "Distance",
        ["Function"] = function() end,
        ["Min"] = 0,
        ["Max"] = 30,
        ["Default"] = 30,
        ["Round"] = 1
    })
end)

runcode(function()
    function GetBeds()
        local beds = {}
        for i,v in pairs(game:GetService("Workspace"):GetChildren()) do
            if string.lower(v.Name) == "bed" and v:FindFirstChild("Covers") ~= nil and v:FindFirstChild("Covers").BrickColor ~= lplr.Team.TeamColor then
                table.insert(beds,v)
            end
        end
        return beds
    end
    function GetPlayers()
        local players = {}
        for i,v in pairs(game:GetService("Players"):GetPlayers()) do
            if v.Team ~= lplr.Team and IsAlive(v) then
                table.insert(players,v)
            end
        end
        return players
    end
    local Enabled = false
    local AutoWin = Tabs["Exploits"]:CreateToggle({
        ["Name"] = "SlowAutoWin",
        ["Callback"] = function(Callback)
            Enabled = Callback
            if Enabled then
                spawn(function()
                    if GetMatchState() ~= 1 then
                        repeat task.wait() until GetMatchState() == 1 or not Enabled
                        if not Enabled then return end
                    end
                    local start = tick()
                    local beds = GetBeds()
                    for i,v in pairs(beds) do
                        repeat
                            task.wait(0.01)
                            if lplr:GetAttribute("DenyBlockBreak") == true then
                                lplr:SetAttribute("DenyBlockBreak",nil)
                            end
                            lplr.Character:FindFirstChild("HumanoidRootPart").CFrame = v.CFrame + Vector3.new(0,3,0)
                            local x = math.round(v.Position.X/3)
                            local y = math.round(v.Position.Y/3)
                            local z = math.round(v.Position.Z/3)
                            game:GetService("ReplicatedStorage").rbxts_include.node_modules:FindFirstChild("@rbxts").net.out._NetManaged.DamageBlock:InvokeServer({
                                ["blockRef"] = {
                                    ["blockPosition"] = Vector3.new(x,y,z)
                                },
                                ["hitPosition"] = Vector3.new(x,y,z),
                                ["hitNormal"] = Vector3.new(x,y,z)
                            })
                        until not v:FindFirstChild("Covers") or not v or not Enabled
                        if not Enabled then return end
                    end
                    local players = GetPlayers()
                    for i,v in pairs(players) do
                        repeat
                            task.wait(0.01)
                            lplr.Character:FindFirstChild("HumanoidRootPart").CFrame = v.Character:FindFirstChild("HumanoidRootPart").CFrame + Vector3.new(0,3,0)
                        until not IsAlive(v)
                    end
                    CreateNotification("AutoWin","Took "..math.abs(start - tick()).." Seconds/Ticks to win Game",5)
                end)
            end
        end
    })
end)

runcode(function()
    local Enabled = false
    local Skywars = Tabs["Exploits"]:CreateToggle({
        ["Name"] = "TrumpetAura",
        ["Callback"] = function(Callback)
            Enabled = Callback
            if Enabled then
               getgenv().Aura = true
               spawn(function()
                   while Aura == true do
                       local args = {[1] = "TRUMPET_PLAY"}
                       game:GetService("ReplicatedStorage"):FindFirstChild("events-@easy-games/game-core:shared/game-core-networking@getEvents.Events").useAbility:FireServer(unpack(args))
                       game:GetService("ReplicatedStorage").rbxts_include.node_modules:FindFirstChild("@rbxts").net.out._NetManaged.ldzwbijyvmlYiTzzalrcvgOmClbeekhiDc:InvokeServer()
                       wait()
                   end
               end)
            else
               getgenv().Aura = false
            end
        end
    })
end)

runcode(function()
    local Enabled = false
    local EmeraldsExploit = Tabs["Exploits"]:CreateToggle({
        ["Name"] = "PickUpEmeralds",
        ["Callback"] = function(Callback)
            Enabled = Callback
            if Enabled then
                spawn(function()
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").ItemDrops.emerald.CFrame
                end)
            end
        end
    })
end)
 
 runcode(function()
    local Enabled = false
    local DiamondsExploit = Tabs["Exploits"]:CreateToggle({
        ["Name"] = "PickupDiamonds",
        ["Callback"] = function(Callback)
            Enabled = Callback
            if Enabled then
                spawn(function()
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").ItemDrops.diamond.CFrame
                end)
            end
        end
    })
end)
 

runcode(function()
    function HasTNT()
        if IsAlive(lplr) and lplr.Character:FindFirstChild("InventoryFolder").Value:FindFirstChild("tnt") then
            return true
        end
        return false
    end
    function getpos()
        local x = math.round(lplr.Character.PrimaryPart.Position.X/3)
        local y = math.round(lplr.Character.PrimaryPart.Position.Y/3)
        local z = math.round(lplr.Character.PrimaryPart.Position.Z/3)
        return Vector3.new(x,y,z)
    end
    local Speed = {["Value"] = 90}
    local Up = {["Value"] = 5}
    local velo
    local Enabled = false
    local TNTFly = Tabs["Blatant"]:CreateToggle({
        ["Name"] = "TNTFly",
        ["Callback"] = function(Callback)
            Enabled = Callback
            if Enabled then
                velo = Instance.new("BodyVelocity")
                velo.MaxForce = Vector3.new(9e9,9e9,9e9)
                velo.Velocity = Vector3.new(0,0.5,0)
                velo.Parent = lplr.Character:FindFirstChild("HumanoidRootPart")
                if not HasTNT() then
                    lib["ToggleFuncs"]["TNTFly"](true)
                    return
                end
                game:GetService("ReplicatedStorage").rbxts_include.node_modules:FindFirstChild("@rbxts").net.out._NetManaged.PlaceBlock:InvokeServer({
                    ["position"] = getpos(),
                    ["blockType"] = "tnt"
                })
                task.wait(3)
                lplr.Character:FindFirstChild("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping)
                velo.Velocity = lplr.Character:FindFirstChild("HumanoidRootPart").CFrame.LookVector * Speed["Value"] + Vector3.new(0,Up["Value"],0)
                lplr.Character:FindFirstChild("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping)
            else
                velo:Destroy()
            end
        end
    })
    Speed = TNTFly:CreateSlider({
        ["Name"] = "Speed",
        ["Function"] = function() end,
        ["Min"] = 0,
        ["Max"] = 125,
        ["Default"] = 80,
        ["Round"] = 1
    })
    Up = TNTFly:CreateSlider({
        ["Name"] = "Height",
        ["Function"] = function() end,
        ["Min"] = 10,
        ["Max"] = 100,
        ["Default"] = 25,
        ["Round"] = 1
    })
end)

 runcode(function()
    local Enabled = false
    local vulflyys = Tabs["Blatant"]:CreateToggle({
        ["Name"] = "VulcanFly",
        ["Callback"] = function(Callback)
            Enabled = Callback
            if Enabled then
                velo = Instance.new("BodyVelocity")

                velo.MaxForce = Vector3.new(0,9e9,0)
                velo.Parent = lplr.Character:FindFirstChild("HumanoidRootPart")
                spawn(function()
                    repeat
                        task.wait(0.1)
                        
                            velo.Velocity = Vector3.new(0,1,0)
                            task.wait(0.15)
                            velo.Velocity = Vector3.new(0,0.1,0)
                        
                            task.wait(0.15)
                            velo.Velocity = Vector3.new(1,0,0)
                            task.wait(0.15)
                            velo.Velocity = Vector3.new(0.1,0,0)
                            task.wait(0.15)
                            velo.Velocity = Vector3.new(0,0,1)
                            task.wait(0.15)
                            velo.Velocity = Vector3.new(0,0,0.1)
                            
                        
                        
                    until not Enabled
                end)
            else
                velo:Destroy()
                for i,v in pairs(lplr.Character:FindFirstChild("HumanoidRootPart"):GetChildren()) do
                    if v:IsA("BodyVelocity") then
                        v:Destroy()
                    end
                end
                end


                
            end
        
    })
end)
if not game:IsLoaded() then game.Loaded:Wait() end
local injected = true
local oldrainbow = false
local customdir = (shared.VapePrivate and "vapeprivate/" or "vape/")
local betterisfile = function(file)
	local suc, res = pcall(function() return readfile(file) end)
	return suc and res ~= nil
end
local function GetURL(scripturl)
	if shared.VapeDeveloper then
		if not betterisfile("vape/"..scripturl) then
			error("File not found : vape/"..scripturl)
		end
		return readfile("vape/"..scripturl)
	else
		local res = game:HttpGet("https://raw.githubusercontent.com/7GrandDadPGN/VapeV4ForRoblox/main/"..scripturl, true)
		assert(res ~= "404: Not Found", "File not found")
		return res
	end
end
local getasset = getsynasset or getcustomasset or function(location) return "rbxasset://"..location end
local queueteleport = syn and syn.queue_on_teleport or queue_on_teleport or fluxus and fluxus.queue_on_teleport or function() end
local requestfunc = syn and syn.request or http and http.request or http_request or fluxus and fluxus.request or request or function(tab)
	if tab.Method == "GET" then
		return {
			Body = game:HttpGet(tab.Url, true),
			Headers = {},
			StatusCode = 200
		}
	else
		return {
			Body = "bad exploit",
			Headers = {},
			StatusCode = 404
		}
	end
end 

local function checkassetversion()
	local req = requestfunc({
		Url = "https://raw.githubusercontent.com/7GrandDadPGN/VapeV4ForRoblox/main/assetsversion.dat",
		Method = "GET"
	})
	if req.StatusCode == 200 then
		return req.Body
	else
		return nil
	end
end

if not (getasset and requestfunc and queueteleport) then
	print("Vape not supported with your exploit.")
	return
end

if shared.VapeExecuted then
	error("Vape Already Injected")
	return
else
	shared.VapeExecuted = true
end

if isfolder(customdir:gsub("/", "")) == false then
	makefolder(customdir:gsub("/", ""))
end
if isfolder("vape") == false then
	makefolder("vape")
end
if not betterisfile("vape/assetsversion.dat") then
	writefile("vape/assetsversion.dat", "1")
end
if isfolder(customdir.."CustomModules") == false then
	makefolder(customdir.."CustomModules")
end
if isfolder(customdir.."Profiles") == false then
	makefolder(customdir.."Profiles")
end
if not betterisfile("vape/language.dat") then
	writefile("vape/language.dat", "en-us")
end
local assetver = checkassetversion()
if assetver and assetver > readfile("vape/assetsversion.dat") then
	if shared.VapeDeveloper == nil then
		if isfolder("vape/assets") then
			if delfolder then
				delfolder("vape/assets")
			end
		end
		writefile("vape/assetsversion.dat", assetver)
	end
end
if isfolder("vape/assets") == false then
	makefolder("vape/assets")
end

local GuiLibrary = loadstring(GetURL("NewGuiLibrary.lua"))()
local translations = {}--loadstring(GetURL("translations/"..GuiLibrary["Language"]..".vapetranslation"))()
local translatedlogo = false--pcall(function() return GetURL("translations/"..GuiLibrary["Language"].."/VapeLogo1.png") end)

local checkpublicreponum = 0
local checkpublicrepo
checkpublicrepo = function(id)
	local suc, req = pcall(function() return requestfunc({
		Url = "https://raw.githubusercontent.com/7GrandDadPGN/VapeV4ForRoblox/main/CustomModules/"..id..".lua",
		Method = "GET"
	}) end)
	if not suc then
		checkpublicreponum = checkpublicreponum + 1
		spawn(function()
			local textlabel = Instance.new("TextLabel")
			textlabel.Size = UDim2.new(1, 0, 0, 36)
			textlabel.Text = "Loading CustomModule Failed!, Attempts : "..checkpublicreponum
			textlabel.BackgroundTransparency = 1
			textlabel.TextStrokeTransparency = 0
			textlabel.TextSize = 30
			textlabel.Font = Enum.Font.SourceSans
			textlabel.TextColor3 = Color3.new(1, 1, 1)
			textlabel.Position = UDim2.new(0, 0, 0, -36)
			textlabel.Parent = GuiLibrary["MainGui"]
			task.wait(2)
			textlabel:Remove()
		end)
		task.wait(2)
		return checkpublicrepo(id)
	end
	if req.StatusCode == 200 then
		return req.Body
	end
	return nil
end

local function getcustomassetfunc(path)
	if not betterisfile(path) then
		spawn(function()
			local textlabel = Instance.new("TextLabel")
			textlabel.Size = UDim2.new(1, 0, 0, 36)
			textlabel.Text = "Downloading "..path
			textlabel.BackgroundTransparency = 1
			textlabel.TextStrokeTransparency = 0
			textlabel.TextSize = 30
			textlabel.Font = Enum.Font.SourceSans
			textlabel.TextColor3 = Color3.new(1, 1, 1)
			textlabel.Position = UDim2.new(0, 0, 0, -36)
			textlabel.Parent = GuiLibrary["MainGui"]
			repeat task.wait() until betterisfile(path)
			textlabel:Remove()
		end)
		local req = requestfunc({
			Url = "https://raw.githubusercontent.com/7GrandDadPGN/VapeV4ForRoblox/main/"..path:gsub("vape/assets", "assets"),
			Method = "GET"
		})
		writefile(path, req.Body)
	end
	return getasset(path) 
end

shared.GuiLibrary = GuiLibrary
local workspace = game:GetService("Workspace")
local cam = workspace.CurrentCamera
local selfdestructsave = coroutine.create(function()
	while task.wait(10) do
		if GuiLibrary and injected then
			if not injected then return end
			GuiLibrary["SaveSettings"]()
		else
			break
		end
	end
end)
local GUI = GuiLibrary.CreateMainWindow()
local Combat = GuiLibrary.CreateWindow({
	["Name"] = "Combat", 
	["Icon"] = "vape/assets/CombatIcon.png", 
	["IconSize"] = 15
})
local Blatant = GuiLibrary.CreateWindow({
	["Name"] = "Blatant", 
	["Icon"] = "vape/assets/BlatantIcon.png", 
	["IconSize"] = 16
})
local Render = GuiLibrary.CreateWindow({
	["Name"] = "Render", 
	["Icon"] = "vape/assets/RenderIcon.png", 
	["IconSize"] = 17
})
local Utility = GuiLibrary.CreateWindow({
	["Name"] = "Utility", 
	["Icon"] = "vape/assets/UtilityIcon.png", 
	["IconSize"] = 17
})
local World = GuiLibrary.CreateWindow({
	["Name"] = "World", 
	["Icon"] = "vape/assets/WorldIcon.png", 
	["IconSize"] = 16
})
local Friends = GuiLibrary.CreateWindow2({
	["Name"] = "Friends", 
	["Icon"] = "vape/assets/FriendsIcon.png", 
	["IconSize"] = 17
})
local Profiles = GuiLibrary.CreateWindow2({
	["Name"] = "Profiles", 
	["Icon"] = "vape/assets/ProfilesIcon.png", 
	["IconSize"] = 19
})
GUI.CreateDivider()
GUI.CreateButton({
	["Name"] = "Combat", 
	["Function"] = function(callback) Combat.SetVisible(callback) end, 
	["Icon"] = "vape/assets/CombatIcon.png", 
	["IconSize"] = 15
})
GUI.CreateButton({
	["Name"] = "Blatant", 
	["Function"] = function(callback) Blatant.SetVisible(callback) end, 
	["Icon"] = "vape/assets/BlatantIcon.png", 
	["IconSize"] = 16
})
GUI.CreateButton({
	["Name"] = "Render", 
	["Function"] = function(callback) Render.SetVisible(callback) end, 
	["Icon"] = "vape/assets/RenderIcon.png", 
	["IconSize"] = 17
})
GUI.CreateButton({
	["Name"] = "Utility", 
	["Function"] = function(callback) Utility.SetVisible(callback) end, 
	["Icon"] = "vape/assets/UtilityIcon.png", 
	["IconSize"] = 17
})
GUI.CreateButton({
	["Name"] = "World", 
	["Function"] = function(callback) World.SetVisible(callback) end, 
	["Icon"] = "vape/assets/WorldIcon.png", 
	["IconSize"] = 16
})
GUI.CreateDivider("MISC")
GUI.CreateButton({
	["Name"] = "Friends", 
	["Function"] = function(callback) Friends.SetVisible(callback) end, 
})
GUI.CreateButton({
	["Name"] = "Profiles", 
	["Function"] = function(callback) Profiles.SetVisible(callback) end, 
})
local FriendsTextList = {["RefreshValues"] = function() end, ["ObjectListEnabled"] = {}}
local FriendsColor = {["Value"] = 0.44}
local friendscreatetab = {
	["Name"] = "FriendsList", 
	["TempText"] = "Username [Alias]", 
	["Color"] = Color3.fromRGB(5, 133, 104)
}
FriendsTextList = Friends.CreateCircleTextList(friendscreatetab)
FriendsTextList.FriendRefresh = Instance.new("BindableEvent")
FriendsTextList.FriendColorRefresh = Instance.new("BindableEvent")
local oldfriendref = FriendsTextList["RefreshValues"]
FriendsTextList["RefreshValues"] = function(...)
	FriendsTextList.FriendRefresh:Fire()
	return oldfriendref(...)
end
Friends.CreateToggle({
	["Name"] = "Use Friends",
	["Function"] = function(callback) 
		FriendsTextList.FriendRefresh:Fire()
	end,
	["Default"] = true
})
Friends.CreateToggle({
	["Name"] = "Use Alias",
	["Function"] = function(callback) end,
	["Default"] = true,
})
Friends.CreateToggle({
	["Name"] = "Spoof alias",
	["Function"] = function(callback) end,
})
local friendrecolor = Friends.CreateToggle({
	["Name"] = "Recolor visuals",
	["Function"] = function(callback) FriendsTextList.FriendColorRefresh:Fire() end,
	["Default"] = true
})
FriendsColor = Friends.CreateColorSlider({
	["Name"] = "Friends Color", 
	["Function"] = function(h, s, v) 
		local col = Color3.fromHSV(h, s, v)
		local addcirc = FriendsTextList["Object"]:FindFirstChild("AddButton", true)
		if addcirc then 
			addcirc.ImageColor3 = col
		end
		for i,v in pairs(FriendsTextList["ScrollingObject"].ScrollingFrame:GetChildren()) do 
			local friendcirc = v:FindFirstChild("FriendCircle")
			local itemtext = v:FindFirstChild("ItemText")
			if friendcirc and itemtext then 
				friendcirc.BackgroundColor3 = itemtext.TextColor3 == Color3.fromRGB(160, 160, 160) and col or friendcirc.BackgroundColor3
			end
		end
		friendscreatetab["Color"] = col
		if friendrecolor.Enabled then
			FriendsTextList.FriendColorRefresh:Fire()
		end
	end
})
local ProfilesTextList = {["RefreshValues"] = function() end}
local profilesloaded = false
ProfilesTextList = Profiles.CreateTextList({
	["Name"] = "ProfilesList",
	["TempText"] = "Type name", 
	["NoSave"] = true,
	["AddFunction"] = function(user)
		GuiLibrary["Profiles"][user] = {["Keybind"] = "", ["Selected"] = false}
		local profiles = {}
		for i,v in pairs(GuiLibrary["Profiles"]) do 
			table.insert(profiles, i)
		end
		table.sort(profiles, function(a, b) return b == "default" and true or a:lower() < b:lower() end)
		ProfilesTextList["RefreshValues"](profiles)
	end, 
	["RemoveFunction"] = function(num, obj) 
		if obj ~= "default" and obj ~= GuiLibrary["CurrentProfile"] then 
			pcall(function() delfile(customdir.."Profiles/"..obj..(shared.CustomSaveVape or game.PlaceId)..".vapeprofile.txt") end)
			GuiLibrary["Profiles"][obj] = nil
		else
			table.insert(ProfilesTextList["ObjectList"], obj)
			ProfilesTextList["RefreshValues"](ProfilesTextList["ObjectList"])
		end
	end, 
	["CustomFunction"] = function(obj, profilename) 
		if GuiLibrary["Profiles"][profilename] == nil then
			GuiLibrary["Profiles"][profilename] = {["Keybind"] = ""}
		end
		obj.MouseButton1Click:Connect(function()
			GuiLibrary["SwitchProfile"](profilename)
		end)
		local newsize = UDim2.new(0, 20, 0, 21)
		local bindbkg = Instance.new("TextButton")
		bindbkg.Text = ""
		bindbkg.AutoButtonColor = false
		bindbkg.Size = UDim2.new(0, 20, 0, 21)
		bindbkg.Position = UDim2.new(1, -50, 0, 6)
		bindbkg.BorderSizePixel = 0
		bindbkg.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		bindbkg.BackgroundTransparency = 0.95
		bindbkg.Visible = GuiLibrary["Profiles"][profilename]["Keybind"] ~= ""
		bindbkg.Parent = obj
		local bindimg = Instance.new("ImageLabel")
		bindimg.Image = getcustomassetfunc("vape/assets/KeybindIcon.png")
		bindimg.BackgroundTransparency = 1
		bindimg.Size = UDim2.new(0, 12, 0, 12)
		bindimg.Position = UDim2.new(0, 4, 0, 5)
		bindimg.ImageTransparency = 0.2
		bindimg.Active = false
		bindimg.Visible = (GuiLibrary["Profiles"][profilename]["Keybind"] == "")
		bindimg.Parent = bindbkg
		local bindtext = Instance.new("TextLabel")
		bindtext.Active = false
		bindtext.BackgroundTransparency = 1
		bindtext.TextSize = 16
		bindtext.Parent = bindbkg
		bindtext.Font = Enum.Font.SourceSans
		bindtext.Size = UDim2.new(1, 0, 1, 0)
		bindtext.TextColor3 = Color3.fromRGB(85, 85, 85)
		bindtext.Visible = (GuiLibrary["Profiles"][profilename]["Keybind"] ~= "")
		local bindtext2 = Instance.new("TextLabel")
		bindtext2.Text = "PRESS A KEY TO BIND"
		bindtext2.Size = UDim2.new(0, 150, 0, 33)
		bindtext2.Font = Enum.Font.SourceSans
		bindtext2.TextSize = 17
		bindtext2.TextColor3 = Color3.fromRGB(201, 201, 201)
		bindtext2.BackgroundColor3 = Color3.fromRGB(37, 37, 37)
		bindtext2.BorderSizePixel = 0
		bindtext2.Visible = false
		bindtext2.Parent = obj
		local bindround = Instance.new("UICorner")
		bindround.CornerRadius = UDim.new(0, 4)
		bindround.Parent = bindbkg
		bindbkg.MouseButton1Click:Connect(function()
			if GuiLibrary["KeybindCaptured"] == false then
				GuiLibrary["KeybindCaptured"] = true
				spawn(function()
					bindtext2.Visible = true
					repeat task.wait() until GuiLibrary["PressedKeybindKey"] ~= ""
					local key = (GuiLibrary["PressedKeybindKey"] == GuiLibrary["Profiles"][profilename]["Keybind"] and "" or GuiLibrary["PressedKeybindKey"])
					if key == "" then
						GuiLibrary["Profiles"][profilename]["Keybind"] = key
						newsize = UDim2.new(0, 20, 0, 21)
						bindbkg.Size = newsize
						bindbkg.Visible = true
						bindbkg.Position = UDim2.new(1, -(30 + newsize.X.Offset), 0, 6)
						bindimg.Visible = true
						bindtext.Visible = false
						bindtext.Text = key
					else
						local textsize = game:GetService("TextService"):GetTextSize(key, 16, bindtext.Font, Vector2.new(99999, 99999))
						newsize = UDim2.new(0, 13 + textsize.X, 0, 21)
						GuiLibrary["Profiles"][profilename]["Keybind"] = key
						bindbkg.Visible = true
						bindbkg.Size = newsize
						bindbkg.Position = UDim2.new(1, -(30 + newsize.X.Offset), 0, 6)
						bindimg.Visible = false
						bindtext.Visible = true
						bindtext.Text = key
					end
					GuiLibrary["PressedKeybindKey"] = ""
					GuiLibrary["KeybindCaptured"] = false
					bindtext2.Visible = false
				end)
			end
		end)
		bindbkg.MouseEnter:Connect(function() 
			bindimg.Image = getcustomassetfunc("vape/assets/PencilIcon.png") 
			bindimg.Visible = true
			bindtext.Visible = false
			bindbkg.Size = UDim2.new(0, 20, 0, 21)
			bindbkg.Position = UDim2.new(1, -50, 0, 6)
		end)
		bindbkg.MouseLeave:Connect(function() 
			bindimg.Image = getcustomassetfunc("vape/assets/KeybindIcon.png")
			if GuiLibrary["Profiles"][profilename]["Keybind"] ~= "" then
				bindimg.Visible = false
				bindtext.Visible = true
				bindbkg.Size = newsize
				bindbkg.Position = UDim2.new(1, -(30 + newsize.X.Offset), 0, 6)
			end
		end)
		obj.MouseEnter:Connect(function()
			bindbkg.Visible = true
		end)
		obj.MouseLeave:Connect(function()
			bindbkg.Visible = GuiLibrary["Profiles"][profilename] and GuiLibrary["Profiles"][profilename]["Keybind"] ~= ""
		end)
		if GuiLibrary["Profiles"][profilename]["Keybind"] ~= "" then

			bindtext.Text = GuiLibrary["Profiles"][profilename]["Keybind"]
			local textsize = game:GetService("TextService"):GetTextSize(GuiLibrary["Profiles"][profilename]["Keybind"], 16, bindtext.Font, Vector2.new(99999, 99999))
			newsize = UDim2.new(0, 13 + textsize.X, 0, 21)
			bindbkg.Size = newsize
			bindbkg.Position = UDim2.new(1, -(30 + newsize.X.Offset), 0, 6)
		end
		if profilename == GuiLibrary["CurrentProfile"] then
			obj.BackgroundColor3 = Color3.fromHSV(GuiLibrary["ObjectsThatCanBeSaved"]["Gui ColorSliderColor"]["Api"]["Hue"], GuiLibrary["ObjectsThatCanBeSaved"]["Gui ColorSliderColor"]["Api"]["Sat"], GuiLibrary["ObjectsThatCanBeSaved"]["Gui ColorSliderColor"]["Api"]["Value"])
			obj.ImageButton.BackgroundColor3 = Color3.fromHSV(GuiLibrary["ObjectsThatCanBeSaved"]["Gui ColorSliderColor"]["Api"]["Hue"], GuiLibrary["ObjectsThatCanBeSaved"]["Gui ColorSliderColor"]["Api"]["Sat"], GuiLibrary["ObjectsThatCanBeSaved"]["Gui ColorSliderColor"]["Api"]["Value"])
			obj.ItemText.TextColor3 = Color3.new(1, 1, 1)
			obj.ItemText.TextStrokeTransparency = 0.75
			bindbkg.BackgroundTransparency = 0.9
			bindtext.TextColor3 = Color3.fromRGB(214, 214, 214)
		end
	end
})
local OnlineProfilesButton = Instance.new("TextButton")
OnlineProfilesButton.Name = "OnlineProfilesButton"
OnlineProfilesButton.LayoutOrder = 1
OnlineProfilesButton.AutoButtonColor = false
OnlineProfilesButton.Size = UDim2.new(0, 45, 0, 29)
OnlineProfilesButton.BackgroundColor3 = Color3.fromRGB(26, 25, 26)
OnlineProfilesButton.Active = false
OnlineProfilesButton.Text = ""
OnlineProfilesButton.ZIndex = 1
OnlineProfilesButton.Font = Enum.Font.SourceSans
OnlineProfilesButton.TextXAlignment = Enum.TextXAlignment.Left
OnlineProfilesButton.Position = UDim2.new(0, 166, 0, 6)
OnlineProfilesButton.Parent = ProfilesTextList["Object"]
local OnlineProfilesButtonBKG = Instance.new("UIStroke")
OnlineProfilesButtonBKG.Color = Color3.fromRGB(38, 37, 38)
OnlineProfilesButtonBKG.Thickness = 1
OnlineProfilesButtonBKG.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
OnlineProfilesButtonBKG.Parent = OnlineProfilesButton
local OnlineProfilesButtonImage = Instance.new("ImageLabel")
OnlineProfilesButtonImage.BackgroundTransparency = 1
OnlineProfilesButtonImage.Position = UDim2.new(0, 14, 0, 7)
OnlineProfilesButtonImage.Size = UDim2.new(0, 17, 0, 16)
OnlineProfilesButtonImage.Image = getcustomassetfunc("vape/assets/OnlineProfilesButton.png")
OnlineProfilesButtonImage.ImageColor3 = Color3.fromRGB(121, 121, 121)
OnlineProfilesButtonImage.ZIndex = 1
OnlineProfilesButtonImage.Active = false
OnlineProfilesButtonImage.Parent = OnlineProfilesButton
local OnlineProfilesbuttonround1 = Instance.new("UICorner")
OnlineProfilesbuttonround1.CornerRadius = UDim.new(0, 5)
OnlineProfilesbuttonround1.Parent = OnlineProfilesButton
local OnlineProfilesbuttonround2 = Instance.new("UICorner")
OnlineProfilesbuttonround2.CornerRadius = UDim.new(0, 5)
OnlineProfilesbuttonround2.Parent = OnlineProfilesButtonBKG
local OnlineProfilesFrame = Instance.new("Frame")
OnlineProfilesFrame.Size = UDim2.new(0, 660, 0, 445)
OnlineProfilesFrame.Position = UDim2.new(0.5, -330, 0.5, -223)
OnlineProfilesFrame.BackgroundColor3 = Color3.fromRGB(26, 25, 26)
OnlineProfilesFrame.Parent = GuiLibrary["MainGui"].ScaledGui.OnlineProfiles
local OnlineProfilesExitButton = Instance.new("ImageButton")
OnlineProfilesExitButton.Name = "OnlineProfilesExitButton"
OnlineProfilesExitButton.ImageColor3 = Color3.fromRGB(121, 121, 121)
OnlineProfilesExitButton.Size = UDim2.new(0, 24, 0, 24)
OnlineProfilesExitButton.AutoButtonColor = false
OnlineProfilesExitButton.Image = getcustomassetfunc("vape/assets/ExitIcon1.png")
OnlineProfilesExitButton.Visible = true
OnlineProfilesExitButton.Position = UDim2.new(1, -31, 0, 8)
OnlineProfilesExitButton.BackgroundColor3 = Color3.fromRGB(26, 25, 26)
OnlineProfilesExitButton.Parent = OnlineProfilesFrame
local OnlineProfilesExitButtonround = Instance.new("UICorner")
OnlineProfilesExitButtonround.CornerRadius = UDim.new(0, 16)
OnlineProfilesExitButtonround.Parent = OnlineProfilesExitButton
OnlineProfilesExitButton.MouseEnter:Connect(function()
	game:GetService("TweenService"):Create(OnlineProfilesExitButton, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {BackgroundColor3 = Color3.fromRGB(60, 60, 60), ImageColor3 = Color3.fromRGB(255, 255, 255)}):Play()
end)
OnlineProfilesExitButton.MouseLeave:Connect(function()
	game:GetService("TweenService"):Create(OnlineProfilesExitButton, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {BackgroundColor3 = Color3.fromRGB(26, 25, 26), ImageColor3 = Color3.fromRGB(121, 121, 121)}):Play()
end)
local OnlineProfilesFrameShadow = Instance.new("ImageLabel")
OnlineProfilesFrameShadow.AnchorPoint = Vector2.new(0.5, 0.5)
OnlineProfilesFrameShadow.Position = UDim2.new(0.5, 0, 0.5, 0)
OnlineProfilesFrameShadow.Image = getcustomassetfunc("vape/assets/WindowBlur.png")
OnlineProfilesFrameShadow.BackgroundTransparency = 1
OnlineProfilesFrameShadow.ZIndex = -1
OnlineProfilesFrameShadow.Size = UDim2.new(1, 6, 1, 6)
OnlineProfilesFrameShadow.ImageColor3 = Color3.new(0, 0, 0)
OnlineProfilesFrameShadow.ScaleType = Enum.ScaleType.Slice
OnlineProfilesFrameShadow.SliceCenter = Rect.new(10, 10, 118, 118)
OnlineProfilesFrameShadow.Parent = OnlineProfilesFrame
local OnlineProfilesFrameIcon = Instance.new("ImageLabel")
OnlineProfilesFrameIcon.Size = UDim2.new(0, 19, 0, 16)
OnlineProfilesFrameIcon.Image = getcustomassetfunc("vape/assets/ProfilesIcon.png")
OnlineProfilesFrameIcon.Name = "WindowIcon"
OnlineProfilesFrameIcon.BackgroundTransparency = 1
OnlineProfilesFrameIcon.Position = UDim2.new(0, 10, 0, 13)
OnlineProfilesFrameIcon.ImageColor3 = Color3.fromRGB(200, 200, 200)
OnlineProfilesFrameIcon.Parent = OnlineProfilesFrame
local OnlineProfilesFrameText = Instance.new("TextLabel")
OnlineProfilesFrameText.Size = UDim2.new(0, 155, 0, 41)
OnlineProfilesFrameText.BackgroundTransparency = 1
OnlineProfilesFrameText.Name = "WindowTitle"
OnlineProfilesFrameText.Position = UDim2.new(0, 36, 0, 0)
OnlineProfilesFrameText.TextXAlignment = Enum.TextXAlignment.Left
OnlineProfilesFrameText.Font = Enum.Font.SourceSans
OnlineProfilesFrameText.TextSize = 17
OnlineProfilesFrameText.Text = "Public Profiles"
OnlineProfilesFrameText.TextColor3 = Color3.fromRGB(201, 201, 201)
OnlineProfilesFrameText.Parent = OnlineProfilesFrame
local OnlineProfilesFrameText2 = Instance.new("TextLabel")
OnlineProfilesFrameText2.TextSize = 15
OnlineProfilesFrameText2.TextColor3 = Color3.fromRGB(85, 84, 85)
OnlineProfilesFrameText2.Text = "YOUR PROFILES"
OnlineProfilesFrameText2.Font = Enum.Font.SourceSans
OnlineProfilesFrameText2.BackgroundTransparency = 1
OnlineProfilesFrameText2.TextXAlignment = Enum.TextXAlignment.Left
OnlineProfilesFrameText2.TextYAlignment = Enum.TextYAlignment.Top
OnlineProfilesFrameText2.Size = UDim2.new(1, 0, 0, 20)
OnlineProfilesFrameText2.Position = UDim2.new(0, 10, 0, 48)
OnlineProfilesFrameText2.Parent = OnlineProfilesFrame
local OnlineProfilesFrameText3 = Instance.new("TextLabel")
OnlineProfilesFrameText3.TextSize = 15
OnlineProfilesFrameText3.TextColor3 = Color3.fromRGB(85, 84, 85)
OnlineProfilesFrameText3.Text = "PUBLIC PROFILES"
OnlineProfilesFrameText3.Font = Enum.Font.SourceSans
OnlineProfilesFrameText3.BackgroundTransparency = 1
OnlineProfilesFrameText3.TextXAlignment = Enum.TextXAlignment.Left
OnlineProfilesFrameText3.TextYAlignment = Enum.TextYAlignment.Top
OnlineProfilesFrameText3.Size = UDim2.new(1, 0, 0, 20)
OnlineProfilesFrameText3.Position = UDim2.new(0, 231, 0, 48)
OnlineProfilesFrameText3.Parent = OnlineProfilesFrame
local OnlineProfilesBorder1 = Instance.new("Frame")
OnlineProfilesBorder1.BackgroundColor3 = Color3.fromRGB(40, 39, 40)
OnlineProfilesBorder1.BorderSizePixel = 0
OnlineProfilesBorder1.Size = UDim2.new(1, 0, 0, 1)
OnlineProfilesBorder1.Position = UDim2.new(0, 0, 0, 41)
OnlineProfilesBorder1.Parent = OnlineProfilesFrame
local OnlineProfilesBorder2 = Instance.new("Frame")
OnlineProfilesBorder2.BackgroundColor3 = Color3.fromRGB(40, 39, 40)
OnlineProfilesBorder2.BorderSizePixel = 0
OnlineProfilesBorder2.Size = UDim2.new(0, 1, 1, -41)
OnlineProfilesBorder2.Position = UDim2.new(0, 220, 0, 41)
OnlineProfilesBorder2.Parent = OnlineProfilesFrame
local OnlineProfilesList = Instance.new("ScrollingFrame")
OnlineProfilesList.BackgroundTransparency = 1
OnlineProfilesList.Size = UDim2.new(0, 408, 0, 319)
OnlineProfilesList.Position = UDim2.new(0, 230, 0, 122)
OnlineProfilesList.CanvasSize = UDim2.new(0, 408, 0, 319)
OnlineProfilesList.Parent = OnlineProfilesFrame
local OnlineProfilesListGrid = Instance.new("UIGridLayout")
OnlineProfilesListGrid.CellSize = UDim2.new(0, 134, 0, 144)
OnlineProfilesListGrid.CellPadding = UDim2.new(0, 4, 0, 4)
OnlineProfilesListGrid.Parent = OnlineProfilesList
local OnlineProfilesFrameCorner = Instance.new("UICorner")
OnlineProfilesFrameCorner.CornerRadius = UDim.new(0, 4)
OnlineProfilesFrameCorner.Parent = OnlineProfilesFrame

local function grabdata(url)
	local success, result = pcall(function()
		return game:GetService("HttpService"):JSONDecode(game:HttpGet(url, true))
	end)
	return success and result or {}
end

OnlineProfilesButton.MouseButton1Click:Connect(function()
	GuiLibrary["MainGui"].ScaledGui.OnlineProfiles.Visible = true
	GuiLibrary["MainGui"].ScaledGui.ClickGui.Visible = false
	if profilesloaded == false then
		local onlineprofiles = {}
		local saveplaceid = tostring(shared.CustomSaveVape or game.PlaceId)
		for i,v in pairs(grabdata("https://raw.githubusercontent.com/7GrandDadPGN/VapeProfiles/main/Profiles/"..saveplaceid.."/profilelist.txt")) do 
			onlineprofiles[i] = v
		end
		for i2,v2 in pairs(onlineprofiles) do
			local profileurl = "https://raw.githubusercontent.com/7GrandDadPGN/VapeProfiles/main/Profiles/"..saveplaceid.."/"..v2.OnlineProfileName
			local profilebox = Instance.new("Frame")
			profilebox.BackgroundColor3 = Color3.fromRGB(31, 30, 31)
			profilebox.Parent = OnlineProfilesList
			local profiletext = Instance.new("TextLabel")
			profiletext.TextSize = 15
			profiletext.TextColor3 = Color3.fromRGB(137, 136, 137)
			profiletext.Size = UDim2.new(0, 100, 0, 20)
			profiletext.Position = UDim2.new(0, 18, 0, 25)
			profiletext.Font = Enum.Font.SourceSans
			profiletext.TextXAlignment = Enum.TextXAlignment.Left
			profiletext.TextYAlignment = Enum.TextYAlignment.Top
			profiletext.BackgroundTransparency = 1
			profiletext.Text = i2
			profiletext.Parent = profilebox
			local profiledownload = Instance.new("TextButton")
			profiledownload.BackgroundColor3 = Color3.fromRGB(31, 30, 31)
			profiledownload.Size = UDim2.new(0, 69, 0, 31)
			profiledownload.Font = Enum.Font.SourceSans
			profiledownload.TextColor3 = Color3.fromRGB(200, 200, 200)
			profiledownload.TextSize = 15
			profiledownload.AutoButtonColor = false
			profiledownload.Text = "DOWNLOAD"
			profiledownload.Position = UDim2.new(0, 14, 0, 96)
			profiledownload.Visible = false 
			profiledownload.Parent = profilebox
			profiledownload.ZIndex = 2
			local profiledownloadbkg = Instance.new("Frame")
			profiledownloadbkg.Size = UDim2.new(0, 71, 0, 33)
			profiledownloadbkg.BackgroundColor3 = Color3.fromRGB(42, 41, 42)
			profiledownloadbkg.Position = UDim2.new(0, 13, 0, 95)
			profiledownloadbkg.ZIndex = 1
			profiledownloadbkg.Visible = false
			profiledownloadbkg.Parent = profilebox
			profilebox.MouseEnter:Connect(function()
				profiletext.TextColor3 = Color3.fromRGB(200, 200, 200)
				profiledownload.Visible = true 
				profiledownloadbkg.Visible = true
			end)
			profilebox.MouseLeave:Connect(function()
				profiletext.TextColor3 = Color3.fromRGB(137, 136, 137)
				profiledownload.Visible = false
				profiledownloadbkg.Visible = false
			end)
			profiledownload.MouseEnter:Connect(function()
				profiledownload.BackgroundColor3 = Color3.fromRGB(5, 134, 105)
			end)
			profiledownload.MouseLeave:Connect(function()
				profiledownload.BackgroundColor3 = Color3.fromRGB(31, 30, 31)
			end)
			profiledownload.MouseButton1Click:Connect(function()
				writefile(customdir.."Profiles/"..v2["ProfileName"]..saveplaceid..".vapeprofile.txt", game:HttpGet(profileurl, true))
				GuiLibrary["Profiles"][v2["ProfileName"]] = {["Keybind"] = "", ["Selected"] = false}
				local profiles = {}
				for i,v in pairs(GuiLibrary["Profiles"]) do 
					table.insert(profiles, i)
				end
				table.sort(profiles, function(a, b) return b == "default" and true or a:lower() < b:lower() end)
				ProfilesTextList["RefreshValues"](profiles)
			end)
			local profileround = Instance.new("UICorner")
			profileround.CornerRadius = UDim.new(0, 4)
			profileround.Parent = profilebox
			local profileround2 = Instance.new("UICorner")
			profileround2.CornerRadius = UDim.new(0, 4)
			profileround2.Parent = profiledownload
			local profileround3 = Instance.new("UICorner")
			profileround3.CornerRadius = UDim.new(0, 4)
			profileround3.Parent = profiledownloadbkg
		end
		profilesloaded = true
	end
end)
OnlineProfilesExitButton.MouseButton1Click:Connect(function()
	GuiLibrary["MainGui"].ScaledGui.OnlineProfiles.Visible = false
	GuiLibrary["MainGui"].ScaledGui.ClickGui.Visible = true
end)

GUI.CreateDivider()
---GUI.CreateCustomButton("Favorites", "vape/assets/FavoritesListIcon.png", UDim2.new(0, 17, 0, 14), function() end, function() end)
--GUI.CreateCustomButton("Text GUIVertical", "vape/assets/TextGUIIcon3.png", UDim2.new(1, -56, 0, 15), function() end, function() end)
local TextGui = GuiLibrary.CreateCustomWindow({
	["Name"] = "Text GUI", 
	["Icon"] = "vape/assets/TextGUIIcon1.png", 
	["IconSize"] = 21
})
local TextGuiCircleObject = {["CircleList"] = {}}
--GUI.CreateCustomButton("Text GUI", "vape/assets/TextGUIIcon2.png", UDim2.new(1, -23, 0, 15), function() TextGui.SetVisible(true) end, function() TextGui.SetVisible(false) end, "OptionsButton")
GUI.CreateCustomToggle({
	["Name"] = "Text GUI", 
	["Icon"] = "vape/assets/TextGUIIcon3.png",
	["Function"] = function(callback) TextGui.SetVisible(callback) end,
	["Priority"] = 2
})	

local rainbowval = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromHSV(0, 0, 1)), ColorSequenceKeypoint.new(1, Color3.fromHSV(0, 0, 1))})
local rainbowval2 = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromHSV(0, 0, 0.42)), ColorSequenceKeypoint.new(1, Color3.fromHSV(0, 0, 0.42))})
local rainbowval3 = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromHSV(0, 0, 1)), ColorSequenceKeypoint.new(1, Color3.fromHSV(0, 0, 1))})
local guicolorslider = {["RainbowValue"] = false}
local textguiscaleslider = {["Value"] = 10}
local textguimode = {["Value"] = "Normal"}
local fontitems = {"SourceSans"}
local fontitems2 = {"GothamBold"}
local textguiframe = Instance.new("Frame")
textguiframe.BackgroundTransparency = 1
textguiframe.Size = UDim2.new(1, 0, 1, 0)
textguiframe.Parent = TextGui.GetCustomChildren()
local onething = Instance.new("ImageLabel")
onething.Parent = textguiframe
onething.Name = "Logo"
onething.Size = UDim2.new(0, 100, 0, 27)
onething.Position = UDim2.new(1, -140, 0, 3)
onething.BackgroundColor3 = Color3.new(0, 0, 0)
onething.BorderSizePixel = 0
onething.BackgroundTransparency = 1
onething.Visible = false
onething.Image = getcustomassetfunc(translatedlogo and "vape/translations/"..GuiLibrary["Language"].."/VapeLogo3.png" or "vape/assets/VapeLogo3.png")
local onething2 = Instance.new("ImageLabel")
onething2.Parent = onething
onething2.Size = UDim2.new(0, 41, 0, 24)
onething2.Name = "Logo2"
onething2.Position = UDim2.new(1, 0, 0, 1)
onething2.BorderSizePixel = 0
onething2.BackgroundColor3 = Color3.new(0, 0, 0)
onething2.BackgroundTransparency = 1
onething2.Image = getcustomassetfunc("vape/assets/VapeLogo4.png")
local onething3 = onething:Clone()
onething3.ImageColor3 = Color3.new(0, 0, 0)
onething3.ImageTransparency = 0.5
onething3.ZIndex = 0
onething3.Position = UDim2.new(0, 1, 0, 1)
onething3.Visible = false
onething3.Parent = onething
onething3.Logo2.ImageColor3 = Color3.new(0, 0, 0)
onething3.Logo2.ZIndex = 0
onething3.Logo2.ImageTransparency = 0.5
local onethinggrad = Instance.new("UIGradient")
onethinggrad.Rotation = 90
onethinggrad.Parent = onething
local onethinggrad2 = Instance.new("UIGradient")
onethinggrad2.Rotation = 90
onethinggrad2.Parent = onething2
local onetext = Instance.new("TextLabel")
onetext.Parent = textguiframe
onetext.Size = UDim2.new(1, 0, 1, 0)
onetext.Position = UDim2.new(1, -154, 0, 35)
onetext.TextColor3 = Color3.new(1, 1, 1)
onetext.RichText = true
onetext.BackgroundTransparency = 1
onetext.TextXAlignment = Enum.TextXAlignment.Left
onetext.TextYAlignment = Enum.TextYAlignment.Top
onetext.BorderSizePixel = 0
onetext.BackgroundColor3 = Color3.new(0, 0, 0)
onetext.Font = Enum.Font.SourceSans
onetext.Text = ""
onetext.TextSize = 23
local onetext2 = Instance.new("TextLabel")
onetext2.Name = "ExtraText"
onetext2.Parent = onetext
onetext2.Size = UDim2.new(1, 0, 1, 0)
onetext2.Position = UDim2.new(0, 1, 0, 1)
onetext2.BorderSizePixel = 0
onetext2.Visible = false
onetext2.ZIndex = 0
onetext2.Text = ""
onetext2.BackgroundTransparency = 1
onetext2.TextTransparency = 0.5
onetext2.TextXAlignment = Enum.TextXAlignment.Left
onetext2.TextYAlignment = Enum.TextYAlignment.Top
onetext2.TextColor3 = Color3.new(0, 0, 0)
onetext2.Font = Enum.Font.SourceSans
onetext2.TextSize = 23
local onecustomtext = Instance.new("TextLabel")
onecustomtext.TextSize = 30
onecustomtext.Font = Enum.Font.GothamBold
onecustomtext.Size = UDim2.new(1, 0, 1, 0)
onecustomtext.BackgroundTransparency = 1
onecustomtext.Position = UDim2.new(0, 0, 0, 35)
onecustomtext.TextXAlignment = Enum.TextXAlignment.Left
onecustomtext.TextYAlignment = Enum.TextYAlignment.Top
onecustomtext.Text = ""
onecustomtext.Parent = textguiframe
local onecustomtext2 = onecustomtext:Clone()
onecustomtext2.ZIndex = -1
onecustomtext2.Size = UDim2.new(1, 0, 1, 0)
onecustomtext2.TextTransparency = 0.5
onecustomtext2.TextColor3 = Color3.new(0, 0, 0)
onecustomtext2.Position = UDim2.new(0, 1, 0, 1)
onecustomtext2.Parent = onecustomtext
onecustomtext:GetPropertyChangedSignal("TextXAlignment"):Connect(function()
	onecustomtext2.TextXAlignment = onecustomtext.TextXAlignment
end)
local onebackground = Instance.new("Frame")
onebackground.BackgroundTransparency = 1
onebackground.BorderSizePixel = 0
onebackground.BackgroundColor3 = Color3.new(0, 0, 0)
onebackground.Size = UDim2.new(1, 0, 1, 0)
onebackground.Visible = false 
onebackground.Parent = textguiframe
onebackground.ZIndex = 0
local onebackgroundsort = Instance.new("UIListLayout")
onebackgroundsort.FillDirection = Enum.FillDirection.Vertical
onebackgroundsort.SortOrder = Enum.SortOrder.LayoutOrder
onebackgroundsort.Padding = UDim.new(0, 0)
onebackgroundsort.Parent = onebackground
local onescale = Instance.new("UIScale")
onescale.Parent = textguiframe
local textguirenderbkg = {["Enabled"] = false}
local textguimodeconnections = {}
local textguimodeobjects = {Logo = {}, Labels = {}, ShadowLabels = {}, Backgrounds = {}}
local function refreshbars(textlists)
	for i,v in pairs(onebackground:GetChildren()) do
		if v:IsA("Frame") then
			v:Remove()
		end
	end
	for i2,v2 in pairs(textlists) do
		local newstr = v2:gsub(":", " ")
		local textsize = game:GetService("TextService"):GetTextSize(newstr, onetext.TextSize, onetext.Font, Vector2.new(1000000, 1000000))
		local frame = Instance.new("Frame")
		frame.BorderSizePixel = 0
		frame.BackgroundTransparency = 0.62
		frame.BackgroundColor3 = Color3.new(0,0,0)
		frame.Visible = true
		frame.ZIndex = 0
		frame.LayoutOrder = i2
		frame.Size = UDim2.new(0, textsize.X + 8, 0, textsize.Y)
		frame.Parent = onebackground
		local colorframe = Instance.new("Frame")
		colorframe.Size = UDim2.new(0, 2, 1, 0)
		colorframe.Position = (onebackgroundsort.HorizontalAlignment == Enum.HorizontalAlignment.Left and UDim2.new(0, 0, 0, 0) or UDim2.new(1, -2, 0, 0))
		colorframe.BorderSizePixel = 0
		colorframe.Name = "ColorFrame"
		colorframe.Parent = frame
		local extraframe = Instance.new("Frame")
		extraframe.BorderSizePixel = 0
		extraframe.BackgroundTransparency = 0.96
		extraframe.BackgroundColor3 = Color3.new(0, 0, 0)
		extraframe.ZIndex = 0
		extraframe.Size = UDim2.new(1, 0, 0, 2)
		extraframe.Position = UDim2.new(0, 0, 1, -1)
		extraframe.Parent = frame
	end
end

onething.Visible = true onetext.Position = UDim2.new(0, 0, 0, 41)

local sortingmethod = "Alphabetical"
local textwithoutthing = ""
local function getSpaces(str)
		local strSize = game:GetService("TextService"):GetTextSize(str, onetext.TextSize, onetext.TextSize, Vector2.new(10000, 10000))
		return math.ceil(strSize.X / 3)
end
local function UpdateHud()
	if GuiLibrary["MainGui"].ScaledGui.Visible then
		local text = ""
		local text2 = ""
		local tableofmodules = {}
		local first = true
		
		for i,v in pairs(GuiLibrary["ObjectsThatCanBeSaved"]) do
			if v["Type"] == "OptionsButton" and v["Api"]["Name"] ~= "Text GUI" then
				if v["Api"]["Enabled"] then
					local blacklisted = table.find(TextGuiCircleObject["CircleList"]["ObjectList"], v["Api"]["Name"]) and TextGuiCircleObject["CircleList"]["ObjectListEnabled"][table.find(TextGuiCircleObject["CircleList"]["ObjectList"], v["Api"]["Name"])]
					if not blacklisted then
						table.insert(tableofmodules, {["Text"] = v["Api"]["Name"], ["ExtraText"] = v["Api"]["GetExtraText"]})
					end
				end
			end
		end
		if sortingmethod == "Alphabetical" then
			table.sort(tableofmodules, function(a, b) return a["Text"]:lower() < b["Text"]:lower() end)
		else
			table.sort(tableofmodules, function(a, b) 
				local textsize1 = (translations[a["Text"]] ~= nil and translations[a["Text"]] or a["Text"])..(a["ExtraText"]() ~= "" and " "..a["ExtraText"]() or "")
				local textsize2 = (translations[b["Text"]] ~= nil and translations[b["Text"]] or b["Text"])..(b["ExtraText"]() ~= "" and " "..b["ExtraText"]() or "")
				textsize1 = game:GetService("TextService"):GetTextSize(textsize1, onetext.TextSize, onetext.Font, Vector2.new(1000000, 1000000))
				textsize2 = game:GetService("TextService"):GetTextSize(textsize2, onetext.TextSize, onetext.Font, Vector2.new(1000000, 1000000))
				return textsize1.X > textsize2.X 
			end)
		end
		local textlists = {}
		for i2,v2 in pairs(tableofmodules) do
			if first then
				text = (translations[v2["Text"]] ~= nil and translations[v2["Text"]] or v2["Text"])..(v2["ExtraText"]() ~= "" and ":"..v2["ExtraText"]() or "")
				first = false
			else
				text = text..'\n'..(translations[v2["Text"]] ~= nil and translations[v2["Text"]] or v2["Text"])..(v2["ExtraText"]() ~= "" and ":"..v2["ExtraText"]() or "")
			end
			table.insert(textlists, (translations[v2["Text"]] ~= nil and translations[v2["Text"]] or v2["Text"])..(v2["ExtraText"]() ~= "" and ":"..v2["ExtraText"]() or ""))
		end
		textwithoutthing = text
		onetext.Text = text
		onetext2.Text = text:gsub(":", " ")
		local newsize = game:GetService("TextService"):GetTextSize(text, onetext.TextSize, onetext.Font, Vector2.new(1000000, 1000000))
		if text == "" then
			newsize = Vector2.new(0, 0)
		end
		onetext.Size = UDim2.new(0, 154, 0, newsize.Y)
		if TextGui.GetCustomChildren().Parent then
			if (TextGui.GetCustomChildren().Parent.Position.X.Offset + TextGui.GetCustomChildren().Parent.Size.X.Offset / 2) >= (cam.ViewportSize.X / 2) then
				onetext.TextXAlignment = Enum.TextXAlignment.Right
				onetext2.TextXAlignment = Enum.TextXAlignment.Right
				onetext2.Position = UDim2.new(0, 1, 0, 1)
				onething.Position = UDim2.new(1, -142, 0, 8)
				onetext.Position = UDim2.new(1, -154, 0, (onething.Visible and (textguirenderbkg["Enabled"] and 41 or 35) or 5) + (onecustomtext.Visible and 25 or 0))
				onecustomtext.Position = UDim2.new(0, 0, 0, onething.Visible and 35 or 0)
				onecustomtext.TextXAlignment = Enum.TextXAlignment.Right
				onebackgroundsort.HorizontalAlignment = Enum.HorizontalAlignment.Right
				onebackground.Position = onetext.Position + UDim2.new(0, -60, 0, 2)
			else
				onetext.TextXAlignment = Enum.TextXAlignment.Left
				onetext2.TextXAlignment = Enum.TextXAlignment.Left
				onetext2.Position = UDim2.new(0, 5, 0, 1)
				onething.Position = UDim2.new(0, 2, 0, 8)
				onetext.Position = UDim2.new(0, 6, 0, (onething.Visible and (textguirenderbkg["Enabled"] and 41 or 35) or 5) + (onecustomtext.Visible and 25 or 0))
				onecustomtext.TextXAlignment = Enum.TextXAlignment.Left
				onebackgroundsort.HorizontalAlignment = Enum.HorizontalAlignment.Left
				onebackground.Position = onetext.Position + UDim2.new(0, -1, 0, 2)
			end
		end
		if textguimode["Value"] == "Drawing" then 
			for i,v in pairs(textguimodeobjects.Labels) do 
				v.Visible = false
				v:Remove()
				textguimodeobjects.Labels[i] = nil
			end
			for i,v in pairs(textguimodeobjects.ShadowLabels) do 
				v.Visible = false
				v:Remove()
				textguimodeobjects.ShadowLabels[i] = nil
			end
			for i,v in pairs(textlists) do 
				local textdraw = Drawing.new("Text")
				textdraw.Text = v:gsub(":", " ")
				textdraw.Size = 23 * onescale.Scale
				textdraw.ZIndex = 2
				textdraw.Position = onetext.AbsolutePosition + Vector2.new(onetext.TextXAlignment == Enum.TextXAlignment.Right and (onetext.AbsoluteSize.X - textdraw.TextBounds.X), ((textdraw.Size - 3) * i) + 6)
				textdraw.Visible = true
				local textdraw2 = Drawing.new("Text")
				textdraw2.Text = textdraw.Text
				textdraw2.Size = 23 * onescale.Scale
				textdraw2.Position = textdraw.Position + Vector2.new(1, 1)
				textdraw2.Color = Color3.new(0, 0, 0)
				textdraw2.Transparency = 0.5
				textdraw2.Visible = onetext2.Visible
				table.insert(textguimodeobjects.Labels, textdraw)
				table.insert(textguimodeobjects.ShadowLabels, textdraw2)
			end
		end
		refreshbars(textlists)
		GuiLibrary["UpdateUI"](GuiLibrary["ObjectsThatCanBeSaved"]["Gui ColorSliderColor"]["Api"]["Hue"], GuiLibrary["ObjectsThatCanBeSaved"]["Gui ColorSliderColor"]["Api"]["Sat"], GuiLibrary["ObjectsThatCanBeSaved"]["Gui ColorSliderColor"]["Api"]["Value"])
	end
end

TextGui.GetCustomChildren().Parent:GetPropertyChangedSignal("Position"):Connect(UpdateHud)
onescale:GetPropertyChangedSignal("Scale"):Connect(function()
	local childrenobj = TextGui.GetCustomChildren()
	local check = (childrenobj.Parent.Position.X.Offset + childrenobj.Parent.Size.X.Offset / 2) >= (cam.ViewportSize.X / 2)
	childrenobj.Position = UDim2.new((check and -(onescale.Scale - 1) or 0), (check and 0 or -6 * (onescale.Scale - 1)), 1, -6 * (onescale.Scale - 1))
	UpdateHud()
end)
GuiLibrary["UpdateHudEvent"].Event:Connect(UpdateHud)
for i,v in pairs(Enum.Font:GetEnumItems()) do 
	if v ~= "SourceSans" then
		table.insert(fontitems, v.Name)
	end
	if v ~= "GothamBold" then
		table.insert(fontitems2, v.Name)
	end
end
textguimode = TextGui.CreateDropdown({
	["Name"] = "Mode",
	["List"] = {"Normal", "Drawing"},
	["Function"] = function(val)
		textguiframe.Visible = val == "Normal"
		for i,v in pairs(textguimodeconnections) do 
			v:Disconnect()
		end
		for i,v in pairs(textguimodeobjects) do 
			for i2,v2 in pairs(v) do 
				v2.Visible = false
				v2:Remove()
				v[i2] = nil
			end
		end
		if val == "Drawing" then
			local onethingdrawing = Drawing.new("Image")
			onethingdrawing.Data = readfile(translatedlogo and "vape/translations/"..GuiLibrary["Language"].."/VapeLogo3.png" or "vape/assets/VapeLogo3.png")
			onethingdrawing.Size = onething.AbsoluteSize
			onethingdrawing.Position = onething.AbsolutePosition + Vector2.new(0, 36)
			onethingdrawing.ZIndex = 2
			onethingdrawing.Visible = onething.Visible
			local onething2drawing = Drawing.new("Image")
			onething2drawing.Data = readfile("vape/assets/VapeLogo4.png")
			onething2drawing.Size = onething2.AbsoluteSize
			onething2drawing.Position = onething2.AbsolutePosition + Vector2.new(0, 36)
			onething2drawing.ZIndex = 2
			onething2drawing.Visible = onething.Visible
			local onething3drawing = Drawing.new("Image")
			onething3drawing.Data = readfile(translatedlogo and "vape/translations/"..GuiLibrary["Language"].."/VapeLogo3.png" or "vape/assets/VapeLogo3.png")
			onething3drawing.Size = onething.AbsoluteSize
			onething3drawing.Position = onething.AbsolutePosition + Vector2.new(1, 37)
			onething3drawing.Transparency = 0.5
			onething3drawing.Visible = onething.Visible and onething3.Visible
			local onething4drawing = Drawing.new("Image")
			onething4drawing.Data = readfile("vape/assets/VapeLogo4.png")
			onething4drawing.Size = onething2.AbsoluteSize
			onething4drawing.Position = onething2.AbsolutePosition + Vector2.new(1, 37)
			onething4drawing.Transparency = 0.5
			onething4drawing.Visible = onething.Visible and onething3.Visible
			local onecustomdrawtext = Drawing.new("Text")
			onecustomdrawtext.Size = 30
			onecustomdrawtext.Text = onecustomtext.Text
			onecustomdrawtext.Color = onecustomtext.TextColor3
			onecustomdrawtext.ZIndex = 2
			onecustomdrawtext.Position = onecustomtext.AbsolutePosition + Vector2.new(onetext.TextXAlignment == Enum.TextXAlignment.Right and (onecustomtext.AbsoluteSize.X - onecustomdrawtext.TextBounds.X), 32)
			onecustomdrawtext.Visible = onecustomtext.Visible
			local onecustomdrawtext2 = Drawing.new("Text")
			onecustomdrawtext2.Size = 30
			onecustomdrawtext2.Text = onecustomtext.Text
			onecustomdrawtext2.Transparency = 0.5
			onecustomdrawtext2.Color = Color3.new(0, 0, 0)
			onecustomdrawtext2.Position = onecustomdrawtext.Position + Vector2.new(1, 1)
			onecustomdrawtext2.Visible = onecustomtext.Visible and onetext2.Visible
			pcall(function()
				onething3drawing.Color = Color3.new(0, 0, 0)
				onething4drawing.Color = Color3.new(0, 0, 0)
				onethingdrawing.Color = onethinggrad.Color.Keypoints[1].Value
			end)
			table.insert(textguimodeobjects.Logo, onethingdrawing)
			table.insert(textguimodeobjects.Logo, onething2drawing)
			table.insert(textguimodeobjects.Logo, onething3drawing)
			table.insert(textguimodeobjects.Logo, onething4drawing)
			table.insert(textguimodeobjects.Logo, onecustomdrawtext)
			table.insert(textguimodeobjects.Logo, onecustomdrawtext2)
			table.insert(textguimodeconnections, onething:GetPropertyChangedSignal("AbsolutePosition"):Connect(function()
				onethingdrawing.Position = onething.AbsolutePosition + Vector2.new(0, 36)
				onething3drawing.Position = onething.AbsolutePosition + Vector2.new(1, 37)
			end))
			table.insert(textguimodeconnections, onething:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
				onethingdrawing.Size = onething.AbsoluteSize
				onething3drawing.Size = onething.AbsoluteSize
				onecustomdrawtext.Size = 30 * onescale.Scale
				onecustomdrawtext2.Size = 30 * onescale.Scale
			end))
			table.insert(textguimodeconnections, onething2:GetPropertyChangedSignal("AbsolutePosition"):Connect(function()
				onething2drawing.Position = onething2.AbsolutePosition + Vector2.new(0, 36)
				onething4drawing.Position = onething2.AbsolutePosition + Vector2.new(1, 37)
			end))
			table.insert(textguimodeconnections, onething2:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
				onething2drawing.Size = onething2.AbsoluteSize
				onething4drawing.Size = onething2.AbsoluteSize
			end))
			table.insert(textguimodeconnections, onecustomtext:GetPropertyChangedSignal("AbsolutePosition"):Connect(function()
				onecustomdrawtext.Position = onecustomtext.AbsolutePosition + Vector2.new(onetext.TextXAlignment == Enum.TextXAlignment.Right and (onecustomtext.AbsoluteSize.X - onecustomdrawtext.TextBounds.X), 32)
				onecustomdrawtext2.Position = onecustomdrawtext.Position + Vector2.new(1, 1)
			end))
			table.insert(textguimodeconnections, onething3:GetPropertyChangedSignal("Visible"):Connect(function()
				onething3drawing.Visible = onething3.Visible
				onething4drawing.Visible = onething3.Visible
			end))
			table.insert(textguimodeconnections, onetext2:GetPropertyChangedSignal("Visible"):Connect(function()
				for i,textdraw in pairs(textguimodeobjects.ShadowLabels) do 
					textdraw.Visible = onetext2.Visible
				end
				onecustomdrawtext2.Visible = onecustomtext.Visible and onetext2.Visible
			end))
			table.insert(textguimodeconnections, onething:GetPropertyChangedSignal("Visible"):Connect(function()
				onethingdrawing.Visible = onething.Visible
				onething2drawing.Visible = onething.Visible
				onething3drawing.Visible = onething.Visible and onetext2.Visible
				onething4drawing.Visible = onething.Visible and onetext2.Visible
			end))
			table.insert(textguimodeconnections, onecustomtext:GetPropertyChangedSignal("Visible"):Connect(function()
				onecustomdrawtext.Visible = onecustomtext.Visible
				onecustomdrawtext2.Visible = onecustomtext.Visible and onetext2.Visible
			end))
			table.insert(textguimodeconnections, onecustomtext:GetPropertyChangedSignal("Text"):Connect(function()
				onecustomdrawtext.Text = onecustomtext.Text
				onecustomdrawtext2.Text = onecustomtext.Text
				onecustomdrawtext.Position = onecustomtext.AbsolutePosition + Vector2.new(onetext.TextXAlignment == Enum.TextXAlignment.Right and (onecustomtext.AbsoluteSize.X - onecustomdrawtext.TextBounds.X), 32)
				onecustomdrawtext2.Position = onecustomdrawtext.Position + Vector2.new(1, 1)
			end))
			table.insert(textguimodeconnections, onecustomtext:GetPropertyChangedSignal("TextColor3"):Connect(function()
				onecustomdrawtext.Color = onecustomtext.TextColor3
			end))
			table.insert(textguimodeconnections, onetext:GetPropertyChangedSignal("AbsolutePosition"):Connect(function()
				for i,textdraw in pairs(textguimodeobjects.Labels) do 
					textdraw.Position = onetext.AbsolutePosition + Vector2.new(onetext.TextXAlignment == Enum.TextXAlignment.Right and (onetext.AbsoluteSize.X - textdraw.TextBounds.X), ((textdraw.Size - 3) * i) + 6)
				end
				for i,textdraw in pairs(textguimodeobjects.ShadowLabels) do 
					textdraw.Position = Vector2.new(1, 1) + (onetext.AbsolutePosition + Vector2.new(onetext.TextXAlignment == Enum.TextXAlignment.Right and (onetext.AbsoluteSize.X - textdraw.TextBounds.X), ((textdraw.Size - 3) * i) + 6))
				end
			end))
			table.insert(textguimodeconnections, onethinggrad:GetPropertyChangedSignal("Color"):Connect(function()
				pcall(function()
					onethingdrawing.Color = onethinggrad.Color.Keypoints[1].Value
				end)
			end))
		end
	end
})
TextGui.CreateDropdown({
	["Name"] = "Sort",
	["List"] = {"Alphabetical", "Length"},
	["Function"] = function(val)
		sortingmethod = val
		GuiLibrary["UpdateHudEvent"]:Fire()
	end
})
TextGui.CreateDropdown({
	["Name"] = "Font",
	["List"] = fontitems,
	["Function"] = function(val)
		onetext.Font = Enum.Font[val]
		onetext2.Font = Enum.Font[val]
		GuiLibrary["UpdateHudEvent"]:Fire()
	end
})
TextGui.CreateDropdown({
	["Name"] = "CustomTextFont",
	["List"] = fontitems2,
	["Function"] = function(val)
		onecustomtext.Font = Enum.Font[val]
		onecustomtext2.Font = Enum.Font[val]
		GuiLibrary["UpdateHudEvent"]:Fire()
	end
})
textguiscaleslider = TextGui.CreateSlider({
	["Name"] = "Scale",
	["Min"] = 1,
	["Max"] = 50,
	["Default"] = 10,
	["Function"] = function(val)
		onescale.Scale = val / 10
	end
})
TextGui.CreateToggle({
	["Name"] = "Shadow", 
	["Function"] = function(callback) onetext2.Visible = callback onething3.Visible = callback end,
	["HoverText"] = "Renders shadowed text."
})
TextGui.CreateToggle({
	["Name"] = "Watermark", 
	["Function"] = function(callback) 
		onething.Visible = callback
		UpdateHud()
	end,
	["HoverText"] = "Renders a vape watermark"
})
textguirenderbkg = TextGui.CreateToggle({
	["Name"] = "Render background", 
	["Function"] = function(callback)
		onebackground.Visible = callback
		UpdateHud()
	end
})
TextGui.CreateToggle({
	["Name"] = "Hide Modules",
	["Function"] = function(callback) 
		if TextGuiCircleObject["Object"] then
			TextGuiCircleObject["Object"].Visible = callback
		end
	end
})
TextGuiCircleObject = TextGui.CreateCircleWindow({
	["Name"] = "Blacklist",
	["Type"] = "Blacklist",
	["UpdateFunction"] = function()
		UpdateHud()
	end
})
TextGuiCircleObject["Object"].Visible = false
local textguigradient = TextGui.CreateToggle({
	["Name"] = "Gradient Logo",
	["Function"] = function() 
		UpdateHud()
	end
})
TextGui.CreateToggle({
	["Name"] = "Alternate Text",
	["Function"] = function() 
		UpdateHud()
	end
})
local CustomText = {["Value"] = "", ["Object"] = nil}
TextGui.CreateToggle({
	["Name"] = "Add custom text", 
	["Function"] = function(callback) 
		onecustomtext.Visible = callback
		if CustomText["Object"] then 
			CustomText["Object"].Visible = callback
		end
		GuiLibrary["UpdateHudEvent"]:Fire()
	end,
	["HoverText"] = "Renders a custom label"
})
CustomText = TextGui.CreateTextBox({
	["Name"] = "Custom text",
	["FocusLost"] = function(enter)
		onecustomtext.Text = CustomText["Value"]
		onecustomtext2.Text = CustomText["Value"]
	end
})
CustomText["Object"].Visible = false

local healthColorToPosition = {
	[0.01] = Color3.fromRGB(255, 28, 0);
	[0.5] = Color3.fromRGB(250, 235, 0);
	[0.99] = Color3.fromRGB(27, 252, 107);
}

local function HealthbarColorTransferFunction(healthPercent)
	healthPercent = math.clamp(healthPercent, 0.01, 0.99)
	local lastcolor = Color3.new(1, 1, 1)
	for samplePoint, colorSampleValue in pairs(healthColorToPosition) do
		local distance = (healthPercent / samplePoint)
		if distance == 1 then
			return colorSampleValue
		elseif distance < 1 then 
			return lastcolor:lerp(colorSampleValue, distance)
		else
			lastcolor = colorSampleValue
		end
	end
	return lastcolor
end

local TargetInfo = GuiLibrary.CreateCustomWindow({
	["Name"] = "Target Info",
	["Icon"] = "vape/assets/TargetInfoIcon1.png",
	["IconSize"] = 16
})
local TargetInfoDisplayNames = TargetInfo.CreateToggle({
	["Name"] = "Use Display Name",
	["Function"] = function() end,
	["Default"] = true
})
local TargetInfoBackground = {["Enabled"] = false}
local targetinfobkg1 = Instance.new("Frame")
targetinfobkg1.BackgroundColor3 = Color3.fromRGB(26, 25, 26)
targetinfobkg1.BorderSizePixel = 0
targetinfobkg1.BackgroundTransparency = 1
targetinfobkg1.Size = UDim2.new(0, 220, 0, 72)
targetinfobkg1.Position = UDim2.new(0, 0, 0, 5)
targetinfobkg1.Parent = TargetInfo.GetCustomChildren()
local targetinfobkg3 = Instance.new("Frame")
targetinfobkg3.BackgroundColor3 = Color3.fromRGB(31, 30, 31)
targetinfobkg3.Size = UDim2.new(0, 220, 0, 80)
targetinfobkg3.BackgroundTransparency = 0.25
targetinfobkg3.Position = UDim2.new(0, 0, 0, 0)
targetinfobkg3.Name = "MainInfo"
targetinfobkg3.Parent = targetinfobkg1
local targetname = Instance.new("TextLabel")
targetname.TextSize = 17
targetname.Font = Enum.Font.SourceSans
targetname.TextColor3 = Color3.fromRGB(162, 162, 162)
targetname.Position = UDim2.new(0, 72, 0, 7)
targetname.TextStrokeTransparency = 1
targetname.BackgroundTransparency = 1
targetname.Size = UDim2.new(0, 80, 0, 16)
targetname.TextScaled = true
targetname.Text = "Target name"
targetname.ZIndex = 2
targetname.TextXAlignment = Enum.TextXAlignment.Left
targetname.TextYAlignment = Enum.TextYAlignment.Top
targetname.Parent = targetinfobkg3
local targetnameclone = targetname:Clone()
targetnameclone.Size = UDim2.new(1, 0, 1, 0)
targetnameclone.TextTransparency = 0.5
targetnameclone.TextColor3 = Color3.new()
targetnameclone.ZIndex = 1
targetnameclone.Position = UDim2.new(0, 1, 0, 1)
targetname:GetPropertyChangedSignal("Text"):Connect(function()
	targetnameclone.Text = targetname.Text
end)
targetnameclone.Parent = targetname
local targethealthbkg = Instance.new("Frame")
targethealthbkg.BackgroundColor3 = Color3.fromRGB(54, 54, 54)
targethealthbkg.Size = UDim2.new(0, 138, 0, 4)
targethealthbkg.Position = UDim2.new(0, 72, 0, 29)
targethealthbkg.Parent = targetinfobkg3
local healthbarbkgshadow = Instance.new("ImageLabel")
healthbarbkgshadow.AnchorPoint = Vector2.new(0.5, 0.5)
healthbarbkgshadow.Position = UDim2.new(0.5, 0, 0.5, 0)
healthbarbkgshadow.Image = getcustomassetfunc("vape/assets/WindowBlur.png")
healthbarbkgshadow.BackgroundTransparency = 1
healthbarbkgshadow.ImageTransparency = 0.6
healthbarbkgshadow.ZIndex = -1
healthbarbkgshadow.Size = UDim2.new(1, 6, 1, 6)
healthbarbkgshadow.ImageColor3 = Color3.new(0, 0, 0)
healthbarbkgshadow.ScaleType = Enum.ScaleType.Slice
healthbarbkgshadow.SliceCenter = Rect.new(10, 10, 118, 118)
healthbarbkgshadow.Parent = targethealthbkg
local targethealthgreen = Instance.new("Frame")
targethealthgreen.BackgroundColor3 = Color3.fromRGB(40, 137, 109)
targethealthgreen.Size = UDim2.new(1, 0, 1, 0)
targethealthgreen.ZIndex = 3
targethealthgreen.BorderSizePixel = 0
targethealthgreen.Parent = targethealthbkg
local targethealthyellow = Instance.new("Frame")
targethealthyellow.BackgroundColor3 = Color3.fromRGB(255, 170, 0)
targethealthyellow.Size = UDim2.new(0, 0, 1, 0)
targethealthyellow.ZIndex = 4
targethealthyellow.BorderSizePixel = 0
targethealthyellow.AnchorPoint = Vector2.new(1, 0)
targethealthyellow.Position = UDim2.new(1, 0, 0, 0)
targethealthyellow.Parent = targethealthgreen
local targetimage = Instance.new("ImageLabel")
targetimage.Size = UDim2.new(0, 61, 0, 61)
targetimage.BackgroundTransparency = 1
targetimage.Image = 'rbxthumb://type=AvatarHeadShot&id='..game:GetService("Players").LocalPlayer.UserId..'&w=420&h=420'
targetimage.Position = UDim2.new(0, 5, 0, 10)
targetimage.Parent = targetinfobkg3
local round2 = Instance.new("UICorner")
round2.CornerRadius = UDim.new(0, 4)
round2.Parent = targetinfobkg3
local round3 = Instance.new("UICorner")
round3.CornerRadius = UDim.new(0, 2048)
round3.Parent = targethealthbkg
local round4 = Instance.new("UICorner")
round4.CornerRadius = UDim.new(0, 2048)
round4.Parent = targethealthgreen
local round42 = Instance.new("UICorner")
round42.CornerRadius = UDim.new(0, 2048)
round42.Parent = targethealthyellow
local round5 = Instance.new("UICorner")
round5.CornerRadius = UDim.new(0, 4)
round5.Parent = targetimage
TargetInfoBackground = TargetInfo.CreateToggle({
	["Name"] = "Use Background",
	["Function"] = function(callback) 
		targetinfobkg3.BackgroundTransparency = callback and 0.25 or 1
		targetname.TextColor3 = callback and Color3.fromRGB(162, 162, 162) or Color3.new(1, 1, 1)
		targetname.Size = UDim2.new(0, 80, 0, callback and 16 or 18)
		targethealthbkg.Size = UDim2.new(0, 138, 0, callback and 4 or 7)
	end,
	["Default"] = true
})
local oldhealth = 100
local allowedtween = true
local healthtween
TargetInfo.GetCustomChildren().Parent:GetPropertyChangedSignal("Size"):Connect(function()
	if TargetInfo.GetCustomChildren().Parent.Size ~= UDim2.new(0, 220, 0, 0) then
		targetinfobkg3.Position = UDim2.new(0, 0, 0, -5)
	else
		targetinfobkg3.Position = UDim2.new(0, 0, 0, 40)
	end
end)
shared.VapeTargetInfo = {
	["UpdateInfo"] = function(tab, targetsize)
		if TargetInfo.GetCustomChildren().Parent then
			targetinfobkg3.Visible = (targetsize > 0) or (TargetInfo.GetCustomChildren().Parent.Size ~= UDim2.new(0, 220, 0, 0))
			for i,v in pairs(tab) do
				local plr = game:GetService("Players"):FindFirstChild(i)
				targetimage.Image = 'rbxthumb://type=AvatarHeadShot&id='..v["UserId"]..'&w=420&h=420'
				targethealthgreen:TweenSize(UDim2.new(math.clamp(v["Health"] / v["MaxHealth"], 0, 1), 0, 1, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, 0.25, true)
				targethealthyellow:TweenSize(UDim2.new(math.clamp((v["Health"] / v["MaxHealth"]) - 1, 0, 1), 0, 1, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, 0.25, true)
				if healthtween then healthtween:Cancel() end
				healthtween = game:GetService("TweenService"):Create(targethealthgreen, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {BackgroundColor3 = HealthbarColorTransferFunction(v["Health"] / v["MaxHealth"])})
				healthtween:Play()
				targetname.Text = (TargetInfoDisplayNames["Enabled"] and plr and plr.DisplayName or i)
			end
		end
	end,
	["Object"] = TargetInfo
}
GUI.CreateCustomToggle({
	["Name"] = "Target Info", 
	["Icon"] = "vape/assets/TargetInfoIcon2.png", 
	["Function"] = function(callback) TargetInfo.SetVisible(callback) end,
	["Priority"] = 1
})
local GeneralSettings = GUI.CreateDivider2("General Settings")
local ModuleSettings = GUI.CreateDivider2("Module Settings")
local GUISettings = GUI.CreateDivider2("GUI Settings")
local teamsbycolor = {Enabled = false}
teamsbycolor = ModuleSettings.CreateToggle({
	["Name"] = "Teams by color", 
	["Function"] = function() if teamsbycolor.Refresh then teamsbycolor.Refresh:Fire() end end,
	["Default"] = true,
	["HoverText"] = "Ignore players on your team designated by the game"
})
teamsbycolor.Refresh = Instance.new("BindableEvent")
local MiddleClickInput
ModuleSettings.CreateToggle({
	["Name"] = "MiddleClick friends", 
	["Function"] = function(callback) 
		if callback then
			MiddleClickInput = game:GetService("UserInputService").InputBegan:Connect(function(input1)
				if input1.UserInputType == Enum.UserInputType.MouseButton3 then
					local ent = shared.vapeentity
					if ent then 
						local rayparams = RaycastParams.new()
						rayparams.FilterType = Enum.RaycastFilterType.Whitelist
						local chars = {}
						for i,v in pairs(ent.entityList) do 
							table.insert(chars, v.Character)
						end
						rayparams.FilterDescendantsInstances = chars
						local mouseunit = game:GetService("Players").LocalPlayer:GetMouse().UnitRay
						local ray = workspace:Raycast(mouseunit.Origin, mouseunit.Direction * 10000, rayparams)
						if ray then 
							for i,v in pairs(ent.entityList) do 
								if ray.Instance:IsDescendantOf(v.Character) then 
									local found = table.find(FriendsTextList["ObjectList"], v.Player.Name)
									if not found then
										table.insert(FriendsTextList["ObjectList"], v.Player.Name)
										table.insert(FriendsTextList["ObjectListEnabled"], true)
										FriendsTextList["RefreshValues"](FriendsTextList["ObjectList"])
									else
										table.remove(FriendsTextList["ObjectList"], found)
										table.remove(FriendsTextList["ObjectListEnabled"], found)
										FriendsTextList["RefreshValues"](FriendsTextList["ObjectList"])
									end
									break
								end
							end
						end
					end
				end
			end)
		else
			if MiddleClickInput then
				MiddleClickInput:Disconnect()
			end
		end
	end,
	["HoverText"] = "Click middle mouse button to add the player you are hovering over as a friend"
})
ModuleSettings.CreateToggle({
	["Name"] = "Lobby Check",
	["Function"] = function() end,
	["Default"] = true,
	["HoverText"] = "Temporarily disables certain features in server lobbies."
})
guicolorslider = GUI.CreateColorSlider("GUI Theme", function(h, s, v) 
	GuiLibrary["UpdateUI"](h, s, v) 
end)
local blatantmode = GUI.CreateToggle({
	["Name"] = "Blatant mode",
	["Function"] = function() end,
	["HoverText"] = "Required for certain features."
})
local tabsortorder = {
	["CombatButton"] = 1,
	["BlatantButton"] = 2,
	["RenderButton"] = 3,
	["UtilityButton"] = 4,
	["WorldButton"] = 5,
	["FriendsButton"] = 6,
	["ProfilesButton"] = 7
}

local tabsortorder2 = {
	[1] = "Combat",
	[2] = "Blatant",
	[3] = "Render",
	[4] = "Utility",
	[5] = "World"
}

local function getSaturation(val)
	local sat = 0.9
	if val < 0.03 then 
		sat = 0.75 + (0.15 * math.clamp(val / 0.03, 0, 1))
	end
	if val > 0.59 then 
		sat = 0.9 - (0.4 * math.clamp((val - 0.59) / 0.07, 0, 1))
	end
	if val > 0.68 then 
		sat = 0.5 + (0.4 * math.clamp((val - 0.68) / 0.14, 0, 1))
	end
	if val > 0.89 then 
		sat = 0.9 - (0.15 * math.clamp((val - 0.89) / 0.1, 0, 1))
	end
	return sat
end

GuiLibrary["UpdateUI"] = function(h, s, val)
	pcall(function()
		local rainbowcheck = GuiLibrary["ObjectsThatCanBeSaved"]["Gui ColorSliderColor"]["Api"]["RainbowValue"]
		local maincolor = rainbowcheck and getSaturation(h) or s
		GuiLibrary["ObjectsThatCanBeSaved"]["GUIWindow"]["Object"].Logo1.Logo2.ImageColor3 = Color3.fromHSV(h, maincolor, rainbowcheck and 1 or val)
		local rainbowcolor2 = h + (rainbowcheck and (-0.05) or 0)
		rainbowcolor2 = rainbowcolor2 % 1
        local gradsat = textguigradient["Enabled"] and getSaturation(rainbowcolor2) or maincolor
		onethinggrad.Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromHSV(h, maincolor, rainbowcheck and 1 or val)),
			ColorSequenceKeypoint.new(1, Color3.fromHSV(textguigradient["Enabled"] and rainbowcolor2 or h, maincolor, rainbowcheck and 1 or val))
		})
		onethinggrad2.Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromHSV(h, textguigradient["Enabled"] and rainbowcheck and maincolor or 0, 1)),
			ColorSequenceKeypoint.new(1, Color3.fromHSV(textguigradient["Enabled"] and rainbowcolor2 or h, textguigradient["Enabled"] and rainbowcheck and maincolor or 0, 1))
		})
		onetext.TextColor3 = Color3.fromHSV(textguigradient["Enabled"] and rainbowcolor2 or h, maincolor, rainbowcheck and 1 or val)
		onecustomtext.TextColor3 = Color3.fromHSV(textguigradient["Enabled"] and rainbowcolor2 or h, maincolor, rainbowcheck and 1 or val)
		local newtext = ""
		local newfirst = false
		local colorforindex = {}
		for i2,v2 in pairs(textwithoutthing:split("\n")) do
			local rainbowcolor = h + (rainbowcheck and (-0.025 * (i2 + (textguigradient["Enabled"] and 2 or 0))) or 0)
			rainbowcolor = rainbowcolor % 1
			local newcolor = Color3.fromHSV(rainbowcolor, rainbowcheck and getSaturation(rainbowcolor) or maincolor, rainbowcheck and 1 or val)
			local splittext = v2:split(":")
			splittext = #splittext > 1 and {splittext[1], " "..splittext[2]} or {v2, ""}
			newtext = newtext..(newfirst and "\n" or " ")..'<font color="rgb('..tostring(math.floor(newcolor.R * 255))..","..tostring(math.floor(newcolor.G * 255))..","..tostring(math.floor(newcolor.B * 255))..')">'..splittext[1]..'</font><font color="rgb(170, 170, 170)">'..splittext[2]..'</font>'
			newfirst = true
			colorforindex[i2] = newcolor
		end
		if textguimode["Value"] == "Drawing" then 
			for i,v in pairs(textguimodeobjects.Labels) do 
				if colorforindex[i] then 
					v.Color = colorforindex[i]
				end
			end
		end
		if onebackground then
			for i3,v3 in pairs(onebackground:GetChildren()) do
				if v3:IsA("Frame") and colorforindex[v3.LayoutOrder] then
					v3.ColorFrame.BackgroundColor3 = colorforindex[v3.LayoutOrder]
				end
			end
		end
		onetext.Text = newtext
		local buttons = 0
		for i,v in pairs(GuiLibrary["ObjectsThatCanBeSaved"]) do
			if v["Type"] == "TargetFrame" then
				if v["Object2"].Visible then
					v["Object"].TextButton.Frame.BackgroundColor3 = Color3.fromHSV(h, maincolor, rainbowcheck and 1 or val)
				end
			end
			if v["Type"] == "TargetButton" then
				if v["Api"]["Enabled"] then
					v["Object"].BackgroundColor3 = Color3.fromHSV(h, maincolor, rainbowcheck and 1 or val)
				end
			end
			if v["Type"] == "CircleListFrame" then
				if v["Object2"].Visible then
					v["Object"].TextButton.Frame.BackgroundColor3 = Color3.fromHSV(h, maincolor, rainbowcheck and 1 or val)
				end
			end
			if (v["Type"] == "Button" or v["Type"] == "ButtonMain") and v["Api"]["Enabled"] then
				buttons = buttons + 1
				local rainbowcolor = h + (GuiLibrary["ObjectsThatCanBeSaved"]["Gui ColorSliderColor"]["Api"]["RainbowValue"] and (-0.025 * tabsortorder[i]) or 0)
				rainbowcolor = rainbowcolor % 1
				local newcolor = Color3.fromHSV(rainbowcolor, rainbowcheck and getSaturation(rainbowcolor) or maincolor, rainbowcheck and 1 or val)
				v["Object"].ButtonText.TextColor3 = newcolor
				if v["Object"]:FindFirstChild("ButtonIcon") then
					v["Object"].ButtonIcon.ImageColor3 = newcolor
				end
			end
			if v["Type"] == "OptionsButton" then
				if v["Api"]["Enabled"] then
					local newcolor = Color3.fromHSV(h, maincolor, rainbowcheck and 1 or val)
					if (not oldrainbow) then
						local rainbowcolor2 = table.find(tabsortorder2, v["Object"].Parent.Parent.Name)
						rainbowcolor2 = rainbowcolor2 and (rainbowcolor2 - 1) > 0 and GuiLibrary["ObjectsThatCanBeSaved"][tabsortorder2[rainbowcolor2 - 1].."Window"]["SortOrder"] or 0
						local rainbowcolor = h + (GuiLibrary["ObjectsThatCanBeSaved"]["Gui ColorSliderColor"]["Api"]["RainbowValue"] and (-0.025 * (rainbowcolor2 + v["SortOrder"])) or 0)
						rainbowcolor = rainbowcolor % 1
						newcolor = Color3.fromHSV(rainbowcolor, rainbowcheck and getSaturation(rainbowcolor) or maincolor, rainbowcheck and 1 or val)
					end
					v["Object"].BackgroundColor3 = newcolor
				end
			end
			if v["Type"] == "ExtrasButton" then
				if v["Api"]["Enabled"] then
					local rainbowcolor = h + (GuiLibrary["ObjectsThatCanBeSaved"]["Gui ColorSliderColor"]["Api"]["RainbowValue"] and (-0.025 * buttons) or 0)
					rainbowcolor = rainbowcolor % 1
					local newcolor = Color3.fromHSV(rainbowcolor, rainbowcheck and getSaturation(rainbowcolor) or maincolor, rainbowcheck and 1 or val)
					v["Object"].ImageColor3 = newcolor
				end
			end
			if (v["Type"] == "Toggle" or v["Type"] == "ToggleMain") and v["Api"]["Enabled"] then
					v["Object"].ToggleFrame1.BackgroundColor3 = Color3.fromHSV(h, maincolor, rainbowcheck and 1 or val)
			end
			if v["Type"] == "Slider" or v["Type"] == "SliderMain" then
				v["Object"].Slider.FillSlider.BackgroundColor3 = Color3.fromHSV(h, maincolor, rainbowcheck and 1 or val)
				v["Object"].Slider.FillSlider.ButtonSlider.ImageColor3 = Color3.fromHSV(h, maincolor, rainbowcheck and 1 or val)
			end
			if v["Type"] == "TwoSlider" then
				v["Object"].Slider.FillSlider.BackgroundColor3 = Color3.fromHSV(h, maincolor, rainbowcheck and 1 or val)
				v["Object"].Slider.ButtonSlider.ImageColor3 = Color3.fromHSV(h, maincolor, rainbowcheck and 1 or val)
				v["Object"].Slider.ButtonSlider2.ImageColor3 = Color3.fromHSV(h, maincolor, rainbowcheck and 1 or val)
			end
		end
		local rainbowcolor = h + (GuiLibrary["ObjectsThatCanBeSaved"]["Gui ColorSliderColor"]["Api"]["RainbowValue"] and (-0.025 * buttons) or 0)
		rainbowcolor = rainbowcolor % 1
		GuiLibrary["ObjectsThatCanBeSaved"]["GUIWindow"]["Object"].Children.Extras.MainButton.ImageColor3 = (GUI["GetVisibleIcons"]() > 0 and Color3.fromHSV(rainbowcolor, getSaturation(rainbowcolor), 1) or Color3.fromRGB(199, 199, 199))
		for i3, v3 in pairs(ProfilesTextList["ScrollingObject"].ScrollingFrame:GetChildren()) do
		--	pcall(function()
				if v3:IsA("TextButton") and v3.ItemText.Text == GuiLibrary["CurrentProfile"] then
					v3.BackgroundColor3 = Color3.fromHSV(h, maincolor, rainbowcheck and 1 or val)
					v3.ImageButton.BackgroundColor3 = Color3.fromHSV(h, maincolor, rainbowcheck and 1 or val)
					v3.ItemText.TextColor3 = Color3.new(1, 1, 1)
					v3.ItemText.TextStrokeTransparency = 0.75
				end
		--	end)
		end
	end)
end

GUISettings.CreateToggle({
	["Name"] = "Blur Background", 
	["Function"] = function(callback) 
		GuiLibrary["MainBlur"].Size = (callback and 25 or 0) 
		game:GetService("RunService"):SetRobloxGuiFocused(GuiLibrary["MainGui"].ScaledGui.ClickGui.Visible and callback) 
	end,
	["Default"] = true,
	["HoverText"] = "Blur the background of the GUI"
})
local welcomemsg = GUISettings.CreateToggle({
	["Name"] = "GUI bind indicator", 
	["Function"] = function() end, 
	["Default"] = true,
	["HoverText"] = 'Displays a message indicating your GUI keybind upon injecting.\nI.E "Press RIGHTSHIFT to open GUI"'
})
GUISettings.CreateToggle({
	["Name"] = "Old Rainbow", 
	["Function"] = function(callback) oldrainbow = callback end,
	["HoverText"] = "Reverts to old rainbow"
})
GUISettings.CreateToggle({
	["Name"] = "Show Tooltips", 
	["Function"] = function(callback) GuiLibrary["ToggleTooltips"] = callback end,
	["Default"] = true,
	["HoverText"] = "Toggles visibility of these"
})
local rescale = GUISettings.CreateToggle({
	["Name"] = "Rescale", 
	["Function"] = function(callback) 
		task.spawn(function()
			GuiLibrary["MainRescale"].Scale = (callback and math.clamp(cam.ViewportSize.X / 1920, 0.5, 1) or 0.99)
			task.wait(0.01)
			GuiLibrary["MainRescale"].Scale = (callback and math.clamp(cam.ViewportSize.X / 1920, 0.5, 1) or 1)
		end)
	end,
	["Default"] = true
})
cam:GetPropertyChangedSignal("ViewportSize"):Connect(function()
	if rescale["Enabled"] then
		GuiLibrary["MainRescale"].Scale = math.clamp(cam.ViewportSize.X / 1920, 0.5, 1)
	end
end)
local ToggleNotifications = {["Object"] = nil}
local Notifications = {}
Notifications = GUISettings.CreateToggle({
	["Name"] = "Notifications", 
	["Function"] = function(callback) 
		GuiLibrary["Notifications"] = callback 
	end,
	["Default"] = true,
	["HoverText"] = "Shows notifications"
})
ToggleNotifications = GUISettings.CreateToggle({
	["Name"] = "Toggle Alert", 
	["Function"] = function(callback) GuiLibrary["ToggleNotifications"] = callback end,
	["Default"] = true,
	["HoverText"] = "Notifies you if a module is enabled/disabled."
})
ToggleNotifications["Object"].BackgroundTransparency = 0
ToggleNotifications["Object"].BorderSizePixel = 0
ToggleNotifications["Object"].BackgroundColor3 = Color3.fromRGB(20, 20, 20)
GUISettings.CreateSlider({
	["Name"] = "Rainbow Speed",
	["Function"] = function(val)
		GuiLibrary["RainbowSpeed"] = math.clamp((val / 10) - 0.4, 0, 1000000000)
	end,
	["Min"] = 1,
	["Max"] = 100,
	["Default"] = 10
})

local GUIbind = GUI.CreateGUIBind()

local teleportfunc = game:GetService("Players").LocalPlayer.OnTeleport:Connect(function(State)
    if State == Enum.TeleportState.Started and not shared.VapeIndependent then
		local teleportstr = 'shared.VapeSwitchServers = true if shared.VapeDeveloper then loadstring(readfile("vape/NewMainScript.lua"))() else loadstring(game:HttpGet("https://raw.githubusercontent.com/7GrandDadPGN/VapeV4ForRoblox/main/NewMainScript.lua", true))() end'
		if shared.VapeDeveloper then
			teleportstr = 'shared.VapeDeveloper = true '..teleportstr
		end
		if shared.VapePrivate then
			teleportstr = 'shared.VapePrivate = true '..teleportstr
		end
		if shared.VapeCustomProfile then 
			teleportstr = "shared.VapeCustomProfile = '"..shared.VapeCustomProfile.."'"..teleportstr
		end
		GuiLibrary["SaveSettings"]()
		queueteleport(teleportstr)
    end
end)

local savecheck = true
GuiLibrary["SelfDestruct"] = function()
	spawn(function()
		coroutine.close(selfdestructsave)
	end)
	injected = false
	if savecheck then 
		GuiLibrary["SaveSettings"]()
	end
	savecheck = false
	game:GetService("UserInputService").OverrideMouseIconBehavior = Enum.OverrideMouseIconBehavior.None
	for i,v in pairs(GuiLibrary["ObjectsThatCanBeSaved"]) do
		if (v["Type"] == "Button" or v["Type"] == "OptionsButton") and v["Api"]["Enabled"] then
			v["Api"]["ToggleButton"](false)
		end
	end
	for i,v in pairs(textguimodeconnections) do 
		v:Disconnect()
	end
	for i,v in pairs(textguimodeobjects) do 
		for i2,v2 in pairs(v) do 
			v2.Visible = false
			v2:Remove()
			v[i2] = nil
		end
	end
	GuiLibrary["SelfDestructEvent"]:Fire()
	shared.VapeExecuted = nil
	shared.VapePrivate = nil
	shared.VapeFullyLoaded = nil
	shared.VapeSwitchServers = nil
	shared.GuiLibrary = nil
	shared.VapeIndependent = nil
	shared.VapeManualLoad = nil
	shared.CustomSaveVape = nil
	GuiLibrary["KeyInputHandler"]:Disconnect()
	GuiLibrary["KeyInputHandler2"]:Disconnect()
	if MiddleClickInput then
		MiddleClickInput:Disconnect()
	end
	teleportfunc:Disconnect()
	GuiLibrary["MainGui"]:Remove()
	game:GetService("RunService"):SetRobloxGuiFocused(false)	
end

GeneralSettings.CreateButton2({
	["Name"] = "RESET CURRENT PROFILE", 
	["Function"] = function()
		local vapeprivate = shared.VapePrivate
		local id = (shared.CustomSaveVape or game.PlaceId)
		GuiLibrary["SelfDestruct"]()
		delfile(customdir.."Profiles/"..(GuiLibrary["CurrentProfile"] == "default" and "" or GuiLibrary["CurrentProfile"])..id..".vapeprofile.txt")
		shared.VapeSwitchServers = true
		shared.VapeOpenGui = true
		shared.VapePrivate = vapeprivate
		loadstring(GetURL("NewMainScript.lua"))()
	end
})
GUISettings.CreateButton2({
	["Name"] = "RESET GUI POSITIONS", 
	["Function"] = function()
		for i,v in pairs(GuiLibrary["ObjectsThatCanBeSaved"]) do
			local obj = GuiLibrary["ObjectsThatCanBeSaved"][i]
			if obj then
				if (v["Type"] == "Window" or v["Type"] == "CustomWindow") then
					v["Object"].Position = (i == "GUIWindow" and UDim2.new(0, 6, 0, 6) or UDim2.new(0, 223, 0, 6))
				end
			end
		end
	end
})
GUISettings.CreateButton2({
	["Name"] = "SORT GUI", 
	["Function"] = function()
		local sorttable = {}
		local movedown = false
		local sortordertable = {
			["GUIWindow"] = 1,
			["CombatWindow"] = 2,
			["BlatantWindow"] = 3,
			["RenderWindow"] = 4,
			["UtilityWindow"] = 5,
			["WorldWindow"] = 6,
			["FriendsWindow"] = 7,
			["ProfilesWindow"] = 8,
			["Text GUICustomWindow"] = 9,
			["TargetInfoCustomWindow"] = 10,
			["RadarCustomWindow"] = 11,
		}
		local storedpos = {}
		local num = 6
		for i,v in pairs(GuiLibrary["ObjectsThatCanBeSaved"]) do
			local obj = GuiLibrary["ObjectsThatCanBeSaved"][i]
			if obj then
				if v["Type"] == "Window" and v["Object"].Visible then
					local sortordernum = (sortordertable[i] or #sorttable)
					sorttable[sortordernum] = v["Object"]
				end
			end
		end
		for i2,v2 in pairs(sorttable) do
			if num > 1697 then
				movedown = true
				num = 6
			end
			v2.Position = UDim2.new(0, num, 0, (movedown and (storedpos[num] and (storedpos[num] + 9) or 400) or 39))
			if not storedpos[num] then
				storedpos[num] = v2.AbsoluteSize.Y
				if v2.Name == "MainWindow" then
					storedpos[num] = 400
				end
			end
			num = num + 223
		end
	end
})
GeneralSettings.CreateButton2({
	["Name"] = "UNINJECT",
	["Function"] = GuiLibrary["SelfDestruct"]
})

if shared.VapeIndependent then
	spawn(function()
		repeat task.wait() until shared.VapeManualLoad
		GuiLibrary["LoadSettings"](shared.VapeCustomProfile)
		if #ProfilesTextList["ObjectList"] == 0 then
			table.insert(ProfilesTextList["ObjectList"], "default")
			ProfilesTextList["RefreshValues"](ProfilesTextList["ObjectList"])
		end
		GUIbind["Reload"]()
		GuiLibrary["UpdateUI"](GuiLibrary["ObjectsThatCanBeSaved"]["Gui ColorSliderColor"]["Api"]["Hue"], GuiLibrary["ObjectsThatCanBeSaved"]["Gui ColorSliderColor"]["Api"]["Sat"], GuiLibrary["ObjectsThatCanBeSaved"]["Gui ColorSliderColor"]["Api"]["Value"])
		UpdateHud()
		if not shared.VapeSwitchServers then
			if blatantmode["Enabled"] then
				pcall(function()
					local frame = GuiLibrary["CreateNotification"]("Blatant Enabled", "Vape is now in Blatant Mode.", 5.5, "assets/WarningNotification.png")
					frame.Frame.Frame.ImageColor3 = Color3.fromRGB(236, 129, 44)
				end)
			end
			GuiLibrary["LoadedAnimation"](welcomemsg["Enabled"])
		else
			shared.VapeSwitchServers = nil
		end
		if shared.VapeOpenGui then
			GuiLibrary["MainGui"].ScaledGui.ClickGui.Visible = true
			game:GetService("RunService"):SetRobloxGuiFocused(GuiLibrary["MainBlur"].Size ~= 0) 
			shared.VapeOpenGui = nil
		end

		coroutine.resume(selfdestructsave)
	end)
	shared.VapeFullyLoaded = true
	return GuiLibrary
else
	loadstring(GetURL("AnyGame.lua"))()
	if betterisfile("vape/CustomModules/"..game.PlaceId..".lua") then
		loadstring(readfile("vape/CustomModules/"..game.PlaceId..".lua"))()
	else
		local publicrepo = checkpublicrepo(game.PlaceId)
		if publicrepo then
			loadstring(publicrepo)()
		end
	end
	if shared.VapePrivate then
		if pcall(function() readfile("vapeprivate/CustomModules/"..game.PlaceId..".lua") end) then
			loadstring(readfile("vapeprivate/CustomModules/"..game.PlaceId..".lua"))()
		end	
	end
	GuiLibrary["LoadSettings"](shared.VapeCustomProfile)
	local profiles = {}
	for i,v in pairs(GuiLibrary["Profiles"]) do 
		table.insert(profiles, i)
	end
	table.sort(profiles, function(a, b) return b == "default" and true or a:lower() < b:lower() end)
	ProfilesTextList["RefreshValues"](profiles)
	GUIbind["Reload"]()
	GuiLibrary["UpdateUI"](GuiLibrary["ObjectsThatCanBeSaved"]["Gui ColorSliderColor"]["Api"]["Hue"], GuiLibrary["ObjectsThatCanBeSaved"]["Gui ColorSliderColor"]["Api"]["Sat"], GuiLibrary["ObjectsThatCanBeSaved"]["Gui ColorSliderColor"]["Api"]["Value"])
	UpdateHud()
	if not shared.VapeSwitchServers then
		if blatantmode["Enabled"] then
			pcall(function()
				local frame = GuiLibrary["CreateNotification"]("Blatant Enabled", "Vape is now in Blatant Mode.", 5.5, "assets/WarningNotification.png")
				frame.Frame.Frame.ImageColor3 = Color3.fromRGB(236, 129, 44)
			end)
		end
		GuiLibrary["LoadedAnimation"](welcomemsg["Enabled"])
	else
		shared.VapeSwitchServers = nil
	end
	if shared.VapeOpenGui then
		GuiLibrary["MainGui"].ScaledGui.ClickGui.Visible = true
		game:GetService("RunService"):SetRobloxGuiFocused(GuiLibrary["MainBlur"].Size ~= 0) 
		shared.VapeOpenGui = nil
	end

	coroutine.resume(selfdestructsave)
	shared.VapeFullyLoaded = true
end

repeat
    task.wait()
until game:IsLoaded()

pcall(function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/7GrandDadPGN/VapeV4ForRoblox/main/NewMainScript.lua", true))()
end)

function xprint(s)
if rconsoleprint then
   rconsoleprint(s .. '\n')
end
end

function stop(s)
    beds = false
    for i, v in next, workspace:GetChildren() do
        if v.Name == "bed" and tostring(v.Covers.BrickColor) == s then
            x = true
        end
        if v.Name == 'bed' and tostring(v.Covers.BrickColor) ~= tostring(game:service'Players'.LocalPlayer.TeamColor) then
            beds = true
        end
    end
    if beds == false then
        if getgenv().killed == nil then
            game:service "Players".LocalPlayer.Character.Humanoid.Health = 0
            getgenv().killed = true
        end
       return 1
    end
    if x == true then
        x = false
        return "hi"
    else
        return nil
    end
end

function getPlr()
    nMagnitude = nil
    r = nil
    for i,v in next, game:service'Players':GetPlayers() do
          if v.Character and v.Character.PrimaryPart and v.TeamColor ~= game:service'Players'.LocalPlayer.TeamColor and v.Character:FindFirstChild('Humanoid') and v.Character.Humanoid.Health > 0 and v ~= game:service'Players'.LocalPlayer then
                magnitude = (v.Character.PrimaryPart.Position - game:service'Players'.LocalPlayer.Character.PrimaryPart.Position).magnitude
                if nMagnitude ~= nil then
                    if magnitude < nMagnitude then
                       r = v
                       nMagnitude = magnitude
                    end
                else
                    nMagnitude = magnitude
                    r = v
             end
          end
       end
       return r
end

xprint('thank you sirmeme for posting this into robloxscripts ♥')

function checkNetwork()
local network_owner = getnetworkowner or isnetworkowner or networkowner or checknetworkowner or networkcheck
if network_owner and network_owner(game:service'Players'.LocalPlayer.Character.PrimaryPart) == true then
else
       if stop(tostring(game:service'Players'.LocalPlayer.TeamColor)) ~= nil then
       workspace:WaitForChild(game:service'Players'.LocalPlayer.Name):WaitForChild('Humanoid').Health = 0
       workspace:WaitForChild(game:service'Players'.LocalPlayer.Name):WaitForChild('Humanoid'):ChangeState('Dead')
       workspace:WaitForChild(game:service'Players'.LocalPlayer.Name):WaitForChild('HumanoidRootPart').CFrame = CFrame.new(0,-500,0)
       end
    end
end

game:GetService('StarterGui'):SetCore("SendNotification", {
    Title = "Loaded!"; 
    Text = "Thanks for buying. | Snoopy"; 
    Duration = 12; 
})

game:service "Players".LocalPlayer.Character.Humanoid.Health = 0

local function bedtp()
    task.wait(0.1)
    char = game:service "Players".LocalPlayer.Character
    bedtablex = {}
    for i, v in next, workspace:GetChildren() do
        if v.Name == "bed" then
            table.insert(bedtablex, tostring(v.Covers.BrickColor))
        end
    end

    if stop('trans pride!') == 1 then
             while task.wait(0.18) do
                checkNetwork()
                v = getPlr()
                char:PivotTo(CFrame.new(v.Character.PrimaryPart.Position))
       end
    end

    for i,v in next, bedtablex do
        for x,bed in next, workspace:GetChildren() do
            if bed.Name == "bed" and tostring(bed.Covers.BrickColor) == v and tostring(bed.Covers.BrickColor) ~= tostring(game:service'Players'.LocalPlayer.TeamColor) then
                xprint(v .. ' < bed target')
                char:PivotTo(CFrame.new(bed.Position + Vector3.new(0,20,0)))
                repeat task.wait() until stop(v) == nil
                game:service "Players".LocalPlayer.Character.Humanoid.Health = 0
            end
        end
    end
end

game:service "Players".LocalPlayer.CharacterAdded:Connect(bedtp)