--[[
 .____                  ________ ___.    _____                           __                
 |    |    __ _______   \_____  \\_ |___/ ____\_ __  ______ ____ _____ _/  |_  ___________ 
 |    |   |  |  \__  \   /   |   \| __ \   __\  |  \/  ___// ___\\__  \\   __\/  _ \_  __ \
 |    |___|  |  // __ \_/    |    \ \_\ \  | |  |  /\___ \\  \___ / __ \|  | (  <_> )  | \/
 |_______ \____/(____  /\_______  /___  /__| |____//____  >\___  >____  /__|  \____/|__|   
         \/          \/         \/    \/                \/     \/     \/                   
          \_Welcome to LuaObfuscator.com   (Alpha 0.1.6) ~  Much Love, Ferib 

]]--

local v0 = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Rayfield/main/source"))();
local v1 = v0:CreateWindow({Name="Bedwars Anticheat Fighter V5 Private",LoadingTitle="Loading Anticheat Fighter...",LoadingSubtitle="Version 5.0 Beta Private",ConfigurationSaving={Enabled=true,FolderName=V5AnticheatFighter,FileName="V5NACFRP"},Discord={Enabled=false,Invite="v8yzRCg7zU",RememberJoins=true},KeySystem=false,KeySettings={Title="Bedwars Anticheat Fighter V4 Private",Subtitle="Secure Key System",Note="Enter the key that Owner gave.",FileName="V4PriKeys",SaveKey=false,GrabKeyFromSite=false,Key="o0mdo10skdkNis9d01kKodo200KkdoalLLLiiiLda13"}});
local v2 = v1:CreateTab("Main");
local v3 = v2:CreateSection("Main");
local v4 = v2:CreateButton({Name="Auto Win(use with Killaura)",Callback=function()
	loadstring(game:HttpGet("https://pastebin.com/raw/T2auu8vQ"))();
end});
local v4 = v2:CreateButton({Name="KillAura",Callback=function()
	local v5 = game:GetService("Players");
	local v6 = v5.LocalPlayer;
	local v7 = workspace.CurrentCamera;
	local v8 = debug.getupvalue(require(v6.PlayerScripts.TS.knit).setup, 6);
	local v9 = v8.Controllers.SwordController;
	local v10 = false;
	local v11 = {Value=14};
	function Aura()
		for v12, v13 in pairs(game.Players:GetChildren()) do
			if (v13.Character and (v13.Name ~= game.Players.LocalPlayer.Name) and v13.Character:FindFirstChild("HumanoidRootPart")) then
				local v14 = (v13.Character.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude;
				if ((v14 <= ({Value=14})['Value']) and (v13.Team ~= game.Players.LocalPlayer.Team) and v13.Character:FindFirstChild("Humanoid")) then
					if (v13.Character.Humanoid.Health > 0) then
						true = true;
						v9:swingSwordAtMouse();
					end
				end
			end
		end
	end
	game:GetService("RunService").Stepped:connect(function()
		Aura();
	end);
end});
local v4 = v2:CreateButton({Name="BedTp(Only Work 2 Times)",Callback=function()
	loadstring(game:HttpGet("https://pastebin.com/raw/XG5xMjqR"))();
end});
local v4 = v2:CreateButton({Name="Better Partial Disabler(WIP)",Callback=function()
	v0:Notify({Title="This Module is Work in Progress!",Content="Unfinished Module",Duration=5.5,Image=4483362458,Actions={Ignore={Name="Okay!",Callback=function()
		print("The user tapped Okay!");
	end}}});
end});
local v4 = v2:CreateButton({Name="MultiAura V3",Callback=function()
	v0:Notify({Title="Enabled Module!",Content="MultiAura V3",Duration=5.5,Image=4483362458,Actions={Ignore={Name="Okay!",Callback=function()
		print("The user tapped Okay!");
	end}}});
end});
local v4 = v2:CreateButton({Name="Dupe(WIP)",Callback=function()
	v0:Notify({Title="Warning!",Content="The recent Staff Duping Report has been flaged BUGGED, it will be working again when we fixed! Apologize!",Duration=10.5,Image=4483362458,Actions={Ignore={Name="Okay!",Callback=function()
		print("The user tapped Okay!");
	end}}});
end});
local v4 = v2:CreateButton({Name="Instant Break Block/Bed",Callback=function()
	v0:Notify({Title="Warning!",Content="You Need a Diamond Axe to Let This Work! Use the Diamond Axe When Break Beds!",Duration=20,Image=4483362458,Actions={Ignore={Name="Okay!",Callback=function()
		print("The user tapped Okay!");
	end}}});
end});
local v4 = v2:CreateButton({Name="Open HOST/ADMIN PANEL(OP)",Callback=function()
	loadstring(game:HttpGet("https://pastebin.com/raw/tW45gRs0"))();
end});
local v2 = v1:CreateTab("Other");
local v3 = v2:CreateSection("Other");
local v4 = v2:CreateButton({Name="Infinite Yield",Callback=function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))();
end});
local v4 = v2:CreateButton({Name="Vape V4",Callback=function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/7GrandDadPGN/VapeV4ForRoblox/main/NewMainScript.lua", true))();
end});
local v4 = v2:CreateButton({Name="AutoClicker",Callback=function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/JustEzpi/ROBLOX-Scripts/main/ROBLOX_AutoClicker", true))();
end});
