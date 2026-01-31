local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- LOAD RAYFIELD
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- LOAD SAVED CONFIG
local function loadConfig()
    local success, result = pcall(function()
        return Rayfield:GetConfiguration("MEVHub", "VolleyballLegends")
    end)
    
    if success and result then
        if result.HitboxToggle ~= nil then
            HitboxEnabled = result.HitboxToggle
        end
        if result.HitboxSize then
            HitboxSize = result.HitboxSize
        end
        if result.HitboxColor then
            HitboxColor = result.HitboxColor
        end
        if result.JumpESPToggle ~= nil then
            JumpESPEnabled = result.JumpESPToggle
        end
        if result.JumpESPColor then
            JumpESPColor = result.JumpESPColor
        end
        if result.PredictAimToggle ~= nil then
            PredictAimEnabled = result.PredictAimToggle
        end
        if result.PredictAimColor then
            PredictAimColor = result.PredictAimColor
        end
        if result.PredictAimLength then
            PredictAimLength = result.PredictAimLength
        end
        if result.AutoStrongServeToggle ~= nil then
            AutoStrongServeEnabled = result.AutoStrongServeToggle
        end
    end
end

-- VARIABLES
local HitboxEnabled = true
local HitboxSize = 10
local HitboxColor = Color3.fromRGB(0, 255, 0)

local JumpESPEnabled = false
local JumpESPColor = Color3.fromRGB(255, 0, 0)

local PredictAimEnabled = true
local PredictAimColor = Color3.fromRGB(255, 255, 0)
local PredictAimLength = 25

local AutoStrongServeEnabled = false

local JumpESPObjects = {}
local PredictAimObjects = {}

loadConfig()

-- FUNCTIONS
local function getPlayerTeam(player)
    if player.Team then
        return player.Team
    end
    return nil
end

local function isEnemy(player)
    if player == LocalPlayer then
        return false
    end
    
    local localTeam = getPlayerTeam(LocalPlayer)
    local playerTeam = getPlayerTeam(player)
    
    if localTeam and playerTeam then
        return localTeam ~= playerTeam
    end
    
    return true
end

local function isJumping(player)
    local character = player.Character
    if not character then 
        return false 
    end
    
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    
    if humanoid and rootPart then
        local state = humanoid:GetState()
        if state == Enum.HumanoidStateType.Jumping or state == Enum.HumanoidStateType.Freefall then
            return true
        end
        
        if rootPart.AssemblyLinearVelocity.Y > 5 then
            return true
        end
    end
    
    return false
end

local function createJumpESP(player)
    local character = player.Character
    if not character then 
        return 
    end
    
    if JumpESPObjects[player] then
        JumpESPObjects[player]:Destroy()
        JumpESPObjects[player] = nil
    end
    
    local highlight = Instance.new("Highlight")
    highlight.Name = "JumpESP"
    highlight.Adornee = character
    highlight.FillColor = JumpESPColor
    highlight.OutlineColor = JumpESPColor
    highlight.FillTransparency = 0.5
    highlight.OutlineTransparency = 0
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.Parent = character
    
    JumpESPObjects[player] = highlight
end

local function removeJumpESP(player)
    if JumpESPObjects[player] then
        JumpESPObjects[player]:Destroy()
        JumpESPObjects[player] = nil
    end
end

local function createPredictLine(player)
    local character = player.Character
    if not character then 
        return 
    end
    
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    local head = character:FindFirstChild("Head")
    if not rootPart or not head then 
        return 
    end
    
    if PredictAimObjects[player] then
        if PredictAimObjects[player].Line then
            PredictAimObjects[player].Line:Destroy()
        end
        if PredictAimObjects[player].Point then
            PredictAimObjects[player].Point:Destroy()
        end
        PredictAimObjects[player] = nil
    end
    
    local lookVector = rootPart.CFrame.LookVector
    local spikeDirection = lookVector.Unit
    
    local line = Instance.new("Part")
    line.Name = "PredictLine"
    line.Anchored = true
    line.CanCollide = false
    line.Material = Enum.Material.Neon
    line.Color = PredictAimColor
    line.Size = Vector3.new(0.2, 0.2, PredictAimLength)
    line.Transparency = 0.3
    
    local startPos = head.Position + Vector3.new(0, 1, 0)
    local endPos = startPos + (spikeDirection * PredictAimLength)
    local midPoint = (startPos + endPos) / 2
    
    line.CFrame = CFrame.lookAt(midPoint, endPos)
    line.Parent = workspace
    
    local point = Instance.new("Part")
    point.Name = "PredictPoint"
    point.Anchored = true
    point.CanCollide = false
    point.Material = Enum.Material.Neon
    point.Color = PredictAimColor
    point.Size = Vector3.new(1, 1, 1)
    point.Shape = Enum.PartType.Ball
    point.Transparency = 0.3
    point.Position = endPos
    -- point.Parent = workspace -- Commented out to remove the ball
    
    PredictAimObjects[player] = {
        Line = line,
        Point = point
    }
