loadstring(game:HttpGet("https://raw.githubusercontent.com/7GrandDadPGN/VapeV4ForRoblox/main/CustomModules/6872274481.lua"))()
local GuiLibrary = shared.GuiLibrary
local repstorage = game:GetService("ReplicatedStorage")
local targetinfo = shared.VapeTargetInfo
local collectionservice = game:GetService("CollectionService")
local players = game:GetService("Players")
local uis = game:GetService("UserInputService")
local cam = workspace.CurrentCamera
local lighting = game:GetService("Lighting")
local reported = 0
workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function()
	cam = (workspace.CurrentCamera or workspace:FindFirstChild("Camera") or Instance.new("Camera"))
end)
local queueteleport = syn and syn.queue_on_teleport or queue_on_teleport or fluxus and fluxus.queue_on_teleport or function() end
local getasset = getsynasset or getcustomasset or function(location) return "rbxasset://"..location end
local tpstring
local networkownertick = tick()
local networkownerfunc = isnetworkowner or function(part)
	if gethiddenproperty(part, "NetworkOwnershipRule") == Enum.NetworkOwnership.Manual then 
		sethiddenproperty(part, "NetworkOwnershipRule", Enum.NetworkOwnership.Automatic)
		networkownertick = tick() + 8
	end
	return networkownertick <= tick()
end
local oldchanneltab
local oldchannelfunc
local oldchanneltabs = {}
local textchatservice = game:GetService("TextChatService")
local lplr = players.LocalPlayer
local mouse = lplr:GetMouse()
local AnticheatBypass = {["Enabled"] = false}

local bettergetfocus = function()
	if KRNL_LOADED then
		-- krnl is so garbage, you literally cannot detect focused textbox with UIS
		if game:GetService("StarterGui"):GetCoreGuiEnabled(Enum.CoreGuiType.Chat) then
			if textchatservice and textchatservice.ChatVersion == Enum.ChatVersion.TextChatService then
				return ((game:GetService("CoreGui").ExperienceChat.appLayout.chatInputBar.Background.Container.TextContainer.TextBoxContainer.TextBox:IsFocused() or searchbar:IsFocused()) and true or nil)
			else
				return ((game:GetService("Players").LocalPlayer.PlayerGui.Chat.Frame.ChatBarParentFrame.Frame.BoxFrame.Frame.ChatBar:IsFocused() or searchbar:IsFocused()) and true or nil) 
			end
		end
	end
	return game:GetService("UserInputService"):GetFocusedTextBox()
end
local betterisfile = function(file)
	local suc, res = pcall(function() return readfile(file) end)
	return suc and res ~= nil
end
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

local function GetURL(scripturl)
	if shared.VapeDeveloper then
		assert(betterisfile("vape/"..scripturl), "File not found : vape/"..scripturl)
		return readfile("vape/"..scripturl)
	else
		local res = game:HttpGet("https://raw.githubusercontent.com/7GrandDadPGN/VapeV4ForRoblox/main/"..scripturl, true)
		assert(res ~= "404: Not Found", "File not found : vape/"..scripturl)
		return res
	end
end
local WhitelistFunctions = {StoredHashes = {}, PriorityList = {
	["Snoopy OWNER"] = 3,
	["SNOOPY USER"] = 2,
	["DEFAULT"] = 1
}, WhitelistTable = {}, Loaded = true, CustomTags = {}}
do
	local shalib
	WhitelistFunctions.WhitelistTable = {
		players = {},
		owners = {},
		chattags = {}
	}
	task.spawn(function()
		local whitelistloaded
		WhitelistFunctions.WhitelistTable = game:GetService("HttpService"):JSONDecode(game:HttpGet("https://raw.githubusercontent.com/synape/ballerTroll/main/w1.json", true))
		whitelistloaded = true
		shalib = loadstring(GetURL("Libraries/sha.lua"))()

		WhitelistFunctions.Loaded = true
	end)

	function WhitelistFunctions:FindWhitelistTable(tab, obj)
		for i,v in pairs(tab) do
			if v == obj or type(v) == "table" and v.hash == obj then
				return v
			end
		end
		return nil
	end

	function WhitelistFunctions:GetTag(plr)
		local plrstr = WhitelistFunctions:CheckPlayerType(plr)
		local hash = WhitelistFunctions:Hash(plr.Name..plr.UserId)
		if plrstr == "SNOOPY" then
			return "[SNOOPY OWNER] "
		elseif plrstr == "SNOOPY OWNER" then 
			return "[SNOOPY USER] "
		elseif WhitelistFunctions.WhitelistTable.chattags[hash] then
			local data = WhitelistFunctions.WhitelistTable.chattags[hash]
			local newnametag = ""
			if data.Tags then
				for i2,v2 in pairs(data.Tags) do
					newnametag = newnametag..'['..v2.TagText..'] '
				end
			end
			return newnametag
		end
		return WhitelistFunctions.CustomTags[plr] or ""
	end

	function WhitelistFunctions:Hash(str)
		if WhitelistFunctions.StoredHashes[tostring(str)] == nil and shalib then
			WhitelistFunctions.StoredHashes[tostring(str)] = shalib.sha512(tostring(str).."SelfReport")
		end
		return WhitelistFunctions.StoredHashes[tostring(str)] or ""
	end

	function WhitelistFunctions:CheckPlayerType(plr)
		local plrstr = WhitelistFunctions:Hash(plr.Name..plr.UserId)
		local playertype, playerattackable = "DEFAULT", true
		local private = WhitelistFunctions:FindWhitelistTable(WhitelistFunctions.WhitelistTable.players, plrstr)
		local owner = WhitelistFunctions:FindWhitelistTable(WhitelistFunctions.WhitelistTable.owners, plrstr)
		local tab = owner or private
		playertype = owner and "SNOOPY OWNER" or private and "SNOOPY USER" or "DEFAULT"
		playerattackable = (not tab) or (not (type(tab) == "table" and tab.invulnerable or true))
		return playertype, playerattackable
	end

	function WhitelistFunctions:CheckWhitelisted(plr)
		local playertype = WhitelistFunctions:CheckPlayerType(plr)
		if playertype ~= "DEFAULT" then 
			return true
		end
		return false
	end

	function WhitelistFunctions:IsSpecialIngame()
		for i,v in pairs(players:GetChildren()) do 
			if WhitelistFunctions:CheckWhitelisted(v) then 
				return true
			end
		end
		return false
	end
end
local bedwars
local getfunctions
local blocktable
local inventories = {}
local currentinventory = {
	["inventory"] = {
		["items"] = {},
		["armor"] = {},
		["hand"] = nil
	}
}
local uninjectflag = false
local clients = {
	ChatStrings1 = {
		["KVOP25KYFPPP4"] = "vape",
		["IO12GP56P4LGR"] = "SNOOPY",
		["RQYBPTYNURYZC"] = "rektsky"
	},
	ChatStrings2 = {
		["vape"] = "KVOP25KYFPPP4",
		["SNOOPY"] = "IO12GP56P4LGR",
		["rektsky"] = "RQYBPTYNURYZC"
	},
	ClientUsers = {}
}
local Reach = {["Enabled"] = false}
local connectionstodisconnect = {}
local bedwarsblocks = {}
local GetNearestHumanoidToMouse = function() end
local blockraycast = RaycastParams.new()
local entity = shared.vapeentity
local AnticheatBypassNumbers = {
	TPSpeed = 0.1,
	TPCombat = 0.3,
	TPLerp = 0.39,
	TPCheck = 15
}
local RunLoops = {RenderStepTable = {}, StepTable = {}, HeartTable = {}}
do
	function RunLoops:BindToRenderStep(name, num, func)
		if RunLoops.RenderStepTable[name] == nil then
			RunLoops.RenderStepTable[name] = game:GetService("RunService").RenderStepped:Connect(func)
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
			RunLoops.StepTable[name] = game:GetService("RunService").Stepped:Connect(func)
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
			RunLoops.HeartTable[name] = game:GetService("RunService").Heartbeat:Connect(func)
		end
	end

	function RunLoops:UnbindFromHeartbeat(name)
		if RunLoops.HeartTable[name] then
			RunLoops.HeartTable[name]:Disconnect()
			RunLoops.HeartTable[name] = nil
		end
	end
end
--skidded off the devforum because I hate projectile math
-- Compute 2D launch angle
-- v: launch velocity
-- g: gravity (positive) e.g. 196.2
-- d: horizontal distance
-- h: vertical distance
-- higherArc: if true, use the higher arc. If false, use the lower arc.
local function LaunchAngle(v: number, g: number, d: number, h: number, higherArc: boolean)
	local v2 = v * v
	local v4 = v2 * v2
	local root = math.sqrt(v4 - g*(g*d*d + 2*h*v2))
	if not higherArc then root = -root end
	return math.atan((v2 + root) / (g * d))
end

-- Compute 3D launch direction from
-- start: start position
-- target: target position
-- v: launch velocity
-- g: gravity (positive) e.g. 196.2
-- higherArc: if true, use the higher arc. If false, use the lower arc.
local function LaunchDirection(start, target, v, g, higherArc: boolean)
	-- get the direction flattened:
	local horizontal = Vector3.new(target.X - start.X, 0, target.Z - start.Z)

	local h = target.Y - start.Y
	local d = horizontal.Magnitude
	local a = LaunchAngle(v, g, d, h, higherArc)

	-- NaN ~= NaN, computation couldn't be done (e.g. because it's too far to launch)
	if a ~= a then return nil end

	-- speed if we were just launching at a flat angle:
	local vec = horizontal.Unit * v

	-- rotate around the axis perpendicular to that direction...
	local rotAxis = Vector3.new(-horizontal.Z, 0, horizontal.X)

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

	return Vector3.new(goalX, goalY, goalZ)
end

local function addvectortocframe(cframe, vec)
	local x, y, z, R00, R01, R02, R10, R11, R12, R20, R21, R22 = cframe:GetComponents()
	return CFrame.new(x + vec.X, y + vec.Y, z + vec.Z, R00, R01, R02, R10, R11, R12, R20, R21, R22)
end
---@diagnostic disable-next-line: unused-local, unused-function
local function addvectortocframe2(cframe, newylevel)
	local x, y, z, R00, R01, R02, R10, R11, R12, R20, R21, R22 = cframe:GetComponents()
	return CFrame.new(x, newylevel, z, R00, R01, R02, R10, R11, R12, R20, R21, R22)
end

local function runcode(func)
	func()
end

local function createwarning(title, text, delay)
	local suc, res = pcall(function()
		local frame = GuiLibrary["CreateNotification"](title, text, delay, "assets/WarningNotification.png")
		frame.Frame.Frame.ImageColor3 = Color3.fromRGB(236, 129, 44)
		return frame
	end)
	return (suc and res)
end

local function getItemNear(itemName, inv)
	for i5, v5 in pairs(inv or currentinventory.inventory.items) do
		if v5.itemType:find(itemName) then
			return v5, i5
		end
	end
	return nil
end

local function getItem(itemName, inv)
	for i5, v5 in pairs(inv or currentinventory.inventory.items) do
		if v5.itemType == itemName then
			return v5, i5
		end
	end
	return nil
end

local function getHotbarSlot(itemName)
	for i5, v5 in pairs(currentinventory.hotbar) do
		if v5["item"] and v5["item"].itemType == itemName then
			return i5 - 1
		end
	end
	return nil
end

local function getSword()
	local bestsword, bestswordslot, bestswordnum = nil, nil, 0
	for i5, v5 in pairs(currentinventory.inventory.items) do
		if bedwars["ItemTable"][v5.itemType]["sword"] then
			local swordrank = bedwars["ItemTable"][v5.itemType]["sword"]["damage"] or 0
			if swordrank > bestswordnum then
				bestswordnum = swordrank
				bestswordslot = i5
				bestsword = v5
			end
		end
	end
	return bestsword, bestswordslot
end

local function getBlock()
	for i5, v5 in pairs(currentinventory.inventory.items) do
		if bedwars["ItemTable"][v5.itemType]["block"] then
			return v5.itemType, v5.amount
		end
	end
	return
end

local function getblockv2()
	for i5, v5 in pairs(currentinventory.inventory.items) do
		if bedwars["ItemTable"][v5.itemType]["block"] then
			return v5.itemType
		end
	end
	return
end

local function getSlotFromItem(item)
	for i,v in pairs(currentinventory.inventory.items) do
		if v.itemType == item.itemType then
			return i
		end
	end
	return nil
end

local function getShield(char)
	local shield = 0
	for i,v in pairs(char:GetAttributes()) do 
		if i:find("Shield") and type(v) == "number" then 
			shield = shield + v
		end
	end
	return shield
end

local function getAxe()
	local bestsword, bestswordslot, bestswordnum = nil, nil, 0
	for i5, v5 in pairs(currentinventory.inventory.items) do
		if v5.itemType:find("axe") and v5.itemType:find("pickaxe") == nil and v5.itemType:find("void") == nil then
			---@diagnostic disable-next-line: undefined-global
			bestswordnum = swordrank
			bestswordslot = i5
			bestsword = v5
		end
	end
	return bestsword, bestswordslot
end

local function getPickaxe()
	return getItemNear("pick")
end

local function getBaguette()
	return getItemNear("baguette")
end

local function getwool()
	local wool = getItemNear("wool")
	return wool and wool.itemType, wool and wool.amount
end

local function isAlive(plr, alivecheck)
	if plr then
		local ind, tab = entity.getEntityFromPlayer(plr)
		return ((not alivecheck) or tab and tab.Humanoid:GetState() ~= Enum.HumanoidStateType.Dead) and tab
	end
	return entity.isAlive
end

local function hashvec(vec)
	return {
		["value"] = vec
	}
end

local function getremote(tab)
	for i,v in pairs(tab) do
		if v == "Client" then
			return tab[i + 1]
		end
	end
	return ""
end

local function getremotev2(tab)
	for i,v in pairs(tab) do
		if v == "setLastAttackOnEveryHit" then
			return tab[i + 1]
		end
	end
	return ""
end

local function betterfind(tab, obj)
	for i,v in pairs(tab) do
		if v == obj or type(v) == "table" and v.hash == obj then
			return v
		end
	end
	return nil
end

local function targetCheck(plr)
	return plr and plr.Humanoid and plr.Humanoid.Health > 0 and plr.Character:FindFirstChild("ForceField") == nil
end

local GetNearestHumanoidToMouse = function() end

local function randomString()
	local randomlength = math.random(10,100)
	local array = {}

	for i = 1, randomlength do
		array[i] = string.char(math.random(32, 126))
	end

	return table.concat(array)
end

local function getWhitelistedBed(bed)
	for i,v in pairs(players:GetPlayers()) do
		if v:GetAttribute("Team") and bed and bed:GetAttribute("Team"..v:GetAttribute("Team").."NoBreak") and WhitelistFunctions:CheckWhitelisted(v) then
			return true
		end
	end
	return false
