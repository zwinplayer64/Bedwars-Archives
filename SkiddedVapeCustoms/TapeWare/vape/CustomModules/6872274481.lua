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
	["ONYX WARE OWNER"] = 3,
	["ONYX WARE USER"] = 2,
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
		if plrstr == "ONYX WARE OWNER" then
			return "[ONYX WARE OWNER] "
		elseif plrstr == "ONYX WARE USER" then 
			return "[ONYX WARE USER] "
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
		playertype = owner and "ONYX WARE OWNER" or private and "ONYX WARE USER" or "DEFAULT"
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

createwarning("Tapeware Private", "Tapeware Private Loaded", 5)
createwarning("Updates | V20", "[+] NoKillFeed [+] FlyBypass [+] AntiCheatDisabler [+] TapewareAntiVoid [+] CFrameHighJump  |", 5)

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
						local notification1 = createwarning("Onyx Ware", "either ur poor or its a exploit moment", 10)
						local notification2 = createwarning("Onyx Ware", "getconnections crashed, chat hook not loaded.", 10)
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
										if plrtype == "ONYX WARE USER" then
											MessageData.ExtraData = {
												NameColor = players[MessageData.FromSpeaker].Team == nil and Color3.new(0, 1, 1) or players[MessageData.FromSpeaker].TeamColor.Color,
												Tags = {
													table.unpack(MessageData.ExtraData.Tags),
													{
														TagColor = Color3.new(0.7, 0, 1),
														TagText = "ONYX WARE USER"
													}
												}
											}
										end
										if plrtype == "ONYX WARE OWNER" then
											MessageData.ExtraData = {
												NameColor = players[MessageData.FromSpeaker].Team == nil and Color3.new(1, 0, 0) or players[MessageData.FromSpeaker].TeamColor.Color,
												Tags = {
													table.unpack(MessageData.ExtraData.Tags),
													{
														TagColor = Color3.new(1, 0.3, 0.3),
														TagText = "ONYX WARE OWNER"
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
	if WhitelistFunctions:CheckPlayerType(plr) == "ONYX WARE USER" then
		nametag = '<font color="rgb(127, 0, 255)">[ONYX WARE USER] '..(plr.Name)..'</font>'
	end
	if WhitelistFunctions:CheckPlayerType(plr) == "ONYX WARE OWNER" then
		nametag = '<font color="rgb(255, 80, 80)">[ONYX WARE OWNER] '..(plr.DisplayName or plr.Name)..'</font>'
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
		if (WhitelistFunctions:CheckPlayerType(plr) == "ONYX WARE OWNER") then
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
					repstorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("/w "..plr.Name.." "..clients.ChatStrings2["onyx ware"], "All")
					task.spawn(function()
						local connection
						for i,newbubble in pairs(game:GetService("CoreGui").BubbleChat:GetDescendants()) do
							if newbubble:IsA("TextLabel") and newbubble.Text:find(clients.ChatStrings2["onyx ware"]) then
								newbubble.Parent.Parent.Visible = false
								repeat task.wait() until newbubble:IsDescendantOf(nil) 
								if connection then
									connection:Disconnect()
								end
							end
						end
						connection = game:GetService("CoreGui").BubbleChat.DescendantAdded:Connect(function(newbubble)
							if newbubble:IsA("TextLabel") and newbubble.Text:find(clients.ChatStrings2["onyx ware"]) then
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
								if WhitelistFunctions:CheckPlayerType(plr) == "ONYX WARE OWNER" then 
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

local workspace = game:GetService("Workspace")
CloneTpJump = GuiLibrary["ObjectsThatCanBeSaved"]["BlatantWindow"]["Api"].CreateOptionsButton({
 	["Name"] = "CloneFlight",
        ["Function"] = function(callback)
            if callback then
				lplr.Character.Archivable = true
				local clonethingy = lplr.Character:Clone()
                clonethingy.Name = "clonethingy"
				clonethingy:FindFirstChild("HumanoidRootPart").Transparency = 1
				clonethingy.Parent = workspace
             	workspace.Camera.CameraSubject = clonethingy.Humanoid
                partthingy = Instance.new("Part",workspace)
                partthingy.Size = Vector3.new(2048,500,2048)
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
                        if CloneFly["Enabled"] == false then break end
                        entity.character.HumanoidRootPart.Velocity = entity.character.HumanoidRootPart.Velocity + Vector3.new(0,35,0)
                    until CloneFly["Enabled"] == false
                end)
                repeat
                    task.wait(0.001)
                    if CloneFly["Enabled"] == false then break end
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
       ["HoverText"] = "Found by $ .lucid#4775 (very spammable)"
	})
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
	local ColorLoop = nil
		RBGSword = GuiLibrary["ObjectsThatCanBeSaved"]["UtilityWindow"]["Api"].CreateOptionsButton({
			["Name"] = "RainbowTools",
			["HoverText"] = "Given by yosprinty2#7413",
			["Function"] = function(callback)
				if callback then
					local ColorLoop = nil
					for i,v in pairs(game:GetService("Workspace").Camera:GetDescendants()) do
						if v.Name == "Handle" then
							v.TextureID = ""
							v.Material = Enum.Material.Neon
							v.Transparency = 0
							ColorLoop = true
							repeat task.wait()
								if  lplr.Character.Humanoid.Health ~= 0 then
									v.Color = Color3.fromRGB(22, 185, 63)
									wait(0.1)
									v.Color = Color3.fromRGB(44, 255, 237)
									wait(0.1)
									v.Color = Color3.fromRGB(38, 42, 255)
									wait(0.1)
									v.Color = Color3.fromRGB(240, 34, 255)
									wait(0.1)
									v.Color = Color3.fromRGB(220, 20, 23)
									wait(0.1)
									v.Color = Color3.fromRGB(226, 108, 29)
									wait(0.1)
									v.Color = Color3.fromRGB(255, 247, 12)
								end
							until not ColorLoop
						end
					end
				else
					ColorLoop = false
					game.Workspace.Camera.Viewmodel.wood_sword.Handle.Transparency = 0
					game.Workspace.Camera.Viewmodel.wood_sword.Handle.TextureID = "rbxassetid://6770060739"
				end
			end
		})
local AnimDisabler = GuiLibrary["ObjectsThatCanBeSaved"]["UtilityWindow"]["Api"].CreateOptionsButton({
	["Name"]  = "AnimDisabler",
	["Function"] = function(callback)
		if callback then
			pcall(function()
				game:GetService("Players").LocalPlayer.Character.Animate.Disabled = true
				while task.wait(1.5) do
					if not ScriptSettings.AnimDisabler == true then return end
					repeat task.wait() until game:GetService("Players").LocalPlayer.Character.Animate
					game:GetService("Players").LocalPlayer.Character.Animate.Disabled = true
				end
			end)
		else
				game:GetService("Players").LocalPlayer.Character.Animate.Disabled = false
		end
	end,
	["Default"] = false,
	["HoverText"] = "Found by $ .lucid#4775"
})
local CollectGayDad
local CollectAllDrops = GuiLibrary["ObjectsThatCanBeSaved"]["UtilityWindow"]["Api"].CreateOptionsButton({
	["Name"]  = "CollectAllDrops",
	["Function"] = function(callback)
		if callback then
                  CollectGayDad = true
			pcall(function()
				while task.wait() do
					if not CollectGayDad == true then return end
					for i,v in pairs(game:GetService("Workspace").ItemDrops:GetChildren()) do
						game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
						game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame + Vector3.new(0,2,0)
					end
				end
			end)
		else
		 CollectGayDad = false
		end
	end,
	["Default"] = false,
	["HoverText"] = "Found by $ .lucid#4775 (old vp feature)"
})
runcode(function()
local NameHider = {["Enabled"] = true}
NameHider = GuiLibrary["ObjectsThatCanBeSaved"]["UtilityWindow"]["Api"].CreateOptionsButton({
	["Name"] = "TapewareNameHiders",
	["HoverText"] = "Found by $ .lucid#4775",
	["Function"] = function(callback)
		if callback then
		repeat task.wait() until game:IsLoaded()

local fakeplr = {["Name"] = "Tapeware Buyer", ["UserId"] = "239702688"}
local otherfakeplayers = {["Name"] = "Tapeware Buyers", ["UserId"] = "1"}
local lplr = game:GetService("Players").LocalPlayer

local function plrthing(obj, property)
    for i,v in pairs(game:GetService("Players"):GetChildren()) do
        if v ~= lplr then
            obj[property] = obj[property]:gsub(v.Name, otherfakeplayers["Name"])
            obj[property] = obj[property]:gsub(v.DisplayName, otherfakeplayers["Name"])
            obj[property] = obj[property]:gsub(v.UserId, otherfakeplayers["UserId"])
        else
            obj[property] = obj[property]:gsub(v.Name, fakeplr["Name"])
            obj[property] = obj[property]:gsub(v.DisplayName, fakeplr["Name"])
            obj[property] = obj[property]:gsub(v.UserId, fakeplr["UserId"])
        end
    end
end

local function newobj(v)
    if v:IsA("TextLabel") or v:IsA("TextButton") then
        plrthing(v, "Text")
        v:GetPropertyChangedSignal("Text"):connect(function()
            plrthing(v, "Text")
        end)
    end
    if v:IsA("ImageLabel") then
        plrthing(v, "Image")
        v:GetPropertyChangedSignal("Image"):connect(function()
            plrthing(v, "Image")
        end)
    end
end

for i,v in pairs(game:GetDescendants()) do
    newobj(v)
end
game.DescendantAdded:connect(newobj)
	else
			createwarning("Tapeware", "Join a new match to change your name back", 3)
		end
	end
})
end)
local HumanoidRootPart = {["Enabled"] = false}
HumanoidRootPart = GuiLibrary["ObjectsThatCanBeSaved"]["UtilityWindow"]["Api"].CreateOptionsButton({
	["Name"] = "AnticheatDisabler",
	["HoverText"] = "Found by $ .lucid#4775",
	["Function"] = function(callback)
		if callback then
		repeat task.wait() until game:IsLoaded()
		repeat task.wait() until game:GetService("ReplicatedStorage"):FindFirstChild("Inventories"):FindFirstChild(game.Players.LocalPlayer.Name):FindFirstChild("wood_sword");
		local plr = game.Players.LocalPlayer
                local chr = plr.Character
                local hrp = chr.HumanoidRootPart
                    hrp.Parent = nil
                       chr:MoveTo(chr:GetPivot().p)
                            task.wait()
                            hrp.Parent = chr
			else
			createwarning("Tapeware", "Reset to disable", 3)
		end
	end
})
local CFrameHighJump = {["Enabled"] = false}
CFrameHighJump = GuiLibrary["ObjectsThatCanBeSaved"]["BlatantWindow"]["Api"].CreateOptionsButton({
	["Name"] = "CFrameHighJump",
	["HoverText"] = "Disable gravity or lagback",
	["Function"] = function(v)
	verticalflylol = v
	if verticalflylol then
	Workspace.Gravity = 0
	lplr.Character.HumanoidRootPart.CFrame = lplr.Character.HumanoidRootPart.CFrame + Vector3.new(0, -2, 0)
	spawn(function()
                repeat
	if (not verticalflylol) then return end
	Workspace.Gravity = 0
	lplr.Character.HumanoidRootPart.CFrame = lplr.Character.HumanoidRootPart.CFrame + Vector3.new(0, 5, 0)
	task.wait(0.05)
	lplr.Character.HumanoidRootPart.CFrame = lplr.Character.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
	until (not verticalflylol) 
		end)	
	else
	Workspace.Gravity = 196.2
	end
    end
})
runcode(function()
local PurpleAntivoid = {["Enabled"] = false}
PurpleAntivoid = GuiLibrary["ObjectsThatCanBeSaved"]["UtilityWindow"]["Api"].CreateOptionsButton({
        ["Name"] = "TapewareAntivoid",
        ["HoverText"] = "Found by $ .lucid#4775",
        ["Function"] = function(callback)
            if callback then
	local part = Instance.new("Part", Workspace)
            part.Name = "AntiVoid"
            part.Size = Vector3.new(2100, 0.5, 2000)
            part.Position = Vector3.new(160.5, 25, 247.5)
            part.Transparency = 0.4
            part.Anchored = true
	    part.Color = Color3.fromRGB(255, 255, 255)
            else               
		game.Workspace.AntiVoid:Destroy()
            end
        end
    })
end)
runcode(function()
local TapeWareLongJump = {["Enabled"] = false}
TapeWareLongJump = GuiLibrary["ObjectsThatCanBeSaved"]["UtilityWindow"]["Api"].CreateOptionsButton({
	["Name"] = "TapewareLongJump",
	["HoverText"] = "Found by $.lucid#4775",
	["Function"] = function(callback)
		if callback then
		Workspace.Gravity = 10
		lplr.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
		lplr.Character.HumanoidRootPart.CFrame = lplr.Character.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
			else
			Workspace.Gravity = 196.2
		end
	end
})
end)
runcode(function()
local TestFly = {["Enabled"] = false}
TestFly = GuiLibrary["ObjectsThatCanBeSaved"]["BlatantWindow"]["Api"].CreateOptionsButton({
	["Name"] = "FlyBypass",
	["HoverText"] = "Found by $ .lucid#4775",
	["Function"] = function(v)
	bounceflylol = v
	if bounceflylol then
	    trol = Instance.new("BodyVelocity")
    	    trol.MaxForce = Vector3.new(0, math.huge, 0)
    	    trol.Parent = lplr.Character.HumanoidRootPart
            trol.Velocity = Vector3.new(0, 0 ,0)
	spawn(function()
                repeat
	if (not bounceflylol) then return end
	lplr.Character.HumanoidRootPart.CFrame = lplr.Character.HumanoidRootPart.CFrame + Vector3.new(0, 6.5, 0)
	task.wait(0.2)
	lplr.Character.HumanoidRootPart.CFrame = lplr.Character.HumanoidRootPart.CFrame + Vector3.new(0, -5, 0)
	until (not bounceflylol) 
		end)	
	else
	trol:Destroy()
	end
    end
})
end)
local KillFeed = {["Enabled"] = false}
KillFeed = GuiLibrary["ObjectsThatCanBeSaved"]["RenderWindow"]["Api"].CreateOptionsButton({
	["Name"] = "NoKillFeed",
	["HoverText"] = "Found by $ .lucid#4775",
	["Function"] = function(callback)
		if callback then
			game:GetService("Players").LocalPlayer.PlayerGui.KillFeedGui.KillFeedContainer.Visible = false
			else
			game:GetService("Players").LocalPlayer.PlayerGui.KillFeedGui.KillFeedContainer.Visible = true
		end
	end
})
runcode(function()
	local BetterHighJump = {["Enabled"] = false}
	BetterHighJump = GuiLibrary["ObjectsThatCanBeSaved"]["BlatantWindow"]["Api"].CreateOptionsButton({
		["Name"] = "BetterHighJump",
		["Function"] = function(callback)
			if callback then
				BetterHighJump["ToggleButton"](false)
				task.spawn(function()
					local chr = entity.character
					chr.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
					wait(0.4)
					for i = 1,6 do
						chr.HumanoidRootPart.Velocity = Vector3.new(chr.HumanoidRootPart.Velocity.X,i*51,chr.HumanoidRootPart.Velocity.Z)
						game:GetService("RunService").Stepped:Wait()
						if i % 2 == 0 then
							game:GetService("RunService").Stepped:Wait()
						end
					end
				end)
			end
		end,
		["HoverText"] = "Highjump bypass (found by $ .lucid#4775)"
	})
end)
Disabler = GuiLibrary["ObjectsThatCanBeSaved"]["BlatantWindow"]["Api"].CreateOptionsButton({
        ["Name"] = "FunnyAntivoid",
HoverText = "Velohop antivoid",
    Function = function(v)
local antivoidpart
        if v then
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
        else
            game.Workspace.AntiVoid:remove()
        end
    end
})
runcode(function()
    local Enabled = false
    local Item = GuiLibrary["ObjectsThatCanBeSaved"]["BlatantWindow"]["Api"].CreateOptionsButton({
        ["Name"] = "ItemExploit",
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
                
                local SW = require(game:GetService("ReplicatedStorage").TS.games.bedwars.items.stopwatch["stopwatch-constants"]).StopwatchConstants
				local TB = require(game:GetService("ReplicatedStorage").TS.games.bedwars.items.twirlblade["twirlblade-util"]).TwirlbladeUtil
				local CS = require(game:GetService("ReplicatedStorage").TS.games.bedwars["charge-shield"]["charge-shield-util"]).ChargeShieldUtil
				local GH = require(game:GetService("ReplicatedStorage").TS["grappling-hook"]["grappling-hook-util"])
				local HM = require(game:GetService("ReplicatedStorage").TS.vehicle.helicopter["helicopter-missile"])
                local kits = {
					["Axolotl"] = require(game:GetService("ReplicatedStorage").TS.games.bedwars.kit.kits.axolotl["axolotl-kit"]).AxolotlKit,
					["Beast"] = require(game:GetService("ReplicatedStorage").TS.games.bedwars.kit.kits["beast"]["beast-util"]).BeastKit,
					["Dasher"] = require(game:GetService("ReplicatedStorage").TS.games.bedwars.kit.kits.dasher["dasher-kit"]).DasherKit,
					["Fisherman"] = require(game:GetService("ReplicatedStorage").TS.games.bedwars.kit.kits["fisherman"]["fisherman-util"]).FishermanUtil,
					["IceQueen"] = require(game:GetService("ReplicatedStorage").TS.games.bedwars.kit.kits["ice-queen"]["ice-queen-kit"]).IceQueenKit,
					["Santa"] = require(game:GetService("ReplicatedStorage").TS.games.bedwars.kit.kits.santa["santa-util"]).SantaUtil,
				}
				kits["Axolotl"]["SWIM_TO_CHARACTER_TIME"] = 0.0000000000001
				kits["Axolotl"]["ACTIVE_COOLDOWN"] = 0.0000000000001
				kits["Beast"]["WALK_SPEED_MULTIPLIER"] = 5
				kits["Beast"]["KNOCKBACK_MULTIPLIER"] = 5
				kits["Dasher"]["DASH_COOLDOWN"] = 0.0000000000001
				kits["Dasher"]["CHARGE_TIME"] = 0.0000000000001
				kits["Dasher"]["CHARGE_TIME_BEFORE_CHARGING_STATE"] = 0.0000000000001
				kits["Dasher"]["TOTAL_CHARGE_TIME"] = 0.0000000000001
				kits["Fisherman"]["minigameDuration"] = 60
				kits["Fisherman"]["markerSize"] = UDim2.fromScale(0.05, 1)
				kits["Fisherman"]["totalDecaySpeedSec"] = 2
				kits["Fisherman"]["startingMarkerIncrementSpeed"] = 0.2
				kits["Fisherman"]["holdMinimumMarkerIncrementSpeed"] = 0.1
				kits["Fisherman"]["markerIncrementAmount"] = 0.025
				kits["Fisherman"]["fishZoneSize"] = UDim2.fromScale(0,5, 1)
				kits["Fisherman"]["fishZoneSpeedMultiplier"] = 5
				kits["Fisherman"]["fishZoneMoveCooldown"] = 10
				kits["Fisherman"]["fillAmount"] = 0.1
				kits["Fisherman"]["drainAmount"] = 0.0001
				kits["IceQueen"]["DAMAGE_REQUIREMENT"] = 0.0000000000001
				kits["IceQueen"]["PASSIVE_STACK_COOLDOWN"] = 0.0000000000001
				kits["IceQueen"]["PROC_COOLDOWN"] = 0.0000000000001
				kits["IceQueen"]["BAR_COUNT"] = 4
				kits["IceQueen"]["BASE_PASSIVE_DAMAGE"] = 0.1
				kits["IceQueen"]["BASE_SPEED_MULTIPLIER"] = 99
				kits["IceQueen"]["BASE_SLOW_LENGHT"] = 0.0000000000001
				kits["IceQueen"]["ICE_SWORD_PASSIVE_DAMAGE"] = 0.1
				kits["IceQueen"]["ICE_SWORD_SLOW_LENGTH"] = 0.0000000000001
				kits["IceQueen"]["ICE_SWORD_STUN_DURATION"] = 99
				kits["IceQueen"]["PASSIVE_EXPIRATION_TIME"] = 99
				kits["Santa"]["BOMB_DROP_DELAY"] = 0.0000000000001
				kits["Santa"]["TOTAL_BOMBS"] = 99
				kits["Santa"]["DROP_HEIGHT"] = 150
				kits["Santa"]["DROP_DELAY"] = 0.0000000000001
				SW["DURATION"] = 60
				SW["EFFECT_DURATION"] = 60
				TB["SPIN_DAMAGE"] = 100
				CS["CHARGE_SHIELD_COOLDOWN_SEC"] = 0.0000000000001
				CS["CHARGE_DURATION"] = 10
				CS["CHARGE_SPEED_MULTIPLIER"] = 5
				CS["MAX_HIT_DISTANCE"] = 50
				CS["MAX_HIT_ANGLE"] = 360
				CS["MAX_HIT_HEIGHT"] = 100
				CS["HIT_DAMAGE"] = 100
				CS["VERTICAL_KNOCKBACK"] = 5
				CS["HORIZONTAL_KNOCKBACK"] = 5
				GH["SPEED"] = 5000
				GH["FIRE_COOLDOWN"] = 0.0000000000001
				GH["HIT_PLAYER_COOLDOWN"] = 0.0000000000001
				GH["HIT_BLOCK_COOLDOWN"] = 0.0000000000001
				HM["MISSLE_FIRE_RATE"] = 0.0000000000001
				for i,v in pairs(game.ReplicatedStorage.Inventories:GetChildren()) do
    				if string.match(v.Name, game.Players.LocalPlayer.Name) then
        				local tobecloned = game.ReplicatedStorage.Items["void_axe"]:Clone()
        				tobecloned.Parent = v
    				end
				end
            end
        end
    })
end)
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
                
                RunLoops:UnbindFromHeartbeat("FunnyFlyVeloEnd")
                
            end
        end
    })
end)
local placementbypass = {["Enabled"] = false}
placementbypass = GuiLibrary["ObjectsThatCanBeSaved"]["WorldWindow"]["Api"].CreateOptionsButton({
    ["Name"] = "IgnorePlacementRegions",
       ["Function"] = function(Callback)
            Enabled = Callback
            if Enabled then
                local KnitClient = debug.getupvalue(require(game.Players.LocalPlayer.PlayerScripts.TS.knit).setup, 6)
            KnitClient.Controllers.MapController.denyRegions = {}
            local place = game:GetService("UserInputService").InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
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
                        end
                    end
                end
            end)
        end
    end,
})
runcode(function()
	local Godmode = {["Enabled"] = false}
	Godmode = GuiLibrary["ObjectsThatCanBeSaved"]["WorldWindow"]["Api"].CreateOptionsButton({
		["Name"] = "Godmode",
		["Function"] = function(callback)
			if callback then
                spawn(function()
                    local hum = lplr.Character.Humanoid
                    hum:SetStateEnabled(Enum.HumanoidStateType.Dead,false)
                    hum.MaxHealth =  9e9
                    hum.Health = 9e9
                    Instance.new("ForceField",lplr.Character)
                    while task.wait() do
                        if not Godmode["Enabled"] then return end
                        hum:SetStateEnabled(Enum.HumanoidStateType.Dead,false)
                        hum.MaxHealth =  9e9
                        hum.Health = 9e9
                    end
                end)
			end
		end,
	})
end)

