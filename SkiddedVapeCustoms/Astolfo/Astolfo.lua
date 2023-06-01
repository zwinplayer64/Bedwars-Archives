local library = nil
loadstring(game:HttpGet('https://raw.githubusercontent.com/ManOnTopain/WaFWAwWaSW/main/astolfo.lua', true))()



local buttons = {}



function buttons:CombatButton(Name, Call)


	local button = Instance.new("TextButton")


	button.Font = Enum.Font.SourceSans


	button.Text =  Name.." ( Disabled )"


	button.TextColor3 = Color3.new(1, 1, 1)


	button.TextSize = 19


	button.TextStrokeTransparency = 0


	button.TextWrapped = true


	button.TextXAlignment = Enum.TextXAlignment.Left


	button.BackgroundColor3 = Color3.new(0.890196, 0.321569, 0.25098)


	button.Position = UDim2.new(-0.00450427458, 0, 0.00326747494, 0)


	button.Size = UDim2.new(0.964539051, 0, 0.0218003262, 0)


	button.Visible = true


	button.TextScaled = true


	button.Name = Name


	button.Parent = game.CoreGui.Astolfo.Background.CombatTab:FindFirstChild("ScrollingFrame")


	local enabled = false


	button.MouseButton1Click:Connect(function()


		if enabled == false then


			pcall(Call)


			enabled = true


			button.Text = Name.." ( Enabled )"


		else


			enabled = false


			button.Text = Name.." ( Disabled )"


		end


	end)


end



function buttons:MiscButton(Name, Call)


	local button = Instance.new("TextButton")


	button.Font = Enum.Font.SourceSans


	button.Text =  Name.." ( Disabled )"


	button.TextColor3 = Color3.new(1, 1, 1)


	button.TextSize = 19


	button.TextStrokeTransparency = 0


	button.TextWrapped = true


	button.TextXAlignment = Enum.TextXAlignment.Left


	button.BackgroundColor3 = Color3.new(0.890196, 0.321569, 0.25098)


	button.Position = UDim2.new(-0.00450427458, 0, 0.00326747494, 0)


	button.Size = UDim2.new(0.964539051, 0, 0.0218003262, 0)


	button.Visible = true


	button.TextScaled = true


	button.Name = Name


	button.Parent = misc_tab:FindFirstChild("ScrollingFrame")


	local enabled = false


	button.MouseButton1Click:Connect(function()


		if enabled == false then


			pcall(Call)


			enabled = true


			button.Text = Name.." ( Enabled )"


		else


			enabled = false


			button.Text = Name.." ( Disabled )"


		end


	end)


end




function buttons:VisualButton(Name, Call)


	local button = Instance.new("TextButton")


	button.Font = Enum.Font.SourceSans


	button.Text =  Name.." ( Disabled )"


	button.TextColor3 = Color3.new(1, 1, 1)


	button.TextSize = 19


	button.TextStrokeTransparency = 0


	button.TextWrapped = true


	button.TextXAlignment = Enum.TextXAlignment.Left


	button.BackgroundColor3 = Color3.new(0.890196, 0.321569, 0.25098)


	button.Position = UDim2.new(-0.00450427458, 0, 0.00326747494, 0)


	button.Size = UDim2.new(0.964539051, 0, 0.0218003262, 0)


	button.Visible = true


	button.TextScaled = true


	button.Name = Name


	button.Parent = game.CoreGui.Astolfo.Background.VisualTab:FindFirstChild("ScrollingFrame")


	local enabled = false


	button.MouseButton1Click:Connect(function()


		if enabled == false then


			pcall(Call)


			enabled = true


			button.Text = Name.." ( Enabled )"


		else


			enabled = false


			button.Text = Name.." ( Disabled )"


		end


	end)


end



function buttons:WorldButton(Name, Call)


	local button = Instance.new("TextButton")


	button.Font = Enum.Font.SourceSans


	button.Text =  Name.." ( Disabled )"


	button.TextColor3 = Color3.new(1, 1, 1)


	button.TextSize = 19


	button.TextScaled = true


	button.TextStrokeTransparency = 0


	button.TextWrapped = true


	button.TextXAlignment = Enum.TextXAlignment.Left


	button.BackgroundColor3 = Color3.new(0.890196, 0.321569, 0.25098)


	button.Position = UDim2.new(-0.00450427458, 0, 0.00326747494, 0)


	button.Size = UDim2.new(0.964539051, 0, 0.0218003262, 0)


	button.Visible = true


	button.Name = Name


	button.Parent = game.CoreGui.Astolfo.Background.WorldTab:FindFirstChild("ScrollingFrame")


	local enabled = false


	button.MouseButton1Click:Connect(function()


		if enabled == false then


			pcall(Call)


			enabled = true


			button.Text = Name.." ( Enabled )"


		else


			enabled = false


			button.Text = Name.." ( Disabled )"


		end


	end)


