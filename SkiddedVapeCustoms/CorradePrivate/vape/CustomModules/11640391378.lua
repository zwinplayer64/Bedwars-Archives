-- Corrade Private Development By Corrade#4385
-- Telanthric BedWars
print("Loading Corrade Private...\nCorrade Private Loaded!")
local HWIDTable = loadstring(game:HttpGet("https://raw.githubusercontent.com/CorradeYT/Corrade-Private-Scripts/main/Whitelist.lua"))()
local HWID = game:GetService("RbxAnalyticsService"):GetClientId()

for i,v in pairs(HWIDTable) do
    if v == v then
		print("Successfully Loaded Whitelist!")

loadstring(game:HttpGet("https://raw.githubusercontent.com/7GrandDadPGN/VapeV4ForRoblox/main/CustomModules/11640391378.lua",true))()

local GuiLibrary = shared.GuiLibrary
local players = game:GetService("Players")
local textservice = game:GetService("TextService")
local repstorage = game:GetService("ReplicatedStorage")
local lplr = players.LocalPlayer
local workspace = game:GetService("Workspace")
local lighting = game:GetService("Lighting")
local cam = workspace.CurrentCamera
workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function()
	cam = (workspace.CurrentCamera or workspace:FindFirstChildWhichIsA("Camera") or Instance.new("Camera"))
end)
local targetinfo = shared.VapeTargetInfo
local uis = game:GetService("UserInputService")
local v3check = syn and syn.toast_notification and "V3" or ""
local networkownertick = tick()
local networkownerfunc = isnetworkowner or function(part)
	if gethiddenproperty(part, "NetworkOwnershipRule") == Enum.NetworkOwnership.Manual then 
		sethiddenproperty(part, "NetworkOwnershipRule", Enum.NetworkOwnership.Automatic)
		networkownertick = tick() + 8
	end
	return networkownertick <= tick()
end
local betterisfile = function(file)
	local suc, res = pcall(function() return readfile(file) end)
	return suc and res ~= nil
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
local requestfunc = syn and syn.request or http and http.request or http_request or fluxus and fluxus.request or request or function(tab)
	if tab.Method == "GET" then
		return {
			Body = game:HttpGet(tab.Url, true),
			Headers = {},
			StatusCode = 200
		}
	end
	return {
		Body = "bad exploit",
		Headers = {},
		StatusCode = 404
	}
end 
local queueteleport = syn and syn.queue_on_teleport or queue_on_teleport or fluxus and fluxus.queue_on_teleport or function() end
local getasset = getsynasset or getcustomasset or function(location) return "rbxasset://"..location end
local entity = shared.vapeentity

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

local WhitelistFunctions = shared.vapewhitelist

local function createwarning(title, text, delay)
	local suc, res = pcall(function()
		local frame = GuiLibrary["CreateNotification"](title, text, delay, "assets/WarningNotification.png")
		frame.Frame.Frame.ImageColor3 = Color3.fromRGB(236, 129, 44)
		return frame
	end)
	return (suc and res)
end

local function friendCheck(plr, recolor)
	if GuiLibrary["ObjectsThatCanBeSaved"]["Use FriendsToggle"]["Api"]["Enabled"] then
		local friend = table.find(GuiLibrary["ObjectsThatCanBeSaved"]["FriendsListTextCircleList"]["Api"]["ObjectList"], plr.Name)
		friend = friend and GuiLibrary["ObjectsThatCanBeSaved"]["FriendsListTextCircleList"]["Api"]["ObjectListEnabled"][friend] and true or nil
		if recolor then
			friend = friend and GuiLibrary["ObjectsThatCanBeSaved"]["Recolor visualsToggle"]["Api"]["Enabled"] or nil
		end
		return friend
	end
	return nil
end

local function getPlayerColor(plr)
	return (friendCheck(plr, true) and Color3.fromHSV(GuiLibrary["ObjectsThatCanBeSaved"]["Friends ColorSliderColor"]["Api"]["Hue"], GuiLibrary["ObjectsThatCanBeSaved"]["Friends ColorSliderColor"]["Api"]["Sat"], GuiLibrary["ObjectsThatCanBeSaved"]["Friends ColorSliderColor"]["Api"]["Value"]) or tostring(plr.TeamColor) ~= "White" and plr.TeamColor.Color)
