 -- made my grassy for grass privet thank u for azura for some of the modules 
--thanks mastadawn for texture pack 
-- snoopy v5 modules aswell sub to SSnopy yt

local GuiLibrary = shared.GuiLibrary
local blockraycast = RaycastParams.new()
blockraycast.FilterType = Enum.RaycastFilterType.Whitelist
local players = game:GetService("Players")
local getasset = getsynasset or getcustomasset or function(location) return "rbxasset://"..location end
local textservice = game:GetService("TextService")
local repstorage = game:GetService("ReplicatedStorage")
local lplr = players.LocalPlayer
local workspace = game:GetService("Workspace")
local lighting = game:GetService("Lighting")
local cam = workspace.CurrentCamera
local chatconnection
local modules = {}
local targetinfo = shared.VapeTargetInfo
local uis = game:GetService("UserInputService")
local mouse = lplr:GetMouse()
local remotes = {}
local bedwars = {}
local inventories = {}
local lagbackevent = Instance.new("BindableEvent")
local vec3 = Vector3.new
local cfnew = CFrame.new
local entity = shared.vapeentity
local uninjectflag = false
local matchstatetick = 0
local queueteleport = syn and syn.queue_on_teleport or queue_on_teleport or fluxus and fluxus.queue_on_teleport or function() end
local teleportfunc
local clients = {
	ChatStrings1 = {
		["KVOP25KYFPPP4"] = "vape",
		["IO12GP56P4LGR"] = "future",
		["RQYBPTYNURYZC"] = "rektsky"
	},
	ChatStrings2 = {
		["vape"] = "KVOP25KYFPPP4",
		["future"] = "IO12GP56P4LGR",
		["rektsky"] = "RQYBPTYNURYZC"
	},
	ClientUsers = {}
}
local requestfunc = syn and syn.request or http and http.request or http_request or fluxus and fluxus.request or getgenv().request or request
local checkpublicreponum = 0
local checkpublicrepo
checkpublicrepo = function(id)
	local suc, req = pcall(function() return requestfunc({
		Url = "https://raw.githubusercontent.com/7GrandDadPGN/VapeV4ForRoblox/main/CustomModules/6872274481.lua",
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
local publicrepo = checkpublicrepo(game.PlaceId)
if publicrepo then
    loadstring(publicrepo)()
end


local function createwarning(title, text, delay)
	local suc, res = pcall(function()
		local frame = GuiLibrary["CreateNotification"](title, text, delay, "assets/WarningNotification.png")
		frame.Frame.Frame.ImageColor3 = Color3.fromRGB(201, 126, 14)
		return frame
	end)
	return (suc and res)
end

createwarning("grass config", "grass privet loaded :)", 5)


		local cachedassets = {}
local function getcustomassetfunc(path)
	if not betterisfile(path) then
		task.spawn(function()
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
	if cachedassets[path] == nil then
		cachedassets[path] = getasset(path) 
	end
	return cachedassets[path]
end

local function getremote(tab)
	for i,v in pairs(tab) do
		if v == "Client" then
			return tab[i + 1]
		end
	end
	return ""
end
local function runcode(func)
	func()
end	
	
local function createwarning(title, text, delay)
	local suc, res = pcall(function()
		local frame = GuiLibrary["CreateNotification"](title, text, delay, "assets/WarningNotification.png")
		frame.Frame.Frame.ImageColor3 = Color3.fromRGB(201, 126, 14)
		return frame
	end)
	return (suc and res)
end

local function targetCheck(plr)
	return plr and plr.Humanoid and plr.Humanoid.Health > 0 and plr.Character:FindFirstChild("ForceField") == nil
end


local function targetCheck(plr)
	return plr and plr.Humanoid and plr.Humanoid.Health > 0 and plr.Character:FindFirstChild("ForceField") == nil
end

local function isAliveOld(plr, alivecheck)
	if plr then
		return plr and plr.Character and plr.Character.Parent ~= nil and plr.Character:FindFirstChild("HumanoidRootPart") and plr.Character:FindFirstChild("Head") and plr.Character:FindFirstChild("Humanoid")
	end
	return entity.isAlive
end



local betterisfile = function(file)
	local suc, res = pcall(function() return readfile(file) end)
	return suc and res ~= nil
end

local cachedassets = {}
local function getcustomassetfunc(path)
	if not betterisfile(path) then
		task.spawn(function()
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
	if cachedassets[path] == nil then
		cachedassets[path] = getasset(path) 
	end
	return cachedassets[path]
end


local RunLoops = {RenderStepTable = {}, StepTable = {}, HeartTable = {}}
do
	function RunLoops:BindToRenderStep(name, num, func)
		if RunLoops.RenderStepTable[name] == nil then
			RunLoops.RenderStepTable[name] = game:GetService("RunService").RenderStepped:connect(func)
		end
	end

	function RunLoops:UnbindFromRenderStep(name)
		if RunLoops.RenderStepTable[name] then
			RunLoops.RenderStepTable[name]:Disconnect()
			RunLoops.RenderStepTable[name] = nil
		end
	end

	function RunLoops:BindToStepped(name, num, func)
		if RunLoops.StepTable[name] == nil then
			RunLoops.StepTable[name] = game:GetService("RunService").Stepped:connect(func)
		end
	end

	function RunLoops:UnbindFromStepped(name)
		if RunLoops.StepTable[name] then
			RunLoops.StepTable[name]:Disconnect()
			RunLoops.StepTable[name] = nil
		end
	end

	function RunLoops:BindToHeartbeat(name, num, func)
		if RunLoops.HeartTable[name] == nil then
			RunLoops.HeartTable[name] = game:GetService("RunService").Heartbeat:connect(func)
		end
	end

	function RunLoops:UnbindFromHeartbeat(name)
		if RunLoops.HeartTable[name] then
			RunLoops.HeartTable[name]:Disconnect()
			RunLoops.HeartTable[name] = nil
		end
	end
end

local funnyFly = {["Enabled"] = false}
local funnyAura = {["Enabled"] = false}

runcode(function()
	local funnyFly 
	local part
	local cam = workspace.CurrentCamera
    funnyFly = GuiLibrary["ObjectsThatCanBeSaved"]["BlatantWindow"]["Api"].CreateOptionsButton({
        ["Name"] = "FunnyFly",
        ["Function"] = function(callback)
            if callback then
                if funnyAura.Enabled then funnyAura.ToggleButton(false) end
                local origy = entity.character.HumanoidRootPart.Position.y
                part = Instance.new("Part", workspace)
                part.Size = Vector3.new(1,1,1)
                part.Transparency = 1
                part.Anchored = true
                part.CanCollide = false
                cam.CameraSubject = part
                RunLoops:BindToHeartbeat("FunnyFlyPart", 1, function()
                    local pos = entity.character.HumanoidRootPart.Position
                    part.Position = Vector3.new(pos.x, origy, pos.z)
                end)
                local cf = entity.character.HumanoidRootPart.CFrame
                entity.character.HumanoidRootPart.CFrame = CFrame.new(cf.x, 300000, cf.z)
                if entity.character.HumanoidRootPart.Position.X < 50000 then 
                    entity.character.HumanoidRootPart.CFrame *= CFrame.new(0, 100000, 0)
                end
            else
                RunLoops:UnbindFromHeartbeat("FunnyFlyPart")
                local pos = entity.character.HumanoidRootPart.Position
                local rcparams = RaycastParams.new()
                rcparams.FilterType = Enum.RaycastFilterType.Whitelist
                rcparams.FilterDescendantsInstances = {workspace.Map}
                rc = workspace:Raycast(Vector3.new(pos.x, 300, pos.z), Vector3.new(0,-1000,0), rcparams)
                if rc and rc.Position then
                    entity.character.HumanoidRootPart.CFrame = CFrame.new(rc.Position) * CFrame.new(0,3,0)
                end
                cam.CameraSubject = lplr.Character
                part:Destroy()
                RunLoops:BindToHeartbeat("FunnyFlyVeloEnd", 1, function()
                    entity.character.HumanoidRootPart.Velocity = Vector3.new(0,0,0)
                    entity.character.HumanoidRootPart.CFrame = CFrame.new(rc.Position) * CFrame.new(0,3,0)
                end)
                task.wait(1)
                RunLoops:UnbindFromHeartbeat("FunnyFlyVeloEnd")
                
            end
        end
    })
end)


local workspace = game:GetService("Workspace")
inffly = GuiLibrary["ObjectsThatCanBeSaved"]["BlatantWindow"]["Api"].CreateOptionsButton({
 	["Name"] = "azura fly v2",
        ["Function"] = function(callback)
            if callback then
				lplr.Character.Archivable = true
				local clonethingy = lplr.Character:Clone()
                clonethingy.Name = "clonethingy"
				clonethingy:FindFirstChild("HumanoidRootPart").Transparency = 1
				clonethingy.Parent = workspace
             	workspace.Camera.CameraSubject = clonethingy.Humanoid
                partthingy = Instance.new("Part",workspace)
                partthingy.Size = Vector3.new(2048,1,2048)
                partthingy.CFrame = clonethingy.HumanoidRootPart.CFrame * CFrame.new(0,-4,0)
                partthingy.Anchored = true
                partthingy.Transparency = 1
				partthingy.Name = "partthingy"
                RunLoops:BindToHeartbeat("BoostSilentFly", 1, function(delta)
                    clonethingy.HumanoidRootPart.CFrame = CFrame.new(entity.character.HumanoidRootPart.CFrame.X,clonethingy.HumanoidRootPart.CFrame.Y,entity.character.HumanoidRootPart.CFrame.Z)
                    clonethingy.HumanoidRootPart.Rotation = entity.character.HumanoidRootPart.Rotation
                end)
                task.spawn(function()
                    repeat
                        task.wait(0.1)
                        if inffly["Enabled"] == false then break end
                        entity.character.HumanoidRootPart.Velocity = entity.character.HumanoidRootPart.Velocity + Vector3.new(0,35,0)
                    until inffly["Enabled"] == false
                end)
                repeat
                    task.wait(0.001)
                    if inffly["Enabled"] == false then break end
                    clonethingy.HumanoidRootPart.CFrame = CFrame.new(entity.character.HumanoidRootPart.CFrame.X,clonethingy.HumanoidRootPart.CFrame.Y,entity.character.HumanoidRootPart.CFrame.Z)
                until testing == true
            else
					if workspace:FindFirstChild("clonethingy") or workspace:FindFirstChild("partthingy") then
						workspace:FindFirstChild("clonethingy"):Destroy()
						workspace:FindFirstChild("partthingy"):Destroy()
                        RunLoops:UnbindFromHeartbeat("BoostSilentFly")
                        testing = true
                        workspace.Camera.CameraSubject = lplr.Character.Humanoid
                    end
            
			end

        end,
       [" HoverText"] = "No Lagbacks, max 20 seconds"
    })
        local BoostAirJump = {["Enabled"] = false}
BoostAirJump = GuiLibrary["ObjectsThatCanBeSaved"]["BlatantWindow"]["Api"].CreateOptionsButton({
    ["Name"] = "BoostAirJump",
    ["Function"] = function(callback)
        if callback then
            task.spawn(function()
                repeat
                    task.wait(0.1)
                    if BoostAirJump["Enabled"] == false then break end
                    entity.character.HumanoidRootPart.Velocity = entity.character.HumanoidRootPart.Velocity + Vector3.new(0,35,0)
                until BoostAirJump["Enabled"] == false
            end)
        end
    end,
    ["HoverText"] = "Bypasses High Jump"
})
repeat task.wait() until game:IsLoaded()
repeat task.wait() until shared.GuiLibrary
local GuiLibrary = shared.GuiLibrary
local vec3 = Vector3.new
local lplr = game:GetService("Players")
local ScriptSettings = {}
local UIS = game:GetService("UserInputService")
local COB = function(tab, argstable) 
    return GuiLibrary["ObjectsThatCanBeSaved"][tab.."Window"]["Api"].CreateOptionsButton(argstable)
end

local currentinventory = {
	["inventory"] = {
		["items"] = {},
		["armor"] = {},
		["hand"] = nil
	}
}
local repstorage = game:GetService("ReplicatedStorage")
local client = {}
local Client = require(repstorage.TS.remotes).default.Client
local function getremote(tab)
	for i,v in pairs(tab) do
		if v == "Client" then
			return tab[i + 1]
		end
	end
	return ""
end
local function runcode(func)
	func()
end	
local bedwars = {}
local arrowdodgedata
local getfunctions
						local OldClientGet 
local oldbreakremote
local oldbob
runcode(function()
    getfunctions = function()
		local Flamework = require(repstorage["rbxts_include"]["node_modules"]["@flamework"].core.out).Flamework
		repeat task.wait() until Flamework.isInitialized
        local KnitClient = debug.getupvalue(require(lplr.PlayerScripts.TS.knit).setup, 6)
        local Client = require(repstorage.TS.remotes).default.Client
        local InventoryUtil = require(repstorage.TS.inventory["inventory-util"]).InventoryUtil
        OldClientGet = getmetatable(Client).Get
        getmetatable(Client).Get = function(Self, remotename)
			local res = OldClientGet(Self, remotename)
			if uninjectflag then return res end
			if remotename == "DamageBlock" then
				return {
					["CallServerAsync"] = function(Self, tab)
						local block = bedwars["BlockController"]:getStore():getBlockAt(tab.blockRef.blockPosition)
						if block and block.Name == "bed" then
							if getWhitelistedBed(block) then
								return {andThen = function(self, func) 
									func("failed")
								end}
							end
						end
						return res:CallServerAsync(tab)
					end,
					["CallServer"] = function(Self, tab)
						local block = bedwars["BlockController"]:getStore():getBlockAt(tab.blockRef.blockPosition)
						if block and block.Name == "bed" then
							if getWhitelistedBed(block) then
								return {andThen = function(self, func) 
									func("failed")
								end}
							end
						end
						return res:CallServer(tab)
					end
				}
			elseif remotename == bedwars["AttackRemote"] then
				return {
					["instance"] = res["instance"],
					["SendToServer"] = function(Self, tab)
						local suc, plr = pcall(function() return players:GetPlayerFromCharacter(tab.entityInstance) end)
						if suc and plr then
							local playertype, playerattackable = WhitelistFunctions:CheckPlayerType(plr)
							if not playerattackable then 
								return nil
							end
						end
						if Reach["Enabled"] then
							local mag = (tab.validate.selfPosition.value - tab.validate.targetPosition.value).magnitude
							local newres = hashvec(tab.validate.selfPosition.value + (mag > 14.4 and (CFrame.lookAt(tab.validate.selfPosition.value, tab.validate.targetPosition.value).lookVector * 4) or Vector3.zero))
							tab.validate.selfPosition = newres
						end
						return res:SendToServer(tab)
					end
				}
			end
            return res
        end
		bedwars = {
			["AnimationUtil"] = require(repstorage["rbxts_include"]["node_modules"]["@easy-games"]["game-core"].out["shared"].util["animation-util"]).AnimationUtil,
			["AngelUtil"] = require(repstorage.TS.games.bedwars.kit.kits.angel["angel-kit"]),
			["AppController"] = require(repstorage["rbxts_include"]["node_modules"]["@easy-games"]["game-core"].out.client.controllers["app-controller"]).AppController,
			["AttackRemote"] = getremote(debug.getconstants(getmetatable(KnitClient.Controllers.SwordController)["attackEntity"])),
			["BatteryRemote"] = getremote(debug.getconstants(debug.getproto(debug.getproto(KnitClient.Controllers.BatteryController.KnitStart, 1), 1))),
			["BatteryEffectController"] = KnitClient.Controllers.BatteryEffectsController,
            ["BalloonController"] = KnitClient.Controllers.BalloonController,
            ["BlockController"] = require(repstorage["rbxts_include"]["node_modules"]["@easy-games"]["block-engine"].out).BlockEngine,
            ["BlockController2"] = require(repstorage["rbxts_include"]["node_modules"]["@easy-games"]["block-engine"].out.client.placement["block-placer"]).BlockPlacer,
            ["BlockEngine"] = require(lplr.PlayerScripts.TS.lib["block-engine"]["client-block-engine"]).ClientBlockEngine,
            ["BlockEngineClientEvents"] = require(repstorage["rbxts_include"]["node_modules"]["@easy-games"]["block-engine"].out.client["block-engine-client-events"]).BlockEngineClientEvents,
			["BlockPlacementController"] = KnitClient.Controllers.BlockPlacementController,
            ["BedwarsKits"] = require(repstorage.TS.games.bedwars.kit["bedwars-kit-shop"]).BedwarsKitShop,
            ["BlockBreaker"] = KnitClient.Controllers.BlockBreakController.blockBreaker,
            ["BowTable"] = KnitClient.Controllers.ProjectileController,
			["BowConstantsTable"] = debug.getupvalue(KnitClient.Controllers.ProjectileController.enableBeam, 5),
			["ChestController"] = KnitClient.Controllers.ChestController,
			["ClickHold"] = require(repstorage["rbxts_include"]["node_modules"]["@easy-games"]["game-core"].out.client.ui.lib.util["click-hold"]).ClickHold,
            ["ClientHandler"] = Client,
			["SharedConstants"] = require(repstorage.TS["shared-constants"]),
            ["ClientHandlerDamageBlock"] = require(repstorage["rbxts_include"]["node_modules"]["@easy-games"]["block-engine"].out.remotes).BlockEngineRemotes.Client,
            ["ClientStoreHandler"] = require(lplr.PlayerScripts.TS.ui.store).ClientStore,
			["ClientHandlerSyncEvents"] = require(lplr.PlayerScripts.TS["client-sync-events"]).ClientSyncEvents,
            ["CombatConstant"] = require(repstorage.TS.combat["combat-constant"]).CombatConstant,
			["CombatController"] = KnitClient.Controllers.CombatController,
			["ConsumeSoulRemote"] = getremote(debug.getconstants(KnitClient.Controllers.GrimReaperController.consumeSoul)),
			["ConstantManager"] = require(repstorage["rbxts_include"]["node_modules"]["@easy-games"]["game-core"].out["shared"].constant["constant-manager"]).ConstantManager,
			["CooldownController"] = KnitClient.Controllers.CooldownController,
            ["damageTable"] = KnitClient.Controllers.DamageController,
			["DinoRemote"] = getremote(debug.getconstants(debug.getproto(KnitClient.Controllers.DinoTamerController.KnitStart, 3))),
			["DaoRemote"] = getremote(debug.getconstants(debug.getprotos(KnitClient.Controllers.DaoController.onEnable)[4])),
			["DamageController"] = KnitClient.Controllers.DamageController,
			["DamageIndicator"] = KnitClient.Controllers.DamageIndicatorController.spawnDamageIndicator,
			["DamageIndicatorController"] = KnitClient.Controllers.DamageIndicatorController,
			["DetonateRavenRemote"] = getremote(debug.getconstants(getmetatable(KnitClient.Controllers.RavenController).detonateRaven)),
            ["DropItem"] = getmetatable(KnitClient.Controllers.ItemDropController).dropItemInHand,
            ["DropItemRemote"] = getremote(debug.getconstants(getmetatable(KnitClient.Controllers.ItemDropController).dropItemInHand)),
            ["EatRemote"] = getremote(debug.getconstants(debug.getproto(getmetatable(KnitClient.Controllers.ConsumeController).onEnable, 1))),
            ["EquipItemRemote"] = getremote(debug.getconstants(debug.getprotos(shared.oldequipitem or require(repstorage.TS.entity.entities["inventory-entity"]).InventoryEntity.equipItem)[3])),
			["FishermanTable"] = KnitClient.Controllers.FishermanController,
			["FovController"] = KnitClient.Controllers.FovController,
			["GameAnimationUtil"] = require(repstorage.TS.animation["animation-util"]).GameAnimationUtil,
			["GamePlayerUtil"] = require(repstorage.TS.player["player-util"]).GamePlayerUtil,
            ["getEntityTable"] = require(repstorage.TS.entity["entity-util"]).EntityUtil,
            ["getIcon"] = function(item, showinv)
                local itemmeta = bedwars["ItemTable"][item.itemType]
                if itemmeta and showinv then
                    return itemmeta.image
                end
                return ""
            end,
			["getInventory2"] = function(plr)
                local suc, result = pcall(function() 
					return InventoryUtil.getInventory(plr) 
				end)
                return (suc and result or {
                    ["items"] = {},
                    ["armor"] = {},
                    ["hand"] = nil
                })
            end,
            ["getItemMetadata"] = require(repstorage.TS.item["item-meta"]).getItemMeta,
			["GrimReaperController"] = KnitClient.Controllers.GrimReaperController,
			["GuitarHealRemote"] = getremote(debug.getconstants(KnitClient.Controllers.GuitarController.performHeal)),
			["HangGliderController"] = KnitClient.Controllers.HangGliderController,
			["HighlightController"] = KnitClient.Controllers.EntityHighlightController,
            ["ItemTable"] = debug.getupvalue(require(repstorage.TS.item["item-meta"]).getItemMeta, 1),
			["JuggernautRemote"] = getremote(debug.getconstants(debug.getprotos(debug.getprotos(KnitClient.Controllers.JuggernautController.KnitStart)[1])[4])),
			["KatanaController"] = KnitClient.Controllers.DaoController,
			["KatanaRemote"] = getremote(debug.getconstants(debug.getproto(KnitClient.Controllers.DaoController.onEnable, 4))),
            ["KnockbackTable"] = debug.getupvalue(require(repstorage.TS.damage["knockback-util"]).KnockbackUtil.calculateKnockbackVelocity, 1),
			["LobbyClientEvents"] = require(repstorage["rbxts_include"]["node_modules"]["@easy-games"].lobby.out.client.events).LobbyClientEvents,
			["MapMeta"] = require(repstorage.TS.game.map["map-meta"]),
			["MissileController"] = KnitClient.Controllers.GuidedProjectileController,
			["MinerRemote"] = getremote(debug.getconstants(debug.getprotos(debug.getproto(getmetatable(KnitClient.Controllers.MinerController).onKitEnabled, 1))[2])),
			["MinerController"] = KnitClient.Controllers.MinerController,
			["ProdAnimations"] = require(repstorage.TS.animation.definitions["prod-animations"]).ProdAnimations,
            ["PickupRemote"] = getremote(debug.getconstants(getmetatable(KnitClient.Controllers.ItemDropController).checkForPickup)),
            ["PlayerUtil"] = require(repstorage.TS.player["player-util"]).GamePlayerUtil,
			["ProjectileMeta"] = require(repstorage.TS.projectile["projectile-meta"]).ProjectileMeta,
			["QueueMeta"] = require(repstorage.TS.game["queue-meta"]).QueueMeta,
			["QueueCard"] = require(lplr.PlayerScripts.TS.controllers.global.queue.ui["queue-card"]).QueueCard,
			["QueryUtil"] = require(repstorage["rbxts_include"]["node_modules"]["@easy-games"]["game-core"].out).GameQueryUtil,
			["PaintRemote"] = getremote(debug.getconstants(KnitClient.Controllers.PaintShotgunController.fire)),
            ["prepareHashing"] = require(repstorage.TS["remote-hash"]["remote-hash-util"]).RemoteHashUtil.prepareHashVector3,
			["ProjectileRemote"] = getremote(debug.getconstants(debug.getupvalues(getmetatable(KnitClient.Controllers.ProjectileController)["launchProjectileWithValues"])[2])),
			["ProjectileHitRemote"] = getremote(debug.getconstants(debug.getproto(KnitClient.Controllers.ProjectileController.createLocalProjectile, 1))),
            ["RavenTable"] = KnitClient.Controllers.RavenController,
			["RespawnController"] = KnitClient.Controllers.BedwarsRespawnController,
			["RespawnTimer"] = require(lplr.PlayerScripts.TS.controllers.games.bedwars.respawn.ui["respawn-timer"]).RespawnTimerWrapper,
			["ResetRemote"] = getremote(debug.getconstants(debug.getproto(KnitClient.Controllers.ResetController.createBindable, 1))),
			["Roact"] = require(repstorage["rbxts_include"]["node_modules"]["roact"].src),
			["RuntimeLib"] = require(repstorage["rbxts_include"].RuntimeLib),
            ["Shop"] = require(repstorage.TS.games.bedwars.shop["bedwars-shop"]).BedwarsShop,
			["ShopItems"] = debug.getupvalue(require(repstorage.TS.games.bedwars.shop["bedwars-shop"]).BedwarsShop.getShopItem, 2),
            ["ShopRight"] = require(lplr.PlayerScripts.TS.controllers.games.bedwars.shop.ui["item-shop"]["shop-left"]["shop-left"]).BedwarsItemShopLeft,
			["SpawnRavenRemote"] = getremote(debug.getconstants(getmetatable(KnitClient.Controllers.RavenController).spawnRaven)),
            ["SoundManager"] = require(repstorage["rbxts_include"]["node_modules"]["@easy-games"]["game-core"].out).SoundManager,
			["SoundList"] = require(repstorage.TS.sound["game-sound"]).GameSound,
            ["sprintTable"] = KnitClient.Controllers.SprintController,
			["StopwatchController"] = KnitClient.Controllers.StopwatchController,
            ["SwingSword"] = getmetatable(KnitClient.Controllers.SwordController).swingSwordAtMouse,
            ["SwingSwordRegion"] = getmetatable(KnitClient.Controllers.SwordController).swingSwordInRegion,
            ["SwordController"] = KnitClient.Controllers.SwordController,
            ["TreeRemote"] = getremote(debug.getconstants(debug.getprotos(debug.getprotos(KnitClient.Controllers.BigmanController.KnitStart)[2])[1])),
			["TrinityRemote"] = getremote(debug.getconstants(debug.getproto(getmetatable(KnitClient.Controllers.AngelController).onKitEnabled, 1))),
            ["VictoryScreen"] = require(lplr.PlayerScripts.TS.controllers["game"].match.ui["victory-section"]).VictorySection,
            ["ViewmodelController"] = KnitClient.Controllers.ViewmodelController,
			["VehicleController"] = KnitClient.Controllers.VehicleController,
			["WeldTable"] = require(repstorage.TS.util["weld-util"]).WeldUtil,
        }
	end
end)

				
-- Compute 3D launch direction from
-- start: start position
-- target: target position
-- v: launch velocity
-- g: gravity (positive) e.g. 196.2
-- higherArc: if true, use the higher arc. If false, use the lower arc.
local function LaunchDirection(start, target, v, g, higherArc: boolean)
-- get the direction flattened:
local horizontal = vec3(target.X - start.X, 0, target.Z - start.Z)

local h = target.Y - start.Y
local d = horizontal.Magnitude
local a = LaunchAngle(v, g, d, h, higherArc)

-- NaN ~= NaN, computation couldn't be done (e.g. because it's too far to launch)
if a ~= a then return nil end

-- speed if we were just launching at a flat angle:
local vec = horizontal.Unit * v

-- rotate around the axis perpendicular to that direction...
local rotAxis = vec3(-horizontal.Z, 0, horizontal.X)

-- ...by the angle amount
return CFrame.fromAxisAngle(rotAxis, a) * vec
end

local function FindLeadShot(targetPosition: Vector3, targetVelocity: Vector3, projectileSpeed: Number, shooterPosition: Vector3, shooterVelocity: Vector3, gravity: Number)
local distance = (targetPosition - shooterPosition).Magnitude

local p = targetPosition - shooterPosition
local v = targetVelocity - shooterVelocity
local a = Vector3.zero

local timeTaken = (distance / projectileSpeed)

if gravity > 0 then
local timeTaken = projectileSpeed/gravity+math.sqrt(2*distance/gravity+projectileSpeed^2/gravity^2)
end

local goalX = targetPosition.X + v.X*timeTaken + 0.5 * a.X * timeTaken^2
local goalY = targetPosition.Y + v.Y*timeTaken + 0.5 * a.Y * timeTaken^2
local goalZ = targetPosition.Z + v.Z*timeTaken + 0.5 * a.Z * timeTaken^2

return vec3(goalX, goalY, goalZ)
end

local function addvectortocframe(cframe, vec)
local x, y, z, R00, R01, R02, R10, R11, R12, R20, R21, R22 = cframe:GetComponents()
return cfnew(x + vec.X, y + vec.Y, z + vec.Z, R00, R01, R02, R10, R11, R12, R20, R21, R22)
end

local function addvectortocframe2(cframe, newylevel)
local x, y, z, R00, R01, R02, R10, R11, R12, R20, R21, R22 = cframe:GetComponents()
return cfnew(x, newylevel, z, R00, R01, R02, R10, R11, R12, R20, R21, R22)
end
local oldcloneroot
function notify(text)
    local frame = GuiLibrary["CreateNotification"]("Azura Client Lite Notification", text, 5, "assets/WarningNotification.png")
    frame.Frame.Frame.ImageColor3 = Color3.fromRGB(255, 64, 64)
end
function boxnotify(text)
    if messagebox then
        messagebox(text, "Azura V4", 0)
     end
end

local clone

local oldchar
AnticheatBypassArrowDodge = GuiLibrary["ObjectsThatCanBeSaved"]["AnticheatBypassOptionsButton"]["Api"].CreateToggle({
        ["Name"] = "Arrow Dodge",
        ["Function"] = function(callback)
            if callback then
                Client = {
                    WaitFor = function(self6, remote)
                task.spawn(function()
                    oldcloneroot = entity.character.HumanoidRootPart
lplr.Character.Parent = game
clone = oldcloneroot:Clone()
clone.Parent = lplr.Character
oldcloneroot.Parent = cam
bedwars["QueryUtil"]:setQueryIgnored(oldcloneroot, true)
oldcloneroot.Transparency = 1
clone.CFrame = oldcloneroot.CFrame

lplr.Character.PrimaryPart = clone
lplr.Character.Parent = workspace
                    bedwars["ClientHandler"]:WaitFor("ProjectileLaunch"):andThen(function(p6)
                        arrowdodgeconnection = p6:Connect(function(data)
                            if oldchar and clone and GuiLibrary["ObjectsThatCanBeSaved"]["AnticheatBypassOptionsButton"]["Api"]["Enabled"] and (arrowdodgedata == nil or arrowdodgedata.launchVelocity ~= data.launchVelocity) and entity.isAlive and tostring(data.projectile):find("arrow") then
                                arrowdodgedata = data
                                local projmetatab = bedwars["ProjectileMeta"][tostring(data.projectile)]
                                local prediction = (projmetatab.predictionLifetimeSec or projmetatab.lifetimeSec or 3)
                                local gravity = (projmetatab.gravitationalAcceleration or 196.2)
                                local multigrav = gravity
                                local offsetshootpos = data.position
                                local pos = (oldchar.HumanoidRootPart.Position + vec3(0, 0.8, 0)) 
                                local calculated2 = FindLeadShot(pos, Vector3.zero, (Vector3.zero - data.launchVelocity).magnitude, offsetshootpos, Vector3.zero, multigrav) 
                                local calculated = LaunchDirection(offsetshootpos, pos, (Vector3.zero - data.launchVelocity).magnitude, gravity, false)
                                local initialvelo = calculated--(calculated - offsetshootpos).Unit * launchvelo
                                local initialvelo2 = (calculated2 - offsetshootpos).Unit * (Vector3.zero - data.launchVelocity).magnitude
                                local calculatedvelo = vec3(initialvelo2.X, (initialvelo and initialvelo.Y or initialvelo2.Y), initialvelo2.Z).Unit * (Vector3.zero - data.launchVelocity).magnitude
                                if (calculatedvelo - data.launchVelocity).magnitude <= 20 then 
                                    oldchar.HumanoidRootPart.CFrame = oldchar.HumanoidRootPart.CFrame:lerp(clone.HumanoidRootPart.CFrame, 0.6)
                                end
                            end
                        end)
                    end)
                end)
            end
            }
            end
        end,
        ["Default"] = true,
        ["HoverText"] = "Dodge arrows (tanqr moment)"
})

local AnticheatDisabler = COB("Render", {
    Name = "texture pack",
    Function = function(callback) 
        if callback then
         local obj = game:GetObjects("rbxassetid://11144793662")[1]
                obj.Name = "Part"
                obj.Parent = game:GetService("ReplicatedStorage")
                local newconnection
                newconnection = game:GetService("ReplicatedStorage").ChildAdded:Connect(function(v)
                    for i,x in pairs(obj:GetChildren()) do
                        x:Clone().Parent = v
                    end
                    newconnection:Disconnect()
                end)
                loadstring(game:HttpGet("https://raw.githubusercontent.com/eLeCtRaDoMiNuS/milkwareclient/main/texture.lua"))()
        end
    end,
    Default = false,
    HoverText = "texture pack"

})


local function getWhitelistedBed(bed)
	for i,v in pairs(players:GetChildren()) do
		if v:GetAttribute("Team") and bed and bed:GetAttribute("Team"..v:GetAttribute("Team").."NoBreak") and bedwars["CheckWhitelisted"](v) then
			return true
		end
	end
	return false
end
local getfunctions
local OldClientGet 
local oldbreakremote
local oldbob
runcode(function()
    getfunctions = function()
		local Flamework = require(repstorage["rbxts_include"]["node_modules"]["@flamework"].core.out).Flamework
		repeat task.wait() until Flamework.isInitialized
        local KnitClient = debug.getupvalue(require(lplr.PlayerScripts.TS.knit).setup, 6)
        local Client = require(repstorage.TS.remotes).default.Client
        local InventoryUtil = require(repstorage.TS.inventory["inventory-util"]).InventoryUtil
        OldClientGet = getmetatable(Client).Get
        getmetatable(Client).Get = function(Self, remotename)
			local res = OldClientGet(Self, remotename)
			if uninjectflag then return res end
			if remotename == "DamageBlock" then
				return {
					["CallServerAsync"] = function(Self, tab)
						local block = bedwars["BlockController"]:getStore():getBlockAt(tab.blockRef.blockPosition)
						if block and block.Name == "bed" then
							if getWhitelistedBed(block) then
								return {andThen = function(self, func) 
									func("failed")
								end}
							end
						end
						return res:CallServerAsync(tab)
					end,
					["CallServer"] = function(Self, tab)
						local block = bedwars["BlockController"]:getStore():getBlockAt(tab.blockRef.blockPosition)
						if block and block.Name == "bed" then
							if getWhitelistedBed(block) then
								return {andThen = function(self, func) 
									func("failed")
								end}
							end
						end
						return res:CallServer(tab)
					end
				}
			elseif remotename == bedwars["AttackRemote"] then
				return {
					["instance"] = res["instance"],
					["SendToServer"] = function(Self, tab)
						local suc, plr = pcall(function() return players:GetPlayerFromCharacter(tab.entityInstance) end)
						if suc and plr then
							local playertype, playerattackable = bedwars["CheckPlayerType"](plr)
							if not playerattackable then 
								return nil
							end
						end
						if Reach["Enabled"] then
							local mag = (tab.validate.selfPosition.value - tab.validate.targetPosition.value).magnitude
							local newres = hashvec(tab.validate.selfPosition.value + (mag > 14.4 and (CFrame.lookAt(tab.validate.selfPosition.value, tab.validate.targetPosition.value).lookVector * 4) or Vector3.zero))
							tab.validate.selfPosition = newres
						end
						return res:SendToServer(tab)
					end
				}
			end
            return res
        end

		bedwars = {
			["AnimationUtil"] = require(repstorage["rbxts_include"]["node_modules"]["@easy-games"]["game-core"].out["shared"].util["animation-util"]).AnimationUtil,
			["AngelUtil"] = require(repstorage.TS.games.bedwars.kit.kits.angel["angel-kit"]),
			["AppController"] = require(repstorage["rbxts_include"]["node_modules"]["@easy-games"]["game-core"].out.client.controllers["app-controller"]).AppController,
			["AttackRemote"] = getremote(debug.getconstants(getmetatable(KnitClient.Controllers.SwordController)["attackEntity"])),
			["BatteryRemote"] = getremote(debug.getconstants(debug.getproto(debug.getproto(KnitClient.Controllers.BatteryController.KnitStart, 1), 1))),
			["BatteryEffectController"] = KnitClient.Controllers.BatteryEffectsController,
            ["BalloonController"] = KnitClient.Controllers.BalloonController,
            ["BlockController"] = require(repstorage["rbxts_include"]["node_modules"]["@easy-games"]["block-engine"].out).BlockEngine,
            ["BlockController2"] = require(repstorage["rbxts_include"]["node_modules"]["@easy-games"]["block-engine"].out.client.placement["block-placer"]).BlockPlacer,
            ["BlockEngine"] = require(lplr.PlayerScripts.TS.lib["block-engine"]["client-block-engine"]).ClientBlockEngine,
            ["BlockEngineClientEvents"] = require(repstorage["rbxts_include"]["node_modules"]["@easy-games"]["block-engine"].out.client["block-engine-client-events"]).BlockEngineClientEvents,
			["BlockPlacementController"] = KnitClient.Controllers.BlockPlacementController,
            ["BedwarsKits"] = require(repstorage.TS.games.bedwars.kit["bedwars-kit-shop"]).BedwarsKitShop,
            ["BlockBreaker"] = KnitClient.Controllers.BlockBreakController.blockBreaker,
            ["BowTable"] = KnitClient.Controllers.ProjectileController,
			["BowConstantsTable"] = debug.getupvalue(KnitClient.Controllers.ProjectileController.enableBeam, 5),
			["ChestController"] = KnitClient.Controllers.ChestController,
			["ClickHold"] = require(repstorage["rbxts_include"]["node_modules"]["@easy-games"]["game-core"].out.client.ui.lib.util["click-hold"]).ClickHold,
            ["ClientHandler"] = Client,
			["SharedConstants"] = require(repstorage.TS["shared-constants"]),
            ["ClientHandlerDamageBlock"] = require(repstorage["rbxts_include"]["node_modules"]["@easy-games"]["block-engine"].out.remotes).BlockEngineRemotes.Client,
            ["ClientStoreHandler"] = require(lplr.PlayerScripts.TS.ui.store).ClientStore,
			["ClientHandlerSyncEvents"] = require(lplr.PlayerScripts.TS["client-sync-events"]).ClientSyncEvents,
            ["CombatConstant"] = require(repstorage.TS.combat["combat-constant"]).CombatConstant,
			["CombatController"] = KnitClient.Controllers.CombatController,
			["ConsumeSoulRemote"] = getremote(debug.getconstants(KnitClient.Controllers.GrimReaperController.consumeSoul)),
			["ConstantManager"] = require(repstorage["rbxts_include"]["node_modules"]["@easy-games"]["game-core"].out["shared"].constant["constant-manager"]).ConstantManager,
			["CooldownController"] = KnitClient.Controllers.CooldownController,
            ["damageTable"] = KnitClient.Controllers.DamageController,
			["DinoRemote"] = getremote(debug.getconstants(debug.getproto(KnitClient.Controllers.DinoTamerController.KnitStart, 3))),
			["DaoRemote"] = getremote(debug.getconstants(debug.getprotos(KnitClient.Controllers.DaoController.onEnable)[4])),
			["DamageController"] = KnitClient.Controllers.DamageController,
			["DamageIndicator"] = KnitClient.Controllers.DamageIndicatorController.spawnDamageIndicator,
			["DamageIndicatorController"] = KnitClient.Controllers.DamageIndicatorController,
			["DetonateRavenRemote"] = getremote(debug.getconstants(getmetatable(KnitClient.Controllers.RavenController).detonateRaven)),
            ["DropItem"] = getmetatable(KnitClient.Controllers.ItemDropController).dropItemInHand,
            ["DropItemRemote"] = getremote(debug.getconstants(getmetatable(KnitClient.Controllers.ItemDropController).dropItemInHand)),
            ["EatRemote"] = getremote(debug.getconstants(debug.getproto(getmetatable(KnitClient.Controllers.ConsumeController).onEnable, 1))),
            ["EquipItemRemote"] = getremote(debug.getconstants(debug.getprotos(shared.oldequipitem or require(repstorage.TS.entity.entities["inventory-entity"]).InventoryEntity.equipItem)[3])),
			["FishermanTable"] = KnitClient.Controllers.FishermanController,
			["FovController"] = KnitClient.Controllers.FovController,
			["GameAnimationUtil"] = require(repstorage.TS.animation["animation-util"]).GameAnimationUtil,
			["GamePlayerUtil"] = require(repstorage.TS.player["player-util"]).GamePlayerUtil,
            ["getEntityTable"] = require(repstorage.TS.entity["entity-util"]).EntityUtil,
            ["getIcon"] = function(item, showinv)
                local itemmeta = bedwars["ItemTable"][item.itemType]
                if itemmeta and showinv then
                    return itemmeta.image
                end
                return ""
            end,
			["getInventory2"] = function(plr)
                local suc, result = pcall(function() 
					return InventoryUtil.getInventory(plr) 
				end)
                return (suc and result or {
                    ["items"] = {},
                    ["armor"] = {},
                    ["hand"] = nil
                })
            end,
            ["getItemMetadata"] = require(repstorage.TS.item["item-meta"]).getItemMeta,
			["GrimReaperController"] = KnitClient.Controllers.GrimReaperController,
			["GuitarHealRemote"] = getremote(debug.getconstants(KnitClient.Controllers.GuitarController.performHeal)),
			["HangGliderController"] = KnitClient.Controllers.HangGliderController,
			["HighlightController"] = KnitClient.Controllers.EntityHighlightController,
            ["ItemTable"] = debug.getupvalue(require(repstorage.TS.item["item-meta"]).getItemMeta, 1),
			["JuggernautRemote"] = getremote(debug.getconstants(debug.getprotos(debug.getprotos(KnitClient.Controllers.JuggernautController.KnitStart)[1])[4])),
			["KatanaController"] = KnitClient.Controllers.DaoController,
			["KatanaRemote"] = getremote(debug.getconstants(debug.getproto(KnitClient.Controllers.DaoController.onEnable, 4))),
            ["KnockbackTable"] = debug.getupvalue(require(repstorage.TS.damage["knockback-util"]).KnockbackUtil.calculateKnockbackVelocity, 1),
			["LobbyClientEvents"] = require(repstorage["rbxts_include"]["node_modules"]["@easy-games"].lobby.out.client.events).LobbyClientEvents,
			["MapMeta"] = require(repstorage.TS.game.map["map-meta"]),
			["MissileController"] = KnitClient.Controllers.GuidedProjectileController,
			["MinerRemote"] = getremote(debug.getconstants(debug.getprotos(debug.getproto(getmetatable(KnitClient.Controllers.MinerController).onKitEnabled, 1))[2])),
			["MinerController"] = KnitClient.Controllers.MinerController,
			["ProdAnimations"] = require(repstorage.TS.animation.definitions["prod-animations"]).ProdAnimations,
            ["PickupRemote"] = getremote(debug.getconstants(getmetatable(KnitClient.Controllers.ItemDropController).checkForPickup)),
            ["PlayerUtil"] = require(repstorage.TS.player["player-util"]).GamePlayerUtil,
			["ProjectileMeta"] = require(repstorage.TS.projectile["projectile-meta"]).ProjectileMeta,
			["QueueMeta"] = require(repstorage.TS.game["queue-meta"]).QueueMeta,
			["QueueCard"] = require(lplr.PlayerScripts.TS.controllers.global.queue.ui["queue-card"]).QueueCard,
			["QueryUtil"] = require(repstorage["rbxts_include"]["node_modules"]["@easy-games"]["game-core"].out).GameQueryUtil,
			["PaintRemote"] = getremote(debug.getconstants(KnitClient.Controllers.PaintShotgunController.fire)),
            ["prepareHashing"] = require(repstorage.TS["remote-hash"]["remote-hash-util"]).RemoteHashUtil.prepareHashVector3,
			["ProjectileRemote"] = getremote(debug.getconstants(debug.getupvalues(getmetatable(KnitClient.Controllers.ProjectileController)["launchProjectileWithValues"])[2])),
			["ProjectileHitRemote"] = getremote(debug.getconstants(debug.getproto(KnitClient.Controllers.ProjectileController.createLocalProjectile, 1))),
            ["RavenTable"] = KnitClient.Controllers.RavenController,
			["RespawnController"] = KnitClient.Controllers.BedwarsRespawnController,
			["RespawnTimer"] = require(lplr.PlayerScripts.TS.controllers.games.bedwars.respawn.ui["respawn-timer"]).RespawnTimerWrapper,
			["ResetRemote"] = getremote(debug.getconstants(debug.getproto(KnitClient.Controllers.ResetController.createBindable, 1))),
			["Roact"] = require(repstorage["rbxts_include"]["node_modules"]["roact"].src),
			["RuntimeLib"] = require(repstorage["rbxts_include"].RuntimeLib),
            ["Shop"] = require(repstorage.TS.games.bedwars.shop["bedwars-shop"]).BedwarsShop,
			["ShopItems"] = debug.getupvalue(require(repstorage.TS.games.bedwars.shop["bedwars-shop"]).BedwarsShop.getShopItem, 2),
            ["ShopRight"] = require(lplr.PlayerScripts.TS.controllers.games.bedwars.shop.ui["item-shop"]["shop-left"]["shop-left"]).BedwarsItemShopLeft,
			["SpawnRavenRemote"] = getremote(debug.getconstants(getmetatable(KnitClient.Controllers.RavenController).spawnRaven)),
            ["SoundManager"] = require(repstorage["rbxts_include"]["node_modules"]["@easy-games"]["game-core"].out).SoundManager,
			["SoundList"] = require(repstorage.TS.sound["game-sound"]).GameSound,
            ["sprintTable"] = KnitClient.Controllers.SprintController,
			["StopwatchController"] = KnitClient.Controllers.StopwatchController,
            ["SwingSword"] = getmetatable(KnitClient.Controllers.SwordController).swingSwordAtMouse,
            ["SwingSwordRegion"] = getmetatable(KnitClient.Controllers.SwordController).swingSwordInRegion,
            ["SwordController"] = KnitClient.Controllers.SwordController,
            ["TreeRemote"] = getremote(debug.getconstants(debug.getprotos(debug.getprotos(KnitClient.Controllers.BigmanController.KnitStart)[2])[1])),
			["TrinityRemote"] = getremote(debug.getconstants(debug.getproto(getmetatable(KnitClient.Controllers.AngelController).onKitEnabled, 1))),
            ["VictoryScreen"] = require(lplr.PlayerScripts.TS.controllers["game"].match.ui["victory-section"]).VictorySection,
            ["ViewmodelController"] = KnitClient.Controllers.ViewmodelController,
			["VehicleController"] = KnitClient.Controllers.VehicleController,
			["WeldTable"] = require(repstorage.TS.util["weld-util"]).WeldUtil,
        }
	end
end)
local lplr = game:GetService("Players").LocalPlayer
local queueType = "bedwars_test"
local currentinventory = {
	["inventory"] = {
		["items"] = {},
		["armor"] = {},
		["hand"] = nil
	}
}
local function getSpeedMultiplier(reduce)
	local speed = 1
	if lplr.Character then 
		local speedboost = lplr.Character:GetAttribute("SpeedBoost")
		if speedboost and speedboost > 1 then 
			speed = speed + (speedboost - 1)
		end
		if lplr.Character:GetAttribute("GrimReaperChannel") then 
			speed = speed + 0.6
		end
		if lplr.Character:GetAttribute("SpeedPieBuff") then 
			speed = speed + (queueType == "SURVIVAL" and 0.15 or 0.3)
		end
		local armor = currentinventory.inventory.armor[3]
		if type(armor) ~= "table" then armor = {itemType = ""} end
		if armor.itemType == "speed_boots" then 
			speed = speed + 1
		end
	end
	return reduce and speed ~= 1 and speed * (0.9 - (0.15 * math.floor(speed))) or speed
end

local networkownerfunc = isnetworkowner or function(part)
	if gethiddenproperty(part, "NetworkOwnershipRule") == Enum.NetworkOwnership.Manual then 
		sethiddenproperty(part, "NetworkOwnershipRule", Enum.NetworkOwnership.Automatic)
		networkownertick = tick() + 8
	end
	return networkownertick <= tick()
end



repeat task.wait() until game:IsLoaded()
repeat task.wait() until shared.GuiLibrary
local GuiLibrary = shared.GuiLibrary
local ScriptSettings = {}
local UIS = game:GetService("UserInputService")
local COB = function(tab, argstable) 
    return GuiLibrary["ObjectsThatCanBeSaved"][tab.."Window"]["Api"].CreateOptionsButton(argstable)
end


local void = GuiLibrary["ObjectsThatCanBeSaved"]["WorldWindow"]["Api"].CreateOptionsButton({
    ["Name"] = "space sky",
    ["Function"] = function(v)
        if v then
            game.Lighting.Sky.SkyboxBk = "http://www.roblox.com/asset/?id=159454299"
            game.Lighting.Sky.SkyboxDn = "http://www.roblox.com/asset/?id=159454296"
            game.Lighting.Sky.SkyboxFt = "http://www.roblox.com/asset/?id=159454293"
            game.Lighting.Sky.SkyboxLf = "http://www.roblox.com/asset/?id=159454286"
            game.Lighting.Sky.SkyboxRt = "http://www.roblox.com/asset/?id=159454300"
            game.Lighting.Sky.SkyboxUp = "http://www.roblox.com/asset/?id=159454288"
            game.Lighting.FogColor = Color3.new(236, 88, 241)
            game.Lighting.FogEnd = "200"
            game.Lighting.FogStart = "0"
            game.Lighting.Ambient = Color3.new(0.5, 0, 1)
        else
            game.Lighting.Sky.SkyboxBk = "http://www.roblox.com/asset/?id=7018684000"
            game.Lighting.Sky.SkyboxDn = "http://www.roblox.com/asset/?id=6334928194"
            game.Lighting.Sky.SkyboxFt = "http://www.roblox.com/asset/?id=7018684000"
            game.Lighting.Sky.SkyboxLf = "http://www.roblox.com/asset/?id=7018684000"
            game.Lighting.Sky.SkyboxRt = "http://www.roblox.com/asset/?id=7018684000"
            game.Lighting.Sky.SkyboxUp = "http://www.roblox.com/asset/?id=7018689553"
            game.Lighting.FogColor = Color3.new(1, 1, 1)
            game.Lighting.FogEnd = "10000"
            game.Lighting.FogStart = "0"
            game.Lighting.Ambient = Color3.new(0, 0, 0)
        end
    end
})

local void = GuiLibrary["ObjectsThatCanBeSaved"]["WorldWindow"]["Api"].CreateOptionsButton({
    ["Name"] = "shader sky",
    ["Function"] = function(v)
        if v then
            game.Lighting.Sky.SkyboxBk = "http://www.roblox.com/asset/?id=415688378"
            game.Lighting.Sky.SkyboxDn = "http://www.roblox.com/asset/?id=415688193"
            game.Lighting.Sky.SkyboxFt = "http://www.roblox.com/asset/?id=415688242"
            game.Lighting.Sky.SkyboxLf = "http://www.roblox.com/asset/?id=415688310"
            game.Lighting.Sky.SkyboxRt = "http://www.roblox.com/asset/?id=415688274"
            game.Lighting.Sky.SkyboxUp = "http://www.roblox.com/asset/?id=415688354"
            game.Lighting.FogColor = Color3.new(236, 88, 241)
            game.Lighting.FogEnd = "200"
            game.Lighting.FogStart = "0"
            game.Lighting.Ambient = Color3.new(0.5, 0, 1)
        else
            game.Lighting.Sky.SkyboxBk = "http://www.roblox.com/asset/?id=7018684000"
            game.Lighting.Sky.SkyboxDn = "http://www.roblox.com/asset/?id=6334928194"
            game.Lighting.Sky.SkyboxFt = "http://www.roblox.com/asset/?id=7018684000"
            game.Lighting.Sky.SkyboxLf = "http://www.roblox.com/asset/?id=7018684000"
            game.Lighting.Sky.SkyboxRt = "http://www.roblox.com/asset/?id=7018684000"
            game.Lighting.Sky.SkyboxUp = "http://www.roblox.com/asset/?id=7018689553"
            game.Lighting.FogColor = Color3.new(1, 1, 1)
            game.Lighting.FogEnd = "10000"
            game.Lighting.FogStart = "0"
            game.Lighting.Ambient = Color3.new(0, 0, 0)
        end
    end
})

local void = GuiLibrary["ObjectsThatCanBeSaved"]["WorldWindow"]["Api"].CreateOptionsButton({
    ["Name"] = "pink moutian sky",
    ["Function"] = function(v)
        if v then
            game.Lighting.Sky.SkyboxBk = "http://www.roblox.com/asset/?id=160188495"
            game.Lighting.Sky.SkyboxDn = "http://www.roblox.com/asset/?id=160188614"
            game.Lighting.Sky.SkyboxFt = "http://www.roblox.com/asset/?id=160188609"
            game.Lighting.Sky.SkyboxLf = "http://www.roblox.com/asset/?id=160188589"
            game.Lighting.Sky.SkyboxRt = "http://www.roblox.com/asset/?id=160188597"
            game.Lighting.Sky.SkyboxUp = "http://www.roblox.com/asset/?id=160188588"
            game.Lighting.FogColor = Color3.new(236, 88, 241)
            game.Lighting.FogEnd = "200"
            game.Lighting.FogStart = "0"
            game.Lighting.Ambient = Color3.new(0.5, 0, 1)
        else
            game.Lighting.Sky.SkyboxBk = "http://www.roblox.com/asset/?id=7018684000"
            game.Lighting.Sky.SkyboxDn = "http://www.roblox.com/asset/?id=6334928194"
            game.Lighting.Sky.SkyboxFt = "http://www.roblox.com/asset/?id=7018684000"
            game.Lighting.Sky.SkyboxLf = "http://www.roblox.com/asset/?id=7018684000"
            game.Lighting.Sky.SkyboxRt = "http://www.roblox.com/asset/?id=7018684000"
            game.Lighting.Sky.SkyboxUp = "http://www.roblox.com/asset/?id=7018689553"
            game.Lighting.FogColor = Color3.new(1, 1, 1)
            game.Lighting.FogEnd = "10000"
            game.Lighting.FogStart = "0"
            game.Lighting.Ambient = Color3.new(0, 0, 0)
        end
    end
})

youtubedetector = GuiLibrary["ObjectsThatCanBeSaved"]["UtilityWindow"]["Api"].CreateOptionsButton({
	["Name"] = "Youtube detector/star detector", 
	["Function"] = function(callback)
		if callback then
			for i, plr in pairs(players:GetChildren()) do
				if plr:IsInGroup(4199740) and plr:GetRankInGroup(4199740) >= 1 then
					createwarning("Vape", "Youtuber found " .. plr.Name .. "(" .. plr.DisplayName .. ")", 20)
					end
				end
			end
		end
})


local void = GuiLibrary["ObjectsThatCanBeSaved"]["WorldWindow"]["Api"].CreateOptionsButton({
    ["Name"] = "purple sky",
    ["Function"] = function(v)
        if v then
            game.Lighting.Sky.SkyboxBk = "http://www.roblox.com/asset/?id=433274085"
            game.Lighting.Sky.SkyboxDn = "http://www.roblox.com/asset/?id=433274194"
            game.Lighting.Sky.SkyboxFt = "http://www.roblox.com/asset/?id=433274131"
            game.Lighting.Sky.SkyboxLf = "http://www.roblox.com/asset/?id=433274370"
            game.Lighting.Sky.SkyboxRt = "http://www.roblox.com/asset/?id=433274429"
            game.Lighting.Sky.SkyboxUp = "http://www.roblox.com/asset/?id=433274285"
            game.Lighting.FogColor = Color3.new(170, 0, 255)
            game.Lighting.FogEnd = "200"
            game.Lighting.FogStart = "0"
            game.Lighting.Ambient = Color3.new(170, 0, 255)
        else
            game.Lighting.Sky.SkyboxBk = "http://www.roblox.com/asset/?id=7018684000"
            game.Lighting.Sky.SkyboxDn = "http://www.roblox.com/asset/?id=6334928194"
            game.Lighting.Sky.SkyboxFt = "http://www.roblox.com/asset/?id=7018684000"
            game.Lighting.Sky.SkyboxLf = "http://www.roblox.com/asset/?id=7018684000"
            game.Lighting.Sky.SkyboxRt = "http://www.roblox.com/asset/?id=7018684000"
            game.Lighting.Sky.SkyboxUp = "http://www.roblox.com/asset/?id=7018689553"
            game.Lighting.FogColor = Color3.new(1, 1, 1)
            game.Lighting.FogEnd = "10000"
            game.Lighting.FogStart = "0"
            game.Lighting.Ambient = Color3.new(0, 0, 0)
        end
    end
})

local RagdollDisabler = COB("Utility", {
	["Name"]  = "ragdoll disabler",
	["Function"] = function(callback)
		if callback then
			pcall(function()
				ScriptSettings.RagdollDisabler = true
				while task.wait(0.1) do
					if not ScriptSettings.RagdollDisabler == true then return end
					game:GetService("Players").LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Ragdoll)
					task.wait(0.085)
					game:GetService("Players").LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Running)
				end
			end)
		else
			pcall(function()
				ScriptSettings.SlowDisabler = false
			end)
		end
	end,
	["Default"] = false,
	["HoverText"] = "Ragdolls to bypass ac"
})

local Crosshair = COB("Render", {
	["Name"] = "Crosshair",
	["Function"] = function(callback)
		if callback then
			pcall(function()
				ScriptSettings.Crosshair = true
				local mouse = game:GetService("Players").LocalPlayer:GetMouse()
				mouse.Icon = "rbxassetid://9943168532"
				mouse:GetPropertyChangedSignal("Icon"):Connect(function()
				    if not ScriptSettings.Crosshair == true then return end
				    mouse.Icon = "rbxassetid://9943168532"
				end)
			end)
		else
			pcall(function()
				ScriptSettings.Crosshair = false
				local mouse = game:GetService("Players").LocalPlayer:GetMouse()
				mouse.Icon = ""
			end)
		end
	end,
	["Default"] = false,
	["HoverText"] = "Custom crosshair"
})

local Crosshair = COB("Render", {
	["Name"] = "Dot Crosshair",
	["Function"] = function(callback)
		if callback then
			pcall(function()
				ScriptSettings.Crosshair = true
				local mouse = game:GetService("Players").LocalPlayer:GetMouse()
				mouse.Icon = "rbxassetid://4978985249"
				mouse:GetPropertyChangedSignal("Icon"):Connect(function()
				    if not ScriptSettings.Crosshair == true then return end
				    mouse.Icon = "rbxassetid://4978985249"
				end)
			end)
		else
			pcall(function()
				ScriptSettings.Crosshair = false
				local mouse = game:GetService("Players").LocalPlayer:GetMouse()
				mouse.Icon = ""
			end)
		end
	end,
	["Default"] = false,
	["HoverText"] = "Custom crosshair"
})

local Crosshair = COB("Render", {
	["Name"] = "Glowing dot",
	["Function"] = function(callback)
		if callback then
			pcall(function()
				ScriptSettings.Crosshair = true
				local mouse = game:GetService("Players").LocalPlayer:GetMouse()
				mouse.Icon = "rbxassetid://10891594349"
				mouse:GetPropertyChangedSignal("Icon"):Connect(function()
				    if not ScriptSettings.Crosshair == true then return end
				    mouse.Icon = "rbxassetid://10891594349"
				end)
			end)
		else
			pcall(function()
				ScriptSettings.Crosshair = false
				local mouse = game:GetService("Players").LocalPlayer:GetMouse()
				mouse.Icon = ""
			end)
		end
	end,
	["Default"] = false,
	["HoverText"] = "Custom crosshair"
})


local Crosshair = COB("Render", {
	["Name"] = " Huge Anime ball crosshair",
	["Function"] = function(callback)
		if callback then
			pcall(function()
				ScriptSettings.Crosshair = true
				local mouse = game:GetService("Players").LocalPlayer:GetMouse()
				mouse.Icon = "rbxassetid://10891607513"
				mouse:GetPropertyChangedSignal("Icon"):Connect(function()
				    if not ScriptSettings.Crosshair == true then return end
				    mouse.Icon = "rbxassetid://10891607513"
				end)
			end)
		else
			pcall(function()
				ScriptSettings.Crosshair = false
				local mouse = game:GetService("Players").LocalPlayer:GetMouse()
				mouse.Icon = ""
			end)
		end
	end,
	["Default"] = false,
	["HoverText"] = "Custom crosshair"
})

local Crosshair = COB("Render", {
	["Name"] = " sanrio crosshair",
	["Function"] = function(callback)
		if callback then
			pcall(function()
				ScriptSettings.Crosshair = true
				local mouse = game:GetService("Players").LocalPlayer:GetMouse()
				mouse.Icon = "rbxassetid://11720475063"
				mouse:GetPropertyChangedSignal("Icon"):Connect(function()
				    if not ScriptSettings.Crosshair == true then return end
				    mouse.Icon = "rbxassetid://11720475063"
				end)
			end)
		else
			pcall(function()
				ScriptSettings.Crosshair = false
				local mouse = game:GetService("Players").LocalPlayer:GetMouse()
				mouse.Icon = ""
			end)
		end
	end,
	["Default"] = false,
	["HoverText"] = "Custom crosshair"
})

local Crosshair = COB("Render", {
	["Name"] = "anime heart crosshair",
	["Function"] = function(callback)
		if callback then
			pcall(function()
				ScriptSettings.Crosshair = true
				local mouse = game:GetService("Players").LocalPlayer:GetMouse()
				mouse.Icon = "rbxassetid://11790860834"
				mouse:GetPropertyChangedSignal("Icon"):Connect(function()
				    if not ScriptSettings.Crosshair == true then return end
				    mouse.Icon = "rbxassetid://11790860834"
				end)
			end)
		else
			pcall(function()
				ScriptSettings.Crosshair = false
				local mouse = game:GetService("Players").LocalPlayer:GetMouse()
				mouse.Icon = ""
			end)
		end
	end,
	["Default"] = false,
	["HoverText"] = "Custom crosshair"
})


local Crosshair = COB("Render", {
	["Name"] = "green crosshair",
	["Function"] = function(callback)
		if callback then
			pcall(function()
				ScriptSettings.Crosshair = true
				local mouse = game:GetService("Players").LocalPlayer:GetMouse()
				mouse.Icon = "rbxassetid://2184939409"
				mouse:GetPropertyChangedSignal("Icon"):Connect(function()
				    if not ScriptSettings.Crosshair == true then return end
				    mouse.Icon = "rbxassetid://2184939409"
				end)
			end)
		else
			pcall(function()
				ScriptSettings.Crosshair = false
				local mouse = game:GetService("Players").LocalPlayer:GetMouse()
				mouse.Icon = ""
			end)
		end
	end,
	["Default"] = false,
	["HoverText"] = "Custom crosshair"
})

local AnticheatDisabler = COB("Blatant", {
    Name = "Infinite Jump",
    Function = function(callback) 
        if callback then
local InfiniteJumpEnabled = true
game:GetService("UserInputService").JumpRequest:connect(function()
	if InfiniteJumpEnabled then
		game:GetService"Players".LocalPlayer.Character:FindFirstChildOfClass'Humanoid':ChangeState("Jumping")
	end
end)
        end
    end,
    Default = false,
    HoverText = "Risky Inf Jump"
})

inffly = {["Enabled"] = false}
local testing
local partthingy
inffly = GuiLibrary["ObjectsThatCanBeSaved"]["BlatantWindow"]["Api"].CreateOptionsButton({
	["Name"] = "azura fly",
	["Function"] = function(callback)
		if callback then
			lplr.Character.Archivable = true
			local clonethingy = lplr.Character:Clone()
			clonethingy.Name = "clonethingy"
			clonethingy:FindFirstChild("HumanoidRootPart").Transparency = 1
			clonethingy.Parent = workspace
			 workspace.Camera.CameraSubject = clonethingy.Humanoid
			partthingy = Instance.new("Part",workspace)
			partthingy.Size = Vector3.new(2048,1,2048)
			partthingy.CFrame = clonethingy.HumanoidRootPart.CFrame * CFrame.new(0,-4,0)
			partthingy.Anchored = true
			partthingy.Transparency = 1
			partthingy.Name = "partthingy"
			RunLoops:BindToHeartbeat("BoostSilentFly", 1, function(delta)
				clonethingy.HumanoidRootPart.CFrame = CFrame.new(entity.character.HumanoidRootPart.CFrame.X,clonethingy.HumanoidRootPart.CFrame.Y,entity.character.HumanoidRootPart.CFrame.Z)
				clonethingy.HumanoidRootPart.Rotation = entity.character.HumanoidRootPart.Rotation
			end)
			repeat
				task.wait(0.001)
				if inffly["Enabled"] == false then break end
				clonethingy.HumanoidRootPart.CFrame = CFrame.new(entity.character.HumanoidRootPart.CFrame.X,clonethingy.HumanoidRootPart.CFrame.Y,entity.character.HumanoidRootPart.CFrame.Z)
			until testing == true
					local starty
			local starttick = tick()
			task.spawn(function()
				local timesdone = 0
				if GuiLibrary["ObjectsThatCanBeSaved"]["SpeedModeDropdown"]["Api"]["Value"] == "CFrame" then
					local doboost = true
					repeat
						timesdone = timesdone + 1
						if entity.isAlive then
							local root = entity.character.HumanoidRootPart
							if starty == nil then 
								starty = root.Position.Y
							end
							if not bodyvelo then 
								bodyvelo = Instance.new("BodyVelocity")
								bodyvelo.MaxForce = vec3(0, 1000000, 0)
								bodyvelo.Parent = root
								bodyvelo.Velocity = Vector3.zero
							else
								bodyvelo.Parent = root
							end
							for i = 1, 15 do 
								task.wait(0.01)
								if (not inffly["Enabled"]) then break end
								bodyvelo.Velocity = vec3(0, i * (infflyhigh["Enabled"] and 2 or 1), 0)
							end
							if (not isnetworkowner(root)) then
								break 
							end
						else
							break
						end
					until (not inffly["Enabled"])
				else
					local warning = createwarning("inffly", "inffly is very cool", 5)
					pcall(function()
						warning:GetChildren()[5].Position = UDim2.new(0, 46, 0, 38)
					end)
				end
				if inffly["Enabled"] then 
					inffly["ToggleButton"](false)
				end
			end)
		else
			if workspace:FindFirstChild("clonethingy") or workspace:FindFirstChild("partthingy") then
				workspace:FindFirstChild("clonethingy"):Destroy()
				workspace:FindFirstChild("partthingy"):Destroy()
				RunLoops:UnbindFromHeartbeat("BoostSilentFly")
				testing = true
				workspace.Camera.CameraSubject = lplr.Character.Humanoid
			end
			if bodyvelo then 
				bodyvelo:Destroy()
				bodyvelo = nil
			end
		end
	end
})
infflyhigh = inffly.CreateToggle({
	["Name"] = "High",
	["Function"] = function() end
})

local void = GuiLibrary["ObjectsThatCanBeSaved"]["WorldWindow"]["Api"].CreateOptionsButton({
    ["Name"] = "mc pvp sky lol",
    ["Function"] = function(v)
        if v then
            game.Lighting.Sky.SkyboxBk = "http://www.roblox.com/asset/?id=6556129604"
            game.Lighting.Sky.SkyboxDn = "http://www.roblox.com/asset/?id=6556131274"
            game.Lighting.Sky.SkyboxFt = "http://www.roblox.com/asset/?id=6556125137"
            game.Lighting.Sky.SkyboxLf = "http://www.roblox.com/asset/?id=6551105485"
            game.Lighting.Sky.SkyboxRt = "http://www.roblox.com/asset/?id=6556128084"
            game.Lighting.Sky.SkyboxUp = "http://www.roblox.com/asset/?id=6551108701"
            game.Lighting.FogColor = Color3.new(236, 88, 241)
            game.Lighting.FogEnd = "200"
            game.Lighting.FogStart = "0"
            game.Lighting.Ambient = Color3.new(0.5, 0, 1)
        else
            game.Lighting.Sky.SkyboxBk = "http://www.roblox.com/asset/?id=7018684000"
            game.Lighting.Sky.SkyboxDn = "http://www.roblox.com/asset/?id=6334928194"
            game.Lighting.Sky.SkyboxFt = "http://www.roblox.com/asset/?id=7018684000"
            game.Lighting.Sky.SkyboxLf = "http://www.roblox.com/asset/?id=7018684000"
            game.Lighting.Sky.SkyboxRt = "http://www.roblox.com/asset/?id=7018684000"
            game.Lighting.Sky.SkyboxUp = "http://www.roblox.com/asset/?id=7018689553"
            game.Lighting.FogColor = Color3.new(1, 1, 1)
            game.Lighting.FogEnd = "10000"
            game.Lighting.FogStart = "0"
            game.Lighting.Ambient = Color3.new(0, 0, 0)
        end
    end
})
		
local AnticheatDisabler = COB("World", {
    Name = "better antivoid (bouncy) ",
    Function = function(callback) 
        if callback then
            local antivoidpart = Instance.new("Part", Workspace)
            antivoidpart.Name = "AntiVoid"
            antivoidpart.Size = Vector3.new(2100, 0.5, 2000)
            antivoidpart.Position = Vector3.new(160.5, 25, 247.5)
            antivoidpart.Transparency = 0.4
            antivoidpart.Anchored = true
            antivoidpart.Touched:connect(function(dumbcocks)
                if dumbcocks.Parent:WaitForChild("Humanoid") and dumbcocks.Parent.Name == lplr.Name then
                    game.Players.LocalPlayer.Character.Humanoid:ChangeState("Jumping")
                    wait(0.2)
                    game.Players.LocalPlayer.Character.Humanoid:ChangeState("Jumping")
                    wait(0.2)
                    game.Players.LocalPlayer.Character.Humanoid:ChangeState("Jumping")
                end
            end)
        end
    end,
    Default = false,
    HoverText = " AntiVoid "
})



local AnticheatDisabler = COB("Render", {
    Name = "ChillLighting",
    Function = function(callback) 
        if callback then
    game.Lighting.Ambient = Color3.fromRGB(32, 212, 212)
            game.Lighting.OutdoorAmbient = Color3.fromRGB(32, 212, 212)
        end
    end,
    Default = false,
    HoverText = "ChillLighting"
})

local AnticheatDisabler = COB("World", {
    Name = "vibe sky pack (removes sound)",
    Function = function(callback) 
        if callback then
    local Lighting = game.Lighting
local random = math.random(100000000, 999999999)
Lighting.Name = "Lighting"..random
local LightingName = "Lighting"..random
for i,v in pairs(Lighting:GetChildren()) do
	v:Destroy()
end
wait(.1)
---Instance---
local Atmosphere = Instance.new("Atmosphere")
local Sky = Instance.new("Sky")
local Bloom = Instance.new("BloomEffect")
local ColorCorrection = Instance.new("ColorCorrectionEffect")
local DepthOfField = Instance.new("DepthOfFieldEffect")
local SunRays = Instance.new("SunRaysEffect")
--------------

--Parent--
Atmosphere.Parent = game[LightingName]
Sky.Parent = game[LightingName]
Bloom.Parent = game[LightingName]
ColorCorrection.Parent = game[LightingName]
DepthOfField.Parent = game[LightingName]
SunRays.Parent = game[LightingName]
----------

--------Vibe Sky pack--------
	--Vibe Sky Pack
	game[LightingName].Sky.SkyboxBk = "rbxassetid://5084575798"
	game[LightingName].Sky.SkyboxDn = "rbxassetid://5084575916"
	game[LightingName].Sky.SkyboxFt = "rbxassetid://5103949679"
	game[LightingName].Sky.SkyboxLf = "rbxassetid://5103948542"
	game[LightingName].Sky.SkyboxRt = "rbxassetid://5103948784"
	game[LightingName].Sky.SkyboxUp = "rbxassetid://5084576400"
	game[LightingName].Sky.MoonAngularSize = 0
	game[LightingName].Sky.SunAngularSize = 0
    game[LightingName].Sky.SunTextureId = ""
    game[LightingName].Sky.MoonTextureId = ""
	game[LightingName].Brightness = 0
	game[LightingName].GlobalShadows = true
	game[LightingName].ClockTime = 17.8
	game[LightingName].GeographicLatitude = 0


	game[LightingName].Atmosphere.Density = 0.3
	game[LightingName].Atmosphere.Offset = 0.25
	game[LightingName].Atmosphere.Color = Color3.new(199, 199, 199)
	game[LightingName].Atmosphere.Decay = Color3.new(106, 112, 125)
	game[LightingName].Atmosphere.Glare = 0
	game[LightingName].Atmosphere.Haze = 0

	game[LightingName].Bloom.Enabled = true
	game[LightingName].Bloom.Intensity = 1
	game[LightingName].Bloom.Size = 24
	game[LightingName].Bloom.Threshold = 2

	game[LightingName].DepthOfField.Enabled = false
	game[LightingName].DepthOfField.FarIntensity = 0.1
	game[LightingName].DepthOfField.FocusDistance = 0.05
	game[LightingName].DepthOfField.InFocusRadius = 30
	game[LightingName].DepthOfField.NearIntensity = 0.75

	game[LightingName].SunRays.Enabled = true
	game[LightingName].SunRays.Intensity = 0.01
	game[LightingName].SunRays.Spread = 0.1
---------------------------------
        end
    end,
    Default = false,
    HoverText = "IMPORTANT! THIS WILL NOT WORK WITH WINTER THEME OR FULLBRIGHT TURN THOSE OFF!"

})

local Reinject = COB("Utility", {
	["Name"] = "Reinject",
	["Function"] = function(callback)
		if callback then
			pcall(function()
				ScriptSettings.Reinject = true
				infonotify("Reinject", "Please disable reinject to use.", 5)
			end)
		else
			pcall(function()
				ScriptSettings.Reinject = false
				GuiLibrary["SelfDestruct"]()
				if shared.DogV4Private_AutoExec then shared.Restart_Vape() else infonotify("Reinject", "You do not have Dog V4 Reinject supported.", "5") end
			end)
		end
	end,
	["Default"] = false,
	["HoverText"] = "Reinject vape"
})

local AnticheatDisabler = COB("World", {
    Name = "no textures (fps boost)",
    Function = function(callback) 
        if callback then
        local decalsyeeted = true -- Leaving this on makes games look crap but the fps goes up by at least 20.
local g = game
local w = g.Workspace
local l = g.Lighting
local t = w.Terrain
t.WaterWaveSize = 0
t.WaterWaveSpeed = 0
t.WaterReflectance = 0
t.WaterTransparency = 0
l.GlobalShadows = false
l.FogEnd = 9e9
l.Brightness = 0
settings().Rendering.QualityLevel = "Level01"
for i, v in pairs(g:GetDescendants()) do
    if v:IsA("Part") or v:IsA("Union") or v:IsA("CornerWedgePart") or v:IsA("TrussPart") then
        v.Material = "Plastic"
        v.Reflectance = 0
    elseif v:IsA("Decal") or v:IsA("Texture") and decalsyeeted then
        v.Transparency = 1
    elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
        v.Lifetime = NumberRange.new(0)
    elseif v:IsA("Explosion") then
        v.BlastPressure = 1
        v.BlastRadius = 1
    elseif v:IsA("Fire") or v:IsA("SpotLight") or v:IsA("Smoke") then
        v.Enabled = false
    elseif v:IsA("MeshPart") then
        v.Material = "Plastic"
        v.Reflectance = 0
        v.TextureID = 10385902758728957
    end
end
for i, e in pairs(l:GetChildren()) do
    if e:IsA("BlurEffect") or e:IsA("SunRaysEffect") or e:IsA("ColorCorrectionEffect") or e:IsA("BloomEffect") or e:IsA("DepthOfFieldEffect") then
        e.Enabled = false
    end
end
        end
    end,
    Default = false,
    HoverText = "FPS Booster"
})
local AnticheatDisabler = COB("World", {
    Name = "sunset sky",
    Function = function(callback) 
        if callback then
        if not game:IsLoaded() then
	game.Loaded:Wait()
end
wait()

--// instances
local cc = Instance.new("ColorCorrectionEffect")
local lighting = game:GetService("Lighting")
local sbox = Instance.new("Sky")

--// coool
sbox.Parent = lighting
sbox.SkyboxBk = "http://www.roblox.com/asset/?id=169210090"
sbox.SkyboxDn = "http://www.roblox.com/asset/?id=169210108"
sbox.SkyboxFt = "http://www.roblox.com/asset/?id=169210121"
sbox.SkyboxLf = "http://www.roblox.com/asset/?id=169210133"
sbox.SkyboxRt = "http://www.roblox.com/asset/?id=169210143"
sbox.SkyboxUp = "http://www.roblox.com/asset/?id=169210149"

lighting.Ambient = Color3.fromRGB(128,128,128)
lighting.FogColor = Color3.fromRGB(128,128,128)
lighting.ClockTime = 14
lighting.FogEnd = 2000

for i, v in pairs(game:GetService("Workspace"):GetChildren()) do
    if v:IsA("BasePart") and v.Material == Enum.Material.Grass then
        v.Transparency = 0.25
        v.Color = Color3.fromRGB(125, 125, 200)
    end
end

        end
    end,
    Default = false,
    HoverText = false
})


local AnticheatDisabler = COB("Render", {
    Name = "purple lighting",
    Function = function(callback) 
        if callback then
         game.Lighting.Ambient = Color3.fromRGB(170, 0, 255)
            game.Lighting.OutdoorAmbient = Color3.fromRGB(170, 0, 255)
        end
    end,
    Default = false,
    HoverText = "Purple Themed Lighting"
})


COB("Blatant", {
    Name = "goofy swim fly",
	HoverText = "Custom Flight",
    Function = function(v)
        longjumpval = v
        if longjumpval then
			workspace.Gravity = 0
            spawn(function()
                repeat
                    if (not longjumpval) then return end
                  game:GetService"Players".LocalPlayer.Character:FindFirstChildOfClass'Humanoid':ChangeState("Freefall")
					wait(0.000000000000001)
                   game:GetService"Players".LocalPlayer.Character:FindFirstChildOfClass'Humanoid':ChangeState("Running")
					wait(0.000000000000001)
                  game:GetService"Players".LocalPlayer.Character:FindFirstChildOfClass'Humanoid':ChangeState("Climbing")
					wait(0.000000000000001)
                   game:GetService"Players".LocalPlayer.Character:FindFirstChildOfClass'Humanoid':ChangeState("Swimming")
					wait(0.000000000000001)
					game:GetService"Players".LocalPlayer.Character:FindFirstChildOfClass'Humanoid':ChangeState("Landed")
					wait(0.000000000000001)
                until (not longjumpval)
            end)
        else
            workspace.Gravity = 196.19999694824
            return
        end
    end
})

local Sky = GuiLibrary["ObjectsThatCanBeSaved"]["WorldWindow"]["Api"].CreateOptionsButton({
    ["Name"] = "Pink Sky",
    ["Function"] = function(v)
        if v then
            game.Lighting.Sky.SkyboxBk = "http://www.roblox.com/asset/?id=271042516"
            game.Lighting.Sky.SkyboxDn = "http://www.roblox.com/asset/?id=271077243"
            game.Lighting.Sky.SkyboxFt = "http://www.roblox.com/asset/?id=271042556"
            game.Lighting.Sky.SkyboxLf = "http://www.roblox.com/asset/?id=271042310"
            game.Lighting.Sky.SkyboxRt = "http://www.roblox.com/asset/?id=271042467"
            game.Lighting.Sky.SkyboxUp = "http://www.roblox.com/asset/?id=271077958"
        else
            game.Lighting.Sky.SkyboxBk = "http://www.roblox.com/asset/?id=7018684000"
            game.Lighting.Sky.SkyboxDn = "http://www.roblox.com/asset/?id=6334928194"
            game.Lighting.Sky.SkyboxFt = "http://www.roblox.com/asset/?id=7018684000"
            game.Lighting.Sky.SkyboxLf = "http://www.roblox.com/asset/?id=7018684000"
            game.Lighting.Sky.SkyboxRt = "http://www.roblox.com/asset/?id=7018684000"
            game.Lighting.Sky.SkyboxUp = "http://www.roblox.com/asset/?id=7018689553"
            game.Lighting.FogColor = Color3.new(1, 1, 1)
            game.Lighting.FogEnd = "10000"
            game.Lighting.FogStart = "0"
            game.Lighting.Ambient = Color3.new(0, 0, 0)
        end
    end
})

local Chat = COB("Render", {
	["Name"] = "Chat postition",
	["HoverText"] = "Changes Chat Position",
	["Function"] = function(callback)
		if callback then
			game:GetService("StarterGui"):SetCore('ChatWindowPosition', UDim2.new(0.0, 0, 0.0, 500))
		else
			game:GetService("StarterGui"):SetCore('ChatWindowPosition', UDim2.new(0.0, 0, 0.0, 0))
		end
	end
})

local AutobuyWool = COB("Utility", {
	["Name"] = "Auto Buy Wool",
	["HoverText"] = "AutoBuys Wool",
	["Function"] = function(callback)
		if callback then
			getgenv().AutobuyWool = true;
			while wait() do
				if getgenv().AutobuyWool == true then
					game:GetService("ReplicatedStorage").rbxts_include.node_modules.net.out._NetManaged.BedwarsPurchaseItem:InvokeServer({["shopItem"] = {["currency"] = "iron",["itemType"] = "wool_white",["amount"] = 16,["price"] = 8,["category"] = "Blocks"}})
				end
			end
		else
			getgenv().AutobuyWool = false;
		end
	end
})



local Bed TP = GuiLibrary["ObjectsThatCanBeSaved"]["WorldWindow"]["Api"].CreateOptionsButton({
    Name = "Bed TP (by RauwoV2#1691)",
    Function = function(callback) 
        if callback then
            local ClosestBedMag = math.huge
local ClosestBed = false
local lplr = game.Players.LocalPlayer
function GetNearestBedToPosition()
    for i,v in pairs(game.Workspace:GetChildren()) do
        if v.Name == "bed" and v:FindFirstChild("Covers") and v.Covers.BrickColor ~= game.Players.LocalPlayer.Team.TeamColor then
            if (lplr.Character.HumanoidRootPart.Position - v.Position).Magnitude < ClosestBedMag then
                ClosestBedMag = (lplr.Character.HumanoidRootPart.Position - v.Position).Magnitude
                ClosestBed = v
            end
        end
    end
    return ClosestBed
end
local real = GetNearestBedToPosition().Position
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1000,3009,3900)
task.wait(1)
game.Players.LocalPlayer.Character.PrimaryPart.CFrame = CFrame.new(real) + Vector3.new(0,5,0)
        
        end
    end,
    Default = false,
    HoverText = "only works the first time then it only tps make sure to set death position to the bed and reset (by RauwoV2#1691)"
})

runcode(function()
	local anticheat222 = {["Enabled"] = false}
	anticheat222 = GuiLibrary["ObjectsThatCanBeSaved"]["UtilityWindow"]["Api"].CreateOptionsButton({
		["Name"] = "/DIE",
		["HoverText"] = "/die real command",
		["Function"] = function(callback)
			if callback then
				wait(0.001)
				local x = game.Players.LocalPlayer.Character.HumanoidRootPart.Position.x
local y = game.Players.LocalPlayer.Character.HumanoidRootPart.Position.y 
local z = game.Players.LocalPlayer.Character.HumanoidRootPart.Position.z
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(x,y-10,z)
			else
				print ("rip lol")
			end
		end 
	})
end)

	
	local hrp = game.Players.LocalPlayer.Character.HumanoidRootPart	
	


	local lplr = game:GetService("Players").LocalPlayer
local KnitClient = debug.getupvalue(require(lplr.PlayerScripts.TS.knit).setup, 6)
local Client = require(game:GetService("ReplicatedStorage").TS.remotes).default.Client


local notifications = {["Enabled"] = false}

Client:WaitFor("BedwarsBedBreak"):andThen(function(p13)
	p13:Connect(function(p14)
		if notifications["Enabled"] then
			local team = p14.brokenBedTeam.displayName
			if team == lplr.Team.Name then
				createwarning("Bed broken!", "Your bed got broken LOL", 7)
			end
		end
	end)
end)


Client:WaitFor("BedwarsBedBreak"):andThen(function(p13)
	p13:Connect(function(p14)
		if notifications["Enabled"] then
			if p14.player.Name == lplr.Name then
				createwarning("Broken bed!", "you broke a bed", 7)
			end
		end
	end)
end)

Client:WaitFor("EntityDeathEvent"):andThen(function(p13)
	p13:Connect(function(p14)
		if notifications["Enabled"] then
			if p14.player.Name == lplr.Name then
				createwarning("LOL!", "oof lol", 7)
			end
		end
	end)
end)



Client:WaitFor("EntityDeathEvent"):andThen(function(p6)
	p6:Connect(function(p7)
		if notifications["Enabled"] then
			if p7.fromEntity and p7.fromEntity == lplr.Character then
				local plr = players:GetPlayerFromCharacter(p7.entityInstance)
				createwarning("you killed", plr.Name.."ez", 7)
			end
		end
	end)
end)

local notifications = GuiLibrary["ObjectsThatCanBeSaved"]["RenderWindow"]["Api"].CreateOptionsButton({
	["Name"] = "Notifications",
	["Function"]= function(callback) notifications["Enabled"] = callback end,
	["HoverText"] = "Sends you a notification when certain actions happen (bed brake,kill,ect)"
})

local theyessirYE = {["Enabled"] = false}
    theyessirYE = GuiLibrary["ObjectsThatCanBeSaved"]["WorldWindow"]["Api"].CreateOptionsButton({
        ["Name"] = "get ems",
        ["HoverText"] = "make take a few times",
            ["Function"] = function(callback)
                if callback then
                      spawn(function()
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").ItemDrops.emerald.CFrame
                end)
            end
        end
    })

local theyessirYE = {["Enabled"] = false}
    theyessirYE = GuiLibrary["ObjectsThatCanBeSaved"]["WorldWindow"]["Api"].CreateOptionsButton({
        ["Name"] = "get dims",
        ["HoverText"] = "make take a few times",
            ["Function"] = function(callback)
                if callback then
                      spawn(function()
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").ItemDrops.diamond.CFrame
                end)
            end
        end
    })


local theyessirYE = {["Enabled"] = false}
    theyessirYE = GuiLibrary["ObjectsThatCanBeSaved"]["UtilityWindow"]["Api"].CreateOptionsButton({
        ["Name"] = "stone sword xploit",
        ["HoverText"] = "sword",
            ["Function"] = function(callback)
                if callback then
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



local AnticheatDisabler = COB("Render", {
    Name = "fake IP grabber",
    Function = function(callback) 
        if callback then
        
wait(3)
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("load (ipcrakerfile.1)" ,"All")


wait(2)
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Getting [sever user players, usernames]" ,"All")

wait(5)
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Loading... Please ... starting data" ,"All")

wait(5)
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("wating for data dowload" ,"All")

wait(2)
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Data Has Been Dowloaded " ,"All")

wait(1)
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Successfully Retreved  file.IP" ,"All")

wait(2)
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("find said file.IP : Logged = true" ,"All")

wait(2)
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("copying file.IP to file.Info" ,"All")

wait(3)
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("loading" ,"All")

wait(2)
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("file.IP grab = true" ,"All")

wait(3)
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("file.IP = ..." ,"All")

wait(2)
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(".file.IP =  ########### " ,"All")

wait(3)
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("if keyletter = # = Successfully Logged " ,"All")

wait(3)
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Ez Ip grabs with Loa Privet " ,"All")

wait(2)
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("find ######.gg/InfoSell server = info sell " ,"All")

wait(2)
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("eneter sell = 1000 robux = if buy. enter file.IP " ,"All")

wait(3)
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("if = buy = find user.gm " ,"All")

wait(2)
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("get user.gm load ipgr. " ,"All")

wait(3)
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("script finnall" ,"All")


wait(4)
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Ezgrabs on top" ,"All")

wait(1)
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("by grassy#" ,"All")

wait(2)
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("4355" ,"All")

wait(2)
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("end.                                                                                 .dot end load . file                                                                                  Ezgrabs.gg" ,"All")

wait(3)
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("file auto deleted = 1" ,"All")


wait(5)
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("file made possible  with ez gang & tubers (Staff)" ,"All")



wait(3)
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("if file said = auto deleted" ,"All")


wait(4)
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("if file said = auto deleted, enter saved" ,"All")


wait(3)
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("if file = enter saved find #######.gg/LoaSaverFile" ,"All")


wait(2)
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("if file = find = .saves.grassy" ,"All")


wait(3)
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("if file = store" ,"All")


wait(3)
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("file stored Successfully" ,"All")

wait(3)
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("end privet load" ,"All")


wait(4)
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("grass client on yt" ,"All")


wait(3)
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("debug for errors" ,"All")

wait(3)
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(" if  debug error = true = redo" ,"All")

wait(4)
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(" end privet addon" ,"All")


wait(3)
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(" grassy 4355" ,"All")



        end
    end,
    Default = false,
    HoverText = "fake IP grabber"

})

local AnticheatDisabler = COB("Render", {
    Name = "texture pack",
    Function = function(callback) 
        if callback then
         repeat wait() until game:IsLoaded() == true
repeat wait() until game.ReplicatedStorage ~= nil
repeat wait() until game.ReplicatedStorage.Items ~= nil
repeat wait() until game.Workspace ~= nil 
repeat wait() until game.Workspace:FindFirstChild("Map") ~= nil

local lplr = game:GetService("Players").LocalPlayer
local requestfunc = syn and syn.request or http and http.request or http_request or fluxus and fluxus.request or getgenv().request or request
local setthreadidentity = syn and syn.set_thread_identity or set_thread_identity or setidentity
local getthreadidentity = syn and syn.get_thread_identity or get_thread_identity or getidentity
local getasset = getsynasset or getcustomasset
local cachedthings = {}
local cachedthings2 = {}
local cachedsizes = {}

local function betterisfile(path)
    if cachedthings2[path] == nil then
        cachedthings2[path] = isfile(path)
    end
    return cachedthings2[path]
end

local function removeTags(str)
    str = str:gsub("<br%s*/>", "\n")
    return (str:gsub("<[^<>]->", ""))
end


local function getcustomassetfunc(path)
	if not isfile(path) then
		spawn(function()
            setthreadidentity(7)
			local textlabel = Instance.new("TextLabel")
			textlabel.Size = UDim2.new(1, 0, 0, 36)
			textlabel.Text = "Downloading "..path
			textlabel.BackgroundTransparency = 1
			textlabel.TextStrokeTransparency = 0
			textlabel.TextSize = 30
			textlabel.Font = Enum.Font.SourceSans
			textlabel.TextColor3 = Color3.new(1, 1, 1)
			textlabel.Position = UDim2.new(0, 0, 0, -36)
			textlabel.Parent = game.CoreGui.RobloxGui
			repeat wait() until isfile(path)
			textlabel:Remove()
            setthreadidentity(2)
		end)
		local req = requestfunc({
			Url = "https://raw.githubusercontent.com/supercellgamer/BedwarsPersonal/main/"..path,
			Method = "GET"
		})
		writefile(path, req.Body)
	end
    if cachedthings[path] == nil then
        cachedthings[path] = getasset(path)
    end
	return cachedthings[path]
end

local function cachesize(image)
    local thing = Instance.new("ImageLabel")
    thing.Image = getcustomassetfunc(image)
    thing.Size = UDim2.new(1, 0, 1, 0)
    thing.ImageTransparency = 0.999
    thing.BackgroundTransparency = 1
    thing.Parent = game.CoreGui.RobloxGui
    spawn(function()
        cachedsizes[image] = 1
        repeat wait() until thing.IsLoaded and thing.ContentImageSize ~= Vector2.new(0, 0)
        local oldidentity = getthreadidentity()
        setthreadidentity(7)
        cachedsizes[image] = thing.ContentImageSize.X / 256
        setthreadidentity(oldidentity)
        thing:Remove()
    end)
end

local function downloadassets(path2)
    local json = requestfunc({
        Url = "https://api.github.com/repos/supercellgamer/BedwarsPersonal/contents/"..path2,
        Method = "GET"
    })
    local decodedjson = game:GetService("HttpService"):JSONDecode(json.Body)
    for i2,v2 in pairs(decodedjson) do
        if v2["type"] == "file" then
			getcustomassetfunc(path2.."/"..v2["name"])
		end
    end
end

if isfolder("bedwars") == false then
	makefolder("bedwars")
end
downloadassets("bedwars")
if isfolder("bedwars/models") == false then
	makefolder("bedwars/models")
end
downloadassets("bedwars/models")
if isfolder("bedwars/sounds") == false then
	makefolder("bedwars/sounds")
end
downloadassets("bedwars/sounds")
if isfolder("bedwars/ui") == false then
	makefolder("bedwars/ui")
end
downloadassets("bedwars/sounds")
if isfolder("bedwars/sounds/footstep") == false then
	makefolder("bedwars/sounds/footstep")
end
downloadassets("bedwars/sounds/footstep")

local Flamework = require(game:GetService("ReplicatedStorage")["rbxts_include"]["node_modules"]["@flamework"].core.out).Flamework
local newupdate = game.Players.LocalPlayer.PlayerScripts.TS:FindFirstChild("ui") and true or false
repeat wait() until Flamework.isInitialized
local soundslist = require(game:GetService("ReplicatedStorage").TS.sound["game-sound"]).GameSound
local sounds = (newupdate and require(game:GetService("ReplicatedStorage")["rbxts_include"]["node_modules"]["@easy-games"]["game-core"].out).SoundManager or require(game:GetService("ReplicatedStorage").TS.sound["sound-manager"]).SoundManager)
local footstepsounds = require(game.ReplicatedStorage.TS.sound["footstep-sounds"])
local items = require(game.ReplicatedStorage.TS.item["item-meta"])
local itemtab = debug.getupvalue(items.getItemMeta, 1)
local maps = debug.getupvalue(require(game.ReplicatedStorage.TS.game.map["map-meta"]).getMapMeta, 1)
local defaultremotes = require(game.ReplicatedStorage.TS.remotes).default
local battlepassutils = require(game.ReplicatedStorage.TS["battle-pass"]["battle-pass-utils"]).BattlePassUtils
local inventoryutil = require(game.ReplicatedStorage.TS.inventory["inventory-util"]).InventoryUtil
local inventoryentity = require(game.ReplicatedStorage.TS.entity.entities["inventory-entity"]).InventoryEntity
local notification = require(game:GetService("ReplicatedStorage")["rbxts_include"]["node_modules"]["@easy-games"]["game-core"].out.client.ui.notifications.components["notification-card"]).NotificationCard
local hotbartile = require(game.Players.LocalPlayer.PlayerScripts.TS.controllers.global.hotbar.ui["hotbar-tile"]).HotbarTile
local hotbaropeninventory = require(game.Players.LocalPlayer.PlayerScripts.TS.controllers.global.hotbar.ui["hotbar-open-inventory"]).HotbarOpenInventory
local hotbarpartysection = require(game.Players.LocalPlayer.PlayerScripts.TS.controllers.global.hotbar.ui.party["hotbar-party-section"]).HotbarPartySection
local hotbarspectatesection = require(game.Players.LocalPlayer.PlayerScripts.TS.controllers.global.hotbar.ui.spectate["hotbar-spectator-section"]).HotbarSpectatorSection
local hotbarcustommatchsection = require(game.Players.LocalPlayer.PlayerScripts.TS.controllers.global.hotbar.ui["custom-match"]["hotbar-custom-match-section"]).HotbarCustomMatchSection
local respawntimer = require(game.Players.LocalPlayer.PlayerScripts.TS.controllers.games.bedwars.respawn.ui["respawn-timer"])
local hotbarhealthbar = require(game.Players.LocalPlayer.PlayerScripts.TS.controllers.global.hotbar.ui.healthbar["hotbar-healthbar"]).HotbarHealthbar
local appcontroller = {closeApp = function() end}
if newupdate then
    appcontroller = require(game:GetService("ReplicatedStorage")["rbxts_include"]["node_modules"]["@easy-games"]["game-core"].out.client.controllers["app-controller"]).AppController
end
local getQueueMeta = function() end
if newupdate then
    local queuemeta = require(game.ReplicatedStorage.TS["game"]["queue-meta"]).QueueMeta
    getQueueMeta = function(type)
        return queuemeta[type]
    end
else
    getQueueMeta = require(game.ReplicatedStorage.TS["game"]["queue-meta"]).getQueueMeta
end
local hud2
local hotbarapp = require(game.Players.LocalPlayer.PlayerScripts.TS.controllers.global.hotbar.ui["hotbar-app"]).HotbarApp
local hotbarapp2 = require(game.Players.LocalPlayer.PlayerScripts.TS.controllers.global.hotbar.ui["hotbar-app"])
local itemshopapp = require(game.Players.LocalPlayer.PlayerScripts.TS.controllers.games.bedwars.shop.ui["item-shop"]["bedwars-item-shop-app"])[(newupdate and "BedwarsItemShopAppBase" or "BedwarsItemShopApp")]
local teamshopapp = require(game.Players.LocalPlayer.PlayerScripts.TS.controllers.games.bedwars["generator-upgrade"].ui["bedwars-team-upgrade-app"]).BedwarsTeamUpgradeApp
local victorysection = require(game.Players.LocalPlayer.PlayerScripts.TS.controllers["game"].match.ui["victory-section"]).VictorySection
local battlepasssection = require(game.Players.LocalPlayer.PlayerScripts.TS.controllers.games.bedwars["battle-pass-progression"].ui["battle-pass-progession-app"]).BattlePassProgressionApp
local bedwarsshopitems = require(game.ReplicatedStorage.TS.games.bedwars.shop["bedwars-shop"]).BedwarsShop
local bedwarsbows = require(game.ReplicatedStorage.TS.games.bedwars["bedwars-bows"]).BedwarsBows
local roact = debug.getupvalue(hotbartile.render, 1)
local clientstore = (newupdate and require(game.Players.LocalPlayer.PlayerScripts.TS.ui.store).ClientStore or require(game.Players.LocalPlayer.PlayerScripts.TS.rodux.rodux).ClientStore)
local client = require(game:GetService("ReplicatedStorage").TS.remotes).default.Client
local colorutil = debug.getupvalue(hotbartile.render, 2)
local soundmanager = require(game:GetService("ReplicatedStorage")["rbxts_include"]["node_modules"]["@easy-games"]["game-core"].out).SoundManager
local itemviewport = require(game.Players.LocalPlayer.PlayerScripts.TS.controllers.global.inventory.ui["item-viewport"]).ItemViewport
local empty = debug.getupvalue(hotbartile.render, 6)
local tween = debug.getupvalue(hotbartile.tweenPosition, 1)
local hotbarimage = getcustomassetfunc("bedwars/ui/widgets.png")
local healthimage = getcustomassetfunc("bedwars/ui/icons.png")
local shopimage = getcustomassetfunc("bedwars/ui/container/generic_54.png")
local flashing = false
local realcode = ""
local oldrendercustommatch = hotbarcustommatchsection.render
local crosshairref = roact.createRef()
local beddestroyref = roact.createRef()
local trapref = roact.createRef()
local timerref = roact.createRef()
local startimer = false
local timernum = 0

for i,v in pairs(footstepsounds["FootstepSounds"]) do
    if betterisfile("bedwars/sounds/footstep/"..tostring(i).."-1.mp3") then
        v["walk"][1] = getcustomassetfunc("bedwars/sounds/footstep/"..tostring(i).."-1.mp3")
        v["walk"][2] = getcustomassetfunc("bedwars/sounds/footstep/"..tostring(i).."-2.mp3")
        v["run"][1] = getcustomassetfunc("bedwars/sounds/footstep/"..tostring(i).."-3.mp3")
        v["run"][2] = getcustomassetfunc("bedwars/sounds/footstep/"..tostring(i).."-4.mp3")
    end
end
footstepsounds["BlockFootstepSound"][4] = "WOOL"
footstepsounds["BlockFootstepSound"]["WOOL"] = 4
footstepsounds["FootstepSounds"][4] = {
    ["walk"] = {getcustomassetfunc("bedwars/sounds/footstep/4-1.mp3"), getcustomassetfunc("bedwars/sounds/footstep/4-2.mp3")},
    ["run"] = {getcustomassetfunc("bedwars/sounds/footstep/4-3.mp3"), getcustomassetfunc("bedwars/sounds/footstep/4-4.mp3")}
}
for i,v in pairs(itemtab) do
    if tostring(i):match("wool") then
        v.footstepSound = footstepsounds["BlockFootstepSound"]["WOOL"]
    end
end
for i2,v2 in pairs(soundslist) do 
    --print(i2,v2)
end
for i,v in pairs(listfiles("bedwars/sounds")) do
    local str = tostring(tostring(v):gsub('bedwars/sounds\\', ""):gsub(".mp3", ""))
    if identifyexecutor():find("ScriptWare") then
        str = tostring(tostring(v):gsub('bedwars\\sounds\\', ""):gsub(".mp3", ""))
    end 
    local item = soundslist[str]
    if item then
        soundslist[str] = getcustomassetfunc(v)
    end
end 


local getasset = getsynasset or getcustomasset
for i,v in pairs(listfiles("bedwars")) do
    local str = tostring(tostring(v):gsub('bedwars\\', ""):gsub(".png", ""))
    local item = game.ReplicatedStorage.Items:FindFirstChild(str)
    if item then
        for i2,v2 in pairs(item:GetDescendants()) do
            if v2:IsA("Texture") then
                v2.Texture = getasset(v)
            end
        end
    end
end
for i,v in pairs(getgc(true)) do
    if type(v) == "table" and rawget(v, "wool_blue") and type(v["wool_blue"]) == "table" then
        for i2,v2 in pairs(v) do
            if isfile("bedwars/"..i2..".png") then
                if rawget(v2, "block") and rawget(v2["block"], "greedyMesh") then
                    if #v2["block"]["greedyMesh"]["textures"] > 1 and isfile("bedwars/"..i2.."_side_1.png") then
                        for i3,v3 in pairs(v2["block"]["greedyMesh"]["textures"]) do
                            v2["block"]["greedyMesh"]["textures"][i3] = getasset("bedwars/"..i2.."_side_"..i3..".png")
                        end
                    else
                    v2["block"]["greedyMesh"]["textures"] = {
                            [1] = getasset("bedwars/"..i2..".png")
                    }
                    end
                    if isfile("bedwars/"..i2.."_image.png") then
                        v2["image"] = getasset("bedwars/"..i2.."_image.png")
                    end
                else
                    v2["image"] = getasset("bedwars/"..i2..".png")
                end
            end
        end
    end
end
for i,v in pairs(workspace.Map.Worlds:GetChildren()[1]:GetChildren()) do
    if isfile("bedwars/"..v.Name..".png") and not isfile("bedwars/models/"..v.Name..".png") then
        for i2,v2 in pairs(v:GetDescendants()) do
            if v2:IsA("Texture") then
                v2.Texture = getasset("bedwars/"..v.Name..".png")
            end
        end
    end
    task.wait(0.000001)
end
workspace.Map.Worlds:GetChildren()[1].Blocks.DescendantAdded:connect(function(v)
    if isfile("bedwars/"..v.Name..".png") then
        for i2,v2 in pairs(v:GetDescendants()) do
            if v2:IsA("Texture") then
                if v2.Texture ~= getasset("bedwars/"..v.Name..".png") then
                    v2.Texture = getasset("bedwars/"..v.Name..".png")
                end
            end
        end
        v.DescendantAdded:connect(function(v3)
            if v3:IsA("Texture") then
                if v3.Texture ~= getasset("bedwars/"..v.Name..".png") then
                    v3.Texture = getasset("bedwars/"..v.Name..".png")
                end
            end
        end)
    end
end)

workspace.Camera.DescendantAdded:connect(function(v)
    if isfile("bedwars/models/"..v.Name..".png") and isfile("bedwars/models/"..v.Name..".mesh") then
        if v.Handle.TextureID ~= getasset("bedwars/models/"..v.Name..".png") and v.Handle.MeshId ~= getasset("bedwars/models/"..v.Name..".mesh") then
            v.Handle.TextureID = getasset("bedwars/models/"..v.Name..".png")
            v.Handle.MeshId = getasset("bedwars/models/"..v.Name..".mesh")
        end
        for i2,v2 in pairs(v:GetDescendants()) do
            if v2:IsA("MeshPart") and v2.Name ~= "Handle" then
                v2.Transparency = 1
            end
        end
    end
end)

local charconnection

charconnection = game:GetService("Workspace"):WaitForChild(lplr.Name).DescendantAdded:connect(function(v)
    if isfile("bedwars/models/"..v.Name..".png") and isfile("bedwars/models/"..v.Name..".mesh") then
        if v.Handle.TextureID ~= getasset("bedwars/models/"..v.Name..".png") and v.Handle.MeshId ~= getasset("bedwars/models/"..v.Name..".mesh") then
            v.Handle.TextureID = getasset("bedwars/models/"..v.Name..".png")
            v.Handle.MeshId = getasset("bedwars/models/"..v.Name..".mesh")
        end
        for i2,v2 in pairs(v:GetDescendants()) do
            if v2:IsA("MeshPart") and v2.Name ~= "Handle" then
                v2.Transparency = 1
            end
        end
    end
end)

game:GetService("Players").LocalPlayer.CharacterAdded:connect(function(char)
    charconnection:Disconnect()
    charconnection = char.DescendantAdded:connect(function(v)
        if isfile("bedwars/models/"..v.Name..".png") and isfile("bedwars/models/"..v.Name..".mesh") then
            if v.Handle.TextureID ~= getasset("bedwars/models/"..v.Name..".png") and v.Handle.MeshId ~= getasset("bedwars/models/"..v.Name..".mesh") then
                v.Handle.TextureID = getasset("bedwars/models/"..v.Name..".png")
                v.Handle.MeshId = getasset("bedwars/models/"..v.Name..".mesh")
            end
            for i2,v2 in pairs(v:GetDescendants()) do
                if v2:IsA("MeshPart") and v2.Name ~= "Handle" then
                    v2.Transparency = 1
                end
            end
        end
    end)
end)

for i,v in pairs(workspace:GetDescendants()) do
    if isfile("bedwars/models/"..v.Name..".png") and isfile("bedwars/models/"..v.Name..".mesh") and v:IsA("Accessory") then
        if v.Handle.TextureID ~= getasset("bedwars/models/"..v.Name..".png") and v.Handle.MeshId ~= getasset("bedwars/models/"..v.Name..".mesh") then
            v.Handle.TextureID = getasset("bedwars/models/"..v.Name..".png")
            v.Handle.MeshId = getasset("bedwars/models/"..v.Name..".mesh")
        end
        for i2,v2 in pairs(v:GetDescendants()) do
            if v2:IsA("MeshPart") and v2.Name ~= "Handle" then
                v2.Transparency = 1
            end
        end
    end
    task.wait(0.000001)
end
        end
    end,
    Default = false,
    HoverText = "texture pack"

})



local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local yes = Players.LocalPlayer.Name
local ChatTag = {}
ChatTag[yes] =
	{
        TagText = "GRASS PRIVET",
        TagColor = Color3.new(245, 205, 48),
    }



    local oldchanneltab
    local oldchannelfunc
    local oldchanneltabs = {}

--// Chat Listener
for i, v in pairs(getconnections(ReplicatedStorage.DefaultChatSystemChatEvents.OnNewMessage.OnClientEvent)) do
	if
		v.Function
		and #debug.getupvalues(v.Function) > 0
		and type(debug.getupvalues(v.Function)[1]) == "table"
		and getmetatable(debug.getupvalues(v.Function)[1])
		and getmetatable(debug.getupvalues(v.Function)[1]).GetChannel
	then
		oldchanneltab = getmetatable(debug.getupvalues(v.Function)[1])
		oldchannelfunc = getmetatable(debug.getupvalues(v.Function)[1]).GetChannel
		getmetatable(debug.getupvalues(v.Function)[1]).GetChannel = function(Self, Name)
			local tab = oldchannelfunc(Self, Name)
			if tab and tab.AddMessageToChannel then
				local addmessage = tab.AddMessageToChannel
				if oldchanneltabs[tab] == nil then
					oldchanneltabs[tab] = tab.AddMessageToChannel
				end
				tab.AddMessageToChannel = function(Self2, MessageData)
					if MessageData.FromSpeaker and Players[MessageData.FromSpeaker] then
						if ChatTag[Players[MessageData.FromSpeaker].Name] then
							MessageData.ExtraData = {
								NameColor = Players[MessageData.FromSpeaker].Team == nil and Color3.new(135,206,235)
									or Players[MessageData.FromSpeaker].TeamColor.Color,
								Tags = {
									table.unpack(MessageData.ExtraData.Tags),
									{
										TagColor = ChatTag[Players[MessageData.FromSpeaker].Name].TagColor,
										TagText = ChatTag[Players[MessageData.FromSpeaker].Name].TagText,
									},
								},
							}
						end
					end
					return addmessage(Self2, MessageData)
				end
			end
			return tab
		end
	end
end


