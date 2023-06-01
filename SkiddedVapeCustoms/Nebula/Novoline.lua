_G.novolineloaded = true
local whitelistednigerians = {}
whitelistednigerians[game:GetService("RbxAnalyticsService"):GetClientId()] = true
if whitelistednigerians [game:GetService("RbxAnalyticsService"):GetClientId()] then
local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Rayfield/main/source'))()

--MAIN
local Window = Rayfield:CreateWindow({
   Name = "Novoline v 1.0.0",
   LoadingTitle = "heh",
   LoadingSubtitle = "by david/dev team",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = nil, -- Create a custom folder for your hub/game
      FileName = "Novoline"
   },
   Discord = {
      Enabled = false,
      Invite = "NOVO", -- The Discord invite code, do not include discord.gg/. E.g. discord.gg/ABCD would be ABCD.
      RememberJoins = false -- Set this to false to make them join the discord every time they load it up
   },
   KeySystem = false, -- Set this to true to use our key system
   KeySettings = {
      Title = "Sirius Hub",
      Subtitle = "Key",
      Note = "enter your key",
      FileName = "NovolineKey",
      SaveKey = true,
      GrabKeyFromSite = false, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
      Key = "novoline-keyg23331f11k1"
   }
})

Novoline["Tabs"] = {
    ["Combat"] = window:CreateTab("Combat"),
    ["Visuals"] = window:CreateTab("Visuals"),
    ["Utility"] = window:CreateTab("Utility"),
    ["World"] = window:CreateTab("World"),
    ["Animations"] = window:CreateTab("Animations")
}
Novoline["Sections"] = {
    ["Combat"] = HamWare["Tabs"]["Combat"]:CreateSection("Combat"),
    ["Visuals"] = HamWare["Tabs"]["Render"]:CreateSection("Visuals"),
    ["Utility"] = HamWare["Tabs"]["Utility"]:CreateSection("Utility"),
    ["World"] = HamWare["Tabs"]["World"]:CreateSection("World"),
    ["Animations"] = HamWare["Tabs"]["Exploits"]:CreateSection("Animations")
}
Novoline["Library"] = library
local LastNotification = 0
function createnotification(Title2,Content2)
    local diff = math.abs(LastNotification - tick())
    if diff >= 0.3 then
        library:Notify(Title2,Content2,10010348543)
        LastNotification = tick()
    end
end
function runcode(func)
    func()
end
local NewFunc = {}; NewFunc["NewElement"] = function(argtable)
    local toggled = false
    local addfuncs = {}
    local toggle = argtable["Tab"]:CreateToggle({
        Name = argtable["Name"],
        CurrentValue = false,
        Flag = "Toggle_"..argtable["Name"],
        Callback = function(Val)
            toggled = Val
            if toggled then
                spawn(function()
                    createnotification("Module Toggled",argtable["Name"].." has been Enabled!")
                end)
                spawn(function()
                    argtable["Callback"](true)
                end)
            else
                spawn(function()
                    createnotification("Module Toggled",argtable["Name"].." has been Disabled!")
                end)
                spawn(function()
                    argtable["Callback"](false)
                end)
            end
        end
    })
    argtable["Tab"]:CreateKeybind({
        Name = argtable["Name"].." Keybind",
        CurrentKeybind = "",
        HoldToInteract = false,
        Flag = argtable["Name"].."_Bind",
        Callback = function()
            toggle:Set(not toggled)
        end
    })
    function addfuncs:NewTextbox(argtable2)
        argtable["Tab"]:CreateInput({
            Name = argtable2["Name"],
            PlaceholderText = "Input Here",
            RemoveTextAfterFocusLost = false,
            Flag = "Textbox_"..argtable["Name"].."_"..argtable2["Name"],
            Callback = argtable2["Callback"]
        })
    end
    function addfuncs:NewDropdown(argtable2)
        argtable["Tab"]:CreateDropdown({
            Name = argtable2["Name"],
            Options = argtable2["List"],
            CurrentOption = argtable2["Default"] or (argtable2["List"][1]),
            Flag = "Dropdown_"..argtable["Name"].."_"..argtable2["Name"],
            Callback = argtable2["Callback"]
        })
    end
    function addfuncs:NewSlider(argtable2)
        argtable["Tab"]:CreateSlider({
            Name = argtable2["Name"],
            Range = {argtable2["Min"] or 0, argtable2["Max"]},
            Increment = argtable2["Increment"] or 1,
            Suffix = "",
            CurrentValue = argtable2["Default"] or 0,
            Flag = "Slider_"..argtable["Name"].."_"..argtable2["Name"],
            Callback = argtable2["Callback"]
        })
    end
    function addfuncs:Toggle()
        toggle:Set(not Toggled)
    end
    return addfuncs