end

local function getcustomassetfunc(path)
	if not isfile(path) then
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
			repeat wait() until isfile(path)
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

local function targetCheck(plr)
	local ForceField = not plr.Character.FindFirstChildWhichIsA(plr.Character, "ForceField")
	local state = plr.Humanoid.GetState(plr.Humanoid)
	return state ~= Enum.HumanoidStateType.Dead and state ~= Enum.HumanoidStateType.Physics and plr.Humanoid.Health > 0 and ForceField
end

local function isAlive(plr, alivecheck)
	if plr then
		local ind, tab = entity.getEntityFromPlayer(plr)
		return ((not alivecheck) or tab and tab.Humanoid:GetState() ~= Enum.HumanoidStateType.Dead) and tab
	end
	return entity.isAlive
end

local function vischeck(char, checktable)
	local rayparams = checktable.IgnoreObject or RaycastParams.new()
	if not checktable.IgnoreObject then 
		rayparams.FilterDescendantsInstances = {lplr.Character, char, cam, table.unpack(checktable.IgnoreTable or {})}
	end
	local ray = workspace.Raycast(workspace, checktable.Origin, CFrame.lookAt(checktable.Origin, char[checktable.AimPart].Position).lookVector * (checktable.Origin - char[checktable.AimPart].Position).Magnitude, rayparams)
	return not ray
end

local function runcode(func)
	func()
end

local function GetAllNearestHumanoidToPosition(player, distance, amount, checktab)
	local returnedplayer = {}
	local currentamount = 0
	checktab = checktab or {}
    if entity.isAlive then
		for i, v in pairs(entity.entityList) do -- loop through players
			if not v.Targetable then continue end
            if targetCheck(v) and currentamount < amount then -- checks
				local mag = (entity.character.HumanoidRootPart.Position - v.RootPart.Position).magnitude
                if mag <= distance then -- mag check
					if checktab.WallCheck then
						if not vischeck(v.Character, checktab) then continue end
					end
                    table.insert(returnedplayer, v)
					currentamount = currentamount + 1
                end
            end
        end
	end
	return returnedplayer
end

local function GetNearestHumanoidToPosition(player, distance, checktab)
	local closest, returnedplayer, targetpart = distance, nil, nil
	checktab = checktab or {}
	if entity.isAlive then
		for i, v in pairs(entity.entityList) do -- loop through players
			if not v.Targetable then continue end
            if targetCheck(v) then -- checks
				local mag = (entity.character.HumanoidRootPart.Position - v.RootPart.Position).magnitude
                if mag <= closest then -- mag check
					if checktab.WallCheck then
						if not vischeck(v.Character, checktab) then continue end
					end
                    closest = mag
					returnedplayer = v
                end
            end
        end
	end
	return returnedplayer
end

local function worldtoscreenpoint(pos)
	if v3check == "V3" then 
		local scr = worldtoscreen({pos})
		return scr[1], scr[1].Z > 0
	end
	return cam.WorldToScreenPoint(cam, pos)
end

local function GetNearestHumanoidToMouse(player, distance, checktab)
    local closest, returnedplayer = distance, nil
	checktab = checktab or {}
    if entity.isAlive then
		local mousepos = uis.GetMouseLocation(uis)
		for i, v in pairs(entity.entityList) do -- loop through players
			if not v.Targetable then continue end
            if targetCheck(v) then -- checks
				local vec, vis = worldtoscreenpoint(v.Character[checktab.AimPart].Position)
				local mag = (mousepos - Vector2.new(vec.X, vec.Y)).magnitude
                if vis and mag <= closest then -- mag check
					if checktab.WallCheck then
						if not vischeck(v.Character, checktab) then continue end
					end
                    closest = mag
					returnedplayer = v
                end
            end
        end
    end
    return returnedplayer
end

local function findTouchInterest(tool)
	return tool and tool:FindFirstChildWhichIsA("TouchTransmitter", true)
end

local framework = require(game:GetService("ReplicatedStorage"):WaitForChild("MultiboxFramework"))
local setthreadidentity = syn and syn.set_thread_identity or set_thread_identity or setidentity
local getthreadidentity = syn and syn.get_thread_identity or get_thread_identity or getidentity