end

local function updatePredictLine(player)
    local character = player.Character
    if not character then 
        return 
    end
    
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    local head = character:FindFirstChild("Head")
    if not rootPart or not head then 
        return 
    end
    
    if PredictAimObjects[player] then
        local lookVector = rootPart.CFrame.LookVector
        local spikeDirection = lookVector.Unit
        
        local startPos = head.Position + Vector3.new(0, 1, 0)
        local endPos = startPos + (spikeDirection * PredictAimLength)
        local midPoint = (startPos + endPos) / 2
        
        if PredictAimObjects[player].Line then
            PredictAimObjects[player].Line.Size = Vector3.new(0.2, 0.2, PredictAimLength)
            PredictAimObjects[player].Line.CFrame = CFrame.lookAt(midPoint, endPos)
            PredictAimObjects[player].Line.Color = PredictAimColor
        end
        
        if PredictAimObjects[player].Point then
            PredictAimObjects[player].Point.Position = endPos
            PredictAimObjects[player].Point.Color = PredictAimColor
        end
    end
end

local function removePredictLine(player)
    if PredictAimObjects[player] then
        if PredictAimObjects[player].Line then
            PredictAimObjects[player].Line:Destroy()
        end
        if PredictAimObjects[player].Point then
            PredictAimObjects[player].Point:Destroy()
        end
        PredictAimObjects[player] = nil
    end
end

local function clearAllJumpESP()
    for player, obj in pairs(JumpESPObjects) do
        if obj then
            obj:Destroy()
        end
    end
    JumpESPObjects = {}
end

local function clearAllPredictAim()
    for player, obj in pairs(PredictAimObjects) do
        if obj then
            if obj.Line then 
                obj.Line:Destroy() 
            end
            if obj.Point then 
                obj.Point:Destroy() 
            end
        end
    end
    PredictAimObjects = {}
end

local function modifyBallHitbox()
    for _, v in pairs(workspace:GetChildren()) do
        if v.Name:find("CLIENT_BALL") and v:IsA("Model") then
            for _, part in pairs(v:GetDescendants()) do
                if part:IsA("BasePart") and part.Name ~= "ExtendedHitbox" then
                    local existingHitbox = v:FindFirstChild("ExtendedHitbox")
                    
                    if existingHitbox then
                        existingHitbox.Size = Vector3.new(HitboxSize, HitboxSize, HitboxSize)
                        existingHitbox.Color = HitboxColor
                        existingHitbox.Material = Enum.Material.Neon
                        existingHitbox.CFrame = part.CFrame
                    else
                        local hitbox = Instance.new("Part")
                        hitbox.Name = "ExtendedHitbox"
                        hitbox.Size = Vector3.new(HitboxSize, HitboxSize, HitboxSize)
                        hitbox.Transparency = 0.8
                        hitbox.Color = HitboxColor
                        hitbox.Material = Enum.Material.Neon
                        hitbox.CanCollide = false
                        hitbox.CanTouch = true
                        hitbox.Massless = true
                        hitbox.Anchored = false
                        hitbox.Shape = Enum.PartType.Ball
                        hitbox.CFrame = part.CFrame
                        hitbox.Parent = v
                        
                        local weld = Instance.new("WeldConstraint")
                        weld.Part0 = part
                        weld.Part1 = hitbox
                        weld.Parent = hitbox
                    end
                end
            end
        end
    end
end

local function removeHitboxes()
    for _, v in pairs(workspace:GetChildren()) do
        if v.Name:find("CLIENT_BALL") and v:IsA("Model") then
            local hitbox = v:FindFirstChild("ExtendedHitbox")
            if hitbox then
                hitbox:Destroy()
            end
        end
    end
