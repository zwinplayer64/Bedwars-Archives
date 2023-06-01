runcode(function()
	local funnyfly = {["Enabled"] = false}
	local funnyflyhigh = {["Enabled"] = true}
	local flyacprogressbar
	local flyacprogressbarframe
	local flyacprogressbarframe2
	local flyacprogressbartext
	local bodyvelo
	funnyfly = GuiLibrary["ObjectsThatCanBeSaved"]["BlatantWindow"]["Api"].CreateOptionsButton({
		["Name"] = "GravityFunnyFly",
		["Function"] = function(callback)
			if callback then 
				workspace.Gravity = 150
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
									if (not funnyfly["Enabled"]) then break end
									bodyvelo.Velocity = vec3(0, i * (funnyflyhigh["Enabled"] and 2 or 1), 0)
								end
								if (not isnetworkowner(root)) then
									break 
								end
							else
								break
							end
						until (not funnyfly["Enabled"])
					else
						local warning = createwarning("FunnyFly", "FunnyFly only works with\nspeed on CFrame mode", 5)
						pcall(function()
							warning:GetChildren()[5].Position = UDim2.new(0, 46, 0, 38)
						end)
					end
					if funnyfly["Enabled"] then 
						funnyfly["ToggleButton"](false)
					end
				end)
			else
				workspace.Gravity = 196.2
				if bodyvelo then 
					bodyvelo:Destroy()
					bodyvelo = nil
				end
			end
		end
	})
	funnyflyhigh = funnyfly.CreateToggle({
		["Name"] = "High",
		["Function"] = function() end,
		["Default"] = true
	})
end)