local function fireremote(...)
	local old = getthreadidentity()
	setthreadidentity(2)
	framework.Network.Fire(...)
	setthreadidentity(old)
end

local function firefunction(...)
	local old = getthreadidentity()
	setthreadidentity(2)
	framework.Network.Invoke(...)
	setthreadidentity(old)
end
-- Infinite Jump
runcode(function()
    local InfiniteJump = {["Enabled"] = false}
    InfiniteJump = GuiLibrary["ObjectsThatCanBeSaved"]["BlatantWindow"]["Api"].CreateOptionsButton({
        ["Name"] = "Infinite Jump",
		["HoverText"] = "It Lets You Freely Jump",
        ["Function"] = function(callback)
            if callback then
                getgenv().InfiniteJump = true;
                game:GetService("UserInputService").jumpRequest:Connect(function()
					wait(InfiniteJumpDel)
                    if getgenv().InfiniteJump == true then
                        wait(InfiniteJumpDel)
						game:GetService"Players".LocalPlayer.Character:FindFirstChildOfClass"Humanoid":ChangeState("Jumping")
						wait(InfiniteJumpDel)
						game:GetService"Players".LocalPlayer.Character:FindFirstChildOfClass"Humanoid":ChangeState("freefall")
                    end
                end)
            else
                getgenv().InfiniteJump = false;
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
-- VClip
local VClip = {["Enabled"] = false}
VClip = GuiLibrary["ObjectsThatCanBeSaved"]["BlatantWindow"]["Api"].CreateOptionsButton({
	["Name"] = "VClip",
	["HoverText"] = false,
	["Function"] = function(callback)
		if callback then
			VClip["ToggleButton"](false)
			local x = game.Players.LocalPlayer.Character.HumanoidRootPart.Position.x
			local y = game.Players.LocalPlayer.Character.HumanoidRootPart.Position.y 
			local z = game.Players.LocalPlayer.Character.HumanoidRootPart.Position.z
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(x,y-10,z)
			createwarning("VClip", "Success", 1)
			Vclip["ToggleButton"](false)
		end
	end
})
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
-- Notification(s) & Version Text
GuiLibrary["MainGui"].ScaledGui.ClickGui.Version.Text = "              Corrade Private"
GuiLibrary["MainGui"].ScaledGui.ClickGui.MainWindow.TextLabel.Text = "              Corrade Private"
GuiLibrary["MainGui"].ScaledGui.ClickGui.Version.Version.Text = "              Corrade Private"
GuiLibrary["MainGui"].ScaledGui.ClickGui.Version.Position = UDim2.new(1, -175 - 20, 1, -25)
createwarning("Corrade Private", "Successfully Loaded", 3)

GuiLibrary["RemoveObject"]("SilentAimOptionsButton")
GuiLibrary["RemoveObject"]("TriggerBotOptionsButton")
GuiLibrary["RemoveObject"]("AutoLeaveOptionsButton")
GuiLibrary["RemoveObject"]("LongJumpOptionsButton")
GuiLibrary["RemoveObject"]("BlinkOptionsButton")
GuiLibrary["RemoveObject"]("SpinBotOptionsButton")
GuiLibrary["RemoveObject"]("SwimOptionsButton")
GuiLibrary["RemoveObject"]("ArrowsOptionsButton")
GuiLibrary["RemoveObject"]("BreadcrumbsOptionsButton")
GuiLibrary["RemoveObject"]("DisguiseOptionsButton")
GuiLibrary["RemoveObject"]("FullbrightOptionsButton")
GuiLibrary["RemoveObject"]("HealthOptionsButton")
GuiLibrary["RemoveObject"]("AutoReportOptionsButton")
GuiLibrary["RemoveObject"]("ChatSpammerOptionsButton")
GuiLibrary["RemoveObject"]("ClientKickDisablerOptionsButton")
GuiLibrary["RemoveObject"]("PanicOptionsButton")
GuiLibrary["RemoveObject"]("SafeWalkOptionsButton")
GuiLibrary["RemoveObject"]("XrayOptionsButton")
GuiLibrary["RemoveObject"]("SearchOptionsButton")
    end
end