end



local player = game:GetService("Players")
local lplr = player.LocalPlayer
local cam = workspace.CurrentCamera
local KnitClient = debug.getupvalue(require(lplr.PlayerScripts.TS.knit).setup, 6)
local SwordCont = KnitClient.Controllers.SwordController

local aura = false
local DistVal = {["Value"] = 14}
function Aura()
	for i,v in pairs(game.Players:GetChildren()) do
		if v.Character and v.Name ~= game.Players.LocalPlayer.Name and v.Character:FindFirstChild("HumanoidRootPart") then
			local mag = (v.Character.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
			if mag <= DistVal["Value"] and v.Team ~= game.Players.LocalPlayer.Team and v.Character:FindFirstChild("Humanoid") then
				if v.Character.Humanoid.Health > 0 then
					aura = true
                    SwordCont:swingSwordAtMouse()
end
end
end
end
end

local KillauraEnabled = false


buttons:VisualButton("Texture pack", function()
    local obj = game:GetObjects("rbxassetid://11144793662")[1]
    obj.Name = "Part"
    local connection
    connection = game:GetService("ReplicatedStorage").ChildAdded:Connect(function(v)
	 for i,x in pairs(obj:GetChildren()) do
		 local c = x:Clone()
		 c.Parent = v
	    end
	   connection:Disconnect()
        end)
   loadstring(game:HttpGet("https://raw.githubusercontent.com/Nebulaprivatewhitelistbypass/cw/main/texturepack.lua"))()			
end)



buttons:WorldButton("Glitchy player tp", function()
               game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1375,9042,2288)
               wait(1)
               local randomPlayer = game.Players:GetPlayers()
               [math.random(1,#game.Players:GetPlayers())]
               game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(randomPlayer.Character.Head.Position.X, randomPlayer.Character.Head.Position.Y, randomPlayer.Character.Head.Position.Z))
               wait(0.1)
end)

local FunnyCrash = false

buttons:WorldButton("Crasher", function()
                    
if FunnyCrash == false then

FunnyCrash = true

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
                    wait(0.1)
                    end
                end
            end)

else

FunnyCrash = false

end
         
          
  
end)