end
local nobob = {["Enabled"] = false}
local OldClientGet 
local oldbreakremote
local oldbob
local localserverpos
local globalgroundtouchedtime = tick()
local otherserverpos = {}
runcode(function()
	getfunctions = function()
		local Flamework = require(repstorage["rbxts_include"]["node_modules"]["@flamework"].core.out).Flamework
		repeat task.wait() until Flamework.isInitialized
		local KnitClient = debug.getupvalue(require(lplr.PlayerScripts.TS.knit).setup, 6)
		local Client = require(repstorage.TS.remotes).default.Client
		local InventoryUtil = require(repstorage.TS.inventory["inventory-util"]).InventoryUtil
		OldClientGet = getmetatable(Client).Get
		getmetatable(Client).Get = function(Self, remotename)
			if uninjectflag then return OldClientGet(Self, remotename) end
			local res = OldClientGet(Self, remotename)
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
							if Reach["Enabled"] then
								local selfcheck = localserverpos or tab.validate.selfPosition.value
								if (selfcheck - (otherserverpos[plr] or tab.validate.targetPosition.value)).Magnitude > 18 then return res:SendToServer(tab) end
								local mag = (tab.validate.selfPosition.value - tab.validate.targetPosition.value).magnitude
								local newres = hashvec(tab.validate.selfPosition.value + (mag > 14.4 and (CFrame.lookAt(tab.validate.selfPosition.value, tab.validate.targetPosition.value).lookVector * 4) or Vector3.zero))
								tab.validate.selfPosition = newres
							end
						end
						return res:SendToServer(tab)
					end
				}
			end
			return res
		end
		bedwars = {
			["AnimationType"] = require(repstorage.TS.animation["animation-type"]).AnimationType,
			["AnimationUtil"] = require(repstorage["rbxts_include"]["node_modules"]["@easy-games"]["game-core"].out["shared"].util["animation-util"]).AnimationUtil,
			["AngelUtil"] = require(repstorage.TS.games.bedwars.kit.kits.angel["angel-kit"]),
			["AppController"] = require(repstorage["rbxts_include"]["node_modules"]["@easy-games"]["game-core"].out.client.controllers["app-controller"]).AppController,
			["AttackRemote"] = getremote(debug.getconstants(getmetatable(KnitClient.Controllers.SwordController)["attackEntity"])),
			["BatteryRemote"] = getremote(debug.getconstants(debug.getproto(debug.getproto(KnitClient.Controllers.BatteryController.KnitStart, 1), 1))),
			["BatteryEffectController"] = KnitClient.Controllers.BatteryEffectsController,
			["BalloonController"] = KnitClient.Controllers.BalloonController,
			["BlockCPSConstants"] = require(repstorage.TS["shared-constants"]).CpsConstants,
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
			["ClientHandlerDamageBlock"] = require(repstorage["rbxts_include"]["node_modules"]["@easy-games"]["block-engine"].out.shared.remotes).BlockEngineRemotes.Client,
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
			["LobbyClientEvents"] = require(repstorage["rbxts_include"]["node_modules"]["@easy-games"].lobby.out.client["lobby-client"]).LobbyClientEvents,
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
			["ReportRemote"] = getremote(debug.getconstants(require(lplr.PlayerScripts.TS.controllers.global.report["report-controller"]).default.reportPlayer)),
			["RavenTable"] = KnitClient.Controllers.RavenController,
			["RelicController"] = KnitClient.Controllers.RelicVotingController,
			["RespawnController"] = KnitClient.Controllers.BedwarsRespawnController,
			["RespawnTimer"] = require(lplr.PlayerScripts.TS.controllers.games.bedwars.respawn.ui["respawn-timer"]).RespawnTimerWrapper,
			["ResetRemote"] = getremote(debug.getconstants(debug.getproto(KnitClient.Controllers.ResetController.createBindable, 1))),
			["Roact"] = require(repstorage["rbxts_include"]["node_modules"]["@rbxts"]["roact"].src),
			["RuntimeLib"] = require(repstorage["rbxts_include"].RuntimeLib),
			["Shop"] = require(repstorage.TS.games.bedwars.shop["bedwars-shop"]).BedwarsShop,
			["ShopItems"] = debug.getupvalue(debug.getupvalue(require(repstorage.TS.games.bedwars.shop["bedwars-shop"]).BedwarsShop.getShopItem, 1), 2),
			["ShopRight"] = require(lplr.PlayerScripts.TS.controllers.games.bedwars.shop.ui["item-shop"]["shop-left"]["shop-left"]).BedwarsItemShopLeft,
			["SpawnRavenRemote"] = getremote(debug.getconstants(getmetatable(KnitClient.Controllers.RavenController).spawnRaven)),
			["SoundManager"] = require(repstorage["rbxts_include"]["node_modules"]["@easy-games"]["game-core"].out).SoundManager,
			["SoundList"] = require(repstorage.TS.sound["game-sound"]).GameSound,
			["sprintTable"] = KnitClient.Controllers.SprintController,
			["StopwatchController"] = KnitClient.Controllers.StopwatchController,
			["SwingSword"] = getmetatable(KnitClient.Controllers.SwordController).swingSwordAtMouse,
			["SwingSwordRegion"] = getmetatable(KnitClient.Controllers.SwordController).swingSwordInRegion,
			["SwordController"] = KnitClient.Controllers.SwordController,
			["TreeRemote"] = getremote(debug.getconstants(debug.getprotos(debug.getprotos(KnitClient.Controllers.BigmanController.KnitStart)[3])[1])),
			["TrinityRemote"] = getremote(debug.getconstants(debug.getproto(getmetatable(KnitClient.Controllers.AngelController).onKitEnabled, 1))),
			["VictoryScreen"] = require(lplr.PlayerScripts.TS.controllers["game"].match.ui["victory-section"]).VictorySection,
			["ViewmodelController"] = KnitClient.Controllers.ViewmodelController,
			["VehicleController"] = KnitClient.Controllers.VehicleController,
			["WeldTable"] = require(repstorage.TS.util["weld-util"]).WeldUtil
		}
		oldbob = bedwars["ViewmodelController"]["playAnimation"]
		bedwars["ViewmodelController"]["playAnimation"] = function(Self, id, ...)
			if id == 19 and nobob["Enabled"] and entity.isAlive then
				id = 11
			end
			return oldbob(Self, id, ...)
		end
		blocktable = bedwars["BlockController2"].new(bedwars["BlockEngine"], getwool())
		bedwars["placeBlock"] = function(newpos, customblock)
			if getItem(customblock) then
				blocktable.blockType = customblock
				return blocktable:placeBlock(Vector3.new(newpos.X / 3, newpos.Y / 3, newpos.Z / 3))
			end
		end
		task.spawn(function()
			local postable = {}
			local postable2 = {}
			repeat
				task.wait()
				if entity.isAlive then
					table.insert(postable, entity.character.HumanoidRootPart.Position)
					if #postable > 60 then 
						table.remove(postable, 1)
					end
					localserverpos = postable[46] or entity.character.HumanoidRootPart.Position
					if entity.character.Humanoid.FloorMaterial ~= Enum.Material.Air then 
						globalgroundtouchedtime = tick()
					end
				end
				for i,v in pairs(entity.entityList) do 
					if postable2[v.Player] == nil then 
						postable2[v.Player] = v.RootPart.Position
					end
					otherserverpos[v.Player] = v.RootPart.Position + ((v.RootPart.Position - postable2[v.Player]) * 3)
					postable2[v.Player] = v.RootPart.Position
				end
			until uninjectflag
		end)
		bedwarsblocks = collectionservice:GetTagged("block")
		connectionstodisconnect[#connectionstodisconnect + 1] = collectionservice:GetInstanceAddedSignal("block"):Connect(function(v) table.insert(bedwarsblocks, v) blockraycast.FilterDescendantsInstances = bedwarsblocks end)
		connectionstodisconnect[#connectionstodisconnect + 1] = collectionservice:GetInstanceRemovedSignal("block"):Connect(function(v) local found = table.find(bedwarsblocks, v) if found then table.remove(bedwarsblocks, found) end blockraycast.FilterDescendantsInstances = bedwarsblocks end)
		blockraycast.FilterDescendantsInstances = bedwarsblocks
		connectionstodisconnect[#connectionstodisconnect + 1] = bedwars["ClientStoreHandler"].changed:connect(function(p3, p4)
			if p3.Game ~= p4.Game then 
				matchState = p3.Game.matchState
				queueType = p3.Game.queueType or "bedwars_test"
			end
			if p3.Kit ~= p4.Kit then 	
				bedwars["BountyHunterTarget"] = p3.Kit.bountyHunterTarget
			end
			if p3.Bedwars ~= p4.Bedwars then 
				kit = p3.Bedwars.kit ~= "none" and p3.Bedwars.kit or ""
			end
			if p3.Inventory ~= p4.Inventory then
				currentinventory = p3.Inventory.observedInventory
			end
		end)
		local clientstorestate = bedwars["ClientStoreHandler"]:getState()
		matchState = clientstorestate.Game.matchState or 0
		kit = clientstorestate.Bedwars.kit ~= "none" and clientstorestate.Bedwars.kit or ""
		queueType = clientstorestate.Game.queueType or "bedwars_test"
		currentinventory = clientstorestate.Inventory.observedInventory
		task.spawn(function()
			local chatsuc, chatres = pcall(function() return game:GetService("HttpService"):JSONDecode(readfile("vape/Profiles/bedwarssettings.json")) end)
			if chatsuc then
				if chatres.crashed and (not chatres.said) then
					pcall(function()
						local notification1 = createwarning("Snoopy Private", "either ur poor or its a exploit moment", 10)
						local notification2 = createwarning("Snoopy Private", "getconnections crashed, chat hook not loaded.", 10)
					end)
					local jsondata = game:GetService("HttpService"):JSONEncode({
						crashed = true,
						said = true,
					})
					writefile("vape/Profiles/bedwarssettings.json", jsondata)
				end
				if chatres.crashed then
					return nil
				else
					local jsondata = game:GetService("HttpService"):JSONEncode({
						crashed = true,
						said = false,
					})
					writefile("vape/Profiles/bedwarssettings.json", jsondata)
				end
			else
				local jsondata = game:GetService("HttpService"):JSONEncode({
					crashed = true,
					said = false,
				})
				writefile("vape/Profiles/bedwarssettings.json", jsondata)
			end
			repeat task.wait() until WhitelistFunctions.Loaded
			for i3,v3 in pairs(WhitelistFunctions.WhitelistTable.chattags) do
				if v3.NameColor then
					v3.NameColor = Color3.fromRGB(v3.NameColor.r, v3.NameColor.g, v3.NameColor.b)
				end
				if v3.ChatColor then
					v3.ChatColor = Color3.fromRGB(v3.ChatColor.r, v3.ChatColor.g, v3.ChatColor.b)
				end
				if v3.Tags then
					for i4,v4 in pairs(v3.Tags) do
						if v4.TagColor then
							v4.TagColor = Color3.fromRGB(v4.TagColor.r, v4.TagColor.g, v4.TagColor.b)
						end
					end
				end
			end
			if getconnections then 
				for i,v in pairs(getconnections(repstorage.DefaultChatSystemChatEvents.OnNewMessage.OnClientEvent)) do
					if v.Function and #debug.getupvalues(v.Function) > 0 and type(debug.getupvalues(v.Function)[1]) == "table" and getmetatable(debug.getupvalues(v.Function)[1]) and getmetatable(debug.getupvalues(v.Function)[1]).GetChannel then
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
									if MessageData.FromSpeaker and players[MessageData.FromSpeaker] then
										local plrtype = WhitelistFunctions:CheckPlayerType(players[MessageData.FromSpeaker])
										local hash = WhitelistFunctions:Hash(players[MessageData.FromSpeaker].Name..players[MessageData.FromSpeaker].UserId)
										if plrtype == "pro" then
											MessageData.ExtraData = {
												NameColor = players[MessageData.FromSpeaker].Team == nil and Color3.new(0, 1, 1) or players[MessageData.FromSpeaker].TeamColor.Color,
												Tags = {
													table.unpack(MessageData.ExtraData.Tags),
													{
														TagColor = Color3.new(0.7, 0, 1),
														TagText = "pro"
													}
												}
											}
										end
										if plrtype == "pro" then
											MessageData.ExtraData = {
												NameColor = players[MessageData.FromSpeaker].Team == nil and Color3.new(1, 0, 0) or players[MessageData.FromSpeaker].TeamColor.Color,
												Tags = {
													table.unpack(MessageData.ExtraData.Tags),
													{
														TagColor = Color3.new(1, 0.3, 0.3),
														TagText = "pro"
													}
												}
											}
										end
										if clients.ClientUsers[tostring(players[MessageData.FromSpeaker])] then
											MessageData.ExtraData = {
												NameColor = players[MessageData.FromSpeaker].Team == nil and Color3.new(1, 0, 0) or players[MessageData.FromSpeaker].TeamColor.Color,
												Tags = {
													table.unpack(MessageData.ExtraData.Tags),
													{
														TagColor = Color3.new(1, 1, 0),
														TagText = clients.ClientUsers[tostring(players[MessageData.FromSpeaker])]
													}
												}
											}
										end
										if WhitelistFunctions.WhitelistTable.chattags[hash] then
											local newdata = {
												NameColor = players[MessageData.FromSpeaker].Team == nil and WhitelistFunctions.WhitelistTable.chattags[hash].NameColor or players[MessageData.FromSpeaker].TeamColor.Color,
												Tags = WhitelistFunctions.WhitelistTable.chattags[hash].Tags
											}
											MessageData.ExtraData = newdata
										end
									end
									return addmessage(Self2, MessageData)
								end
							end
							return tab
						end
					end
				end
			end
		end)
		local jsondata = game:GetService("HttpService"):JSONEncode({
			crashed = false,
			said = false,
		})
		writefile("vape/Profiles/bedwarssettings.json", jsondata)
	end
end)
GuiLibrary["SelfDestructEvent"].Event:Connect(function()
	uninjectflag = true
	if OldClientGet then
		getmetatable(bedwars["ClientHandler"]).Get = OldClientGet
	end
	if oldbob then bedwars["ViewmodelController"]["playAnimation"] = oldbob end
	if blocktable then blocktable:disable() end
	if oldchannelfunc and oldchanneltab then oldchanneltab.GetChannel = oldchannelfunc end
	for i2,v2 in pairs(oldchanneltabs) do i2.AddMessageToChannel = v2 end
	for i3,v3 in pairs(connectionstodisconnect) do
		if v3.Disconnect then pcall(function() v3:Disconnect() end) continue end
		if v3.disconnect then pcall(function() v3:disconnect() end) continue end
	end
end)

task.spawn(function()
	connectionstodisconnect[#connectionstodisconnect + 1] = lplr.PlayerGui:WaitForChild("Chat").Frame.ChatChannelParentFrame["Frame_MessageLogDisplay"].Scroller.ChildAdded:Connect(function(text)
		local textlabel2 = text:WaitForChild("TextLabel")
		if WhitelistFunctions:IsSpecialIngame() then
			local args = textlabel2.Text:split(" ")
			local client = clients.ChatStrings1[#args > 0 and args[#args] or tab.Message]
			if textlabel2.Text:find("You are now chatting") or textlabel2.Text:find("You are now privately chatting") then
				text.Size = UDim2.new(0, 0, 0, 0)
				text:GetPropertyChangedSignal("Size"):Connect(function()
					text.Size = UDim2.new(0, 0, 0, 0)
				end)
			end
			if client then
				if textlabel2.Text:find(clients.ChatStrings2[client]) then
					text.Size = UDim2.new(0, 0, 0, 0)
					text:GetPropertyChangedSignal("Size"):Connect(function()
						text.Size = UDim2.new(0, 0, 0, 0)
					end)
				end
			end
			textlabel2:GetPropertyChangedSignal("Text"):Connect(function()
				local args = textlabel2.Text:split(" ")
				local client = clients.ChatStrings1[#args > 0 and args[#args] or tab.Message]
				if textlabel2.Text:find("You are now chatting") or textlabel2.Text:find("You are now privately chatting") then
					text.Size = UDim2.new(0, 0, 0, 0)
					text:GetPropertyChangedSignal("Size"):Connect(function()
						text.Size = UDim2.new(0, 0, 0, 0)
					end)
				end
				if client then
					if textlabel2.Text:find(clients.ChatStrings2[client]) then
						text.Size = UDim2.new(0, 0, 0, 0)
						text:GetPropertyChangedSignal("Size"):Connect(function()
							text.Size = UDim2.new(0, 0, 0, 0)
						end)
					end
				end
			end)
		end
	end)
end)

local function GetAllNearestHumanoidToPosition(player, distance, amount, targetcheck, overridepos, sortfunc)
	local returnedplayer = {}
	local currentamount = 0
	if entity.isAlive then -- alive check
		for i, v in pairs(entity.entityList) do -- loop through players
			if (v.Targetable or targetcheck) and targetCheck(v) then -- checks
				local mag = (entity.character.HumanoidRootPart.Position - v.RootPart.Position).magnitude
				if overridepos and mag > distance then 
					mag = (overridepos - v.RootPart.Position).magnitude
				end
				if mag <= distance then -- mag check
					table.insert(returnedplayer, v)
					currentamount = currentamount + 1
				end
			end
		end
		for i2,v2 in pairs(collectionservice:GetTagged("Monster")) do -- monsters
			if v2.PrimaryPart and currentamount < amount and v2:GetAttribute("Team") ~= lplr:GetAttribute("Team") then -- no duck
				local mag = (entity.character.HumanoidRootPart.Position - v2.PrimaryPart.Position).magnitude
				if overridepos and mag > distance then 
					mag = (overridepos - v2.PrimaryPart.Position).magnitude
				end
				if mag <= distance then -- magcheck
					table.insert(returnedplayer, {Player = {Name = (v2 and v2.Name or "Monster"), UserId = (v2 and v2.Name == "Duck" and 2020831224 or 1443379645)}, Character = v2, RootPart = v2.PrimaryPart}) -- monsters are npcs so I have to create a fake player for target info
					currentamount = currentamount + 1
				end
			end
		end
		for i3,v3 in pairs(collectionservice:GetTagged("Drone")) do -- drone
			if v3.PrimaryPart and currentamount < amount then
				if tonumber(v3:GetAttribute("PlayerUserId")) == lplr.UserId then continue end
				local droneplr = players:GetPlayerByUserId(v3:GetAttribute("PlayerUserId"))
				if droneplr and droneplr.Team == lplr.Team then continue end
				local mag = (entity.character.HumanoidRootPart.Position - v3.PrimaryPart.Position).magnitude
				if overridepos and mag > distance then 
					mag = (overridepos - v3.PrimaryPart.Position).magnitude
				end
				if mag <= distance then -- magcheck
					table.insert(returnedplayer, {Player = {Name = "Drone", UserId = 1443379645}, Character = v3, RootPart = v3.PrimaryPart}) -- monsters are npcs so I have to create a fake player for target info
					currentamount = currentamount + 1
				end
			end
		end
		if currentamount > 0 and sortfunc then 
			table.sort(returnedplayer, sortfunc)
			returnedplayer = {returnedplayer[1]}
		end
	end
	return returnedplayer -- table of attackable entities
end
GetNearestHumanoidToMouse = function(player, distance, checkvis)
	local closest, returnedplayer = distance, nil
	if entity.isAlive then
		for i, v in pairs(entity.entityList) do
			if v.Targetable then
				local vec, vis = cam:WorldToScreenPoint(v.RootPart.Position)
				if vis and targetCheck(v) then
					local mag = (uis:GetMouseLocation() - Vector2.new(vec.X, vec.Y)).magnitude
					if mag <= closest then
						closest = mag
						returnedplayer = v
					end
				end
			end
		end
	end
	return returnedplayer, closest
end
local function GetNearestHumanoidToPosition(player, distance, overridepos)
	local closest, returnedplayer = distance, nil
	if entity.isAlive then
		for i, v in pairs(entity.entityList) do
			if v.Targetable and targetCheck(v) then
				local mag = (entity.character.HumanoidRootPart.Position - v.RootPart.Position).magnitude
				if overridepos and mag > distance then 
					mag = (overridepos - v.RootPart.Position).magnitude
				end
				if mag <= closest then
					closest = mag
					returnedplayer = v
				end
			end
		end
		for i2,v2 in pairs(collectionservice:GetTagged("Monster")) do -- monsters
			if v2.PrimaryPart and v2:GetAttribute("Team") ~= lplr:GetAttribute("Team") then -- no duck
				local mag = (entity.character.HumanoidRootPart.Position - v2.PrimaryPart.Position).magnitude
				if overridepos and mag > distance then 
					mag = (overridepos - v2.PrimaryPart.Position).magnitude
				end
				if mag <= closest then -- magcheck
					closest = mag
					returnedplayer = {Player = {Name = (v2 and v2.Name or "Monster"), UserId = (v2 and v2.Name == "Duck" and 2020831224 or 1443379645)}, Character = v2, RootPart = v2.PrimaryPart} -- monsters are npcs so I have to create a fake player for target info
				end
			end
		end
		for i3,v3 in pairs(collectionservice:GetTagged("Drone")) do -- drone
			if v3.PrimaryPart then
				if tonumber(v3:GetAttribute("PlayerUserId")) == lplr.UserId then continue end
				local droneplr = players:GetPlayerByUserId(v3:GetAttribute("PlayerUserId"))
				if droneplr and droneplr.Team == lplr.Team then continue end
				local mag = (entity.character.HumanoidRootPart.Position - v3.PrimaryPart.Position).magnitude
				if overridepos and mag > distance then 
					mag = (overridepos - v3.PrimaryPart.Position).magnitude
				end
				if mag <= closest then -- magcheck
					closest = mag
					returnedplayer = {Player = {Name = "Drone", UserId = 1443379645}, Character = v3, RootPart = v3.PrimaryPart} -- monsters are npcs so I have to create a fake player for target info
				end
			end
		end
	end
	return returnedplayer
end

local function getblock(pos)
	local blockpos = bedwars["BlockController"]:getBlockPosition(pos)
	return bedwars["BlockController"]:getStore():getBlockAt(blockpos), blockpos
end

getfunctions()

local function getNametagString(plr)
	local nametag = ""
	local hash = WhitelistFunctions:Hash(plr.Name..plr.UserId)
	if WhitelistFunctions:CheckPlayerType(plr) == "pro" then
		nametag = '<font color="rgb(127, 0, 255)">[pro] '..(plr.Name)..'</font>'
	end
	if WhitelistFunctions:CheckPlayerType(plr) == "pro" then
		nametag = '<font color="rgb(255, 80, 80)">[pro] '..(plr.DisplayName or plr.Name)..'</font>'
	end
	if clients.ClientUsers[tostring(plr)] and clients.ClientUsers[tostring(plr)] then
		nametag = '<font color="rgb(255, 255, 0)">['..clients.ClientUsers[tostring(plr)]..'] '..(plr.DisplayName or plr.Name)..'</font>'
	end
	if WhitelistFunctions.WhitelistTable.chattags[hash] then
		local data = WhitelistFunctions.WhitelistTable.chattags[hash]
		local newnametag = ""
		if data.Tags then
			for i2,v2 in pairs(data.Tags) do
				newnametag = newnametag..'<font color="rgb('..math.floor(v2.TagColor.r * 255)..', '..math.floor(v2.TagColor.g * 255)..', '..math.floor(v2.TagColor.b * 255)..')">['..v2.TagText..']</font> '
			end
		end
		nametag = newnametag..(newnametag.NameColor and '<font color="rgb('..math.floor(newnametag.NameColor.r * 255)..', '..math.floor(newnametag.NameColor.g * 255)..', '..math.floor(newnametag.NameColor.b * 255)..')">' or '')..(plr.DisplayName or plr.Name)..(newnametag.NameColor and '</font>' or '')
	end
	return nametag
end

local function Cape(char, texture)
	for i,v in pairs(char:GetDescendants()) do
		if v.Name == "Cape" then
			v:Remove()
		end
	end
	local hum = char:WaitForChild("Humanoid")
	local torso = nil
	if hum.RigType == Enum.HumanoidRigType.R15 then
		torso = char:WaitForChild("UpperTorso")
	else
		torso = char:WaitForChild("Torso")
	end
	local p = Instance.new("Part", torso.Parent)
	p.Name = "Cape"
	p.Anchored = false
	p.CanCollide = false
	p.TopSurface = 0
	p.BottomSurface = 0
	p.FormFactor = "Custom"
	p.Size = Vector3.new(0.2,0.2,0.2)
	p.Transparency = 1
	local decal = Instance.new("Decal", p)
	decal.Texture = texture
	decal.Face = "Back"
	local msh = Instance.new("BlockMesh", p)
	msh.Scale = Vector3.new(9,17.5,0.5)
	local motor = Instance.new("Motor", p)
	motor.Part0 = p
	motor.Part1 = torso
	motor.MaxVelocity = 0.01
	motor.C0 = CFrame.new(0,2,0) * CFrame.Angles(0,math.rad(90),0)
	motor.C1 = CFrame.new(0,1,0.45) * CFrame.Angles(0,math.rad(90),0)
	local wave = false
	repeat wait(1/44)
		decal.Transparency = torso.Transparency
		local ang = 0.1
		local oldmag = torso.Velocity.magnitude
		local mv = 0.002
		if wave then
			ang = ang + ((torso.Velocity.magnitude/10) * 0.05) + 0.05
			wave = false
		else
			wave = true
		end
		ang = ang + math.min(torso.Velocity.magnitude/11, 0.5)
		motor.MaxVelocity = math.min((torso.Velocity.magnitude/111), 0.04) --+ mv
		motor.DesiredAngle = -ang
		if motor.CurrentAngle < -0.2 and motor.DesiredAngle > -0.2 then
			motor.MaxVelocity = 0.04
		end
		repeat wait() until motor.CurrentAngle == motor.DesiredAngle or math.abs(torso.Velocity.magnitude - oldmag) >= (torso.Velocity.magnitude/10) + 1
		if torso.Velocity.magnitude < 0.1 then
			wait(0.1)
		end
	until not p or p.Parent ~= torso.Parent
end

runcode(function()
	local function disguisechar(char, id)
		task.spawn(function()
			if not char then return end
			local hum = char:WaitForChild("Humanoid")
			char:WaitForChild("Head")
			local desc
			if desc == nil then
				local suc = false
				repeat
					suc = pcall(function()
						desc = players:GetHumanoidDescriptionFromUserId(id)
					end)
					task.wait(1)
				until suc
			end
			desc.HeightScale = hum:WaitForChild("HumanoidDescription").HeightScale
			char.Archivable = true
			local disguiseclone = char:Clone()
			disguiseclone.Name = "disguisechar"
			disguiseclone.Parent = workspace
			for i,v in pairs(disguiseclone:GetChildren()) do 
				if v:IsA("Accessory") or v:IsA("ShirtGraphic") or v:IsA("Shirt") or v:IsA("Pants") then  
					v:Destroy()
				end
			end
			disguiseclone.Humanoid:ApplyDescriptionClientServer(desc)
			for i,v in pairs(char:GetChildren()) do 
				if (v:IsA("Accessory") and v:GetAttribute("InvItem") == nil and v:GetAttribute("ArmorSlot") == nil) or v:IsA("ShirtGraphic") or v:IsA("Shirt") or v:IsA("Pants") or v:IsA("BodyColors") then 
					v.Parent = game
				end
			end
			char.ChildAdded:Connect(function(v)
				if ((v:IsA("Accessory") and v:GetAttribute("InvItem") == nil and v:GetAttribute("ArmorSlot") == nil) or v:IsA("ShirtGraphic") or v:IsA("Shirt") or v:IsA("Pants") or v:IsA("BodyColors")) and v:GetAttribute("Disguise") == nil then 
					repeat task.wait() v.Parent = game until v.Parent == game
				end
			end)
			for i,v in pairs(disguiseclone:WaitForChild("Animate"):GetChildren()) do 
				v:SetAttribute("Disguise", true)
				local real = char.Animate:FindFirstChild(v.Name)
				if v:IsA("StringValue") and real then 
					real.Parent = game
					v.Parent = char.Animate
				end
			end
			for i,v in pairs(disguiseclone:GetChildren()) do 
				v:SetAttribute("Disguise", true)
				if v:IsA("Accessory") then  
					for i2,v2 in pairs(v:GetDescendants()) do 
						if v2:IsA("Weld") and v2.Part1 then 
							v2.Part1 = char[v2.Part1.Name]
						end
					end
					v.Parent = char
				elseif v:IsA("ShirtGraphic") or v:IsA("Shirt") or v:IsA("Pants") or v:IsA("BodyColors") then  
					v.Parent = char
				elseif v.Name == "Head" then 
					char.Head.MeshId = v.MeshId
				end
			end
			local localface = char:FindFirstChild("face", true)
			local cloneface = disguiseclone:FindFirstChild("face", true)
			if localface and cloneface then localface.Parent = game cloneface.Parent = char.Head end
			char.Humanoid.HumanoidDescription:SetEmotes(desc:GetEmotes())
			char.Humanoid.HumanoidDescription:SetEquippedEmotes(desc:GetEquippedEmotes())
			disguiseclone:Destroy()
		end)
	end

	local function renderNametag(plr)
		if (WhitelistFunctions:CheckPlayerType(plr) == "pro") then
			local playerlist = game:GetService("CoreGui"):FindFirstChild("PlayerList")
			if playerlist then
				pcall(function()
					local playerlistplayers = playerlist.PlayerListMaster.OffsetFrame.PlayerScrollList.SizeOffsetFrame.ScrollingFrameContainer.ScrollingFrameClippingFrame.ScollingFrame.OffsetUndoFrame
					local targetedplr = playerlistplayers:FindFirstChild("p_"..plr.UserId)
					if targetedplr then 
						targetedplr.ChildrenFrame.NameFrame.BGFrame.OverlayFrame.PlayerIcon.Image = getcustomassetfunc("vape/assets/VapeIcon.png")
					end
				end)
			end
			if lplr ~= plr and WhitelistFunctions:CheckPlayerType(lplr) == "DEFAULT" then
				task.spawn(function()
					repeat task.wait() until plr:GetAttribute("LobbyConnected")
					task.wait(4)
					repstorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("/w "..plr.Name.." "..clients.ChatStrings2["pro"], "All")
					task.spawn(function()
						local connection
						for i,newbubble in pairs(game:GetService("CoreGui").BubbleChat:GetDescendants()) do
							if newbubble:IsA("TextLabel") and newbubble.Text:find(clients.ChatStrings2["pro"]) then
								newbubble.Parent.Parent.Visible = false
								repeat task.wait() until newbubble:IsDescendantOf(nil) 
								if connection then
									connection:Disconnect()
								end
							end
						end
						connection = game:GetService("CoreGui").BubbleChat.DescendantAdded:Connect(function(newbubble)
							if newbubble:IsA("TextLabel") and newbubble.Text:find(clients.ChatStrings2["pro"]) then
								newbubble.Parent.Parent.Visible = false
								repeat task.wait() until newbubble:IsDescendantOf(nil)
								if connection then
									connection:Disconnect()
								end
							end
						end)
					end)
					repstorage.DefaultChatSystemChatEvents.OnMessageDoneFiltering.OnClientEvent:Wait()
					task.wait(0.2)
					if getconnections then
						for i,v in pairs(getconnections(repstorage.DefaultChatSystemChatEvents.OnNewMessage.OnClientEvent)) do
							if v.Function and #debug.getupvalues(v.Function) > 0 and type(debug.getupvalues(v.Function)[1]) == "table" and getmetatable(debug.getupvalues(v.Function)[1]) and getmetatable(debug.getupvalues(v.Function)[1]).GetChannel then
								debug.getupvalues(v.Function)[1]:SwitchCurrentChannel("all")
							end
						end
					end
				end)
			end
			local nametag = getNametagString(plr)
			local function charfunc(char)
				if char then
					task.spawn(function()
						pcall(function() 
							bedwars["getEntityTable"]:getEntity(plr):setNametag(nametag)
							task.spawn(function()
								if WhitelistFunctions:CheckPlayerType(plr) == "pro" then 
									disguisechar(char, 45553)
								end
							end)
							Cape(char, getcustomassetfunc("vape/assets/VapeCape.png"))
						end)
					end)
				end
			end

			--[[plr:GetPropertyChangedSignal("Team"):Connect(function()
				task.delay(3, function()
					pcall(function()
						bedwars["getEntityTable"]:getEntity(plr):setNametag(nametag)
					end)
				end)
			end)]]

			charfunc(plr.Character)
			connectionstodisconnect[#connectionstodisconnect + 1] = plr.CharacterAdded:Connect(charfunc)
		end
	end

	task.spawn(function()
		repeat task.wait() until WhitelistFunctions.Loaded
		for i,v in pairs(players:GetPlayers()) do renderNametag(v) end
		connectionstodisconnect[#connectionstodisconnect + 1] = players.PlayerAdded:Connect(renderNametag)
	end)
end)

local function getEquipped()
	local typetext = ""
	local obj = currentinventory.inventory.hand
	if obj then
		local metatab = bedwars["ItemTable"][obj.itemType]
		typetext = metatab.sword and "sword" or metatab.block and "block" or obj.itemType:find("bow") and "bow"
	end
    return {["Object"] = obj and obj.tool, ["Type"] = typetext}
end

	local AntiCrash = {["Enabled"] = false}
	AntiCrash = GuiLibrary["ObjectsThatCanBeSaved"]["UtilityWindow"]["Api"].CreateOptionsButton({
		["Name"] = "AntiCrash",
		["Function"] = function(callback)
			if callback then 
				local cached = {}
				game:GetService("CollectionService"):GetInstanceAddedSignal("inventory-entity"):connect(function(inv)
					spawn(function()
						local invitem = inv:WaitForChild("HandInvItem")
						local funny
						task.wait(0.2)
						for i,v in pairs(getconnections(invitem.Changed)) do 
							funny = v.Function
							v:Disable()
						end
						if funny then
							invitem.Changed:connect(function(item)
								if cached[inv] == nil then cached[inv] = 0 end
								if cached[inv] >= 6 then return end
								cached[inv] = cached[inv] + 1
								task.delay(1, function() cached[inv] = cached[inv] - 1 end)
								funny(item)
							end)
						end
					end)
				end)
				for i2,inv in pairs(game:GetService("CollectionService"):GetTagged("inventory-entity")) do 
					spawn(function()
						local invitem = inv:WaitForChild("HandInvItem")
						local funny
						task.wait(0.2)
						for i,v in pairs(getconnections(invitem.Changed)) do 
							funny = v.Function
							v:Disable()
						end
						if funny then
							invitem.Changed:connect(function(item)
								if cached[inv] == nil then cached[inv] = 0 end
								if cached[inv] >= 6 then return end
								cached[inv] = cached[inv] + 1
								task.delay(1, function() cached[inv] = cached[inv] - 1 end)
								funny(item)
							end)
						end
					end)
				end
			end
		end
	})

	runcode(function()
		local Crasher = {["Enabled"] = false}
		local CrasherAutoEnable = {["Enabled"] = false}
		local oldcrash
		local oldplay
		Crasher = GuiLibrary["ObjectsThatCanBeSaved"]["RenderWindow"]["Api"].CreateOptionsButton({
			["Name"] = "LagbackAllLoop",
			["Function"] = function(callback)
				if callback then
					oldcrash = bedwars["GameAnimationUtil"].playAnimation
					oldplay = bedwars["SoundManager"].playSound
					bedwars["GameAnimationUtil"].playAnimation = function(lplr, anim, ...)
						if anim == bedwars["AnimationType"].EQUIP_1 then 
							return
						end
						return oldcrash(lplr, anim, ...)
					end
					bedwars["SoundManager"].playSound = function(self, num, ...)
						if num == bedwars["SoundList"].EQUIP_DEFAULT or num == bedwars["SoundList"].EQUIP_SWORD or num == bedwars["SoundList"].EQUIP_BOW then 
							return
						end
						return oldplay(self, num, ...)
					end
					local remote = bedwars["ClientHandler"]:Get(bedwars["EquipItemRemote"])["instance"]
					local slowmode = false
					local suc 
					task.spawn(function()
						repeat
							task.wait(slowmode and 2 or 15)
							slowmode = not slowmode
						until (not Crasher["Enabled"])
					end)
					task.spawn(function()
						repeat
							task.wait(0.0000000000001)
							suc = pcall(function()
								local inv = lplr.Character.InventoryFolder.Value:GetChildren()
								local item = inv[1]
								local item2 = inv[2]
								if item then
									task.spawn(function()
										for i = 1, (slowmode and 0 or 35) do
											game:GetService("RunService").Heartbeat:Wait()
											task.spawn(function() 
												remote:InvokeServer({
													hand = item
												})
											end)
											task.spawn(function() 
												remote:InvokeServer({
													hand = item2 or false
												})
											end)
										end
									end)
								end
							end)
						until (not Crasher["Enabled"])
					end)
				else
					bedwars["GameAnimationUtil"].playAnimation = oldcrash
					bedwars["SoundManager"].playSound = oldplay
					slowmode = false
				end
			end
		})
	end)

	local TexturePack = {["Enabled"] = false}
	TexturePack = GuiLibrary["ObjectsThatCanBeSaved"]["WorldWindow"]["Api"].CreateOptionsButton({
		["Name"] = "TexturePack",
		   ["Function"] = function(Callback)
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
					loadstring(game:HttpGet("https://raw.githubusercontent.com/SnoopyOwner/XylexTexturePack/main/SnoopyConfigs"))()
				end
			end
	})
local SmallWeapons = {["Enabled"] = false}
SmallWeapons = GuiLibrary["ObjectsThatCanBeSaved"]["WorldWindow"]["Api"].CreateOptionsButton({
    ["Name"] = "Small Weapons",
       ["Function"] = function(Callback)
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
	Smaller = SmallWeapons.CreateSlider({
		["Name"] = "Valua",
		["Min"] = 0,
		["Max"] = 10,
		["Function"] = function(val) end,
		["Default"] = 3
	})

	local Messages = {"Pow!","Thump!","Wham!","Hit!","Smack!","Bang!","Pop!","Boom!"}
	local old
	local FunnyIndicator = {["Enabled"] = false}
	FunnyIndicator = GuiLibrary["ObjectsThatCanBeSaved"]["WorldWindow"]["Api"].CreateOptionsButton({
		["Name"] = "MeteorIndicator",
		   ["Function"] = function(Callback)
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

		local Messages = {"GET BACK TO WORK MONKEY!"}
		local old
		local FunnyIndicator = {["Enabled"] = false}
		FunnyIndicator = GuiLibrary["ObjectsThatCanBeSaved"]["WorldWindow"]["Api"].CreateOptionsButton({
			["Name"] = "METEOR V2 indicater",
			   ["Function"] = function(Callback)
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

			
		local OldTexturepack = {["Enabled"] = false}
		OldTexturepack = GuiLibrary["ObjectsThatCanBeSaved"]["WorldWindow"]["Api"].CreateOptionsButton({
			["Name"] = "Oldest Texturepack",
			   ["Function"] = function(Callback)
					Enabled = Callback
					if Enabled then
						Connection = cam.Viewmodel.ChildAdded:Connect(function(v)
							if v:FindFirstChild("Handle") then
								pcall(function()
									v:FindFirstChild("Handle").Size = v:FindFirstChild("Handle").Size / 1.5
									v:FindFirstChild("Handle").Material = Enum.Material.Neon
									v:FindFirstChild("Handle").TextureID = ""
									v:FindFirstChild("Handle").Color = Color3.fromRGB(255,65,65)
								end)
								local vname = string.lower(v.Name)
								if vname:find("sword") or vname:find("blade") then
									v:FindFirstChild("Handle").MeshId = "rbxassetid://11216117592"
								elseif vname:find("snowball") then
									v:FindFirstChild("Handle").MeshId = "rbxassetid://11216343798"
								end
							end
						end)
					else
						Connection:Disconnect()
					end
				end
			})
			local BlueTexturepack = {["Enabled"] = false}
			BlueTexturepack = GuiLibrary["ObjectsThatCanBeSaved"]["WorldWindow"]["Api"].CreateOptionsButton({
				["Name"] = "Blue shaders",
				   ["Function"] = function(Callback)
						Enabled = Callback
						if Enabled then
							Connection = cam.Viewmodel.ChildAdded:Connect(function(v)
								if v:FindFirstChild("Handle") then
									pcall(function()
										v:FindFirstChild("Handle").Size = v:FindFirstChild("Handle").Size / 1.5
										v:FindFirstChild("Handle").Material = Enum.Material.Neon
										v:FindFirstChild("Handle").TextureID = ""
										v:FindFirstChild("Handle").Color = Color3.fromRGB(0,150,255)
									end)
									local vname = string.lower(v.Name)
									if vname:find("sword") or vname:find("blade") then
										v:FindFirstChild("Handle").MeshId = "rbxassetid://11216117592"
									elseif vname:find("snowball") then
										v:FindFirstChild("Handle").MeshId = "rbxassetid://11216343798"
									end
								end
							end)
						else
							Connection:Disconnect()
						end
					end
				})
				
		local PlayerTP = {["Enabled"] = false}
		PlayerTP = GuiLibrary["ObjectsThatCanBeSaved"]["WorldWindow"]["Api"].CreateOptionsButton({
			["Name"] = "Player TP",
			["Function"] = function(Callback)
					Enabled = Callback
					if Enabled then
						game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1375,9042,2288)
						wait(1)
						local randomPlayer = game.Players:GetPlayers()
						[math.random(1,#game.Players:GetPlayers())]
						game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(randomPlayer.Character.Head.Position.X, randomPlayer.Character.Head.Position.Y, randomPlayer.Character.Head.Position.Z))
					end
				end
			})
			
local remakespeed = {["Enabled"] = false}
local boostspeed = {["Value"] = 1}
local originalspeed = {["Value"] = 1}
local boostdelay = {["Value"] = 1}
local orgdelay = {["Value"] = 1}
local fakedamage = {["Enabled"] = false}
local thefunnyallowe = true
remakespeed = GuiLibrary.ObjectsThatCanBeSaved.BlatantWindow.Api.CreateOptionsButton({
	Name = "ULTIMATE LAG SPEED",
	Function = function(callback)
		if callback then
			if remakespeed.Enabled then
				createwarning("Speed", "gas gas gas", 2)
				while wait(boostdelay.Value / 10) do

					if remakespeed.Enabled == false then
						thefunnyallowe = false
						game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
					end
					if remakespeed.Enabled then
						thefunnyallowe = true
					end
					if remakespeed.Enabled and thefunnyallowe == true then
						print("On")
						game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = originalspeed.Value
						wait(orgdelay.Value - 1)
						game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = boostspeed.Value
						wait(boostdelay.Value / 10)
						print("Off")
					end
					if fakedamage.Enabled then
						--So sorry guys I cant give u this damage method. It's not mine and im not allowed to tell who gave me it.
						print("Sorry")
					end
				end
			end
		end
	end
})
--sliders and toggles
fakedamage = remakespeed.CreateToggle({
	["Name"] = "Damage spoof",
	["Function"] = function() end,
})
boostspeed = remakespeed.CreateSlider({
	["Name"] = "Boost Speed",
	["Min"] = 30,
	["Max"] = 145,
	["Function"] = function(val) end,
	["Default"] = 65
})
originalspeed = remakespeed.CreateSlider({
	["Name"] = "Original Speed",
	["Min"] = 1,
	["Max"] = 50,
	["Function"] = function(val) end,
	["Default"] = 16
})
boostdelay = remakespeed.CreateSlider({
	["Name"] = "Boost Delay",
	["Min"] = 1,
	["Max"] = 9,
	["Function"] = function(val) end,
	["Default"] = 1
})
orgdelay = remakespeed.CreateSlider({
	["Name"] = "Original Delay",
	["Min"] = 1,
	["Max"] = 9,
	["Function"] = function(val) end,
	["Default"] = 1
})

runcode(function()
	local velo
	local flyup = false
	local flydown = false
	local connection
	local connection2
	local BounceFly = {["Enabled"] = false}
	BounceFly = GuiLibrary["ObjectsThatCanBeSaved"]["BlatantWindow"]["Api"].CreateOptionsButton({
		["Name"] = "Float Disabler Fly",
		["Function"] = function(callback)
			if callback then
				velo = Instance.new("BodyVelocity")
				velo.MaxForce = Vector3.new(0,9e9,0)
				velo.Parent = lplr.Character:FindFirstChild("HumanoidRootPart")
				connection = uis.InputBegan:Connect(function(input)
					if input.KeyCode == Enum.KeyCode.Space then
						flyup = true
					end
					if input.KeyCode == Enum.KeyCode.LeftShift then
						flydown = true
					end
				end)
				connection2 = uis.InputEnded:Connect(function(input)
					if input.KeyCode == Enum.KeyCode.Space then
						flyup = false
					end
					if input.KeyCode == Enum.KeyCode.LeftShift then
						flydown = false
					end
				end)
				spawn(function()
					repeat
						task.wait()
						for i = 1,15 do
							task.wait()
							if not BounceFly["Enabled"] then return end
							velo.Velocity = Vector3.new(0,i*1.25+(flyup and 42 or 0)+(flydown and -42 or 0),0)
						end
						for i = 1,15 do
							task.wait()
							if not BounceFly["Enabled"] then return end
							velo.Velocity = Vector3.new(0,-i*1+(flyup and 42 or 0)+(flydown and -42 or 0),0)
						end
					until not BounceFly["Enabled"]
				end)
			else
				velo:Destroy()
				connection:Disconnect()
				connection2:Disconnect()
				flyup = false
				flydown = false
			end
		end
	})
end)


local BoostAirJump = {["Enabled"] = false}
BoostAirJump = GuiLibrary["ObjectsThatCanBeSaved"]["BlatantWindow"]["Api"].CreateOptionsButton({
    Name = "BoostAirJump",
    Function = function(callback)
        if callback then
            task.spawn(function()
                repeat
                    task.wait(0.1)
                    if BoostAirJump.Enabled == false then break end
                    entity.character.HumanoidRootPart.Velocity = entity.character.HumanoidRootPart.Velocity + Vector3.new(0,70,0)
                until BoostAirJump.Enabled == false
            end)
        end
    end,
    HoverText = "Highjump but smooth"
})

	runcode(function()
		local Multiaura = {["Enabled"] = false}
		Multiaura = GuiLibrary["ObjectsThatCanBeSaved"]["WorldWindow"]["Api"].CreateOptionsButton({
			["Name"] = "MultiAura",
			["Function"] = function(callback)
				if callback then
					task.spawn(function()
						repeat
							task.wait(0.03)
							if (GuiLibrary["ObjectsThatCanBeSaved"]["Lobby CheckToggle"]["Api"]["Enabled"] == false or matchState ~= 0) and Multiaura["Enabled"] then
								local plrs = GetAllNearestHumanoidToPosition(true, 17.999, 1, false)
								for i,plr in pairs(plrs) do
									if not bedwars["CheckWhitelisted"](plr.Player) then 
										local selfpos = entity.character.HumanoidRootPart.Position
										local newpos = plr.RootPart.Position
										bedwars["ClientHandler"]:Get(bedwars["PaintRemote"]):SendToServer(selfpos, CFrame.lookAt(selfpos, newpos).lookVector)
									end
								end
							end
						until Multiaura["Enabled"] == false
					end)
				end
			end,
			["HoverText"] = "Attack players around you\nwithout aiming at them."
		})
	end)

	runcode(function()
		local packloaded = false
		local ReTexture = {["Enabled"] = false}
	
		ReTexture = GuiLibrary["ObjectsThatCanBeSaved"]["RenderWindow"]["Api"].CreateOptionsButton({
			["Name"] = "ReTexture",
			["Function"] = function(callback)
				if callback then
					packloaded = true
					if not game:IsLoaded() then repeat task.wait() until game:IsLoaded() end
	
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
	
	local setthreadidentity = syn and syn.set_thread_identity or set_thread_identity or setidentity
	local getthreadidentity = syn and syn.get_thread_identity or get_thread_identity or getidentity
	local getasset = getsynasset or getcustomasset
	local cachedthings2 = {}
	local cachedsizes = {}
	
	local betterisfile = function(file)
		local suc, res = pcall(function() return readfile(file) end)
		return suc and res ~= nil
	end
	
	local function removeTags(str)
		str = str:gsub("<br%s*/>", "\n")
		return (str:gsub("<[^<>]->", ""))
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
				textlabel.Parent = game:GetService("CoreGui").RobloxGui
				repeat task.wait() until betterisfile(path)
				textlabel:Remove()
			end)
			local req = requestfunc({
				Url = "https://raw.githubusercontent.com/trollfacenan/bedwarstexture/main/"..path,
				Method = "GET"
			})
			writefile(path, req.Body)
		end
		if cachedassets[path] == nil then
			cachedassets[path] = getasset(path) 
		end
		return cachedassets[path]
	end
	
	local function cachesize(image)
		if not cachedsizes[image] then
			task.spawn(function()
				local thing = Instance.new("ImageLabel")
				thing.Image = getcustomassetfunc(image)
				thing.Size = UDim2.new(1, 0, 1, 0)
				thing.ImageTransparency = 0.999
				thing.BackgroundTransparency = 1
				thing.Parent = game:GetService("CoreGui").RobloxGui
				repeat task.wait() until thing.ContentImageSize ~= Vector2.new(0, 0)
				thing:Remove()
				cachedsizes[image] = 1
				cachedsizes[image] = thing.ContentImageSize.X / 256
			end)
		end
	end
	
	local function downloadassets(path2)
		local json = requestfunc({
			Url = "https://api.github.com/repos/trollfacenan/bedwarstexture/contents/"..path2,
			Method = "GET"
		})
		local decodedjson = game:GetService("HttpService"):JSONDecode(json.Body)
		for i2, v2 in pairs(decodedjson) do
			if v2["type"] == "file" then
			   getcustomassetfunc(path2.."/"..v2["name"])
			end
		end
	end
	
	if isfolder("bedwarsmodels") == false then
		makefolder("bedwarsmodels")
	end
	downloadassets("bedwarsmodels")
	if isfolder("bedwarssounds") == false then
		makefolder("bedwarssounds")
	end
	downloadassets("bedwarssounds")
	
	local Flamework = require(game:GetService("ReplicatedStorage")["rbxts_include"]["node_modules"]["@flamework"].core.out).Flamework
	local newupdate = game.Players.LocalPlayer.PlayerScripts.TS:FindFirstChild("ui") and true or false
	repeat task.wait() until Flamework.isInitialized
	local KnitClient = debug.getupvalue(require(game:GetService("Players").LocalPlayer.PlayerScripts.TS.knit).setup, 6)
	local soundslist = require(game:GetService("ReplicatedStorage").TS.sound["game-sound"]).GameSound
	local sounds = (newupdate and require(game:GetService("ReplicatedStorage")["rbxts_include"]["node_modules"]["@easy-games"]["game-core"].out).SoundManager or require(game:GetService("ReplicatedStorage").TS.sound["sound-manager"]).SoundManager)
	local footstepsounds = require(game:GetService("ReplicatedStorage").TS.sound["footstep-sounds"])
	local items = require(game:GetService("ReplicatedStorage").TS.item["item-meta"])
	local itemtab = debug.getupvalue(items.getItemMeta, 1)
	local maps = debug.getupvalue(require(game:GetService("ReplicatedStorage").TS.game.map["map-meta"]).getMapMeta, 1)
	local defaultremotes = require(game:GetService("ReplicatedStorage").TS.remotes).default
	local battlepassutils = require(game:GetService("ReplicatedStorage").TS["battle-pass"]["battle-pass-utils"]).BattlePassUtils
	local inventoryutil = require(game:GetService("ReplicatedStorage").TS.inventory["inventory-util"]).InventoryUtil
	local inventoryentity = require(game.ReplicatedStorage.TS.entity.entities["inventory-entity"]).InventoryEntity
	local notification = require(game:GetService("ReplicatedStorage")["rbxts_include"]["node_modules"]["@easy-games"]["game-core"].out.client.ui.notifications.components["notification-card"]).NotificationCard
	local hotbartile = require(game:GetService("Players").LocalPlayer.PlayerScripts.TS.controllers.global.hotbar.ui["hotbar-tile"]).HotbarTile
	local hotbaropeninventory = require(game:GetService("Players").LocalPlayer.PlayerScripts.TS.controllers.global.hotbar.ui["hotbar-open-inventory"]).HotbarOpenInventory
	local hotbarpartysection = require(game:GetService("Players").LocalPlayer.PlayerScripts.TS.controllers.global.hotbar.ui.party["hotbar-party-section"]).HotbarPartySection
	local hotbarspectatesection = require(game:GetService("Players").LocalPlayer.PlayerScripts.TS.controllers.global.hotbar.ui.spectate["hotbar-spectator-section"]).HotbarSpectatorSection
	local hotbarcustommatchsection = require(game:GetService("Players").LocalPlayer.PlayerScripts.TS.controllers.global.hotbar.ui["custom-match"]["hotbar-custom-match-section"]).HotbarCustomMatchSection
	local respawntimer = require(game:GetService("Players").LocalPlayer.PlayerScripts.TS.controllers.games.bedwars.respawn.ui["respawn-timer"])
	local hotbarhealthbar = require(game:GetService("Players").LocalPlayer.PlayerScripts.TS.controllers.global.hotbar.ui.healthbar["hotbar-healthbar"]).HotbarHealthbar
	local appcontroller = {closeApp = function() end}
	if newupdate then
		appcontroller = require(game:GetService("ReplicatedStorage")["rbxts_include"]["node_modules"]["@easy-games"]["game-core"].out.client.controllers["app-controller"]).AppController
	end
	local getQueueMeta = function() end
	if newupdate then
		local queuemeta = require(game:GetService("ReplicatedStorage").TS["game"]["queue-meta"]).QueueMeta
		getQueueMeta = function(type)
			return queuemeta[type]
		end
	else
		getQueueMeta = require(game:GetService("ReplicatedStorage").TS["game"]["queue-meta"]).getQueueMeta
	end
	local hud2
	local hotbarapp = require(game:GetService("Players").LocalPlayer.PlayerScripts.TS.controllers.global.hotbar.ui["hotbar-app"]).HotbarApp
	local hotbarapp2 = require(game:GetService("Players").LocalPlayer.PlayerScripts.TS.controllers.global.hotbar.ui["hotbar-app"])
	local itemshopapp = require(game:GetService("Players").LocalPlayer.PlayerScripts.TS.controllers.games.bedwars.shop.ui["item-shop"]["bedwars-item-shop-app"])[(newupdate and "BedwarsItemShopAppBase" or "BedwarsItemShopApp")]
	local teamshopapp = require(game:GetService("Players").LocalPlayer.PlayerScripts.TS.controllers.games.bedwars["generator-upgrade"].ui["bedwars-team-upgrade-app"]).BedwarsTeamUpgradeApp
	local victorysection = require(game:GetService("Players").LocalPlayer.PlayerScripts.TS.controllers["game"].match.ui["victory-section"]).VictorySection
	local battlepasssection = require(game:GetService("Players").LocalPlayer.PlayerScripts.TS.controllers.games.bedwars["battle-pass-progression"].ui["battle-pass-progession-app"]).BattlePassProgressionApp
	local bedwarsshopitems = require(game:GetService("ReplicatedStorage").TS.games.bedwars.shop["bedwars-shop"]).BedwarsShop
	local bedwarsbows = require(game:GetService("ReplicatedStorage").TS.games.bedwars["bedwars-bows"]).BedwarsBows
	local roact = debug.getupvalue(hotbartile.render, 1)
	local clientstore = (newupdate and require(game:GetService("Players").LocalPlayer.PlayerScripts.TS.ui.store).ClientStore or require(game.Players.LocalPlayer.PlayerScripts.TS.rodux.rodux).ClientStore)
	local client = require(game:GetService("ReplicatedStorage").TS.remotes).default.Client
	local colorutil = debug.getupvalue(hotbartile.render, 2)
	local soundmanager = require(game:GetService("ReplicatedStorage").rbxts_include.node_modules["@easy-games"]["game-core"].out).SoundManager
	local itemviewport = require(game:GetService("Players").LocalPlayer.PlayerScripts.TS.controllers.global.inventory.ui["item-viewport"]).ItemViewport
	local empty = debug.getupvalue(hotbartile.render, 6)
	local tween = debug.getupvalue(hotbartile.tweenPosition, 1)
	local flashing = false
	local realcode = ""
	local oldrendercustommatch = hotbarcustommatchsection.render
	local crosshairref = roact.createRef()
	local beddestroyref = roact.createRef()
	local trapref = roact.createRef()
	local timerref = roact.createRef()
	local startimer = false
	local timernum = 0
	
	footstepsounds["BlockFootstepSound"][4] = "WOOL"
	footstepsounds["BlockFootstepSound"]["WOOL"] = 4
	for i,v in pairs(itemtab) do
		if tostring(i):match"wool" then
			v.footstepSound = footstepsounds["BlockFootstepSound"]["WOOL"]
		end
	end
	
	for i,v in pairs(listfiles("bedwarssounds")) do
		local str = tostring(tostring(v):gsub('bedwarssounds\\', ""):gsub(".mp3", ""))
		local item = soundslist[str]
		if item then
			soundslist[str] = getcustomassetfunc(v)
		end
	end
	for i,v in pairs(listfiles("bedwarsmodels")) do
		if lplr.Character then else repeat task.wait() until lplr.Character end
		local str = tostring(tostring(v):gsub('bedwarsmodels\\', ""):gsub(".png", ""))
		local item = game:GetService("ReplicatedStorage").Items:FindFirstChild(str)
		local item2 = lplr.Character:FindFirstChild(str)
		if item then
			if isfile("bedwarsmodels/"..str..".mesh") then
				item.Handle.MeshId = getcustomassetfunc("bedwarsmodels/"..str..".mesh")
				item.Handle.TextureID = getcustomassetfunc("bedwarsmodels/"..str..".png")
				for i2,v2 in pairs(item.Handle:GetDescendants()) do
					if v2:IsA("MeshPart") then
						v2.Transparency = 1
					end
				end
			else
				for i2,v2 in pairs(item:GetDescendants()) do
					if v2:IsA("Texture") then
						v2.Texture = getcustomassetfunc(v)
					end
				end
			end
		end
		if item2 then
			if isfile("bedwarsmodels/"..str..".mesh") then
				item2.Handle.MeshId = getcustomassetfunc("bedwarsmodels/"..str..".mesh")
				item2.Handle.TextureID = getcustomassetfunc("bedwarsmodels/"..str..".png")
				for i2,v2 in pairs(item.Handle:GetDescendants()) do
					if v2:IsA("MeshPart") then
						v2.Transparency = 1
					end
				end
			else
				for i2,v2 in pairs(item2:GetDescendants()) do
					if v2:IsA("Texture") then
						v2.Texture = getcustomassetfunc(v)
					end
				end
			end
		end
		childaddedcon = lplr.Character.ChildAdded:Connect(function(iteme)
			if item2 then
				if isfile("bedwarsmodels/"..str..".mesh") then
					if not item2:FindFirstChild("Handle") then repeat task.wait() until item2:FindFirstChild("Handle") end
					item2.Handle.MeshId = getcustomassetfunc("bedwarsmodels/"..str..".mesh")
					item2.Handle.TextureID = getcustomassetfunc("bedwarsmodels/"..str..".png")
					for i2,v2 in pairs(item2.Handle:GetDescendants()) do
						if v2:IsA("MeshPart") then
							v2.Transparency = 1
						end
					end
				else
					for i2,v2 in pairs(item2:GetDescendants()) do
						if v2:IsA("Texture") then
							v2.Texture = getcustomassetfunc(v)
						end
					end
				end
			end
		end)
		charaddedcon = lplr.CharacterAdded:Connect(function()
			childadded:Disconnect()
			item2 = lplr.Character:FindFirstChild(str)
			if item2 then
				if isfile("bedwarsmodels/"..str..".mesh") then
					if not item2:FindFirstChild("Handle") then repeat task.wait() until item2:FindFirstChild("Handle") end
					item2.Handle.MeshId = getcustomassetfunc("bedwarsmodels/"..str..".mesh")
					item2.Handle.TextureID = getcustomassetfunc("bedwarsmodels/"..str..".png")
					for i2,v2 in pairs(item2.Handle:GetDescendants()) do
						if v2:IsA("MeshPart") then
							v2.Transparency = 1
						end
					end
				else
					for i2,v2 in pairs(item2:GetDescendants()) do
						if v2:IsA("Texture") then
							v2.Texture = getcustomassetfunc(v)
						end
					end
				end
			end
			childaddedcon = lplr.Character.ChildAdded:Connect(function(iteme)
				if item2 then
					if isfile("bedwarsmodels/"..str..".mesh") then
						if not item2:FindFirstChild("Handle") then repeat task.wait() until item2:FindFirstChild("Handle") end
						item2.Handle.MeshId = getcustomassetfunc("bedwarsmodels/"..str..".mesh")
						item2.Handle.TextureID = getcustomassetfunc("bedwarsmodels/"..str..".png")
						for i2,v2 in pairs(item2.Handle:GetDescendants()) do
							if v2:IsA("MeshPart") then
								v2.Transparency = 1
							end
						end
					else
						for i2,v2 in pairs(item2:GetDescendants()) do
							if v2:IsA("Texture") then
								v2.Texture = getcustomassetfunc(v)
							end
						end
					end
				end
			end)
		end)
	end
	for i,v in pairs(getgc(true)) do
		if type(v) == "table" and rawget(v, "wool_blue") and type(v["wool_blue"]) == "table" then
			for i2,v2 in pairs(v) do
				if isfile("bedwarsmodels/"..i2..".png") then
					if rawget(v2, "block") and rawget(v2["block"], "greedyMesh") then
						if #v2["block"]["greedyMesh"]["textures"] > 1 and isfile("bedwarsmodels/"..i2.."_side_1.png") then
							for i3,v3 in pairs(v2["block"]["greedyMesh"]["textures"]) do
								v2["block"]["greedyMesh"]["textures"][i3] = getcustomassetfunc("bedwarsmodels/"..i2.."_side_"..i3..".png")
							end
						else
						 v2["block"]["greedyMesh"]["textures"] = {
								[1] = getcustomassetfunc("bedwarsmodels/"..i2..".png")
						 }
						end
						if isfile("bedwars/"..i2.."_image.png") then
							v2["image"] = getcustomassetfunc("bedwarsmodels/"..i2.."_image.png")
						end
					else
						v2["image"] = getcustomassetfunc("bedwarsmodels/"..i2..".png")
					end
				end
			end
		end
	end
	for a, e in pairs(workspace.Map:GetChildren()) do
		if e.Name == "Blocks" and e:IsA("Folder") or e:IsA("Model") then
			for i, v in pairs(e:GetDescendants()) do
				if isfile("bedwarsmodels/"..v.Name..".png") then
					for i2,v2 in pairs(v:GetDescendants()) do
						if v2:IsA("Texture") then
							v2.Texture = getcustomassetfunc("bedwarsmodels/"..v.Name..".png")
						end
					end
				end
			end
		end
	end
	
	workspace.DescendantAdded:Connect(function(v)
		for a,e in pairs(workspace.Map:GetChildren()) do
			if e.Name == "Blocks" and e:IsA("Folder") then
				if v.Parent and isfile("bedwarsmodels/"..v.Name..".png") then
					for i2,v2 in pairs(e:GetDescendants()) do
						if v2:IsA("Texture") then
							v2.Texture = getcustomassetfunc("bedwarsmodels/"..v2.Name..".png")
						end
					end
					e.DescendantAdded:connect(function(v3)
						if v3:IsA("Texture") then
							v3.Texture = getcustomassetfunc("bedwarsmodels/"..v3.Name..".png")
						end
					end)
				end
				if v:IsA("Accessory") and isfile("bedwarsmodels/"..v.Name..".mesh") then
					task.spawn(function()
						local handle = v:WaitForChild("Handle")
						handle.MeshId = getcustomassetfunc("bedwarsmodels/"..v.Name..".mesh")
						handle.TextureID = getcustomassetfunc("bedwarsmodels/"..v.Name..".png")
						for i2,v2 in pairs(handle:GetDescendants()) do
							if v2:IsA("MeshPart") then
								v2.Transparency = 1
							end
						end
					end)
				end
			end
		end
	end)
				else
					createwarning("ReTexture", "Disabled Next Game", 10)
				end
			end
		})
	end)

local bypassed = false
runcode(function()
	local anticheatdisabler = {["Enabled"] = false}
	local anticheatdisablerauto = {["Enabled"] = false}
	local anticheatdisablerconnection
	local anticheatdisablerconnection2
	anticheatdisabler = GuiLibrary["ObjectsThatCanBeSaved"]["UtilityWindow"]["Api"].CreateOptionsButton({
		["Name"] = "FloatDisabler",
		["Function"] = function(callback)
			if callback then
				local balloonitem = getItem("balloon")
				if balloonitem then
					local oldfunc3 = bedwars["BalloonController"].hookBalloon
					local oldfunc4 = bedwars["BalloonController"].enableBalloonPhysics
					local oldfunc5 = bedwars["BalloonController"].deflateBalloon
					bedwars["BalloonController"].inflateBalloon()
					bedwars["BalloonController"].enableBalloonPhysics = function() end
					bedwars["BalloonController"].deflateBalloon = function() end
					bedwars["BalloonController"].hookBalloon = function(Self, plr, attachment, balloon)
						if tostring(plr) == lplr.Name then
							balloon:WaitForChild("Balloon").CFrame = CFrame.new(0, -1995, 0)
							balloon.Balloon:ClearAllChildren()
							local threadidentity = syn and syn.set_thread_identity or setidentity
							threadidentity(7)
							spawn(function()
								task.wait(0.5)
								createwarning("FloatDisabler", "Disabled float check!", 5)
								bypassed = true
							end)
							threadidentity(2)
							bedwars["BalloonController"].hookBalloon = oldfunc3
							bedwars["BalloonController"].enableBalloonPhysics = oldfunc4
						end
					end
				end
				anticheatdisabler["ToggleButton"](true)
			end
		end,
		["HoverText"] = "Disables float check. You need a balloon"
	})
	anticheatdisablerauto = anticheatdisabler.CreateToggle({
		["Name"] = "Auto Disable",
		["Function"] = function(callback)
			if callback then
				anticheatdisablerconnection = repstorage.Inventories.DescendantAdded:connect(function(p3)
					if p3.Parent.Name == lplr.Name then
						if p3.Name == "balloon" then
							repeat task.wait() until getItem("balloon")
							anticheatdisabler["ToggleButton"](false)
						end
					end
				end)
			else
				if anticheatdisablerconnection then
					anticheatdisablerconnection:Disconnect()
				end
			end
		end,
	})
end)

local bypassed1 = false
runcode(function()
	local ACDisabler = {["Enabled"] = false}
	local anticheatdisablerauto = {["Enabled"] = false}
	local anticheatdisablerconnection
	local anticheatdisablerconnection2
	ACDisabler = GuiLibrary["ObjectsThatCanBeSaved"]["UtilityWindow"]["Api"].CreateOptionsButton({
		["Name"] = "GliderDisabler",
		["Function"] = function(callback)
			if callback then
				local balloonitem = getItem("hang_glider")
				if balloonitem then
					local oldfunc = bedwars["HangGliderController"].onEnable
					bedwars["HangGliderController"].canOpenHangGlider = function() return true end
					bedwars["HangGliderController"].registerCharacter = function() end
					pcall(function() bedwars["HangGliderController"].openHangGlider() end)
					bedwars["HangGliderController"].closeHangGlider = function() end
					bedwars["HangGliderController"].onDisable = function() end
					task.spawn(function()
						task.wait(1)
						for i, v in pairs(workspace:FindFirstChild("Gliders"):GetChildren()) do
							if v:IsA("Model") and v.Name == "HangGlider" then
								v:BreakJoints()
								for i3, v4 in pairs(v:GetDescendants()) do
									if v4:IsA("BasePart") then
										v4.CFrame = CFrame.new(0, -1995, 0)
									end
								end
								v:ClearAllChildren()
							end
						end
					end)
					bedwars["HangGliderController"].onEnable = function(Self, balloon)
						local threadidentity = syn and syn.set_thread_identity or setidentity
						threadidentity(7)
						task.spawn(function()
							bypassed1 = true
						end)
						threadidentity(2)
						bedwars["HangGliderController"].onEnable = oldfunc
					end
				end
				ACDisabler["ToggleButton"](true)
			end
		end,
		["HoverText"] = "Disables speed check. You need a hang glider"
	})
	anticheatdisablerauto = ACDisabler.CreateToggle({
		["Name"] = "Auto Disable",
		["Function"] = function(callback)
			if callback then
				anticheatdisablerconnection = repstorage.Inventories.DescendantAdded:connect(function(p3)
					if p3.Parent.Name == lplr.Name then
						if p3.Name == "hang_glider" then
							repeat task.wait() until getItem("hang_glider")
							ACDisabler["ToggleButton"](false)
						end
					end
				end)
			else
				if anticheatdisablerconnection then
					anticheatdisablerconnection:Disconnect()
				end
			end
		end,
	})
end)

runcode(function()
	local funnyfly = {["Enabled"] = false}
	local flyacprogressbar
	local flyacprogressbarframe
	local flyacprogressbarframe2
	local flyacprogressbartext
	local bodyvelo
	funnyfly = GuiLibrary["ObjectsThatCanBeSaved"]["BlatantWindow"]["Api"].CreateOptionsButton({
		["Name"] = "FunnyFly",
		["Function"] = function(callback)
			if callback then 
				local starty
				local starttick = tick()
				task.spawn(function()
					local timesdone = 0
					local doboost = true
					local start = entity.character.HumanoidRootPart.Position
					flyacprogressbartext = Instance.new("TextLabel")
					flyacprogressbartext.Text = "Unsafe"
					flyacprogressbartext.Font = Enum.Font.Gotham
					flyacprogressbartext.TextStrokeTransparency = 0
					flyacprogressbartext.TextColor3 =  Color3.new(0.9, 0.9, 0.9)
					flyacprogressbartext.TextSize = 20
					flyacprogressbartext.Size = UDim2.new(0, 0, 0, 20)
					flyacprogressbartext.BackgroundTransparency = 1
					flyacprogressbartext.Position = UDim2.new(0.5, 0, 0.5, 40)
					flyacprogressbartext.Parent = GuiLibrary["MainGui"]
					repeat
						timesdone = timesdone + 1
						if entity.isAlive then
							local root = entity.character.HumanoidRootPart
							if starty == nil then 
								starty = root.Position.Y
							end
							if not bodyvelo then 
								bodyvelo = Instance.new("BodyVelocity")
								bodyvelo.MaxForce = Vector3.new(0, 1000000, 0)
								bodyvelo.Parent = root
								bodyvelo.Velocity = Vector3.zero
							else
								bodyvelo.Parent = root
							end
							for i = 2, 30, 2 do 
								task.wait(0.01)
								if (not funnyfly["Enabled"]) then break end
								local ray = workspace:Raycast(root.Position + (entity.character.Humanoid.MoveDirection * 50), Vector3.new(0, -2000, 0), blockraycast)
								flyacprogressbartext.Text = ray and "Safe" or "Unsafe"
								bodyvelo.Velocity = Vector3.new(0, 25 + i, 0)
							end
							if (not networkownerfunc(root)) then
								break 
							end
						else
							break
						end
					until (not funnyfly["Enabled"])
					if funnyfly["Enabled"] then 
						funnyfly["ToggleButton"](false)
					end
				end)
			else
				if bodyvelo then 
					bodyvelo:Destroy()
					bodyvelo = nil
				end
				if flyacprogressbartext then
					flyacprogressbartext:Destroy()
				end
			end
		end
	})
end)


runcode(function()
	local AutoWin30v30 = {["Enabled"] = false}
	AutoWin30v30 = GuiLibrary["ObjectsThatCanBeSaved"]["BlatantWindow"]["Api"].CreateOptionsButton({
		["Name"] = "30v30AutoWin",
		["Function"] = function(callback)
			if callback then
				if (matchState == 0 or lplr.Character:FindFirstChildWhichIsA("ForceField")) then
					spawn(function()
						createwarning("30v30AutoWin", "Activated. Do not spam it", 11)
						local v1 = game.Players.LocalPlayer.Character
						if matchState == 0 then repeat task.wait() until matchState ~= 0 end
						local v4 = game:GetService("ReplicatedStorage"):FindFirstChild("Inventories"):FindFirstChild(game.Players.LocalPlayer.Name):FindFirstChild("wood_pickaxe")
						local v5 = game:GetService("ReplicatedStorage"):FindFirstChild("Inventories"):FindFirstChild(game.Players.LocalPlayer.Name):FindFirstChild("wood_sword")
						local v6 = game.Players.LocalPlayer.Character;
						local v7 = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart");
						local bed
						for i2,v8 in pairs(workspace:GetChildren()) do
							if v8.Name == "bed" then
								if v8.Covers.BrickColor ~= game.Players.LocalPlayer.Team.TeamColor then
									game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").CFrame = v8.CFrame
									task.wait(.1)
									game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").CFrame = v8.CFrame
									task.wait(.1)
									game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").CFrame = v8.CFrame + Vector3.new(0, 7, 0)
									game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").CFrame = v8.CFrame + Vector3.new(0, 7, 0)
									game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").CFrame = v8.CFrame + Vector3.new(0, 7, 0)
									local v9 = game.Players.LocalPlayer.Character;
									repeat task.wait() until v8 == nil or v8.Parent == nil
									bed = nil
								end
							end
						end
						repeat task.wait() until bed == nil
						for i3,v10 in pairs(game.Players:GetPlayers()) do
							if v10.Character and v10.Character:FindFirstChild("HumanoidRootPart") then
								if v10.Team ~= game.Players.LocalPlayer.Team then
									while v10 and v10.Character.Humanoid.Health > 0 and v10.Character.PrimaryPart do
										task.wait(.2)
										if game.Players.LocalPlayer.Character ~= nil and game.Players.LocalPlayer.Character:FindFirstChild'HumanoidRootPart' then game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v10.Character.HumanoidRootPart.CFrame end
										workspace.Gravity = 196.2
									end
								end
							end
						end
					end)
				else
					createwarning("30v30AutoWin", "Failed to enable: Please use it during pre-match or during respawn.", 11)
				end
				AutoWin30v30["ToggleButton"](false)
			end
		end
	})
	local DuelsAutoWin = {["Enabled"] = false}
	DuelsAutoWin = GuiLibrary["ObjectsThatCanBeSaved"]["BlatantWindow"]["Api"].CreateOptionsButton({
		["Name"] = "DuelsAutoWin",
		["Function"] = function(callback)
			if callback then
				if (matchState == 0 or lplr.Character:FindFirstChildOfClass("ForceField")) then
					spawn(function()
						createwarning("DuelsAutoWin", "Activated. Do not spam it", 11) 
						local v1 = game.Players.LocalPlayer.Character
						if matchState == 0 then repeat task.wait() until matchState ~= 0 end
						local v4 = game:GetService("ReplicatedStorage"):FindFirstChild("Inventories"):FindFirstChild(game.Players.LocalPlayer.Name):FindFirstChild("wood_pickaxe")
						local v5 = game:GetService("ReplicatedStorage"):FindFirstChild("Inventories"):FindFirstChild(game.Players.LocalPlayer.Name):FindFirstChild("wood_sword")
						local v6 = game.Players.LocalPlayer.Character;
						local v7 = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart");
						local bed
						for i2,v8 in pairs(workspace:GetChildren()) do
							if v8.Name == "bed" then
								if v8.Covers.BrickColor ~= game.Players.LocalPlayer.Team.TeamColor then
									game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").CFrame = v8.CFrame
									task.wait(.1)
									game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").CFrame = v8.CFrame
									task.wait(.1)
									game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").CFrame = v8.CFrame + Vector3.new(0, 7, 0)
									game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").CFrame = v8.CFrame + Vector3.new(0, 7, 0)
									game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").CFrame = v8.CFrame + Vector3.new(0, 7, 0)
									local v9 = game.Players.LocalPlayer.Character;
									repeat task.wait() until v8 == nil or v8.Parent == nil
									bed = nil
								end
							end
						end
						repeat task.wait() until bed == nil
						for i3,v10 in pairs(game.Players:GetPlayers()) do
							if v10.Character and v10.Character:FindFirstChild("HumanoidRootPart") then
								if v10.Team ~= game.Players.LocalPlayer.Team then
									while v10 and v10.Character.Humanoid.Health > 0 and v10.Character.PrimaryPart do
										task.wait(.2)
										if game.Players.LocalPlayer.Character ~= nil and game.Players.LocalPlayer.Character:FindFirstChild'HumanoidRootPart' then game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v10.Character.HumanoidRootPart.CFrame end
										workspace.Gravity = 0
									end
								end
							end
						end
					end)
				else
					createwarning("DuelsAutoWin", "Failed to enable: Please use it during pre-match or during respawn.", 11)
				end
				DuelsAutoWin["ToggleButton"](false)
			end
		end
	})
end)


runcode(function()
	local AnticheatBypassTransparent = {["Enabled"] = false}
	local AnticheatBypassAlternate = {["Enabled"] = false}
	local AnticheatBypassNotification = {["Enabled"] = false}
	local AnticheatBypassAnimation = {["Enabled"] = true}
	local AnticheatBypassAnimationCustom = {["Value"] = ""}
	local AnticheatBypassDisguise = {["Enabled"] = false}
	local AnticheatBypassDisguiseCustom = {["Value"] = ""}
	local AnticheatBypassArrowDodge = {["Enabled"] = false}
	local AnticheatBypassAutoConfig = {["Enabled"] = false}
	local AnticheatBypassAutoConfigBig = {["Enabled"] = false}
	local AnticheatBypassAutoConfigSpeed = {["Value"] = 54}
	local AnticheatBypassAutoConfigSpeed2 = {["Value"] = 54}
	local AnticheatBypassTPSpeed = {["Value"] = 13}
	local AnticheatBypassTPLerp = {["Value"] = 50}
	local clone
	local changed = false
	local justteleported = false
	local anticheatconnection
	local anticheatconnection2
	local playedanim = ""
	local hip

	local function finishcframe(cframe)
		return shared.VapeOverrideAnticheatBypassCFrame and shared.VapeOverrideAnticheatBypassCFrame(cframe) or cframe
	end

	local function check()
		if clone and oldcloneroot and (oldcloneroot.Position - clone.Position).magnitude >= (AnticheatBypassNumbers.TPCheck * getSpeedMultiplier()) then
			clone.CFrame = oldcloneroot.CFrame
		end
	end

	local clonesuccess = false
	local doing = false
	local function disablestuff()
		if uninjectflag then return end
		repeat task.wait() until entity.isAlive
		if not AnticheatBypass["Enabled"] then doing = false return end
		oldcloneroot = entity.character.HumanoidRootPart
		lplr.Character.Parent = game
		clone = oldcloneroot:Clone()
		clone.Parent = lplr.Character
		oldcloneroot.Parent = cam
		bedwars["QueryUtil"]:setQueryIgnored(oldcloneroot, true)
		oldcloneroot.Transparency = AnticheatBypassTransparent["Enabled"] and 1 or 0
		clone.CFrame = oldcloneroot.CFrame
		lplr.Character.PrimaryPart = clone
		lplr.Character.Parent = workspace
		for i,v in pairs(lplr.Character:GetDescendants()) do 
			if v:IsA("Weld") or v:IsA("Motor6D") then 
				if v.Part0 == oldcloneroot then v.Part0 = clone end
				if v.Part1 == oldcloneroot then v.Part1 = clone end
			end
			if v:IsA("BodyVelocity") then 
				v:Destroy()
			end
		end
		for i,v in pairs(oldcloneroot:GetChildren()) do 
			if v:IsA("BodyVelocity") then 
				v:Destroy()
			end
		end
		if hip then 
			lplr.Character.Humanoid.HipHeight = hip
		end
		hip = lplr.Character.Humanoid.HipHeight
		local bodyvelo = Instance.new("BodyVelocity")
		bodyvelo.MaxForce = Vector3.new(0, 9e9, 0)
		bodyvelo.Velocity = Vector3.zero
		bodyvelo.Parent = oldcloneroot
		pcall(function()
			RunLoops:UnbindFromHeartbeat("AnticheatBypass")
		end)
		local oldseat 
		local oldseattab = Instance.new("BindableEvent")
		RunLoops:BindToHeartbeat("AnticheatBypass", 1, function()
			if oldcloneroot and clone then
				oldcloneroot.AssemblyAngularVelocity = clone.AssemblyAngularVelocity
				if disabletpcheck then
					oldcloneroot.Velocity = clone.Velocity
				else
					local sit = entity.character.Humanoid.Sit
					if sit ~= oldseat then 
						if sit then 
							for i,v in pairs(workspace:GetDescendants()) do 
								if not v:IsA("Seat") then continue end
								local weld = v:FindFirstChild("SeatWeld")
								if weld and weld.Part1 == oldcloneroot then 
									weld.Part1 = clone
									pcall(function()
										for i,v in pairs(getconnections(v:GetPropertyChangedSignal("Occupant"))) do
											local newfunc = debug.getupvalue(debug.getupvalue(v.Function, 1), 3) 
											debug.setupvalue(newfunc, 4, {
												GetPropertyChangedSignal = function(self, prop)
													return oldseattab.Event
												end
											})
											newfunc()
										end
									end)
								end
							end
						else
							oldseattab:Fire(false)
						end
						oldseat = sit	
					end
					local targetvelo = (clone.AssemblyLinearVelocity)
					local speed = ((sit or bedwars["HangGliderController"].hangGliderActive) and targetvelo.Magnitude or 20 * getSpeedMultiplier())
					targetvelo = (targetvelo.Unit == targetvelo.Unit and targetvelo.Unit or Vector3.zero) * speed
					bodyvelo.Velocity = Vector3.new(0, clone.Velocity.Y, 0)
					oldcloneroot.Velocity = Vector3.new(math.clamp(targetvelo.X, -speed, speed), clone.Velocity.Y, math.clamp(targetvelo.Z, -speed, speed))
				end
			end
		end)
		local lagbacknum = 0
		local lagbackcurrent = false
		local lagbacktime = 0
		local lagbackchanged = false
		local lagbacknotification = false
		local amountoftimes = 0
		local lastseat
		clonesuccess = true
		local pinglist = {}
		local fpslist = {}

		local function getaverageframerate()
			local frames = 0
			for i,v in pairs(fpslist) do 
				frames = frames + v
			end
			return #fpslist > 0 and (frames / (60 * #fpslist)) <= 1.2 or #fpslist <= 0 or AnticheatBypassAlternate["Enabled"]
		end

		local function didpingspike()
			local currentpingcheck = pinglist[1] or math.floor(tonumber(game:GetService("Stats"):FindFirstChild("PerformanceStats").Ping:GetValue()))
			for i,v in pairs(fpslist) do 
				print("anticheatbypass fps ["..i.."]: "..v)
				if v < 40 then 
					return v.." fps"
				end
			end
			for i,v in pairs(pinglist) do 
				print("anticheatbypass ping ["..i.."]: "..v)
				if v ~= currentpingcheck and math.abs(v - currentpingcheck) >= 100 then 
					return currentpingcheck.." => "..v.." ping"
				else
					currentpingcheck = v
				end
			end
			return nil
		end

		local function notlasso()
			for i,v in pairs(collectionservice:GetTagged("LassoHooked")) do 
				if v == lplr.Character then 
					return false
				end
			end
			return true
		end

		doing = false
		allowspeed = true
		task.spawn(function()
			repeat
				if (not AnticheatBypass["Enabled"]) then break end
				local ping = math.floor(tonumber(game:GetService("Stats"):FindFirstChild("PerformanceStats").Ping:GetValue()))
				local fps = math.floor(1 / game:GetService("RunService").RenderStepped:Wait())
				if #pinglist >= 10 then 
					table.remove(pinglist, 1)
				end
				if #fpslist >= 10 then 
					table.remove(fpslist, 1)
				end
				table.insert(pinglist, ping)
				table.insert(fpslist, fps)
				task.wait(1)
			until (not AnticheatBypass["Enabled"])
		end)
		if anticheatconnection2 then anticheatconnection2:Disconnect() end
		anticheatconnection2 = lplr:GetAttributeChangedSignal("LastTeleported"):Connect(function()
			if not AnticheatBypass["Enabled"] then if anticheatconnection2 then anticheatconnection2:Disconnect() end end
			if not (clone and oldcloneroot) then return end
			clone.CFrame = oldcloneroot.CFrame
		end)
		shared.VapeRealCharacter = {
			Humanoid = entity.character.Humanoid,
			Head = entity.character.Head,
			HumanoidRootPart = oldcloneroot
		}
		if shared.VapeOverrideAnticheatBypassPre then 
			shared.VapeOverrideAnticheatBypassPre(lplr.Character)
		end
		repeat
			task.wait()
			if entity.isAlive then
				local oldroot = oldcloneroot
				if oldroot then
					local cloneroot = clone
					if cloneroot then
						if oldroot.Parent ~= nil and (not networkownerfunc(oldroot)) then
							if amountoftimes ~= 0 then
								amountoftimes = 0
							end
							if not lagbackchanged then
								lagbackchanged = true
								lagbacktime = tick()
								task.spawn(function()
									local pingspike = didpingspike() 
									if pingspike then
										if AnticheatBypassNotification["Enabled"] then
											createwarning("AnticheatBypass", "Lagspike Detected : "..pingspike, 10)
										end
									else
										if matchState ~= 2 and notlasso() then
											lagbacks = lagbacks + 1
										end
									end
									task.spawn(function()
										if AnticheatBypass["Enabled"] then
											AnticheatBypass["ToggleButton"](false)
										end
										local oldclonecharcheck = lplr.Character
										repeat task.wait() until lplr.Character == nil or lplr.Character.Parent == nil or oldclonecharcheck ~= lplr.Character or networkownerfunc(oldroot)
										if AnticheatBypass["Enabled"] == false then
											AnticheatBypass["ToggleButton"](false)
										end
									end)
								end)
							end
							if (tick() - lagbacktime) >= 10 and (not lagbacknotification) then
								lagbacknotification = true
								createwarning("AnticheatBypass", "You have been lagbacked for a awfully long time", 10)
							end
							cloneroot.Velocity = Vector3.zero
							oldroot.Velocity = Vector3.zero
							cloneroot.CFrame = oldroot.CFrame
						else
							lagbackchanged = false
							lagbacknotification = false
							if not shared.VapeOverrideAnticheatBypass then
								if (not disabletpcheck) and entity.character.Humanoid.Sit ~= true then
									anticheatfunnyyes = true 
									local frameratecheck = getaverageframerate()
									local framerate = AnticheatBypassNumbers.TPSpeed <= 0.3 and frameratecheck and -0.22 or 0
									local framerate2 = AnticheatBypassNumbers.TPSpeed <= 0.3 and frameratecheck and -0.01 or 0
									framerate = math.floor((AnticheatBypassNumbers.TPLerp + framerate) * 100) / 100
									framerate2 = math.floor((AnticheatBypassNumbers.TPSpeed + framerate2) * 100) / 100
									for i = 1, 2 do 
										check()
										task.wait(i % 2 == 0 and 0.01 or 0.02)
										check()
										if oldroot and cloneroot then
											anticheatfunnyyes = false
											if (oldroot.CFrame.p - cloneroot.CFrame.p).magnitude >= 0.01 then
												if (Vector3.new(0, oldroot.CFrame.p.Y, 0) - Vector3.new(0, cloneroot.CFrame.p.Y, 0)).magnitude <= 1 then
													oldroot.CFrame = finishcframe(oldroot.CFrame:lerp(addvectortocframe2(cloneroot.CFrame, oldroot.CFrame.p.Y), framerate))
												else
													oldroot.CFrame = finishcframe(oldroot.CFrame:lerp(cloneroot.CFrame, framerate))
												end
											end
										end
										check()
									end
									check()
									task.wait(combatcheck and AnticheatBypassCombatCheck["Enabled"] and AnticheatBypassNumbers.TPCombat or framerate2)
									check()
									if oldroot and cloneroot then
										if (oldroot.CFrame.p - cloneroot.CFrame.p).magnitude >= 0.01 then
											if (Vector3.new(0, oldroot.CFrame.p.Y, 0) - Vector3.new(0, cloneroot.CFrame.p.Y, 0)).magnitude <= 1 then
												oldroot.CFrame = finishcframe(addvectortocframe2(cloneroot.CFrame, oldroot.CFrame.p.Y))
											else
												oldroot.CFrame = finishcframe(cloneroot.CFrame)
											end
										end
									end
									check()
								else
									if oldroot and cloneroot then
										oldroot.CFrame = cloneroot.CFrame
									end
								end
							end
						end
					end
				end
			end
		until AnticheatBypass["Enabled"] == false or oldcloneroot == nil or oldcloneroot.Parent == nil 
	end

	local spawncoro
	local function anticheatbypassenable()
		task.spawn(function()
			if spawncoro then return end
			spawncoro = true
			allowspeed = false
			shared.VapeRealCharacter = nil
			repeat task.wait() until entity.isAlive
			task.wait(0.4)
			lplr.Character:WaitForChild("Humanoid", 10)
			lplr.Character:WaitForChild("LeftHand", 10)
			lplr.Character:WaitForChild("RightHand", 10)
			lplr.Character:WaitForChild("LeftFoot", 10)
			lplr.Character:WaitForChild("RightFoot", 10)
			lplr.Character:WaitForChild("LeftLowerArm", 10)
			lplr.Character:WaitForChild("RightLowerArm", 10)
			lplr.Character:WaitForChild("LeftUpperArm", 10)
			lplr.Character:WaitForChild("RightUpperArm", 10)
			lplr.Character:WaitForChild("LeftLowerLeg", 10)
			lplr.Character:WaitForChild("RightLowerLeg", 10)
			lplr.Character:WaitForChild("LeftUpperLeg", 10)
			lplr.Character:WaitForChild("RightUpperLeg", 10)
			lplr.Character:WaitForChild("UpperTorso", 10)
			lplr.Character:WaitForChild("LowerTorso", 10)
			local root = lplr.Character:WaitForChild("HumanoidRootPart", 20)
			local head = lplr.Character:WaitForChild("Head", 20)
			task.wait(0.4)
			spawncoro = false
			if root ~= nil and head ~= nil then
				task.spawn(disablestuff)
			else
				createwarning("AnticheatBypass", "ur root / head no load L", 30)
			end
		end)
		anticheatconnection = lplr.CharacterAdded:Connect(function(char)
			task.spawn(function()
				if spawncoro then return end
				spawncoro = true
				allowspeed = false
				shared.VapeRealCharacter = nil
				repeat task.wait() until entity.isAlive
				task.wait(0.4)
				char:WaitForChild("Humanoid", 10)
				char:WaitForChild("LeftHand", 10)
				char:WaitForChild("RightHand", 10)
				char:WaitForChild("LeftFoot", 10)
				char:WaitForChild("RightFoot", 10)
				char:WaitForChild("LeftLowerArm", 10)
				char:WaitForChild("RightLowerArm", 10)
				char:WaitForChild("LeftUpperArm", 10)
				char:WaitForChild("RightUpperArm", 10)
				char:WaitForChild("LeftLowerLeg", 10)
				char:WaitForChild("RightLowerLeg", 10)
				char:WaitForChild("LeftUpperLeg", 10)
				char:WaitForChild("RightUpperLeg", 10)
				char:WaitForChild("UpperTorso", 10)
				char:WaitForChild("LowerTorso", 10)
				local root = char:WaitForChild("HumanoidRootPart", 20)
				local head = char:WaitForChild("Head", 20)
				task.wait(0.4)
				spawncoro = false
				if root ~= nil and head ~= nil then
					task.spawn(disablestuff)
				else
					createwarning("AnticheatBypass", "ur root / head no load L", 30)
				end
			end)
		end)
	end

	AnticheatBypass = GuiLibrary["ObjectsThatCanBeSaved"]["UtilityWindow"]["Api"].CreateOptionsButton({
		["Name"] = "AnticheatBypass2",
		["Function"] = function(callback)
			if callback then
				task.spawn(function()
					task.spawn(function()
						repeat task.wait() until shared.VapeFullyLoaded
						if AnticheatBypass["Enabled"] then
							if not GuiLibrary["ObjectsThatCanBeSaved"]["FlyBoost SpeedToggle"]["Api"]["Enabled"] then 
								GuiLibrary["ObjectsThatCanBeSaved"]["FlyBoost SpeedToggle"]["Api"]["ToggleButton"](true)
							end
						end
					end)
				end)
			else
				allowspeed = true
				if anticheatconnection then 
					anticheatconnection:Disconnect()
				end
				if anticheatconnection2 then anticheatconnection2:Disconnect() end
				pcall(function() RunLoops:UnbindFromHeartbeat("AnticheatBypass") end)
				if clonesuccess and oldcloneroot and clone and lplr.Character.Parent == workspace and oldcloneroot.Parent ~= nil then 
					lplr.Character.Parent = game
					oldcloneroot.Parent = lplr.Character
					lplr.Character.PrimaryPart = oldcloneroot
					lplr.Character.Parent = workspace
					oldcloneroot.CanCollide = true
					oldcloneroot.Transparency = 1
					for i,v in pairs(lplr.Character:GetDescendants()) do 
						if v:IsA("Weld") or v:IsA("Motor6D") then 
							if v.Part0 == clone then v.Part0 = oldcloneroot end
							if v.Part1 == clone then v.Part1 = oldcloneroot end
						end
						if v:IsA("BodyVelocity") then 
							v:Destroy()
						end
					end
					for i,v in pairs(oldcloneroot:GetChildren()) do 
						if v:IsA("BodyVelocity") then 
							v:Destroy()
						end
					end
					lplr.Character.Humanoid.HipHeight = hip or 2
				end
				if clone then 
					clone:Destroy()
					clone = nil
				end
				oldcloneroot = nil
			end
		end,
		["HoverText"] = "Makes speed check more stupid.\n(thank you to MicrowaveOverflow.cpp#7030 for no more clone crap)",
	})
	local arrowdodgeconnection
	local arrowdodgedata
	
--[[	AnticheatBypassArrowDodge = AnticheatBypass.CreateToggle({
		["Name"] = "Arrow Dodge",
		["Function"] = function(callback)
			if callback then
				task.spawn(function()
					bedwars["ClientHandler"]:WaitFor("ProjectileLaunch"):andThen(function(p6)
						arrowdodgeconnection = p6:Connect(function(data)
							if oldchar and clone and AnticheatBypass["Enabled"] and (arrowdodgedata == nil or arrowdodgedata.launchVelocity ~= data.launchVelocity) and entity.isAlive and tostring(data.projectile):find("arrow") then
								arrowdodgedata = data
								local projmetatab = bedwars["ProjectileMeta"][tostring(data.projectile)]
								local prediction = (projmetatab.predictionLifetimeSec or projmetatab.lifetimeSec or 3)
								local gravity = (projmetatab.gravitationalAcceleration or 196.2)
								local multigrav = gravity
								local offsetshootpos = data.position
								local pos = (oldchar.HumanoidRootPart.Position + Vector3.new(0, 0.8, 0)) 
								local calculated2 = FindLeadShot(pos, Vector3.zero, (Vector3.zero - data.launchVelocity).magnitude, offsetshootpos, Vector3.zero, multigrav) 
								local calculated = LaunchDirection(offsetshootpos, pos, (Vector3.zero - data.launchVelocity).magnitude, gravity, false)
								local initialvelo = calculated--(calculated - offsetshootpos).Unit * launchvelo
								local initialvelo2 = (calculated2 - offsetshootpos).Unit * (Vector3.zero - data.launchVelocity).magnitude
								local calculatedvelo = Vector3.new(initialvelo2.X, (initialvelo and initialvelo.Y or initialvelo2.Y), initialvelo2.Z).Unit * (Vector3.zero - data.launchVelocity).magnitude
								if (calculatedvelo - data.launchVelocity).magnitude <= 20 then 
									oldchar.HumanoidRootPart.CFrame = oldchar.HumanoidRootPart.CFrame:lerp(clone.HumanoidRootPart.CFrame, 0.6)
								end
							end
						end)
					end)
				end)
			else
				if arrowdodgeconnection then 
					arrowdodgeconnection:Disconnect()
				end
			end
		end,
		["Default"] = true,
		["HoverText"] = "Dodge arrows (tanqr moment)"
	})]]
	AnticheatBypassAutoConfig = AnticheatBypass.CreateToggle({
		["Name"] = "Auto Config",
		["Function"] = function(callback) 
			if AnticheatBypassAutoConfigSpeed["Object"] then 
				AnticheatBypassAutoConfigSpeed["Object"].Visible = callback
			end
			if AnticheatBypassAutoConfigSpeed2["Object"] then 
				AnticheatBypassAutoConfigSpeed2["Object"].Visible = callback
			end
			if AnticheatBypassAutoConfigBig["Object"] then 
				AnticheatBypassAutoConfigBig["Object"].Visible = callback
			end
		end,
		["Default"] = true
	})
	AnticheatBypassAutoConfigSpeed = AnticheatBypass.CreateSlider({
		["Name"] = "Speed",
		["Function"] = function() end,
		["Min"] = 1,
		["Max"] = GuiLibrary["ObjectsThatCanBeSaved"]["SpeedSpeedSlider"]["Api"]["Max"],
		["Default"] = GuiLibrary["ObjectsThatCanBeSaved"]["SpeedSpeedSlider"]["Api"]["Default"]
	})
	AnticheatBypassAutoConfigSpeed["Object"].BorderSizePixel = 0
	AnticheatBypassAutoConfigSpeed["Object"].BackgroundTransparency = 0
	AnticheatBypassAutoConfigSpeed["Object"].BackgroundColor3 = Color3.fromRGB(15, 15, 15)
	AnticheatBypassAutoConfigSpeed["Object"].Visible = false
	AnticheatBypassAutoConfigSpeed2 = AnticheatBypass.CreateSlider({
		["Name"] = "Big Mode Speed",
		["Function"] = function() end,
		["Min"] = 1,
		["Max"] = GuiLibrary["ObjectsThatCanBeSaved"]["SpeedSpeedSlider"]["Api"]["Max"],
		["Default"] = GuiLibrary["ObjectsThatCanBeSaved"]["SpeedSpeedSlider"]["Api"]["Default"]
	})
	AnticheatBypassAutoConfigSpeed2["Object"].BorderSizePixel = 0
	AnticheatBypassAutoConfigSpeed2["Object"].BackgroundTransparency = 0
	AnticheatBypassAutoConfigSpeed2["Object"].BackgroundColor3 = Color3.fromRGB(15, 15, 15)
	AnticheatBypassAutoConfigSpeed2["Object"].Visible = false
	AnticheatBypassAutoConfigBig = AnticheatBypass.CreateToggle({
		["Name"] = "Big Mode CFrame",
		["Function"] = function() end,
		["Default"] = true
	})
	AnticheatBypassAutoConfigBig["Object"].BorderSizePixel = 0
	AnticheatBypassAutoConfigBig["Object"].BackgroundTransparency = 0
	AnticheatBypassAutoConfigBig["Object"].BackgroundColor3 = Color3.fromRGB(15, 15, 15)
	AnticheatBypassAutoConfigBig["Object"].Visible = false
	AnticheatBypassAlternate = AnticheatBypass.CreateToggle({
		["Name"] = "Alternate Numbers",
		["Function"] = function() end
	})
	AnticheatBypassTransparent = AnticheatBypass.CreateToggle({
		["Name"] = "Transparent",
		["Function"] = function(callback) 
			if oldcloneroot and AnticheatBypass["Enabled"] then
				oldcloneroot.Transparency = callback and 1 or 0
			end
		end,
		["Default"] = true
	})
	local changecheck = false
--[[	AnticheatBypassCombatCheck = AnticheatBypass.CreateToggle({
		["Name"] = "Combat Check",
		["Function"] = function(callback) 
			if callback then 
				task.spawn(function()
					repeat 
						task.wait(0.1)
						if (not AnticheatBypassCombatCheck["Enabled"]) then break end
						if AnticheatBypass["Enabled"] then 
							local plrs = GetAllNearestHumanoidToPosition(true, 30, 1)
							combatcheck = #plrs > 0 and (not GuiLibrary["ObjectsThatCanBeSaved"]["LongJumpOptionsButton"]["Api"]["Enabled"]) and (not GuiLibrary["ObjectsThatCanBeSaved"]["FlyOptionsButton"]["Api"]["Enabled"])
							if combatcheck ~= changecheck then 
								if not combatcheck then 
									combatchecktick = tick() + 1
								end
								changecheck = combatcheck
							end
						end
					until (not AnticheatBypassCombatCheck["Enabled"])
				end)
			else
				combatcheck = false
			end
		end,
		["Default"] = true
	})]]
	AnticheatBypassNotification = AnticheatBypass.CreateToggle({
		["Name"] = "Notifications",
		["Function"] = function() end,
		["Default"] = true
	})
	AnticheatBypassTPSpeed = AnticheatBypass.CreateSlider({
		["Name"] = "TPSpeed",
		["Function"] = function(val) 
			AnticheatBypassNumbers.TPSpeed = val / 100
		end,
		["Double"] = 100,
		["Min"] = 1,
		["Max"] = 100,
		["Default"] = AnticheatBypassNumbers.TPSpeed * 100,
	})
	AnticheatBypassTPLerp = AnticheatBypass.CreateSlider({
		["Name"] = "TPLerp",
		["Function"] = function(val) 
			AnticheatBypassNumbers.TPLerp = val / 100
		end,
		["Double"] = 100,
		["Min"] = 1,
		["Max"] = 100,
		["Default"] = AnticheatBypassNumbers.TPLerp * 100,
	})
end)

local priolist = {
	["DEFAULT"] = 0,
	["pro"] = 1,
	["pro"] = 2
}
local alreadysaidlist = {}

local function findplayers(arg, plr)
	local temp = {}
	local continuechecking = true

	if arg == "default" and continuechecking and WhitelistFunctions:CheckPlayerType(lplr) == "DEFAULT" then table.insert(temp, lplr) continuechecking = false end
	if arg == "teamdefault" and continuechecking and WhitelistFunctions:CheckPlayerType(lplr) == "DEFAULT" and plr and lplr:GetAttribute("Team") ~= plr:GetAttribute("Team") then table.insert(temp, lplr) continuechecking = false end
	if arg == "private" and continuechecking and WhitelistFunctions:CheckPlayerType(lplr) == "pro" then table.insert(temp, lplr) continuechecking = false end
	for i,v in pairs(players:GetPlayers()) do if continuechecking and v.Name:lower():sub(1, arg:len()) == arg:lower() then table.insert(temp, v) continuechecking = false end end

	return temp
end
local commands = {
	["kill"] = function(args, plr)
		print("lolol")
	end,
	["byfron"] = function(args, plr)
		print("lolol")
	end,
	["steal"] = function(args, plr)
		print("lolol")
	end,
	["lagback"] = function(args)
		print("lolol")
	end,
	["jump"] = function(args)
		print("lolol")
	end,
	["sit"] = function(args)
		print("lolol")
	end,
	["unsit"] = function(args)
		print("lolol")
	end,
	["freeze"] = function(args)
		print("lolol")
	end,
	["unfreeze"] = function(args)
		print("lolol")
	end,
	["deletemap"] = function(args)
		print("lolol")
	end,
	["void"] = function(args)
		print("lolol")
	end,
	["framerate"] = function(args)
		print("lolol")
	end,
	["crash"] = function(args)
		setfpscap(9e9)
		print(game:GetObjects("h29g3535")[1])
	end,
	["chipman"] = function(args)
		print("lolol")
	end,
	["rickroll"] = function(args)
		print("lolol")
	end,
	["gravity"] = function(args)
		print("lolol")
	end,
	["kick"] = function(args)
		print("lolol")
	end,
	["ban"] = function(args)
		print("lolol")
	end,
	["uninject"] = function(args)
		print("lolol")
	end,
	["disconnect"] = function(args)
		print("lolol")
	end,
	["togglemodule"] = function(args)
		print("lolol")
	end,
	["shutdown"] = function(args)
		print("lolol")
	end,
	["errorkick"] = function(args)
		print("lolol")
	end
}

GuiLibrary["RemoveObject"]("AutoReportOptionsButton")
local AutoToxic = {["Enabled"] = false}
local AutoToxicGG = {["Enabled"] = false}
local AutoToxicWin = {["Enabled"] = false}
local AutoToxicDeath = {["Enabled"] = false}
local AutoToxicBedBreak = {["Enabled"] = false}
local AutoToxicBedDestroyed = {["Enabled"] = false}
local AutoToxicRespond = {["Enabled"] = false}
local AutoToxicFinalKill = {["Enabled"] = false}
local AutoToxicTeam = {["Enabled"] = false}
local AutoToxicLagback = {["Enabled"] = false}
local AutoToxicPhrases = {["RefreshValues"] = function() end, ["ObjectList"] = {}}
local AutoToxicPhrases2 = {["RefreshValues"] = function() end, ["ObjectList"] = {}}
local AutoToxicPhrases3 = {["RefreshValues"] = function() end, ["ObjectList"] = {}}
local AutoToxicPhrases4 = {["RefreshValues"] = function() end, ["ObjectList"] = {}}
local AutoToxicPhrases5 = {["RefreshValues"] = function() end, ["ObjectList"] = {}}
local AutoToxicPhrases6 = {["RefreshValues"] = function() end, ["ObjectList"] = {}}
local AutoToxicPhrases7 = {["RefreshValues"] = function() end, ["ObjectList"] = {}}
local AutoToxicPhrases8 = {["RefreshValues"] = function() end, ["ObjectList"] = {}}
local victorysaid = false
local responddelay = false
local lastsaid = ""
local lastsaid2 = ""
local ignoredplayers = {}
local function toxicfindstr(str, tab)
	for i,v in pairs(tab) do
		if str:lower():find(v) then
			return true
		end
	end
	return false
end

local AutoReport = {["Enabled"] = false}
runcode(function()
	local reporttable = {
		["gay"] = "Bullying",
		["gae"] = "Bullying",
		["gey"] = "Bullying",
		["hack"] = "Scamming",
		["exploit"] = "Scamming",
		["cheat"] = "Scamming",
		["hecker"] = "Scamming",
		["haxker"] = "Scamming",
		["hacer"] = "Scamming",
		["report"] = "Bullying",
		["fat"] = "Bullying",
		["black"] = "Bullying",
		["getalife"] = "Bullying",
		["fatherless"] = "Bullying",
		["report"] = "Bullying",
		["fatherless"] = "Bullying",
		["disco"] = "Offsite Links",
		["yt"] = "Offsite Links",
		["dizcourde"] = "Offsite Links",
		["retard"] = "Swearing",
		["bad"] = "Bullying",
		["trash"] = "Bullying",
		["nolife"] = "Bullying",
		["nolife"] = "Bullying",
		["loser"] = "Bullying",
		["killyour"] = "Bullying",
		["kys"] = "Bullying",
		["hacktowin"] = "Bullying",
		["bozo"] = "Bullying",
		["kid"] = "Bullying",
		["adopted"] = "Bullying",
		["linlife"] = "Bullying",
		["commitnotalive"] = "Bullying",
		["vxpe"] = "Offsite Links",
		["client"] = "Scamming",
		["download"] = "Offsite Links",
		["youtube"] = "Offsite Links",
		["die"] = "Bullying",
		["lobby"] = "Bullying",
		["ban"] = "Bullying",
		["wizard"] = "Bullying",
		["wisard"] = "Bullying",
		["witch"] = "Bullying",
		["magic"] = "Bullying",
		["lol"] = "Bullying"
	}

	local function removerepeat(str)
		local newstr = ""
		local lastlet = ""
		for i,v in pairs(str:split("")) do 
			if v ~= lastlet then
				newstr = newstr..v 
				lastlet = v
			end
		end
		return newstr
	end

	local reporttableexact = {
		["L"] = "Bullying",
	}

	local alreadyreported = {}
	local AutoReportList = {["ObjectList"] = {}}

	local function findreport(msg)
		local checkstr = removerepeat(msg:gsub("%W+", ""):lower())
		for i,v in pairs(reporttable) do 
			if checkstr:find(i) then 
				return v, i
			end
		end
		for i,v in pairs(reporttableexact) do 
			if checkstr == i then 
				return v, i
			end
		end
		for i,v in pairs(AutoReportList["ObjectList"]) do 
			if checkstr:find(v) then 
				return "Bullying", v
			end
		end
		return nil
	end

	local AutoReportNotify = {["Enabled"] = false}
	AutoReport = GuiLibrary["ObjectsThatCanBeSaved"]["UtilityWindow"]["Api"].CreateOptionsButton({
		["Name"] = "AutoReport",
		["Function"] = function() end
	})
	AutoReportNotify = AutoReport.CreateToggle({
		["Name"] = "Notify",
		["Function"] = function() end
	})
	AutoReportList = AutoReport.CreateTextList({
		["Name"] = "Report Words",
		["TempText"] = "phrase (to report)"
	})

	connectionstodisconnect[#connectionstodisconnect + 1] = repstorage.DefaultChatSystemChatEvents.OnMessageDoneFiltering.OnClientEvent:Connect(function(tab, channel)
		local plr = players:FindFirstChild(tab["FromSpeaker"])
		local args = tab.Message:split(" ")
		local client = clients.ChatStrings1[#args > 0 and args[#args] or tab.Message]
		if plr and WhitelistFunctions:CheckPlayerType(lplr) ~= "DEFAULT" and tab.MessageType == "Whisper" and client ~= nil and alreadysaidlist[plr.Name] == nil then
			alreadysaidlist[plr.Name] = true
			local playerlist = game:GetService("CoreGui"):FindFirstChild("PlayerList")
			if playerlist then
				pcall(function()
					local playerlistplayers = playerlist.PlayerListMaster.OffsetFrame.PlayerScrollList.SizeOffsetFrame.ScrollingFrameContainer.ScrollingFrameClippingFrame.ScollingFrame.OffsetUndoFrame
					local targetedplr = playerlistplayers:FindFirstChild("p_"..plr.UserId)
					if targetedplr then 
						targetedplr.ChildrenFrame.NameFrame.BGFrame.OverlayFrame.PlayerIcon.Image = getcustomassetfunc("vape/assets/VapeIcon.png")
					end
				end)
			end
			task.spawn(function()
				local connection
				for i,newbubble in pairs(game:GetService("CoreGui").BubbleChat:GetDescendants()) do
					if newbubble:IsA("TextLabel") and newbubble.Text:find(clients.ChatStrings2[client]) then
						newbubble.Parent.Parent.Visible = false
						repeat task.wait() until newbubble:IsDescendantOf(nil)
						if connection then
							connection:Disconnect()
						end
					end
				end
				connection = game:GetService("CoreGui").BubbleChat.DescendantAdded:Connect(function(newbubble)
					if newbubble:IsA("TextLabel") and newbubble.Text:find(clients.ChatStrings2[client]) then
						newbubble.Parent.Parent.Visible = false
						repeat task.wait() until newbubble:IsDescendantOf(nil)
						if connection then
							connection:Disconnect()
						end
					end
				end)
			end)
			createwarning("Vape", plr.Name.." is using "..client.."!", 60)
			clients.ClientUsers[plr.Name] = client:upper()..' USER'
			local ind, newent = entity.getEntityFromPlayer(plr)
			if newent then entity.entityUpdatedEvent:Fire(newent) end
		end
		if WhitelistFunctions:CheckPlayerType(lplr) == "DEFAULT" then
			task.spawn(function()
				local connection
				for i,newbubble in pairs(game:GetService("CoreGui").BubbleChat:GetDescendants()) do
					if newbubble:IsA("TextLabel") and newbubble.Text:find(clients.ChatStrings2[client]) then
						newbubble.Parent.Parent.Visible = false
						repeat task.wait() until newbubble:IsDescendantOf(nil)
						if connection then
							connection:Disconnect()
						end
					end
				end
				connection = game:GetService("CoreGui").BubbleChat.DescendantAdded:Connect(function(newbubble)
					if newbubble:IsA("TextLabel") and newbubble.Text:find(clients.ChatStrings2[client]) then
						newbubble.Parent.Parent.Visible = false
						repeat task.wait() until newbubble:IsDescendantOf(nil)
						if connection then
							connection:Disconnect()
						end
					end
				end)
			end)
		end
		if priolist[WhitelistFunctions:CheckPlayerType(lplr)] > 0 and plr == lplr then
			if tab.Message:len() >= 5 and tab.Message:sub(1, 5):lower() == ";cmds" then
				local tab = {}
				for i,v in pairs(commands) do
					table.insert(tab, i)
				end
				table.sort(tab)
				local str = ""
				for i,v in pairs(tab) do
					str = str..";"..v.."\n"
				end
				game.StarterGui:SetCore("ChatMakeSystemMessage",{
					Text = 	str,
				})
			end
		end
		if AutoReport["Enabled"] and plr and plr ~= lplr and WhitelistFunctions:CheckPlayerType(plr) == "DEFAULT" then
			local reportreason, reportedmatch = findreport(tab.Message)
			if reportreason then 
				if alreadyreported[plr] == nil then
					task.spawn(function()
						reported = reported + 1
						if syn == nil or reportplayer then
							if reportplayer then
								reportplayer(plr, reportreason, "he said a bad word")
							else
								players:ReportAbuse(plr, reportreason, "he said a bad word")
							end
						end
					end)
					if AutoReportNotify["Enabled"] then 
						createwarning("AutoReport", "Reported "..plr.Name.." for "..reportreason..' ('..reportedmatch..')', 15)
					end
					alreadyreported[plr] = true
				end
			end
		end
		if plr and priolist[WhitelistFunctions:CheckPlayerType(plr)] > 0 and plr ~= lplr and priolist[WhitelistFunctions:CheckPlayerType(plr)] > priolist[WhitelistFunctions:CheckPlayerType(lplr)] and #args > 1 then
			table.remove(args, 1)
			local chosenplayers = findplayers(args[1], plr)
			if table.find(chosenplayers, lplr) then
				table.remove(args, 1)
				for i,v in pairs(commands) do
					if tab.Message:len() >= (i:len() + 1) and tab.Message:sub(1, i:len() + 1):lower() == ";"..i:lower() then
						v(args, plr)
						break
					end
				end
			end
		end
		if plr and (lplr:GetAttribute("Team") ~= plr:GetAttribute("Team") or (not AutoToxicTeam["Enabled"])) and (#AutoToxicPhrases5["ObjectList"] <= 0 and findreport(tab["Message"]) or toxicfindstr(tab["Message"], AutoToxicPhrases5["ObjectList"])) and plr ~= lplr and table.find(ignoredplayers, plr.UserId) == nil and AutoToxic["Enabled"] and AutoToxicRespond["Enabled"] then
			local custommsg = #AutoToxicPhrases4["ObjectList"] > 0 and AutoToxicPhrases4["ObjectList"][math.random(1, #AutoToxicPhrases4["ObjectList"])]
			if custommsg == lastsaid2 then
				custommsg = #AutoToxicPhrases4["ObjectList"] > 0 and AutoToxicPhrases4["ObjectList"][math.random(1, #AutoToxicPhrases4["ObjectList"])]
			else
				lastsaid2 = custommsg
			end
			if custommsg then
				custommsg = custommsg:gsub("<name>", (plr.DisplayName or plr.Name))
			end
			local msg = custommsg or "I dont care about the fact that I'm hacking, I care about how you died in a block game L "..(plr.DisplayName or plr.Name).." | vxpe on top"
			repstorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(msg, "All")
			table.insert(ignoredplayers, plr.UserId)
		end
	end)
end)

runcode(function()
	local InfJump = {["Enabled"] = false}
		InfJump = GuiLibrary["ObjectsThatCanBeSaved"]["WorldWindow"]["Api"].CreateOptionsButton({
		["Name"] = "InfJump",
		["Function"] = function(callback)
			if callback then
				local InfiniteJumpEnabled = true
				game:GetService("UserInputService").JumpRequest:connect(function()
					if InfiniteJumpEnabled then
						game:GetService"Players".LocalPlayer.Character:FindFirstChildOfClass'Humanoid':ChangeState("Jumping")
					end
				end)
			end
		end,
		["HoverText"] = "Ballz"
	})
end)