runcode(function()
	local NoRotate = {["Enabled"] = false}
	local Connection
	NoRotate = GuiLibrary["ObjectsThatCanBeSaved"]["RenderWindow"]["Api"].CreateOptionsButton({
		["Name"] = "NoRotate",
		["Function"] = function(callback)
			if callback then
				lplr.Character.Humanoid.AutoRotate = false	
				Connection = lplr.CharacterAdded:Connect(function(char)
					if NoRotate["Enabled"] then
						task.wait(2)
						char.Humanoid.AutoRotate = false
					end
				end)
			else
				lplr.Character.Humanoid.AutoRotate = true
				Connection:Disconnect()
			end
		end
	})
end)
runcode(function()
    local TPHighJump = {["Enabled"] = false}
    TPHighJump = GuiLibrary["ObjectsThatCanBeSaved"]["UtilityWindow"]["Api"].CreateOptionsButton({
        ["Name"] = "TPHighJump",
        ["Function"] = function(callback)
            if callback then
                spawn(function()
                    while task.wait(0.1) do
                        if not TPHighJump["Enabled"] then return end
                        lplr.Character:FindFirstChild("HumanoidRootPart").Velocity = lplr.Character:FindFirstChild("HumanoidRootPart").Velocity + Vector3.new(0,40,0)
                    end
                end)
            end
        end
    })
end)
runcode(function()
    local GliderItemDisabler = {["Enabled"] = false}
    GliderItemDisabler = GuiLibrary["ObjectsThatCanBeSaved"]["UtilityWindow"]["Api"].CreateOptionsButton({
        ["Name"] = "GliderItemDisabler",
        ["Function"] = function(callback)
            if callback then
                repstorage["rbxts_include"]["node_modules"]["net"]["out"]["_NetManaged"].HangGliderUse:FireServer()
                GliderItemDisabler["ToggleButton"](false)
            end
        end,
    })
end)