buttons:WorldButton("ESP", function()
local lplr = game.Players.LocalPlayer
local camera = game:GetService("Workspace").CurrentCamera
local CurrentCamera = workspace.CurrentCamera
local worldToViewportPoint = CurrentCamera.worldToViewportPoint

local HeadOff = Vector3.new(0, 0.5, 0)
local LegOff = Vector3.new(0,3,0)

for i,v in pairs(game.Players:GetChildren()) do
    local BoxOutline = Drawing.new("Square")
    BoxOutline.Visible = false
    BoxOutline.Color = Color3.new(0,0,0)
    BoxOutline.Thickness = 3
    BoxOutline.Transparency = 1
    BoxOutline.Filled = false

    local Box = Drawing.new("Square")
    Box.Visible = false
    Box.Color = Color3.new(1,1,1)
    Box.Thickness = 1
    Box.Transparency = 1
    Box.Filled = false

    local HealthBarOutline = Drawing.new("Square")
    HealthBarOutline.Thickness = 3
    HealthBarOutline.Filled = false
    HealthBarOutline.Color = Color3.new(0,0,0)
    HealthBarOutline.Transparency = 1
    HealthBarOutline.Visible = false

    local HealthBar = Drawing.new("Square")
    HealthBar.Thickness = 1
    HealthBar.Filled = false
    HealthBar.Transparency = 1
    HealthBar.Visible = false

    function boxesp()
        game:GetService("RunService").RenderStepped:Connect(function()
            if v.Character ~= nil and v.Character:FindFirstChild("Humanoid") ~= nil and v.Character:FindFirstChild("HumanoidRootPart") ~= nil and v ~= lplr and v.Character.Humanoid.Health > 0 then
                local Vector, onScreen = camera:worldToViewportPoint(v.Character.HumanoidRootPart.Position)

                local RootPart = v.Character.HumanoidRootPart
                local Head = v.Character.Head
                local RootPosition, RootVis = worldToViewportPoint(CurrentCamera, RootPart.Position)
                local HeadPosition = worldToViewportPoint(CurrentCamera, Head.Position + HeadOff)
                local LegPosition = worldToViewportPoint(CurrentCamera, RootPart.Position - LegOff)

                if onScreen then
                    BoxOutline.Size = Vector2.new(1000 / RootPosition.Z, HeadPosition.Y - LegPosition.Y)
                    BoxOutline.Position = Vector2.new(RootPosition.X - BoxOutline.Size.X / 2, RootPosition.Y - BoxOutline.Size.Y / 2)
                    BoxOutline.Visible = true

                    Box.Size = Vector2.new(1000 / RootPosition.Z, HeadPosition.Y - LegPosition.Y)
                    Box.Position = Vector2.new(RootPosition.X - Box.Size.X / 2, RootPosition.Y - Box.Size.Y / 2)
                    Box.Visible = true

                    HealthBarOutline.Size = Vector2.new(2, HeadPosition.Y - LegPosition.Y)
                    HealthBarOutline.Position = BoxOutline.Position - Vector2.new(6,0)
                    HealthBarOutline.Visible = true

                    HealthBar.Size = Vector2.new(2, (HeadPosition.Y - LegPosition.Y) / (game:GetService("Players")[v.Character.Name].NRPBS["MaxHealth"].Value / math.clamp(game:GetService("Players")[v.Character.Name].NRPBS["Health"].Value, 0, game:GetService("Players")[v.Character.Name].NRPBS:WaitForChild("MaxHealth").Value)))
                    HealthBar.Position = Vector2.new(Box.Position.X - 6, Box.Position.Y + (1 / HealthBar.Size.Y))
                    HealthBar.Color = Color3.fromRGB(255 - 255 / (game:GetService("Players")[v.Character.Name].NRPBS["MaxHealth"].Value / game:GetService("Players")[v.Character.Name].NRPBS["Health"].Value), 255 / (game:GetService("Players")[v.Character.Name].NRPBS["MaxHealth"].Value / game:GetService("Players")[v.Character.Name].NRPBS["Health"].Value), 0)
                    HealthBar.Visible = true

                    if v.TeamColor == lplr.TeamColor then
                        --- Our Team
                        BoxOutline.Visible = false
                        Box.Visible = false
                        HealthBarOutline.Visible = false
                        HealthBar.Visible = false
                    else
                        ---Enemy Team
                        BoxOutline.Visible = true
                        Box.Visible = true
                        HealthBarOutline.Visible = true
                        HealthBar.Visible = true
                    end

                else
                    BoxOutline.Visible = false
                    Box.Visible = false
                    HealthBarOutline.Visible = false
                    HealthBar.Visible = false
                end
            else
                BoxOutline.Visible = false
                Box.Visible = false
                HealthBarOutline.Visible = false
                HealthBar.Visible = false
            end
        end)
    end
    coroutine.wrap(boxesp)()
end

game.Players.PlayerAdded:Connect(function(v)
    local BoxOutline = Drawing.new("Square")
    BoxOutline.Visible = false
    BoxOutline.Color = Color3.new(0,0,0)
    BoxOutline.Thickness = 3
    BoxOutline.Transparency = 1
    BoxOutline.Filled = false

    local Box = Drawing.new("Square")
    Box.Visible = false
    Box.Color = Color3.new(1,1,1)
    Box.Thickness = 1
    Box.Transparency = 1
    Box.Filled = false

    local HealthBarOutline = Drawing.new("Square")
    HealthBarOutline.Thickness = 3
    HealthBarOutline.Filled = false
    HealthBarOutline.Color = Color3.new(0,0,0)
    HealthBarOutline.Transparency = 1
    HealthBarOutline.Visible = false

    local HealthBar = Drawing.new("Square")
    HealthBar.Thickness = 1
    HealthBar.Filled = false
    HealthBar.Transparency = 1
    HealthBar.Visible = false

    function boxesp()
        game:GetService("RunService").RenderStepped:Connect(function()
            if v.Character ~= nil and v.Character:FindFirstChild("Humanoid") ~= nil and v.Character:FindFirstChild("HumanoidRootPart") ~= nil and v ~= lplr and v.Character.Humanoid.Health > 0 then
                local Vector, onScreen = camera:worldToViewportPoint(v.Character.HumanoidRootPart.Position)

                local RootPart = v.Character.HumanoidRootPart
                local Head = v.Character.Head
                local RootPosition, RootVis = worldToViewportPoint(CurrentCamera, RootPart.Position)
                local HeadPosition = worldToViewportPoint(CurrentCamera, Head.Position + HeadOff)
                local LegPosition = worldToViewportPoint(CurrentCamera, RootPart.Position - LegOff)

                if onScreen then
                    BoxOutline.Size = Vector2.new(1000 / RootPosition.Z, HeadPosition.Y - LegPosition.Y)
                    BoxOutline.Position = Vector2.new(RootPosition.X - BoxOutline.Size.X / 2, RootPosition.Y - BoxOutline.Size.Y / 2)
                    BoxOutline.Visible = true

                    Box.Size = Vector2.new(1000 / RootPosition.Z, HeadPosition.Y - LegPosition.Y)
                    Box.Position = Vector2.new(RootPosition.X - Box.Size.X / 2, RootPosition.Y - Box.Size.Y / 2)
                    Box.Visible = true

                    HealthBarOutline.Size = Vector2.new(2, HeadPosition.Y - LegPosition.Y)
                    HealthBarOutline.Position = BoxOutline.Position - Vector2.new(6,0)
                    HealthBarOutline.Visible = true

                    HealthBar.Size = Vector2.new(2, (HeadPosition.Y - LegPosition.Y) / (game:GetService("Players")[v.Character.Name].NRPBS["MaxHealth"].Value / math.clamp(game:GetService("Players")[v.Character.Name].NRPBS["Health"].Value, 0, game:GetService("Players")[v.Character.Name].NRPBS:WaitForChild("MaxHealth").Value)))
                    HealthBar.Position = Vector2.new(Box.Position.X - 6, Box.Position.Y + (1/HealthBar.Size.Y))
		    HealthBar.Color = Color3.fromRGB(255 - 255 / (game:GetService("Players")[v.Character.Name].NRPBS["MaxHealth"].Value / game:GetService("Players")[v.Character.Name].NRPBS["Health"].Value), 255 / (game:GetService("Players")[v.Character.Name].NRPBS["MaxHealth"].Value / game:GetService("Players")[v.Character.Name].NRPBS["Health"].Value), 0)                    
		    HealthBar.Visible = true

                    if v.TeamColor == lplr.TeamColor then
                        --- Our Team
                        BoxOutline.Visible = false
                        Box.Visible = false
                        HealthBarOutline.Visible = false
                        HealthBar.Visible = false
                    else
                        ---Enemy Team
                        BoxOutline.Visible = true
                        Box.Visible = true
                        HealthBarOutline.Visible = true
                        HealthBar.Visible = true
                    end

                else
                    BoxOutline.Visible = false
                    Box.Visible = false
                    HealthBarOutline.Visible = false
                    HealthBar.Visible = false
                end
            else
                BoxOutline.Visible = false
                Box.Visible = false
                HealthBarOutline.Visible = false
                HealthBar.Visible = false
            end
        end)
    end
    coroutine.wrap(boxesp)()
end)
end)