end

local function autoStrongServe()
    local playerGui = LocalPlayer:FindFirstChild("PlayerGui")
    if not playerGui then 
        return 
    end
    
    for _, gui in pairs(playerGui:GetDescendants()) do
        if gui:IsA("Frame") or gui:IsA("ImageLabel") then
            local bgColor = gui.BackgroundColor3
            local isPurple = (bgColor.R > 0.4 and bgColor.R < 0.7) and (bgColor.G < 0.3) and (bgColor.B > 0.6)
            
            if isPurple or gui.Name:lower():find("purple") or gui.Name:lower():find("strong") or gui.Name:lower():find("power") then
                local parent = gui.Parent
                if parent then
                    for _, child in pairs(parent:GetChildren()) do
                        if child:IsA("Frame") or child:IsA("ImageLabel") then
                            if child.Name:lower():find("indicator") or child.Name:lower():find("slider") or child.Name:lower():find("marker") then
                                local indicatorPos = child.AbsolutePosition.X + (child.AbsoluteSize.X / 2)
                                local purpleStart = gui.AbsolutePosition.X
                                local purpleEnd = purpleStart + gui.AbsoluteSize.X
                                
                                if indicatorPos >= purpleStart and indicatorPos <= purpleEnd then
                                    local VIM = game:GetService("VirtualInputManager")
                                    local mousePos = UserInputService:GetMouseLocation()
                                    VIM:SendMouseButtonEvent(mousePos.X, mousePos.Y, 0, true, game, 1)
                                    wait()
                                    VIM:SendMouseButtonEvent(mousePos.X, mousePos.Y, 0, false, game, 1)
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

-- MAIN LOOP
RunService.RenderStepped:Connect(function()
    if HitboxEnabled then
        pcall(function()
            modifyBallHitbox()
        end)
    end
    
    if JumpESPEnabled then
        pcall(function()
            for _, player in pairs(Players:GetPlayers()) do
                if isEnemy(player) then
                    if isJumping(player) then
                        if not JumpESPObjects[player] then
                            createJumpESP(player)
                        else
                            JumpESPObjects[player].FillColor = JumpESPColor
                            JumpESPObjects[player].OutlineColor = JumpESPColor
                        end
                    else
                        removeJumpESP(player)
                    end
                end
            end
        end)
    end
    
    if PredictAimEnabled then
        pcall(function()
            for _, player in pairs(Players:GetPlayers()) do
                if isEnemy(player) then
                    if not PredictAimObjects[player] then
                        createPredictLine(player)
                    else
                        updatePredictLine(player)
                    end
                end
            end
        end)
    end
    
    if AutoStrongServeEnabled then
        pcall(function()
            autoStrongServe()
        end)
    end
end)

Players.PlayerRemoving:Connect(function(player)
    removeJumpESP(player)
    removePredictLine(player)
end)

-- RAYFIELD UI
local Window = Rayfield:CreateWindow({
    Name = "MEV Hub | Volleyball Legends",
    Icon = 0,
    LoadingTitle = "MEV Hub",
    LoadingSubtitle = "by blue2k",
    ShowText = "MEV Hub",
    Theme = "Default",
    ToggleUIKeybind = "K",
    DisableRayfieldPrompts = false,
    DisableBuildWarnings = false,
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "MEVHub",
        FileName = "VolleyballLegends"
    },
    Discord = {
        Enabled = false,
        Invite = "noinvitelink",
        RememberJoins = true
    },
    KeySystem = false
})

local MainTab = Window:CreateTab("Main", 4483362458)

MainTab:CreateSection("Ball Hitbox")

MainTab:CreateToggle({
    Name = "Enable Ball Hitbox",
    CurrentValue = true,
    Flag = "HitboxToggle",
    Callback = function(Value)
        HitboxEnabled = Value
        if HitboxEnabled then
            Rayfield:Notify({
                Title = "Hitbox Enabled",
                Content = "Ball hitbox is now active!",
                Duration = 3,
                Image = 4483362458
            })
        else
            removeHitboxes()
            Rayfield:Notify({
                Title = "Hitbox Disabled",
                Content = "Ball hitbox has been removed!",
                Duration = 3,
                Image = 4483362458
            })
        end
    end
})

