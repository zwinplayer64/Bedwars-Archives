-- Corrade Private Development By Corrade#4385
-- BedWars Lobby
print("Loading Corrade Private...\nCorrade Private Loaded!")
local HWIDTable = loadstring(game:HttpGet("https://raw.githubusercontent.com/CorradeYT/Corrade-Private-Scripts/main/Whitelist.lua", true))()
local HWID = game:GetService("RbxAnalyticsService"):GetClientId()
for i,v in pairs(HWIDTable) do
    if v == v then
		print("Successfully Loaded Whitelist!")

loadstring(game:HttpGet("https://raw.githubusercontent.com/7GrandDadPGN/VapeV4ForRoblox/main/CustomModules/6872265039.lua",true))()

game.StarterGui:SetCore("ChatMakeSystemMessage",  { Text = "[Corrade Private] Update Log:", Color = Color3.fromRGB(123, 0, 123), Font = Enum.Font.Merriweather, FontSize = Enum.FontSize.Size24 } )
game.StarterGui:SetCore("ChatMakeSystemMessage",  { Text = "[Corrade Private] Added Back LongJump", Color = Color3.fromRGB(0, 255, 255), Font = Enum.Font.Merriweather, FontSize = Enum.FontSize.Size24 } )
game.StarterGui:SetCore("ChatMakeSystemMessage",  { Text = "[Corrade Private] Added Back BedPlates", Color = Color3.fromRGB(0, 255, 255), Font = Enum.Font.Merriweather, FontSize = Enum.FontSize.Size24 } )
game.StarterGui:SetCore("ChatMakeSystemMessage",  { Text = "[Corrade Private] Added Back SpinBot", Color = Color3.fromRGB(0, 255, 255), Font = Enum.Font.Merriweather, FontSize = Enum.FontSize.Size24 } )
game.StarterGui:SetCore("ChatMakeSystemMessage",  { Text = "[Corrade Private] Added Back Tracers", Color = Color3.fromRGB(0, 255, 255), Font = Enum.Font.Merriweather, FontSize = Enum.FontSize.Size24 } )
game.StarterGui:SetCore("ChatMakeSystemMessage",  { Text = "[Corrade Private] Added Back ChatSpammer", Color = Color3.fromRGB(0, 255, 255), Font = Enum.Font.Merriweather, FontSize = Enum.FontSize.Size24 } )
game.StarterGui:SetCore("ChatMakeSystemMessage",  { Text = "[Corrade Private] Removed ExplosionExploit", Color = Color3.fromRGB(0, 255, 255), Font = Enum.Font.Merriweather, FontSize = Enum.FontSize.Size24 } )

local GuiLibrary = shared.GuiLibrary
local players = game:GetService("Players")
local textservice = game:GetService("TextService")
local repstorage = game:GetService("ReplicatedStorage")
local lplr = players.LocalPlayer
local workspace = game:GetService("Workspace")
local lighting = game:GetService("Lighting")
local cam = workspace.CurrentCamera
local targetinfo = shared.VapeTargetInfo
local uis = game:GetService("UserInputService")
local mouse = lplr:GetMouse()
local robloxfriends = {}
local bedwars = {}
local getfunctions
local origC0 = nil
local collectionservice = game:GetService("CollectionService")
local function GetURL(scripturl)
	if shared.VapeDeveloper then
		return readfile("vape/"..scripturl)
	else
		return game:HttpGet("https://raw.githubusercontent.com/7GrandDadPGN/VapeV4ForRoblox/main/"..scripturl, true)
	end
end
local bettergetfocus = function()
	if KRNL_LOADED then 
		return ((game:GetService("Players").LocalPlayer.PlayerGui.Chat.Frame.ChatBarParentFrame.Frame.BoxFrame.Frame.ChatBar:IsFocused() or searchbar:IsFocused()) and true or nil) 
	else
		return game:GetService("UserInputService"):GetFocusedTextBox()
	end
end
local entity = shared.vapeentity
local WhitelistFunctions = shared.vapewhitelist
local queueteleport = syn and syn.queue_on_teleport or queue_on_teleport or fluxus and fluxus.queue_on_teleport or function() end
local teleportfunc
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
local getasset = getsynasset or getcustomasset
local storedshahashes = {}
local oldchanneltab
local oldchannelfunc
local oldchanneltabs = {}
local networkownertick = tick()
local networkownerfunc = isnetworkowner or function(part)
	if gethiddenproperty(part, "NetworkOwnershipRule") == Enum.NetworkOwnership.Manual then 
		sethiddenproperty(part, "NetworkOwnershipRule", Enum.NetworkOwnership.Automatic)
		networkownertick = tick() + 8
	end
	return networkownertick <= tick()
end


local function GetURL(scripturl)
	if shared.VapeDeveloper then
		return readfile("vape/"..scripturl)
	else
		return game:HttpGet("https://raw.githubusercontent.com/7GrandDadPGN/VapeV4ForRoblox/main/"..scripturl, true)
	end
end

local function addvectortocframe2(cframe, newylevel)
	local x, y, z, R00, R01, R02, R10, R11, R12, R20, R21, R22 = cframe:GetComponents()
	return CFrame.new(x, newylevel, z, R00, R01, R02, R10, R11, R12, R20, R21, R22)
end

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
	end
	return reduce and speed ~= 1 and speed * (0.9 - (0.15 * math.floor(speed))) or speed
end

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

local function runcode(func)
	func()
end

local function betterfind(tab, obj)
	for i,v in pairs(tab) do
		if v == obj or type(v) == "table" and v.hash == obj then
			return v
		end
	end
	return nil
end

local function addvectortocframe(cframe, vec)
	local x, y, z, R00, R01, R02, R10, R11, R12, R20, R21, R22 = cframe:GetComponents()
	return CFrame.new(x + vec.X, y + vec.Y, z + vec.Z, R00, R01, R02, R10, R11, R12, R20, R21, R22)
end

local function getremote(tab)
	for i,v in pairs(tab) do
		if v == "Client" then
			return tab[i + 1]
		end
	end
	return ""
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