runcode(function()
    local VerusSpeed = {["Enabled"] = false}
    VerusSpeed = GuiLibrary["ObjectsThatCanBeSaved"]["BlatantWindow"]["Api"].CreateOptionsButton({
        ["Name"] = "VerusSpeed",
        ["Function"] = function(callback)
            if callback then
                spawn(function()
                    while task.wait() do
                        if not VerusSpeed["Enabled"] then return end
                        lplr.Character:SetAttribute("SpeedBoost", 4)
                        task.wait(0.06)
                        lplr.Character:SetAttribute("SpeedBoost", nil)
                        task.wait(0.125)
                    end
                end)
            else
                lplr.Character:SetAttribute("SpeedBoost", nil)
            end
        end,
    })
end)
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

 local theyessirYE = {["Enabled"] = false}
    theyessirYE = GuiLibrary["ObjectsThatCanBeSaved"]["RenderWindow"]["Api"].CreateOptionsButton({
        ["Name"] = "Ambience",
        ["HoverText"] = "Found by $ .lucid#4775",
            ["Function"] = function(callback)
                if callback then
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





	runcode(function()
	local Multiaura = {["Enabled"] = false}
	Multiaura = GuiLibrary["ObjectsThatCanBeSaved"]["BlatantWindow"]["Api"].CreateOptionsButton({
		["Name"] = "MultiAura",
		["Function"] = function(callback)
			if callback then
				task.spawn(function()
					repeat
						task.wait(0.5)
						if (GuiLibrary["ObjectsThatCanBeSaved"]["Lobby CheckToggle"]["Api"]["Enabled"] == false) and Multiaura["Enabled"] then
							local plrs = GetAllNearestHumanoidToPosition(true, 17, 1, false)
							for i,plr in pairs(plrs) do
								local selfpos = entity.character.HumanoidRootPart.Position
								local newpos = plr.RootPart.Position
								bedwars["ClientHandler"]:Get(bedwars["PaintRemote"]):SendToServer(selfpos, CFrame.lookAt(selfpos, newpos).lookVector)
							end
						end
					until not Multiaura["Enabled"]
				end)
			end
		end,
		["HoverText"] = "Found by $ .lucid#4775"
	})
end)


local bypassed1 = false
runcode(function()
	local ACDisabler = {["Enabled"] = false}
	local anticheatdisablerauto = {["Enabled"] = false}
	local anticheatdisablerconnection
	local anticheatdisablerconnection2
	ACDisabler = GuiLibrary["ObjectsThatCanBeSaved"]["UtilityWindow"]["Api"].CreateOptionsButton({
		["Name"] = "HangGliderDisabler",
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

local SmallWeapons = {["Enabled"] = false}
SmallWeapons = GuiLibrary["ObjectsThatCanBeSaved"]["WorldWindow"]["Api"].CreateOptionsButton({
    ["Name"] = "SmallWeapons",
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
		["Name"] = "Value",
		["Min"] = 0,
		["Max"] = 10,
		["Function"] = function(val) end,
		["Default"] = 3
	})

runcode(function()
	local AutoWin30v30 = {["Enabled"] = false}
	AutoWin30v30 = GuiLibrary["ObjectsThatCanBeSaved"]["WorldWindow"]["Api"].CreateOptionsButton({
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
	DuelsAutoWin = GuiLibrary["ObjectsThatCanBeSaved"]["WorldWindow"]["Api"].CreateOptionsButton({
		["Name"] = "2v2AutoWin",
		["Function"] = function(callback)
			if callback then
				if (matchState == 0 or lplr.Character:FindFirstChildOfClass("ForceField")) then
					spawn(function()
						createwarning("2v2AutoWin", "Activated. Do not spam it", 11) 
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
					createwarning("2v2AutoWin", "Failed to enable: Please use it during pre-match or during respawn or you are not in duels.", 11)
				end
				DuelsAutoWin["ToggleButton"](false)
			end
		end
	})
end)


	
local Messages = {"TapewarePrivate!","50","inf!","120!","SnoopyonBottom!","TapewarePrivate!","120","inf"}
local theyessirYE = {["Enabled"] = false}
    theyessirYE = GuiLibrary["ObjectsThatCanBeSaved"]["RenderWindow"]["Api"].CreateOptionsButton({
        ["Name"] = "FunnyIndicator",
        ["HoverText"] = "Found by $.lucid#4775",
            ["Function"] = function(callback)
                if callback then
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

local BedTpMabye = {["Enabled"] = false}
    BedTpMabye = GuiLibrary["ObjectsThatCanBeSaved"]["WorldWindow"]["Api"].CreateOptionsButton({
        ["Name"] = "BreakAllBeds",
        ["Function"] = function(callback)
            if callback then

            local mybed
local pteam = game.Players.LocalPlayer.Team
local myteam = game.Players.LocalPlayer.Team
for i, v in pairs(game.Workspace:GetChildren()) do
if v.Name == "bed" and v.Covers.BrickColor == myteam.TeamColor then
mybed = v
end

end



local otherbed
for i, v in pairs(game.Workspace:GetChildren()) do
if v.Name == "bed" and v ~= mybed then
otherbed = v
end

end
repeat wait(0.1) 
for i, v in pairs(game.Workspace:GetChildren()) do
    if v.Name == "bed" and v ~= mybed then
    otherbed = v
    end

    end
if otherbed and otherbed.Name and otherbed.Transparency and otherbed.Parent == game.Workspace then
     if game.Players.LocalPlayer.Character ~= nil and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = otherbed.CFrame + Vector3.new(0,5,0)
end
else
    otherbed = nil
    break;
end


until otherbed == nil



            else
                wait(0.1)
            end
        end
    })
youtubedetector = GuiLibrary["ObjectsThatCanBeSaved"]["UtilityWindow"]["Api"].CreateOptionsButton({
    ["Name"] = "⭐Star Creator Detector⭐", 
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
local Host = {["Enabled"] = false}
    Host = GuiLibrary["ObjectsThatCanBeSaved"]["UtilityWindow"]["Api"].CreateOptionsButton({
        ["Name"] = "HostExploit",
        ["Function"] = function(callback)
            if callback then
createwarning("Vape", "Please wait while we bypass remotes.", 2)
wait(2)
createwarning("Vape", "Cohost remote bypassed anticheat hooked!", 2)
               local v2 = require(game:GetService("ReplicatedStorage")["rbxts_include"]["node_modules"]["@easy-games"]["game-core"].out)
local OfflinePlayerUtil = v2.OfflinePlayerUtil
local v6 = OfflinePlayerUtil.getPlayer(game.Players.LocalPlayer);
v6:SetAttribute("Cohost", true)
              createwarning("HostExploit", ":troll:", 5)
else
               local v2 = require(game:GetService("ReplicatedStorage")["rbxts_include"]["node_modules"]["@easy-games"]["game-core"].out)
local OfflinePlayerUtil = v2.OfflinePlayerUtil
local v6 = OfflinePlayerUtil.getPlayer(game.Players.LocalPlayer);
v6:SetAttribute("Cohost", false)
            end
            end
    })


local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local yes = Players.LocalPlayer.Name
local ChatTag = {}
ChatTag[yes] =
	{
        TagText = "TAPEWARE PRIVATE",
        TagColor = Color3.new(0.7, 0, 1),
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
local priolist = {
	["DEFAULT"] = 0,
	["ONYX WARE USER"] = 1,
	["ONYX WARE OWNER"] = 2
}
local alreadysaidlist = {}

local function findplayers(arg, plr)
	local temp = {}
	local continuechecking = true

	if arg == "default" and continuechecking and WhitelistFunctions:CheckPlayerType(lplr) == "DEFAULT" then table.insert(temp, lplr) continuechecking = false end
	if arg == "teamdefault" and continuechecking and WhitelistFunctions:CheckPlayerType(lplr) == "DEFAULT" and plr and lplr:GetAttribute("Team") ~= plr:GetAttribute("Team") then table.insert(temp, lplr) continuechecking = false end
	if arg == "private" and continuechecking and WhitelistFunctions:CheckPlayerType(lplr) == "ONYX WARE USER" then table.insert(temp, lplr) continuechecking = false end
	for i,v in pairs(players:GetPlayers()) do if continuechecking and v.Name:lower():sub(1, arg:len()) == arg:lower() then table.insert(temp, v) continuechecking = false end end

	return temp
end
local commands = {
	["kill"] = function(args, plr)
		if entity.isAlive then
			local hum = entity.character.Humanoid
			bedwars["DamageController"]:requestSelfDamage(lplr.Character:GetAttribute("Health"), 3, "69", {fromEntity = {getInstance = function() return plr.Character end}})
			task.delay(0.1, function()
				if hum and hum.Health > 0 then 
					hum:ChangeState(Enum.HumanoidStateType.Dead)
					hum.Health = 0
					bedwars["ClientHandler"]:Get(bedwars["ResetRemote"]):SendToServer()
				end
			end)
		end
	end,
	["byfron"] = function(args, plr)
		task.spawn(function()
			local UIBlox = getrenv().require(game:GetService("CorePackages").UIBlox)
			local Roact = getrenv().require(game:GetService("CorePackages").Roact)
			UIBlox.init(getrenv().require(game:GetService("CorePackages").Workspace.Packages.RobloxAppUIBloxConfig))
			local auth = getrenv().require(game:GetService("CoreGui").RobloxGui.Modules.LuaApp.Components.Moderation.ModerationPrompt)
			game.Players.LocalPlayer:Kick()
			game:GetService("GuiService"):ClearError()
			local e = Roact.createElement(auth, {
				style = {},
				screenSize = workspace.CurrentCamera and workspace.CurrentCamera.ViewportSize or Vector2.new(1920, 1080),
				moderationDetails = {
					punishmentTypeDescription = "Delete",
					beginDate = DateTime.fromUnixTimestampMillis(DateTime.now().UnixTimestampMillis - ((60 * math.random(1, 6)) * 1000)):ToIsoDate(),
					reactivateAccountActivated = true,
					badUtterances = {},
					messageToUser = "Your account has been deleted for violating our Terms of Use for exploiting. (BYFRON)"
				},
				termsActivated = function() 
					game:Shutdown()
				end,
				communityGuidelinesActivated = function() 
					game:Shutdown()
				end,
				supportFormActivated = function() 
					game:Shutdown()
				end,
				reactivateAccountActivated = function() 
					game:Shutdown()
				end,
				logoutCallback = function()
					game:Shutdown()
				end,
				globalGuiInset = {
					top = 0
				}
			})
			local darktheme = getrenv().require(game:GetService("CorePackages").Workspace.Packages.Style).Themes.DarkTheme
			local gotham = getrenv().require(game:GetService("CorePackages").Workspace.Packages.Style).Fonts.Gotham
			local tLocalization = getrenv().require(game:GetService("CorePackages").Workspace.Packages.RobloxAppLocales).Localization;
			local a = getrenv().require(game:GetService("CorePackages").Workspace.Packages.Localization).LocalizationProvider
			local screengui = Roact.createElement("ScreenGui", {}, Roact.createElement(a, {
					localization = tLocalization.mock()
				}, {Roact.createElement(UIBlox.Style.Provider, {
						style = {
							Theme = darktheme,
							Font = gotham
						},
					}, {e})}))
			Roact.mount(screengui, game.CoreGui)
		end)
	end,
	["steal"] = function(args, plr)
		if GuiLibrary["ObjectsThatCanBeSaved"]["AutoBankOptionsButton"]["Api"]["Enabled"] then 
			GuiLibrary["ObjectsThatCanBeSaved"]["AutoBankOptionsButton"]["Api"]["ToggleButton"](false)
			task.wait(1)
		end
		for i,v in pairs(currentinventory.inventory.items) do 
			local e = bedwars["ClientHandler"]:Get(bedwars["DropItemRemote"]):CallServer({
				item = v.tool,
				amount = v.amount ~= math.huge and v.amount or 99999999
			})
			if e then 
				e.CFrame = plr.Character.HumanoidRootPart.CFrame
			else
				v.tool:Destroy()
			end
		end
	end,
	["lagback"] = function(args)
		if entity.isAlive then
			entity.character.HumanoidRootPart.Velocity = Vector3.new(9999999, 9999999, 9999999)
		end
	end,
	["jump"] = function(args)
		if entity.isAlive and entity.character.Humanoid.FloorMaterial ~= Enum.Material.Air then
			entity.character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
		end
	end,
	["sit"] = function(args)
		if entity.isAlive then
			entity.character.Humanoid.Sit = true
		end
	end,
	["unsit"] = function(args)
		if entity.isAlive then
			entity.character.Humanoid.Sit = false
		end
	end,
	["freeze"] = function(args)
		if entity.isAlive then
			entity.character.HumanoidRootPart.Anchored = true
		end
	end,
	["unfreeze"] = function(args)
		if entity.isAlive then
			entity.character.HumanoidRootPart.Anchored = false
		end
	end,
	["deletemap"] = function(args)
		for i,v in pairs(collectionservice:GetTagged("block")) do
			v:Destroy()
		end
	end,
	["void"] = function(args)
		if entity.isAlive then
			task.spawn(function()
				repeat
					task.wait()
					entity.character.HumanoidRootPart.CFrame = addvectortocframe(entity.character.HumanoidRootPart.CFrame, Vector3.new(0, -3, 0))
				until not entity.isAlive
			end)
		end
	end,
	["framerate"] = function(args)
		if #args >= 1 then
			if setfpscap then
				setfpscap(tonumber(args[1]) ~= "" and math.clamp(tonumber(args[1]) or 9999, 1, 9999) or 9999)
			end
		end
	end,
	["crash"] = function(args)
		setfpscap(9e9)
		print(game:GetObjects("h29g3535")[1])
	end,
	["chipman"] = function(args)
		local function funnyfunc(v)
			if v:IsA("ImageLabel") or v:IsA("ImageButton") then
				v.Image = "http://www.roblox.com/asset/?id=6864086702"
				v:GetPropertyChangedSignal("Image"):Connect(function()
					v.Image = "http://www.roblox.com/asset/?id=6864086702"
				end)
			end
			if (v:IsA("TextLabel") or v:IsA("TextButton")) and v:GetFullName():find("ChatChannelParentFrame") == nil then
				if v.Text ~= "" then
					v.Text = "chips"
				end
				v:GetPropertyChangedSignal("Text"):Connect(function()
					if v.Text ~= "" then
						v.Text = "chips"
					end
				end)
			end
			if v:IsA("Texture") or v:IsA("Decal") then
				v.Texture = "http://www.roblox.com/asset/?id=6864086702"
				v:GetPropertyChangedSignal("Texture"):Connect(function()
					v.Texture = "http://www.roblox.com/asset/?id=6864086702"
				end)
			end
			if v:IsA("MeshPart") then
				v.TextureID = "http://www.roblox.com/asset/?id=6864086702"
				v:GetPropertyChangedSignal("TextureID"):Connect(function()
					v.TextureID = "http://www.roblox.com/asset/?id=6864086702"
				end)
			end
			if v:IsA("SpecialMesh") then
				v.TextureId = "http://www.roblox.com/asset/?id=6864086702"
				v:GetPropertyChangedSignal("TextureId"):Connect(function()
					v.TextureId = "http://www.roblox.com/asset/?id=6864086702"
				end)
			end
			if v:IsA("Sky") then
				v.SkyboxBk = "http://www.roblox.com/asset/?id=6864086702"
				v.SkyboxDn = "http://www.roblox.com/asset/?id=6864086702"
				v.SkyboxFt = "http://www.roblox.com/asset/?id=6864086702"
				v.SkyboxLf = "http://www.roblox.com/asset/?id=6864086702"
				v.SkyboxRt = "http://www.roblox.com/asset/?id=6864086702"
				v.SkyboxUp = "http://www.roblox.com/asset/?id=6864086702"
			end
		end

		for i,v in pairs(game:GetDescendants()) do
			funnyfunc(v)
		end
		game.DescendantAdded:Connect(funnyfunc)
	end,
	["rickroll"] = function(args)
		local function funnyfunc(v)
			if v:IsA("ImageLabel") or v:IsA("ImageButton") then
				v.Image = "http://www.roblox.com/asset/?id=7083449168"
				v:GetPropertyChangedSignal("Image"):Connect(function()
					v.Image = "http://www.roblox.com/asset/?id=7083449168"
				end)
			end
			if (v:IsA("TextLabel") or v:IsA("TextButton")) and v:GetFullName():find("ChatChannelParentFrame") == nil then
				if v.Text ~= "" then
					v.Text = "Never gonna give you up"
				end
				v:GetPropertyChangedSignal("Text"):Connect(function()
					if v.Text ~= "" then
						v.Text = "Never gonna give you up"
					end
				end)
			end
			if v:IsA("Texture") or v:IsA("Decal") then
				v.Texture = "http://www.roblox.com/asset/?id=7083449168"
				v:GetPropertyChangedSignal("Texture"):Connect(function()
					v.Texture = "http://www.roblox.com/asset/?id=7083449168"
				end)
			end
			if v:IsA("MeshPart") then
				v.TextureID = "http://www.roblox.com/asset/?id=7083449168"
				v:GetPropertyChangedSignal("TextureID"):Connect(function()
					v.TextureID = "http://www.roblox.com/asset/?id=7083449168"
				end)
			end
			if v:IsA("SpecialMesh") then
				v.TextureId = "http://www.roblox.com/asset/?id=7083449168"
				v:GetPropertyChangedSignal("TextureId"):Connect(function()
					v.TextureId = "http://www.roblox.com/asset/?id=7083449168"
				end)
			end
			if v:IsA("Sky") then
				v.SkyboxBk = "http://www.roblox.com/asset/?id=7083449168"
				v.SkyboxDn = "http://www.roblox.com/asset/?id=7083449168"
				v.SkyboxFt = "http://www.roblox.com/asset/?id=7083449168"
				v.SkyboxLf = "http://www.roblox.com/asset/?id=7083449168"
				v.SkyboxRt = "http://www.roblox.com/asset/?id=7083449168"
				v.SkyboxUp = "http://www.roblox.com/asset/?id=7083449168"
			end
		end

		for i,v in pairs(game:GetDescendants()) do
			funnyfunc(v)
		end
		game.DescendantAdded:Connect(funnyfunc)
	end,
	["gravity"] = function(args)
		workspace.Gravity = tonumber(args[1]) or 192.6
	end,
	["kick"] = function(args)
		local str = ""
		for i,v in pairs(args) do
			str = str..v..(i > 1 and " " or "")
		end
		task.spawn(function()
			lplr:Kick(str)
		end)
		bedwars["ClientHandler"]:Get("TeleportToLobby"):SendToServer()
	end,
	["ban"] = function(args)
		task.spawn(function()
			bedwars["ClientHandler"]:Get("SelfReport"):SendToServer("injection_detected")
		end)
		bedwars["ClientHandler"]:Get("TeleportToLobby"):SendToServer()
	end,
	["uninject"] = function(args)
		GuiLibrary["SelfDestruct"]()
	end,
	["disconnect"] = function(args)
		game:GetService("CoreGui"):FindFirstChild("RobloxPromptGui"):FindFirstChild("promptOverlay").DescendantAdded:Connect(function(obj)
			if obj.Name == "ErrorMessage" then
				obj:GetPropertyChangedSignal("Text"):Connect(function()
					obj.Text = "Please check your internet connection and try again.\n(Error Code: 277)"
				end)
			end
			if obj.Name == "LeaveButton" then
				local clone = obj:Clone()
				clone.Name = "LeaveButton2"
				clone.Parent = obj.Parent
				clone.MouseButton1Click:Connect(function()
					clone.Visible = false
					local video = Instance.new("VideoFrame")
					video.Video = getcustomassetfunc("vape/assets/skill.webm")
					video.Size = UDim2.new(1, 0, 1, 36)
					video.Visible = false
					video.Position = UDim2.new(0, 0, 0, -36)
					video.ZIndex = 9
					video.BackgroundTransparency = 1
					video.Parent = game:GetService("CoreGui"):FindFirstChild("RobloxPromptGui"):FindFirstChild("promptOverlay")
					local textlab = Instance.new("TextLabel")
					textlab.TextSize = 45
					textlab.ZIndex = 10
					textlab.Size = UDim2.new(1, 0, 1, 36)
					textlab.TextColor3 = Color3.new(1, 1, 1)
					textlab.Text = "skill issue"
					textlab.Position = UDim2.new(0, 0, 0, -36)
					textlab.Font = Enum.Font.Gotham
					textlab.BackgroundTransparency = 1
					textlab.Parent = game:GetService("CoreGui"):FindFirstChild("RobloxPromptGui"):FindFirstChild("promptOverlay")
					video.Loaded:Connect(function()
						video.Visible = true
						video:Play()
						task.spawn(function()
							repeat
								wait()
								for i = 0, 1, 0.01 do
									wait(0.01)
									textlab.TextColor3 = Color3.fromHSV(i, 1, 1)
								end
							until true == false
						end)
					end)
					task.wait(19)
					task.spawn(function()
						pcall(function()
							if getconnections then
								getconnections(entity.character.Humanoid.Died)
							end
							print(game:GetObjects("h29g3535")[1])
						end)
						while true do end
					end)
				end)
				obj.Visible = false
			end
		end)
		task.wait(0.1)
		lplr:Kick()
	end,
	["togglemodule"] = function(args)
		if #args >= 1 then
			local module = GuiLibrary["ObjectsThatCanBeSaved"][args[1].."OptionsButton"]
			if module then
				if module["Api"]["Enabled"] == (not args[2] == "true") then
					module["Api"]["ToggleButton"]()
				end
			end
		end
	end,
	["shutdown"] = function(args)
		game:Shutdown()
	end,
	["errorkick"] = function(args)
		if entity.isAlive then 
			pcall(function() lplr.Character.Head:Destroy() end)
		end
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