MainTab:CreateSlider({
    Name = "Hitbox Size",
    Range = {1, 20},
    Increment = 0.5,
    Suffix = " studs",
    CurrentValue = 10,
    Flag = "HitboxSize",
    Callback = function(Value)
        HitboxSize = Value
    end
})

MainTab:CreateColorPicker({
    Name = "Hitbox Color",
    Color = Color3.fromRGB(0, 255, 0),
    Flag = "HitboxColor",
    Callback = function(Value)
        HitboxColor = Value
    end
})

MainTab:CreateSection("Serve")

MainTab:CreateToggle({
    Name = "Auto Strong Serve",
    CurrentValue = false,
    Flag = "AutoStrongServeToggle",
    Callback = function(Value)
        AutoStrongServeEnabled = Value
        if AutoStrongServeEnabled then
            Rayfield:Notify({
                Title = "Auto Strong Serve Enabled",
                Content = "Will auto-hit the purple zone!",
                Duration = 3,
                Image = 4483362458
            })
        else
            Rayfield:Notify({
                Title = "Auto Strong Serve Disabled",
                Content = "Auto strong serve turned off!",
                Duration = 3,
                Image = 4483362458
            })
        end
    end
})

MainTab:CreateSection("Jump ESP")

MainTab:CreateToggle({
    Name = "Enable Jump ESP",
    CurrentValue = false,
    Flag = "JumpESPToggle",
    Callback = function(Value)
        JumpESPEnabled = Value
        if JumpESPEnabled then
            Rayfield:Notify({
                Title = "Jump ESP Enabled",
                Content = "Enemy jumps will now be highlighted!",
                Duration = 3,
                Image = 4483362458
            })
        else
            clearAllJumpESP()
            Rayfield:Notify({
                Title = "Jump ESP Disabled",
                Content = "Jump ESP has been disabled!",
                Duration = 3,
                Image = 4483362458
            })
        end
    end
})

MainTab:CreateColorPicker({
    Name = "Jump ESP Color",
    Color = Color3.fromRGB(255, 0, 0),
    Flag = "JumpESPColor",
    Callback = function(Value)
        JumpESPColor = Value
    end
})

MainTab:CreateSection("Predict Aim")

MainTab:CreateToggle({
    Name = "Enable Predict Aim",
    CurrentValue = true,
    Flag = "PredictAimToggle",
    Callback = function(Value)
        PredictAimEnabled = Value
        if PredictAimEnabled then
            Rayfield:Notify({
                Title = "Predict Aim Enabled",
                Content = "Spike prediction lines active!",
                Duration = 3,
                Image = 4483362458
            })
        else
            clearAllPredictAim()
            Rayfield:Notify({
                Title = "Predict Aim Disabled",
                Content = "Predict aim has been disabled!",
                Duration = 3,
                Image = 4483362458
            })
        end
    end
})

MainTab:CreateSlider({
    Name = "Prediction Length",
    Range = {5, 50},
    Increment = 1,
    Suffix = " studs",
    CurrentValue = 25,
    Flag = "PredictAimLength",
    Callback = function(Value)
        PredictAimLength = Value
    end
})

MainTab:CreateColorPicker({
    Name = "Predict Aim Color",
    Color = Color3.fromRGB(255, 255, 0),
    Flag = "PredictAimColor",
    Callback = function(Value)
        PredictAimColor = Value
    end
})

local SettingsTab = Window:CreateTab("Settings", 4483362458)

SettingsTab:CreateSection("Information")

SettingsTab:CreateParagraph({
    Title = "MEV Hub Features",
    Content = "Ball Hitbox - Expand ball hitbox\nAuto Strong Serve - Auto purple zone\nJump ESP - See enemy jumps\nPredict Aim - Predict spike direction\n\nDeveloped by blue2k\n\nThank you for using MEV Hub!"
})

SettingsTab:CreateSection("Credits")

SettingsTab:CreateParagraph({
    Title = "Credits",
    Content = "Developer: blue2k\nUI Library: Rayfield\n\nMore features coming soon!"
})

Rayfield:Notify({
    Title = "MEV Hub Loaded!",
    Content = "Welcome to MEV Hub for Volleyball Legends!",
    Duration = 5,
    Image = 4483362458
})