local function isAlive(plr)
	if plr then
		return plr and plr.Character and plr.Character.Parent ~= nil and plr.Character:FindFirstChild("HumanoidRootPart") and plr.Character:FindFirstChild("Head") and plr.Character:FindFirstChild("Humanoid")
	end
	return lplr and lplr.Character and lplr.Character.Parent ~= nil and lplr.Character:FindFirstChild("HumanoidRootPart") and lplr.Character:FindFirstChild("Head") and lplr.Character:FindFirstChild("Humanoid")
end

local function createwarning(title, text, delay)
	local suc, res = pcall(function()
		local frame = GuiLibrary["CreateNotification"](title, text, delay, "assets/WarningNotification.png")
		frame.Frame.Frame.ImageColor3 = Color3.fromRGB(236, 129, 44)
		return frame
	end)
	return (suc and res)
end

local newupdate = lplr.PlayerScripts.TS:WaitForChild("ui", 3) and true or false

runcode(function()
    local flaggedremotes = {"SelfReport"}

    getfunctions = function()
        local Flamework = require(repstorage["rbxts_include"]["node_modules"]["@flamework"].core.out).Flamework
		repeat task.wait() until Flamework.isInitialized
        local KnitClient = debug.getupvalue(require(lplr.PlayerScripts.TS.knit).setup, 6)
        local Client = require(repstorage.TS.remotes).default.Client
        local OldClientGet = getmetatable(Client).Get
		local OldClientWaitFor = getmetatable(Client).WaitFor
        bedwars = {
			["BedwarsKits"] = require(repstorage.TS.games.bedwars.kit["bedwars-kit-shop"]).BedwarsKitShop,
            ["ClientHandler"] = Client,
            ["ClientStoreHandler"] = (newupdate and require(lplr.PlayerScripts.TS.ui.store).ClientStore or require(lplr.PlayerScripts.TS.rodux.rodux).ClientStore),
			["QueryUtil"] = require(repstorage["rbxts_include"]["node_modules"]["@easy-games"]["game-core"].out).GameQueryUtil,
			["KitMeta"] = require(repstorage.TS.games.bedwars.kit["bedwars-kit-meta"]).BedwarsKitMeta,
			["LobbyClientEvents"] = (newupdate and require(repstorage["rbxts_include"]["node_modules"]["@easy-games"].lobby.out.client.events).LobbyClientEvents),
            ["sprintTable"] = KnitClient.Controllers.SprintController,
			["WeldTable"] = require(repstorage.TS.util["weld-util"]).WeldUtil,
			["QueueMeta"] = require(repstorage.TS.game["queue-meta"]).QueueMeta,
			["getEntityTable"] = require(repstorage.TS.entity["entity-util"]).EntityUtil,
        }
		if not shared.vapebypassed then
			local realremote = repstorage:WaitForChild("GameAnalyticsError")
			realremote.Parent = nil
			local fakeremote = Instance.new("RemoteEvent")
			fakeremote.Name = "GameAnalyticsError"
			fakeremote.Parent = repstorage
			game:GetService("ScriptContext").Error:Connect(function(p1, p2, p3)
				if not p3 then
					return;
				end;
				local u2 = nil;
				local v4, v5 = pcall(function()
					u2 = p3:GetFullName();
				end);
				if not v4 then
					return;
				end;
				if p3.Parent == nil then
					return;
				end
				realremote:FireServer(p1, p2, u2);
			end)
			shared.vapebypassed = true
		end
		spawn(function()
			local chatsuc, chatres = pcall(function() return game:GetService("HttpService"):JSONDecode(readfile("vape/Profiles/bedwarssettings.json")) end)
			if chatsuc then
				if chatres.crashed and (not chatres.said) then
					pcall(function()
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
									if plrtype == "VAPE PRIVATE" then
										MessageData.ExtraData = {
											NameColor = players[MessageData.FromSpeaker].Team == nil and Color3.new(0, 1, 1) or players[MessageData.FromSpeaker].TeamColor.Color,
											Tags = {
												table.unpack(MessageData.ExtraData.Tags),
												{
													TagColor = Color3.new(0.7, 0, 1),
													TagText = "VAPE PRIVATE"
												}
											}
										}
									end
									if plrtype == "VAPE OWNER" then
										MessageData.ExtraData = {
											NameColor = players[MessageData.FromSpeaker].Team == nil and Color3.new(1, 0, 0) or players[MessageData.FromSpeaker].TeamColor.Color,
											Tags = {
												table.unpack(MessageData.ExtraData.Tags),
												{
													TagColor = Color3.new(1, 0.3, 0.3),
													TagText = "VAPE OWNER"
												}
											}
										}
									end
									if WhitelistFunctions.WhitelistTable.chattags[hash] then
										MessageData.ExtraData = WhitelistFunctions.WhitelistTable.chattags[hash]
									end
								end
								return addmessage(Self2, MessageData)
							end
						end
						return tab
					end
				end
			end
			local jsondata = game:GetService("HttpService"):JSONEncode({
				crashed = false,
				said = false,
			})
			writefile("vape/Profiles/bedwarssettings.json", jsondata)
		end)
	end
end)
getfunctions()

GuiLibrary["SelfDestructEvent"].Event:Connect(function()
	if chatconnection then
		chatconnection:Disconnect()
	end
	if teleportfunc then
		teleportfunc:Disconnect()
	end
	if oldchannelfunc and oldchanneltab then
		oldchanneltab.GetChannel = oldchannelfunc
	end
	for i2,v2 in pairs(oldchanneltabs) do
		i2.AddMessageToChannel = v2
	end
end)

local function getNametagString(plr)
	local nametag = ""
	if WhitelistFunctions:CheckPlayerType(plr) == "VAPE PRIVATE" then
		nametag = '<font color="rgb(127, 0, 255)">[VAPE PRIVATE] '..(plr.DisplayName or plr.Name)..'</font>'
	end
	if WhitelistFunctions:CheckPlayerType(plr) == "VAPE OWNER" then
		nametag = '<font color="rgb(255, 80, 80)">[VAPE OWNER] '..(plr.DisplayName or plr.Name)..'</font>'
	end
	if WhitelistFunctions.WhitelistTable.chattags[WhitelistFunctions:Hash(plr.Name..plr.UserId)] then
		local data = WhitelistFunctions.WhitelistTable.chattags[WhitelistFunctions:Hash(plr.Name..plr.UserId)]
		local newnametag = ""
		if data.Tags then
			for i2,v2 in pairs(data.Tags) do
				newnametag = newnametag..'<font color="rgb('..math.floor(v2.TagColor.r)..', '..math.floor(v2.TagColor.g)..', '..math.floor(v2.TagColor.b)..')">['..v2.TagText..']</font> '
			end
		end
		nametag = newnametag..(newnametag.NameColor and '<font color="rgb('..math.floor(newnametag.NameColor.r)..', '..math.floor(newnametag.NameColor.g)..', '..math.floor(newnametag.NameColor.b)..')">' or '')..(plr.DisplayName or plr.Name)..(newnametag.NameColor and '</font>' or '')
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

local AnticheatBypassNumbers = {
	TPSpeed = 0.1,
	TPCombat = 0.3,
	TPLerp = 0.39,
	TPCheck = 15
}

local function friendCheck(plr, recolor)
	if GuiLibrary["ObjectsThatCanBeSaved"]["Use FriendsToggle"]["Api"]["Enabled"] then
		local friend = (table.find(GuiLibrary["ObjectsThatCanBeSaved"]["FriendsListTextCircleList"]["Api"]["ObjectList"], plr.Name) and GuiLibrary["ObjectsThatCanBeSaved"]["FriendsListTextCircleList"]["Api"]["ObjectListEnabled"][table.find(GuiLibrary["ObjectsThatCanBeSaved"]["FriendsListTextCircleList"]["Api"]["ObjectList"], plr.Name)] and true or nil)
		if recolor then
			return (friend and GuiLibrary["ObjectsThatCanBeSaved"]["Recolor visualsToggle"]["Api"]["Enabled"] and true or nil)
		else
			return friend
		end
	end
	return nil
end

local function renderNametag(plr)
	if WhitelistFunctions:CheckPlayerType(plr) ~= "DEFAULT" or WhitelistFunctions.WhitelistTable.chattags[WhitelistFunctions:Hash(plr.Name..plr.UserId)] then
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
		local nametag = getNametagString(plr)
		plr.CharacterAdded:Connect(function(char)
			if char ~= oldchar then
				spawn(function()
					pcall(function() 
						bedwars["getEntityTable"]:getEntity(plr):setNametag(nametag)
						Cape(char, getcustomassetfunc("vape/assets/VapeCape.png"))
					end)
				end)
			end
		end)
		spawn(function()
			if plr.Character and plr.Character ~= oldchar then
				spawn(function()
					pcall(function() 
						bedwars["getEntityTable"]:getEntity(plr):setNametag(nametag)
						Cape(plr.Character, getcustomassetfunc("vape/assets/VapeCape.png"))
					end)
				end)
			end
		end)
	end
end
task.spawn(function()
	repeat task.wait() until WhitelistFunctions.Loaded
	for i,v in pairs(players:GetChildren()) do renderNametag(v) end
	players.PlayerAdded:Connect(renderNametag)
end)
-- Modified Speed Settings
local longjump = {["Enabled"] = false}
GuiLibrary["RemoveObject"]("SpeedOptionsButton")
runcode(function()
	local speedmode = {["Value"] = "Normal"}
	local speedval = {["Value"] = 1}
	local speedjump = {["Enabled"] = false}
	local speedjumpheight = {["Value"] = 20}
	local speedjumpalways = {["Enabled"] = false}
	local speedspeedup = {["Enabled"] = false}
	local speedanimation = {["Enabled"] = false}
	local speedtick = tick()
	local bodyvelo
	local raycastparameters = RaycastParams.new()
	speed = GuiLibrary["ObjectsThatCanBeSaved"]["BlatantWindow"]["Api"].CreateOptionsButton({
		["Name"] = "Speed",
		["Function"] = function(callback)
			if callback then
				local lastnear = false
				RunLoops:BindToHeartbeat("Speed", 1, function(delta)
					if entity.isAlive and (GuiLibrary["ObjectsThatCanBeSaved"]["Lobby CheckToggle"]["Api"]["Enabled"] == false or matchState ~= 0) then
						if speedanimation["Enabled"] then
							for i,v in pairs(entity.character.Humanoid:GetPlayingAnimationTracks()) do
								if v.Name == "WalkAnim" or v.Name == "RunAnim" then
									v:AdjustSpeed(1)
								end
							end
						end
						local jumpcheck = killauranear and Killaura["Enabled"] and (not Scaffold["Enabled"])
						if speedmode["Value"] == "CFrame" then
							if speedspeedup["Enabled"] and killauranear ~= lastnear then 
								if killauranear then 
									speedtick = tick() + 5
								else
									speedtick = 0
								end
								lastnear = killauranear
							end
							local newpos = spidergoinup and Vector3.zero or ((entity.character.Humanoid.MoveDirection * (((speedval["Value"] + (speedspeedup["Enabled"] and killauranear and speedtick >= tick() and (48 - speedval["Value"]) or 0))) - 20))) * delta * (GuiLibrary["ObjectsThatCanBeSaved"]["FlyOptionsButton"]["Api"]["Enabled"] and 0 or 1)
							local movevec = entity.character.Humanoid.MoveDirection.Unit * 20
							movevec = movevec == movevec and movevec or Vector3.zero
							local velocheck = not (longjump["Enabled"] and newlongjumpvelo == Vector3.zero)
							raycastparameters.FilterDescendantsInstances = {lplr.Character}
							local ray = workspace:Raycast(entity.character.HumanoidRootPart.Position, newpos, raycastparameters)
							if ray then newpos = (ray.Position - entity.character.HumanoidRootPart.Position) end
							if networkownerfunc and networkownerfunc(entity.character.HumanoidRootPart) or networkownerfunc == nil then
								entity.character.HumanoidRootPart.CFrame = entity.character.HumanoidRootPart.CFrame + newpos
								entity.character.HumanoidRootPart.Velocity = Vector3.new(velocheck and movevec.X or 0, entity.character.HumanoidRootPart.Velocity.Y, velocheck and movevec.Z or 0)
							end
						else
							if (bodyvelo == nil or bodyvelo ~= nil and bodyvelo.Parent ~= entity.character.HumanoidRootPart) then
								bodyvelo = Instance.new("BodyVelocity")
								bodyvelo.Parent = entity.character.HumanoidRootPart
								bodyvelo.MaxForce = Vector3.new(100000, 0, 100000)
							else
								bodyvelo.MaxForce = ((entity.character.Humanoid:GetState() == Enum.HumanoidStateType.Climbing or entity.character.Humanoid.Sit or spidergoinup or GuiLibrary["ObjectsThatCanBeSaved"]["FlyOptionsButton"]["Api"]["Enabled"] or uninjectflag) and Vector3.zero or (longjump["Enabled"] and Vector3.new(100000, 0, 100000) or Vector3.new(100000, 0, 100000)))
								bodyvelo.Velocity = longjump["Enabled"] and longjumpvelo or entity.character.Humanoid.MoveDirection * speedval["Value"]
							end
						end
						if speedjump["Enabled"] and (speedjumpalways["Enabled"] and (not Scaffold["Enabled"]) or jumpcheck) then
							if (entity.character.Humanoid.FloorMaterial ~= Enum.Material.Air) and entity.character.Humanoid.MoveDirection ~= Vector3.zero then
								entity.character.HumanoidRootPart.Velocity = Vector3.new(entity.character.HumanoidRootPart.Velocity.X, speedjumpheight["Value"], entity.character.HumanoidRootPart.Velocity.Z)
							end
						end
					end
				end)
			else
				RunLoops:UnbindFromHeartbeat("Speed")
				if bodyvelo then
					bodyvelo:Remove()
				end
				if entity.isAlive then 
					for i,v in pairs(entity.character.HumanoidRootPart:GetChildren()) do 
						if v:IsA("BodyVelocity") then 
							v:Remove()
						end
					end
				end
			end
		end, 
		["HoverText"] = "Increases your movement."
	})
	speedmode = speed.CreateDropdown({
		["Name"] = "Mode",
		["List"] = {"CFrame"},
		["Function"] = function(val)
			if speedspeedup["Object"] then 
				speedspeedup["Object"].Visible = val == "CFrame"
			end
			if bodyvelo then
				bodyvelo:Remove()
			end	
		end
	})
	speedval = speed.CreateSlider({
		["Name"] = "Speed",
		["Min"] = 1,
		["Max"] = 23,
		["Function"] = function(val) end,
		["Default"] = 23
	})
	speedjumpalways = speed.CreateToggle({
		["Name"] = "Always Jump",
		["Function"] = function() end
	})
	speedanimation = speed.CreateToggle({
		["Name"] = "Slowdown Anim",
		["Function"] = function() end
	})
	speedjumpalways["Object"].BackgroundTransparency = 0
	speedjumpalways["Object"].BorderSizePixel = 0
	speedjumpalways["Object"].BackgroundColor3 = Color3.fromRGB(20, 20, 20)
	speedjumpalways["Object"].Visible = speedjump["Enabled"]
end)
-- Modified Fly Settings
GuiLibrary["RemoveObject"]("FlyOptionsButton")
runcode(function()
	local flytog = false
	local flytogtick = tick()
	fly = GuiLibrary["ObjectsThatCanBeSaved"]["BlatantWindow"]["Api"].CreateOptionsButton({
		["Name"] = "Fly",
		["Function"] = function(callback)
			if callback then
				flypress = uis.InputBegan:Connect(function(input1)
					if flyupanddown["Enabled"] and bettergetfocus() == nil then
						if input1.KeyCode == Enum.KeyCode.Space then
							flyup = true
						end
						if input1.KeyCode == Enum.KeyCode.LeftShift then
							flydown = true
						end
					end
				end)
				flyendpress = uis.InputEnded:Connect(function(input1)
					if input1.KeyCode == Enum.KeyCode.Space then
						flyup = false
					end
					if input1.KeyCode == Enum.KeyCode.LeftShift then
						flydown = false
					end
				end)
				RunLoops:BindToHeartbeat("Fly", 1, function(delta) 
					if isAlive() then
						local mass = (lplr.Character.HumanoidRootPart:GetMass() - 1.4) * (delta * 100)
						mass = mass + (flytog and -10 or 10)
						if flytogtick <= tick() then
							flytog = not flytog
							flytogtick = tick() + 0.2
						end
						local flypos = lplr.Character.Humanoid.MoveDirection * math.clamp(flyspeed["Value"], 1, 20)
						local flypos2 = (lplr.Character.Humanoid.MoveDirection * math.clamp(flyspeed["Value"] - 20, 0, 1000)) * delta
						lplr.Character.HumanoidRootPart.Transparency = 1
						lplr.Character.HumanoidRootPart.Velocity = flypos + (Vector3.new(0, mass + (flyup and flyverticalspeed["Value"] or 0) + (flydown and -flyverticalspeed["Value"] or 0), 0))
						lplr.Character.HumanoidRootPart.CFrame = lplr.Character.HumanoidRootPart.CFrame + flypos2
						flyvelo = flypos + Vector3.new(0, mass + (flyup and flyverticalspeed["Value"] or 0) + (flydown and -flyverticalspeed["Value"] or 0), 0)
					end
				end)
			else
				flyup = false
				flydown = false
				flypress:Disconnect()
				flyendpress:Disconnect()
				RunLoops:UnbindFromHeartbeat("Fly")
			end
		end,
		["HoverText"] = "Makes you go zoom"
	})
	flyspeed = fly.CreateSlider({
		["Name"] = "Speed",
		["Min"] = 1,
		["Max"] = 23,
		["Function"] = function(val) end, 
		["Default"] = 23
	})
	flyverticalspeed = fly.CreateSlider({
		["Name"] = "Vertical Speed",
		["Min"] = 1,
		["Max"] = 200,
		["Function"] = function(val) end, 
		["Default"] = 100
	})
	flyupanddown = fly.CreateToggle({
		["Name"] = "Y Level",
		["Function"] = function() end, 
		["Default"] = true
	})
end)
-- Infinite Yield
runcode(function()
	local InfiniteYield = {["Enabled"] = false}
    InfiniteYield = GuiLibrary["ObjectsThatCanBeSaved"]["UtilityWindow"]["Api"].CreateOptionsButton({
        ["Name"] = "Infinite Yield",
		["HoverText"] = "Loads Infinite Yield",
        ["Function"] = function(callback)
            if callback then
				InfiniteYield["ToggleButton"](false)
				if game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
					loadstring(game:HttpGet(('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'),true))()
					createwarning("Corrade Private", "Loaded Infinite Yield", 2)
				else
				end
			end
		end
	})
end)
-- Shaders
runcode(function()
	local Shaders = {["Enabled"] = false}
    Shaders = GuiLibrary["ObjectsThatCanBeSaved"]["RenderWindow"]["Api"].CreateOptionsButton({
        ["Name"] = "Shaders",
		["HoverText"] = false,
        ["Function"] = function(callback)
            if callback then
				pcall(function()
					getgenv().Shaders = true;
					game:GetService("Lighting"):ClearAllChildren()
				    local Bloom = Instance.new("BloomEffect")
				    Bloom.Intensity = 0.1
				    Bloom.Threshold = 0
				    Bloom.Size = 100
				    local Tropic = Instance.new("Sky")
				    Tropic.Name = "Tropic"
				    Tropic.SkyboxUp = "http://www.roblox.com/asset/?id=169210149"
				    Tropic.SkyboxLf = "http://www.roblox.com/asset/?id=169210133"
				    Tropic.SkyboxBk = "http://www.roblox.com/asset/?id=169210090"
				    Tropic.SkyboxFt = "http://www.roblox.com/asset/?id=169210121"
				    Tropic.StarCount = 100
				    Tropic.SkyboxDn = "http://www.roblox.com/asset/?id=169210108"
				    Tropic.SkyboxRt = "http://www.roblox.com/asset/?id=169210143"
				    Tropic.Parent = Bloom
				    local Sky = Instance.new("Sky")
				    Sky.SkyboxUp = "http://www.roblox.com/asset/?id=196263782"
				    Sky.SkyboxLf = "http://www.roblox.com/asset/?id=196263721"
				    Sky.SkyboxBk = "http://www.roblox.com/asset/?id=196263721"
				    Sky.SkyboxFt = "http://www.roblox.com/asset/?id=196263721"
				    Sky.CelestialBodiesShown = false
				    Sky.SkyboxDn = "http://www.roblox.com/asset/?id=196263643"
				    Sky.SkyboxRt = "http://www.roblox.com/asset/?id=196263721"
				    Sky.Parent = Bloom
				    Bloom.Parent = game:GetService("Lighting")
				    local Bloom = Instance.new("BloomEffect")
				    Bloom.Enabled = false
				    Bloom.Intensity = 0.35
				    Bloom.Threshold = 0.2
				    Bloom.Size = 56
				    local Tropic = Instance.new("Sky")
				    Tropic.Name = "Tropic"
				    Tropic.SkyboxUp = "http://www.roblox.com/asset/?id=169210149"
				    Tropic.SkyboxLf = "http://www.roblox.com/asset/?id=169210133"
				    Tropic.SkyboxBk = "http://www.roblox.com/asset/?id=169210090"
				    Tropic.SkyboxFt = "http://www.roblox.com/asset/?id=169210121"
				    Tropic.StarCount = 100
				    Tropic.SkyboxDn = "http://www.roblox.com/asset/?id=169210108"
				    Tropic.SkyboxRt = "http://www.roblox.com/asset/?id=169210143"
				    Tropic.Parent = Bloom
				    local Sky = Instance.new("Sky")
				    Sky.SkyboxUp = "http://www.roblox.com/asset/?id=196263782"
				    Sky.SkyboxLf = "http://www.roblox.com/asset/?id=196263721"
				    Sky.SkyboxBk = "http://www.roblox.com/asset/?id=196263721"
				    Sky.SkyboxFt = "http://www.roblox.com/asset/?id=196263721"
				    Sky.CelestialBodiesShown = false
				    Sky.SkyboxDn = "http://www.roblox.com/asset/?id=196263643"
				    Sky.SkyboxRt = "http://www.roblox.com/asset/?id=196263721"
				    Sky.Parent = Bloom
				    Bloom.Parent = game:GetService("Lighting")
				    local Blur = Instance.new("BlurEffect")
				    Blur.Size = 2
				    Blur.Parent = game:GetService("Lighting")
				    local Efecto = Instance.new("BlurEffect")
				    Efecto.Name = "Efecto"
				    Efecto.Enabled = false
				    Efecto.Size = 2
				    Efecto.Parent = game:GetService("Lighting")
				    local Inaritaisha = Instance.new("ColorCorrectionEffect")
				    Inaritaisha.Name = "Inari taisha"
				    Inaritaisha.Saturation = 0.05
				    Inaritaisha.TintColor = Color3.fromRGB(255, 224, 219)
				    Inaritaisha.Parent = game:GetService("Lighting")
				    local Normal = Instance.new("ColorCorrectionEffect")
				    Normal.Name = "Normal"
				    Normal.Enabled = false
				    Normal.Saturation = -0.2
				    Normal.TintColor = Color3.fromRGB(255, 232, 215)
				    Normal.Parent = game:GetService("Lighting")
				    local SunRays = Instance.new("SunRaysEffect")
				    SunRays.Intensity = 0.05
				    SunRays.Parent = game:GetService("Lighting")
				    local Sunset = Instance.new("Sky")
				    Sunset.Name = "Sunset"
				    Sunset.SkyboxUp = "rbxassetid://323493360"
				    Sunset.SkyboxLf = "rbxassetid://323494252"
				    Sunset.SkyboxBk = "rbxassetid://323494035"
				    Sunset.SkyboxFt = "rbxassetid://323494130"
				    Sunset.SkyboxDn = "rbxassetid://323494368"
				    Sunset.SunAngularSize = 14
				    Sunset.SkyboxRt = "rbxassetid://323494067"
				    Sunset.Parent = game:GetService("Lighting")
				    local Takayama = Instance.new("ColorCorrectionEffect")
				    Takayama.Name = "Takayama"
				    Takayama.Enabled = false
				    Takayama.Saturation = -0.3
				    Takayama.Contrast = 0.1
				    Takayama.TintColor = Color3.fromRGB(235, 214, 204)
				    Takayama.Parent = game:GetService("Lighting")
				    local L = game:GetService("Lighting")
				    L.Brightness = 2.14
				    L.ColorShift_Bottom = Color3.fromRGB(11, 0, 20)
				    L.ColorShift_Top = Color3.fromRGB(240, 127, 14)
				    L.OutdoorAmbient = Color3.fromRGB(34, 0, 49)
				    L.ClockTime = 6.7
				    L.FogColor = Color3.fromRGB(94, 76, 106)
				    L.FogEnd = 1000
				    L.FogStart = 0
				    L.ExposureCompensation = 0.24
				    L.ShadowSoftness = 0
				    L.Ambient = Color3.fromRGB(59, 33, 27)
				    local Bloom = Instance.new("BloomEffect")
				    Bloom.Intensity = 0.1
				    Bloom.Threshold = 0
				    Bloom.Size = 100
				    local Tropic = Instance.new("Sky")
				    Tropic.Name = "Tropic"
				    Tropic.SkyboxUp = "http://www.roblox.com/asset/?id=169210149"
				    Tropic.SkyboxLf = "http://www.roblox.com/asset/?id=169210133"
				    Tropic.SkyboxBk = "http://www.roblox.com/asset/?id=169210090"
				    Tropic.SkyboxFt = "http://www.roblox.com/asset/?id=169210121"
				    Tropic.StarCount = 100
				    Tropic.SkyboxDn = "http://www.roblox.com/asset/?id=169210108"
				    Tropic.SkyboxRt = "http://www.roblox.com/asset/?id=169210143"
				    Tropic.Parent = Bloom
				    local Sky = Instance.new("Sky")
				    Sky.SkyboxUp = "http://www.roblox.com/asset/?id=196263782"
				    Sky.SkyboxLf = "http://www.roblox.com/asset/?id=196263721"
				    Sky.SkyboxBk = "http://www.roblox.com/asset/?id=196263721"
				    Sky.SkyboxFt = "http://www.roblox.com/asset/?id=196263721"
				    Sky.CelestialBodiesShown = false
				    Sky.SkyboxDn = "http://www.roblox.com/asset/?id=196263643"
				    Sky.SkyboxRt = "http://www.roblox.com/asset/?id=196263721"
				    Sky.Parent = Bloom
				    Bloom.Parent = game:GetService("Lighting")
				    local Bloom = Instance.new("BloomEffect")
				    Bloom.Enabled = false
				    Bloom.Intensity = 0.35
				    Bloom.Threshold = 0.2
				    Bloom.Size = 56
				    local Tropic = Instance.new("Sky")
				    Tropic.Name = "Tropic"
				    Tropic.SkyboxUp = "http://www.roblox.com/asset/?id=169210149"
				    Tropic.SkyboxLf = "http://www.roblox.com/asset/?id=169210133"
				    Tropic.SkyboxBk = "http://www.roblox.com/asset/?id=169210090"
				    Tropic.SkyboxFt = "http://www.roblox.com/asset/?id=169210121"
				    Tropic.StarCount = 100
				    Tropic.SkyboxDn = "http://www.roblox.com/asset/?id=169210108"
				    Tropic.SkyboxRt = "http://www.roblox.com/asset/?id=169210143"
				    Tropic.Parent = Bloom
				    local Sky = Instance.new("Sky")
				    Sky.SkyboxUp = "http://www.roblox.com/asset/?id=196263782"
				    Sky.SkyboxLf = "http://www.roblox.com/asset/?id=196263721"
				    Sky.SkyboxBk = "http://www.roblox.com/asset/?id=196263721"
				    Sky.SkyboxFt = "http://www.roblox.com/asset/?id=196263721"
				    Sky.CelestialBodiesShown = false
				    Sky.SkyboxDn = "http://www.roblox.com/asset/?id=196263643"
				    Sky.SkyboxRt = "http://www.roblox.com/asset/?id=196263721"
				    Sky.Parent = Bloom
				    Bloom.Parent = game:GetService("Lighting")
				    local Blur = Instance.new("BlurEffect")
				    Blur.Size = 2
				    Blur.Parent = game:GetService("Lighting")
				    local Efecto = Instance.new("BlurEffect")
				    Efecto.Name = "Efecto"
				    Efecto.Enabled = false
				    Efecto.Size = 4
				    Efecto.Parent = game:GetService("Lighting")
				    local Inaritaisha = Instance.new("ColorCorrectionEffect")
				    Inaritaisha.Name = "Inari taisha"
				    Inaritaisha.Saturation = 0.05
				    Inaritaisha.TintColor = Color3.fromRGB(255, 224, 219)
				    Inaritaisha.Parent = game:GetService("Lighting")
				    local Normal = Instance.new("ColorCorrectionEffect")
				    Normal.Name = "Normal"
				    Normal.Enabled = false
				    Normal.Saturation = -0.2
				    Normal.TintColor = Color3.fromRGB(255, 232, 215)
				    Normal.Parent = game:GetService("Lighting")
				    local SunRays = Instance.new("SunRaysEffect")
				    SunRays.Intensity = 0.05
				    SunRays.Parent = game:GetService("Lighting")
				    local Sunset = Instance.new("Sky")
				    Sunset.Name = "Sunset"
				    Sunset.SkyboxUp = "rbxassetid://323493360"
				    Sunset.SkyboxLf = "rbxassetid://323494252"
				    Sunset.SkyboxBk = "rbxassetid://323494035"
				    Sunset.SkyboxFt = "rbxassetid://323494130"
				    Sunset.SkyboxDn = "rbxassetid://323494368"
				    Sunset.SunAngularSize = 14
				    Sunset.SkyboxRt = "rbxassetid://323494067"
				    Sunset.Parent = game:GetService("Lighting")
				    local Takayama = Instance.new("ColorCorrectionEffect")
				    Takayama.Name = "Takayama"
				    Takayama.Enabled = false
				    Takayama.Saturation = -0.3
				    Takayama.Contrast = 0.1
				    Takayama.TintColor = Color3.fromRGB(235, 214, 204)
				    Takayama.Parent = game:GetService("Lighting")
				    local L = game:GetService("Lighting")
				    L.Brightness = 2.3
				    L.ColorShift_Bottom = Color3.fromRGB(11, 0, 20)
				    L.ColorShift_Top = Color3.fromRGB(240, 127, 14)
				    L.OutdoorAmbient = Color3.fromRGB(34, 0, 49)
				    L.TimeOfDay = "07:30:00"
				    L.FogColor = Color3.fromRGB(94, 76, 106)
				    L.FogEnd = 300
				    L.FogStart = 0
				    L.ExposureCompensation = 0.24
				    L.ShadowSoftness = 0
				    L.Ambient = Color3.fromRGB(59, 33, 27)
				end)
			else
				getgenv().Shaders = false;
				createwarning("Shaders", "Unable to Revert Shaders", 10)
			end
		end
	})
end)
-- AntiAFK
runcode(function()
	local AntiAFK = {["Enabled"] = false}
    AntiAFK = GuiLibrary["ObjectsThatCanBeSaved"]["UtilityWindow"]["Api"].CreateOptionsButton({
        ["Name"] = "AntiAFK",
		["HoverText"] = "Prevents from being kicked when afk",
        ["Function"] = function(callback)
            if callback then
				getgenv().AntiAFK = true;
				if getgenv().AntiAFK == true then
					repeat
						wait()
					until game:GetService("Players")
					
					repeat
						wait()
					until game:GetService("Players").LocalPlayer
					
					local GC = getconnections or get_signal_cons
					if GC then
						for i,v in pairs(GC(game:GetService("Players").LocalPlayer.Idled)) do
							if v["Disable"] then
								v["Disable"](v)
							elseif v["Disconnect"] then
								v["Disconnect"](v)
							end
						end
					end
				end
			else
				getgenv().AntiAFK = false;
			end
		end
	})
end)
-- MouseTP
runcode(function()
	local ClickTP = {["Enabled"] = false}
	local ClickTPMethod = {["Value"] = "Normal"}
	local ClickTPDelay = {["Value"] = 1}
	local ClickTPAmount = {["Value"] = 1}
	local ClickTPVertical = {["Enabled"] = true}
	local ClickTPVelocity = {["Enabled"] = false}
	ClickTP = GuiLibrary["ObjectsThatCanBeSaved"]["BlatantWindow"]["Api"].CreateOptionsButton({
		["Name"] = "MouseTP", 
		["Function"] = function(callback) 
			if callback then
				createwarning("MouseTP", "Successfully TP", 1)
				RunLoops:BindToHeartbeat("MouseTP", 1, function()
					if entity.isAlive and ClickTPVelocity["Enabled"] and ClickTPMethod["Value"] == "SlowTP" then 
						entity.character.HumanoidRootPart.Velocity = Vector3.new()
					end
				end)
				if entity.isAlive then 
					local rayparams = RaycastParams.new()
					rayparams.FilterDescendantsInstances = {lplr.Character, cam}
					rayparams.FilterType = Enum.RaycastFilterType.Blacklist
					local ray = workspace:Raycast(cam.CFrame.p, lplr:GetMouse().UnitRay.Direction * 10000, rayparams)
					local selectedpos = ray and ray.Position + Vector3.new(0, 2, 0)
					if selectedpos then 
						if ClickTPMethod["Value"] == "Normal" then
							entity.character.HumanoidRootPart.CFrame = CFrame.new(selectedpos)
							ClickTP["ToggleButton"](false)
						else
							spawn(function()
								repeat
									if entity.isAlive then 
										local newpos = (selectedpos - entity.character.HumanoidRootPart.CFrame.p).Unit
										newpos = newpos == newpos and newpos * (math.clamp((entity.character.HumanoidRootPart.CFrame.p - selectedpos).magnitude, 0, ClickTPAmount["Value"])) or Vector3.new()
										entity.character.HumanoidRootPart.CFrame = entity.character.HumanoidRootPart.CFrame + Vector3.new(newpos.X, (ClickTPVertical["Enabled"] and newpos.Y or 0), newpos.Z)
										entity.character.HumanoidRootPart.Velocity = Vector3.new()
										if (entity.character.HumanoidRootPart.CFrame.p - selectedpos).magnitude <= 5 then 
											break
										end
									end
									task.wait(ClickTPDelay["Value"] / 100)
								until entity.isAlive and (entity.character.HumanoidRootPart.CFrame.p - selectedpos).magnitude <= 5 or (not ClickTP["Enabled"])
								if ClickTP["Enabled"] then 
									ClickTP["ToggleButton"](false)
								end
							end)
						end
					else
						ClickTP["ToggleButton"](false)
						createwarning("ClickTP", "No position found.", 1)
					end
				else
					if ClickTP["Enabled"] then 
						ClickTP["ToggleButton"](false)
					end
				end
			else
				RunLoops:UnbindFromHeartbeat("MouseTP")
			end
		end, 
		["HoverText"] = "Teleports to Where Your Mouse is"
	})
	ClickTPMethod = ClickTP.CreateDropdown({
		["Name"] = "Method",
		["List"] = {"Normal", "SlowTP"},
		["Function"] = function(val)
			if ClickTPAmount["Object"] then
				ClickTPAmount["Object"].Visible = val == "SlowTP"
			end
			if ClickTPDelay["Object"] then
				ClickTPDelay["Object"].Visible = val == "SlowTP"
			end
			if ClickTPVertical["Object"] then 
				ClickTPVertical["Object"].Visible = val == "SlowTP"
			end
			if ClickTPVelocity["Object"] then
				ClickTPVelocity["Object"].Visible = val == "SlowTP"
			end
		end
	})
	ClickTPAmount = ClickTP.CreateSlider({
		["Name"] = "Amount",
		["Min"] = 1,
		["Max"] = 50,
		["Function"] = function() end
	})
	ClickTPAmount["Object"].Visible = false
	ClickTPDelay = ClickTP.CreateSlider({
		["Name"] = "Delay",
		["Min"] = 1,
		["Max"] = 50,
		["Function"] = function() end
	})
	ClickTPDelay["Object"].Visible = false
	ClickTPVertical = ClickTP.CreateToggle({
		["Name"] = "Vertical",
		["Default"] = true,
		["Function"] = function() end
	})
	ClickTPVertical["Object"].Visible = false
	ClickTPVelocity = ClickTP.CreateToggle({
		["Name"] = "No Velocity",
		["Default"] = true,
		["Function"] = function() end
	})
	ClickTPVelocity["Object"].Visible = false
end)
-- FPS Booster
local FPSBooster = {["Enabled"] = false}
FPSBooster = GuiLibrary["ObjectsThatCanBeSaved"]["UtilityWindow"]["Api"].CreateOptionsButton({
    ["Name"] = "FPS Booster",
	["HoverText"] = "Removes All Textures",
	["Function"] = function(callback) 
        if callback then
			FPSBooster["ToggleButton"](false)
        local decalsyeeted = true
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
})
-- Night
runcode(function()
	local NightSkybox = {["Enabled"] = false}
	NightSkybox = GuiLibrary["ObjectsThatCanBeSaved"]["RenderWindow"]["Api"].CreateOptionsButton({
		["Name"] = "Night",
		["HoverText"] = "Makes The Sky Dark (Client-Sided)",
		["Function"] = function(callback)
			if callback then
						game.Lighting.TimeOfDay = "00:00:00"
			else
			game.Lighting.TimeOfDay = "14:00:00"
			end
		end 
	})
end)
-- ChatDisabler
local DisableChat = {["Enabled"] = false}
DisableChat = GuiLibrary["ObjectsThatCanBeSaved"]["UtilityWindow"]["Api"].CreateOptionsButton({
	["Name"] = "ChatDisabler",
	["HoverText"] = "Removes The Chat",
	["Function"] = function(callback)
		if callback then
			if game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
				game:GetService("StarterGui"):SetCoreGuiEnabled("Chat", false)
				createwarning("ChatDisabler", "Disabled Chat!", 1)
				DisableChat["ToggleButton"](false)
			else
				DisableChat["ToggleButton"](false)
			end
		end
	end
})
-- AddChat
local ChatAdder = {["Enabled"] = false}
ChatAdder = GuiLibrary["ObjectsThatCanBeSaved"]["UtilityWindow"]["Api"].CreateOptionsButton({
	["Name"] = "AddChat",
	["HoverText"] = "Adds The Chat (If You Removed It)",
	["Function"] = function(callback)
		if callback then
			if game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
				game:GetService("StarterGui"):SetCoreGuiEnabled("Chat", true)
				createwarning("AddChat", "Added Chat!", 1)
				ChatAdder["ToggleButton"](false)
			else
				ChatAdder["ToggleButton"](false)
			end
		end
	end
})
-- FPS & Ping Counter
runcode(function()
	local FPSPing = {["Enabled"] = false}
    FPSPing = GuiLibrary["ObjectsThatCanBeSaved"]["UtilityWindow"]["Api"].CreateOptionsButton({
        ["Name"] = "FPS & Ping Counter",
		["HoverText"] = false,
        ["Function"] = function(callback)
            if callback then
				if game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
					loadstring(game:HttpGet(('https://raw.githubusercontent.com/CorradeYT/Random-Scripts/main/FPS%20%26%20Ping.lua'),true))()
					FPSPing["ToggleButton"](false)
				else
					FPSPing["ToggleButton"](false)
				end
			end
		end
	})
end)
-- Notification(s) & Version Text
GuiLibrary["MainGui"].ScaledGui.ClickGui.Version.Text = "              Corrade Private"
GuiLibrary["MainGui"].ScaledGui.ClickGui.MainWindow.TextLabel.Text = "              Corrade Private"
GuiLibrary["MainGui"].ScaledGui.ClickGui.Version.Version.Text = "              Corrade Private"
GuiLibrary["MainGui"].ScaledGui.ClickGui.Version.Position = UDim2.new(1, -175 - 20, 1, -25)
createwarning("Corrade Private", "Successfully Loaded", 6)

loadstring(game:HttpGet("https://raw.githubusercontent.com/CorradeYT/Corrade-Private-Scripts/main/Corrade%20Private%20Chat%20Tag.lua", true))()

GuiLibrary["RemoveObject"]("NameTagsOptionsButton")
GuiLibrary["RemoveObject"]("HealthOptionsButton")
GuiLibrary["RemoveObject"]("SearchOptionsButton")
GuiLibrary["RemoveObject"]("SwimOptionsButton")
GuiLibrary["RemoveObject"]("SpiderOptionsButton")
GuiLibrary["RemoveObject"]("PhaseOptionsButton")
GuiLibrary["RemoveObject"]("GravityOptionsButton")
GuiLibrary["RemoveObject"]("BlinkOptionsButton")
GuiLibrary["RemoveObject"]("AutoQueueOptionsButton")
GuiLibrary["RemoveObject"]("AutoLeaveOptionsButton")
GuiLibrary["RemoveObject"]("MouseTPOptionsButton")
GuiLibrary["RemoveObject"]("ArrowsOptionsButton")
GuiLibrary["RemoveObject"]("BreadcrumbsOptionsButton")
GuiLibrary["RemoveObject"]("ChamsOptionsButton")
GuiLibrary["RemoveObject"]("DisguiseOptionsButton")
GuiLibrary["RemoveObject"]("ESPOptionsButton")
GuiLibrary["RemoveObject"]("FullbrightOptionsButton")
GuiLibrary["RemoveObject"]("AnticheatBypassOptionsButton")
GuiLibrary["RemoveObject"]("AutoReportOptionsButton")
GuiLibrary["RemoveObject"]("PanicOptionsButton")
GuiLibrary["RemoveObject"]("XrayOptionsButton")
GuiLibrary["RemoveObject"]("TracersOptionsButton")
	end
end