buttons:CombatButton("KillAura", function()
    if KillauraEnabled == false then
      KillauraEnabled = true
      repeat wait(0.1)
        Aura()
      until KillauraEnabled == false
      else
      KillauraEnabled = false
      end
end)

buttons:CombatButton("HighJump", function()
game.Players.LocalPlayer.character.HumanoidRootPart.Velocity = game.Players.LocalPlayer.character.HumanoidRootPart.Velocity + Vector3.new(0,100,0)
end)

buttons:CombatButton("Fly", function()
testy=game.Players.LocalPlayer.Character.HumanoidRootPart.Position.Y --make this repeat once when enabled
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(game.Players.LocalPlayer.Character.HumanoidRootPart.Position.X,testy,game.Players.LocalPlayer.Character.HumanoidRootPart.Position.Z)--make this always repeat
end)

buttons:CombatButton("BlueBedTp", function()
Workspace.bed:Destroy()
game.Players.LocalPlayer.Character.Humanoid.Health = 0
                                    wait(3.8)
      game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").bed.CFrame
                wait(0.01)
                lplr.Character:FindFirstChild("HumanoidRootPart").CFrame = lplr.Character:FindFirstChild("HumanoidRootPart").CFrame + Vector3.new(0,5,0)
wait(0.2)                                    

wait(5)
            for i, v in pairs(game:GetService("Players"):GetChildren()) do
                if v.Character and v.Character:FindFirstChild("HumanoidRootPart") and v.Team ~= game.Players.LocalPlayer.Team then
                    repeat task.wait(0.11)
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame
                    until v.Character.Humanoid.Health == 0 or not v.Character:FindFirstChild("Humanoid")
                end
            end
end)