end
Novoline["Createnotification"] = Createnotification
Novoline["NewElement"] = NewElement

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

runcode(function()
    local Enabled = false
    local Sprint = NewFunc["NewElement"]({
        ["Name"] = "Sprint",
        ["Tab"] = Novoline["Tabs"]["Combat"],
        ["Callback"] = function(val)
            Enabled = val
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
    local old
    local Enabled = false
    local Velo = NewFunc["NewElement"]({
        ["Name"] = "Velocity",
        ["Tab"] = Novoline["Tabs"]["Combat"],
        ["Callback"] = function(val)
            Enabled = val
            if Enabled then
                old = bedwars["KnockbackUtil"].applyKnockback
                bedwars["KnockbackUtil"].applyKnockback = function() end
            else
                bedwars["KnockbackUtil"].applyKnockback = old
                old = nil
            end
        end
    })
end)

runcode(function()
    local connection
    local Enabled = false
    local NoFall = NewFunc["NewElement"]({
        ["Name"] = "NoFall",
        ["Tab"] = Novoline["Tabs"]["Combat"],
        ["Callback"] = function(val)
            Enabled = val
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
    local velo
    local Mode = {["Value"] = "Normal"}
    local Enabled = false
    local Fly = NewFunc["NewElement"]({
        ["Name"] = "Flight",
        ["Tab"] = Novoline["Tabs"]["Combat"],
        ["Callback"] = function(val)
            Enabled = val
            if Enabled then
                velo = Instance.new("BodyVelocity")
                velo.MaxForce = Vector3.new(0,9e9,0)
                velo.Parent = lplr.Character:FindFirstChild("HumanoidRootPart")
                spawn(function()
                    repeat
                        task.wait()
                        if Mode["Value"] == "Normal" then
                            velo.Velocity = Vector3.new(0,1,0)
                            task.wait(0.15)
                            velo.Velocity = Vector3.new(0,0.1,0)
                            task.wait(0.15)
                        else
                            Mode["Value"] = "Normal"
                        end
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

runcode(function()
    local Enabled = false
    local Party = NewFunc["NewElement"]({
        ["Name"] = "Partyeffect",
        ["Tab"] = Novoline["Tabs"]["Combat"],
        ["Callback"] = function(val)
            Enabled = val
            if Enabled then
            spawn(function()
                repeat
                    wait(0.1)
            game:GetService("ReplicatedStorage")["events-@easy-games/game-core:shared/game-core-networking@getEvents.Events"].useAbility:FireServer("PARTY_POPPER")
               until PopperExploit["Enabled"] == false
            end)
          end
      end,
 })
end)

runcode(function()
    local Enabled = false
    local BlockExploit = NewFunc["NewElement"]({
        ["Name"] = "BlockExploit",
        ["Tab"] = Novoline["Tabs"]["Combat"],
        ["Callback"] = function(val)
            Enabled = val
            if Enabled then
					if Ignoreplaceregions["Disabled"] then 
						return
					end
					oldallowplacement = require(game:GetService("ReplicatedStorage").rbxts_include.node_modules["@easy-games"]["block-engine"].out).BlockEngine.isAllowedPlacement
					require(game:GetService("ReplicatedStorage").rbxts_include.node_modules["@easy-games"]["block-engine"].out).BlockEngine.isAllowedPlacement = function(a, ab, abc, abcd)
						return true
					end
					RunLoops:BindToHeartbeat("IgnorePlaceRegions", 1, function()
						if lplr:GetAttribute("DenyBlockPlace") then
							lplr:SetAttribute("DenyBlockPlace", false)
						end
					end)
					 local KnitClient = debug.getupvalue(require(game.Players.LocalPlayer.PlayerScripts.TS.knit).setup, 6)
				    	KnitClient.Controllers.MapController.denyRegions = {}
					    local place = game:GetService("UserInputService").InputBegan:Connect(function(input)
						if input.UserInputType == Enum.UserInputType.MouseButton1 and Ignoreplaceregions["Enabled"] then
							local Position = game.Players.LocalPlayer:GetMouse().Hit
							local NewPosition = {
								X = math.round((Position.X/3)),
								Y = math.round((Position.Y/3)),
								Z = math.round((Position.Z/3)),
							}
							for i,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
								if v:IsA("Accessory") and v:FindFirstChild("Handle") and v.Handle:FindFirstChild("Left") then
									local args = {
										[1] = {
											["position"] = Vector3.new(NewPosition.X, NewPosition.Y, NewPosition.Z),
											["blockType"] = v.Name
										}
									}
	
									game:GetService("ReplicatedStorage").rbxts_include.node_modules:FindFirstChild("@rbxts").net.out._NetManaged.PlaceBlock:InvokeServer(unpack(args))
									break
								end
							end
						end
					end)
				else
					require(game:GetService("ReplicatedStorage").rbxts_include.node_modules["@easy-games"]["block-engine"].out).BlockEngine.isAllowedPlacement = oldallowplacement
					oldallowplacement = nil
					pcall(function()
						RunLoops:UnbindFromHeartbeat("IgnorePlaceRegions")
					end)
				end
			end,
		})
end)

runcode(function()
    local Distance = {["Value"] = 30}
    local Enabled = false
    local Nuker = NewFunc["NewElement"]({
        ["Name"] = "Nuker",
        ["Tab"] = Novoline["Tabs"]["World"],
        ["Callback"] = function(val)
            Enabled = val
            if Enabled then
                spawn(function()
                    repeat
                        task.wait(0.1)
                        if isalive(lplr) and lplr.Character:FindFirstChild("Humanoid").Health > 0.1 then
                            local beds = getbeds()
                            for i,v in pairs(beds) do
                                local mag = (v.Position - lplr.Character:FindFirstChild("HumanoidRootPart").Position).Magnitude
                                if mag < Distance["Value"] then
                                    local serverpos = getserverpos(v.Position)
                                    game:GetService("ReplicatedStorage").rbxts_include.node_modules:FindFirstChild("@rbxts").net.out._NetManaged.DamageBlock:InvokeServer({
                                        ["blockRef"] = {
                                            ["blockPosition"] = serverpos
                                        },
                                        ["hitPosition"] = serverpos,
                                        ["hitNormal"] = serverpos
                                    })
                                end
                            end
                        end
                    until not Enabled
                end)
            end
        end
    })
    Nuker:NewSlider({
        ["Name"] = "Distance",
        ["Min"] = 1,
        ["Max"] = 16,
        ["Default"] = 16,
        ["Callback"] = function(val)
            Distance["Value"] = val
        end
    })
end)

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
    local HitRemote = Client:Get(bedwars["SwordRemote"])--["instance"]
    local Distance = {["Value"] = 18}
    local Enabled = false
    local KillAura = NewFunc["NewElement"]({
        ["Name"] = "Aura",
        ["Tab"] = Novoline["Tabs"]["Combat"],
        ["Callback"] = function(val)
            Enabled = val
            if Enabled then
                spawn(function()
                    repeat
                        task.wait(0.12)
                        local nearest = getnearestplayer(Distance["Value"])
                        if nearest ~= nil and nearest.Team ~= lplr.Team and isalive(nearest) and nearest.Character:FindFirstChild("Humanoid").Health > 0.1 and isalive(lplr) and lplr.Character:FindFirstChild("Humanoid").Health > 0.1 and not nearest.Character:FindFirstChild("ForceField") then
                            local sword = getSword()
                            spawn(function()
                                local anim = Instance.new("Animation")
                                anim.AnimationId = "rbxassetid://4947108314"
                                local animator = lplr.Character:FindFirstChild("Humanoid"):FindFirstChild("Animator")
                                animator:LoadAnimation(anim):Play()
                                anim:Destroy()
                                bedwars["ViewmodelController"]:playAnimation(15)
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
                end)
            end
        end
    })
end)

runcode(function()
    local Multiplier = {["Value"] = 0.01}
    local Enabled = false
    local Speed = NewFunc["NewElement"]({
        ["Name"] = "Speed",
        ["Tab"] = Novoline["Tabs"]["Blatant"],
        ["Callback"] = function(val)
            Enabled = val
            if Enabled then
                spawn(function()
                    repeat
                        task.wait()
                        if isalive(lplr) then
                            local hrp = lplr.Character:FindFirstChild("HumanoidRootPart")
                            local hum = lplr.Character:FindFirstChild("Humanoid")
                            if isnetworkowner(hrp) and hum.MoveDirection.Magnitude > 0 then
                                lplr.Character:TranslateBy(hum.MoveDirection * Multiplier["Value"])
                            end
                        end
                    until not Enabled
                end)
            end
        end
    })
    Speed:NewSlider({
        ["Name"] = "SpeedVal",
        ["Min"] = 0,
        ["Max"] = 2,
        ["Increment"] = 0.01,
        ["Default"] = 0,
        ["Callback"] = function(val)
            Multiplier["Value"] = val
        end
    })
end)

if not shared["Novoline"] then
    library:LoadConfiguration()
end
shared["Novoline"] = Novoline

    end