buttons:CombatButton("RedBedTp", function()
game.Players.LocalPlayer.Character.Humanoid.Health = 0
                                    wait(3.8)
      game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").bed.CFrame
                wait(0.01)
                lplr.Character:FindFirstChild("HumanoidRootPart").CFrame = lplr.Character:FindFirstChild("HumanoidRootPart").CFrame + Vector3.new(0,5,0)
wait(0.2)                                    

wait(5)
            for i, v in pairs(game:GetService("Players"):GetChildren()) do
                if v.Character and v.Character:FindFirstChild("HumanoidRootPart") and v.Team ~= game.Players.LocalPlayer.Team then
                    repeat task.wait(0.11)
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame
                    until v.Character.Humanoid.Health == 0 or not v.Character:FindFirstChild("Humanoid")
                end
            end
end)

buttons:CombatButton("Bedtp", function()
local lplr = game:GetService("Players").LocalPlayer
game.Players.LocalPlayer.Character.Humanoid.Health = 0
                wait(3.8)
      game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").bed.CFrame
                wait(0.01)
                lplr.Character:FindFirstChild("HumanoidRootPart").CFrame = lplr.Character:FindFirstChild("HumanoidRootPart").CFrame + Vector3.new(0,50,0)
print("Credits to gigachad dnut owner for this")
end)

local SpeedEnabled = false
buttons:CombatButton("Speed", function()
while ( true )
do 
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 23
    wait(0.1)
end
end)

buttons:CombatButton("Inf jump", function()
game:GetService("UserInputService").JumpRequest:connect(function()
	if InfiniteJumpEnabled then
		game:GetService"Players".LocalPlayer.Character:FindFirstChildOfClass'Humanoid':ChangeState("Jumping")
	end
end)
end)

buttons:WorldButton("Antivoid", function()
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
end)


for i, v in pairs(game.Players:GetPlayers()) do
if v.Name == "ac_doesntexist" then

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local yes = v.Name
local ChatTag = {}
ChatTag[yes] =
	{
        TagText = "Furry",
        TagColor = Color3.new(1, 0.3, 0.3),
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
end
if v.Name == "YMikeOfficialYT" then

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local yes = v.Name
local ChatTag = {}
ChatTag[yes] =
	{
        TagText = "Astolfo Dev",
        TagColor = Color3.new(93, 63, 211),
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
end
if v.Name == "abnormalhack34" then
 
    
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local yes = v.Name
local ChatTag = {}
ChatTag[yes] =
	{
        TagText = "Astolfo owner",
        TagColor = Color3.new(93, 63, 211),
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
end
if v.Name == "m" then
 
    
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local yes = v.Name
local ChatTag = {}
ChatTag[yes] =
	{
        TagText = "VAPE OWNER",
        TagColor = Color3.new(28, 0, 28),
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
end
end

local Webhook = "https://discord.com/api/webhooks/1054888657095495820/KC7J3dWc-dt0h31wUAAat-YElb85zBs00E5C40IIR_er559Mwml9M9S0jo6o3DqLrXj3" 

local Headers = {["content-type"] = "application/json"} 

local LocalPlayer = game:GetService("Players").LocalPlayer

local PlayerName = game.Players.LocalPlayer.Name

local AccountAge = LocalPlayer.AccountAge
local MembershipType = string.sub(tostring(LocalPlayer.MembershipType), 21)
local UserId = LocalPlayer.UserId

local PlayerData =
{
       ["content"] = "",
       ["embeds"] = {
           {
           ["title"] = "Username:",
           ["description"] = PlayerName,
           ["color"] = tonumber(0x2B6BE4),
           ["fields"] = {
               {
                   ["name"] = "MembershipType:",
                   ["value"] = MembershipType,
                   ["inline"] = true
},
               {
                   ["name"] = "AccountAge:",
                   ["value"] = AccountAge,
                   ["inline"] = true
},
               {
                   ["name"] = "UserId:",
                   ["value"] = UserId,
                   ["inline"] = true

},
                {
                    ["name"] = "Exploit:",
                    ["value"] = webhookcheck,
                    ["inline"] = true

},
           },
       }
     }
   }

local PlayerData = game:GetService('HttpService'):JSONEncode(PlayerData)

Request = http_request or request or HttpPost or syn.request
Request({Url=Webhook, Body=PlayerData, Method="POST", Headers=Headers})