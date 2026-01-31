local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- LOADING SCREEN
local function CreateLoadingScreen()
    local LoadingGui = Instance.new("ScreenGui")
    LoadingGui.Name = "MEVHubLoading"
    LoadingGui.ResetOnSpawn = false
    LoadingGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    LoadingGui.IgnoreGuiInset = true
    LoadingGui.Parent = PlayerGui
    
    local Background = Instance.new("Frame")
    Background.Name = "Background"
    Background.Size = UDim2.new(1, 0, 1, 0)
    Background.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
    Background.BorderSizePixel = 0
    Background.Parent = LoadingGui
    
    local UIGradient = Instance.new("UIGradient")
    UIGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(20, 20, 40)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(30, 30, 60)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(15, 15, 30))
    })
    UIGradient.Rotation = 45
    UIGradient.Parent = Background
    
    local ParticlesFrame = Instance.new("Frame")
    ParticlesFrame.Name = "Particles"
    ParticlesFrame.Size = UDim2.new(1, 0, 1, 0)
    ParticlesFrame.BackgroundTransparency = 1
    ParticlesFrame.Parent = Background
    
    for i = 1, 20 do
        spawn(function()
            local particle = Instance.new("Frame")
            particle.Name = "Particle" .. i
            particle.Size = UDim2.new(0, math.random(3, 8), 0, math.random(3, 8))
            particle.Position = UDim2.new(math.random(), 0, math.random(), 0)
            particle.BackgroundColor3 = Color3.fromRGB(138, 43, 226)
            particle.BorderSizePixel = 0
            particle.BackgroundTransparency = math.random(5, 8) / 10
            particle.Parent = ParticlesFrame
            
            local corner = Instance.new("UICorner")
            corner.CornerRadius = UDim.new(1, 0)
            corner.Parent = particle
            
            while LoadingGui.Parent do
                local newPos = UDim2.new(math.random(), 0, math.random(), 0)
                local tween = TweenService:Create(particle, TweenInfo.new(math.random(3, 6), Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                    Position = newPos,
                    BackgroundTransparency = math.random(5, 9) / 10
                })
                tween:Play()
                tween.Completed:Wait()
            end
        end)
    end
    
    local CenterContainer = Instance.new("Frame")
    CenterContainer.Name = "CenterContainer"
    CenterContainer.Size = UDim2.new(0, 400, 0, 300)
    CenterContainer.Position = UDim2.new(0.5, 0, 0.5, 0)
    CenterContainer.AnchorPoint = Vector2.new(0.5, 0.5)
    CenterContainer.BackgroundTransparency = 1
    CenterContainer.Parent = Background
    
    local LogoCircle = Instance.new("Frame")
    LogoCircle.Name = "LogoCircle"
    LogoCircle.Size = UDim2.new(0, 100, 0, 100)
    LogoCircle.Position = UDim2.new(0.5, 0, 0.2, 0)
    LogoCircle.AnchorPoint = Vector2.new(0.5, 0.5)
    LogoCircle.BackgroundColor3 = Color3.fromRGB(138, 43, 226)
    LogoCircle.BorderSizePixel = 0
    LogoCircle.Parent = CenterContainer
    
    local LogoCorner = Instance.new("UICorner")
    LogoCorner.CornerRadius = UDim.new(1, 0)
    LogoCorner.Parent = LogoCircle
    
    local LogoGlow = Instance.new("ImageLabel")
    LogoGlow.Name = "Glow"
    LogoGlow.Size = UDim2.new(1.5, 0, 1.5, 0)
    LogoGlow.Position = UDim2.new(0.5, 0, 0.5, 0)
    LogoGlow.AnchorPoint = Vector2.new(0.5, 0.5)
    LogoGlow.BackgroundTransparency = 1
    LogoGlow.Image = "rbxassetid://5028857084"
    LogoGlow.ImageColor3 = Color3.fromRGB(138, 43, 226)
    LogoGlow.ImageTransparency = 0.5
    LogoGlow.Parent = LogoCircle
    
    local VolleyballEmoji = Instance.new("TextLabel")
    VolleyballEmoji.Name = "Emoji"
    VolleyballEmoji.Size = UDim2.new(1, 0, 1, 0)
    VolleyballEmoji.BackgroundTransparency = 1
    VolleyballEmoji.Text = "V"
    VolleyballEmoji.TextSize = 50
    VolleyballEmoji.Font = Enum.Font.GothamBlack
    VolleyballEmoji.TextColor3 = Color3.fromRGB(255, 255, 255)
    VolleyballEmoji.Parent = LogoCircle
    
    local Title = Instance.new("TextLabel")
    Title.Name = "Title"
    Title.Size = UDim2.new(1, 0, 0, 50)
    Title.Position = UDim2.new(0.5, 0, 0.45, 0)
    Title.AnchorPoint = Vector2.new(0.5, 0.5)
    Title.BackgroundTransparency = 1
    Title.Text = "MEV HUB"
    Title.TextSize = 42
    Title.Font = Enum.Font.GothamBlack
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextTransparency = 1
    Title.Parent = CenterContainer
    
    local TitleGradient = Instance.new("UIGradient")
    TitleGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(138, 43, 226)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 255, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(138, 43, 226))
    })
    TitleGradient.Parent = Title
    
    local Subtitle = Instance.new("TextLabel")
    Subtitle.Name = "Subtitle"
    Subtitle.Size = UDim2.new(1, 0, 0, 25)
    Subtitle.Position = UDim2.new(0.5, 0, 0.55, 0)
    Subtitle.AnchorPoint = Vector2.new(0.5, 0.5)
    Subtitle.BackgroundTransparency = 1
    Subtitle.Text = "Current Supported Games: 1"
    Subtitle.TextSize = 18
    Subtitle.Font = Enum.Font.Gotham
    Subtitle.TextColor3 = Color3.fromRGB(180, 180, 180)
    Subtitle.TextTransparency = 1
    Subtitle.Parent = CenterContainer
    
    local Creator = Instance.new("TextLabel")
    Creator.Name = "Creator"
    Creator.Size = UDim2.new(1, 0, 0, 20)
    Creator.Position = UDim2.new(0.5, 0, 0.65, 0)
    Creator.AnchorPoint = Vector2.new(0.5, 0.5)
    Creator.BackgroundTransparency = 1
    Creator.Text = "Created by blue2k"
    Creator.TextSize = 16
    Creator.Font = Enum.Font.GothamMedium
    Creator.TextColor3 = Color3.fromRGB(138, 43, 226)
    Creator.TextTransparency = 1
    Creator.Parent = CenterContainer
    
    local LoadingBarBg = Instance.new("Frame")
    LoadingBarBg.Name = "LoadingBarBg"
    LoadingBarBg.Size = UDim2.new(0.7, 0, 0, 8)
    LoadingBarBg.Position = UDim2.new(0.5, 0, 0.8, 0)
    LoadingBarBg.AnchorPoint = Vector2.new(0.5, 0.5)
    LoadingBarBg.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
    LoadingBarBg.BorderSizePixel = 0
    LoadingBarBg.Parent = CenterContainer
    
    local LoadingBarBgCorner = Instance.new("UICorner")
    LoadingBarBgCorner.CornerRadius = UDim.new(1, 0)
    LoadingBarBgCorner.Parent = LoadingBarBg
    
    local LoadingBarFill = Instance.new("Frame")
    LoadingBarFill.Name = "Fill"
    LoadingBarFill.Size = UDim2.new(0, 0, 1, 0)
    LoadingBarFill.BackgroundColor3 = Color3.fromRGB(138, 43, 226)
    LoadingBarFill.BorderSizePixel = 0
    LoadingBarFill.Parent = LoadingBarBg
    
    local LoadingBarFillCorner = Instance.new("UICorner")
    LoadingBarFillCorner.CornerRadius = UDim.new(1, 0)
    LoadingBarFillCorner.Parent = LoadingBarFill
    
    local LoadingGradient = Instance.new("UIGradient")
    LoadingGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(138, 43, 226)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(180, 100, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(138, 43, 226))
    })
    LoadingGradient.Parent = LoadingBarFill
    
    local LoadingText = Instance.new("TextLabel")
    LoadingText.Name = "LoadingText"
    LoadingText.Size = UDim2.new(1, 0, 0, 20)
    LoadingText.Position = UDim2.new(0.5, 0, 0.88, 0)
    LoadingText.AnchorPoint = Vector2.new(0.5, 0.5)
    LoadingText.BackgroundTransparency = 1
    LoadingText.Text = "Loading..."
    LoadingText.TextSize = 14
    LoadingText.Font = Enum.Font.Gotham
    LoadingText.TextColor3 = Color3.fromRGB(150, 150, 150)
    LoadingText.Parent = CenterContainer
    
    local SpinRing = Instance.new("ImageLabel")
    SpinRing.Name = "SpinRing"
    SpinRing.Size = UDim2.new(0, 130, 0, 130)
    SpinRing.Position = UDim2.new(0.5, 0, 0.2, 0)
    SpinRing.AnchorPoint = Vector2.new(0.5, 0.5)
    SpinRing.BackgroundTransparency = 1
    SpinRing.Image = "rbxassetid://11419725435"
    SpinRing.ImageColor3 = Color3.fromRGB(138, 43, 226)
    SpinRing.ImageTransparency = 0.3
    SpinRing.Parent = CenterContainer
    
    spawn(function()
        while LoadingGui.Parent do
            SpinRing.Rotation = SpinRing.Rotation + 2
            RunService.RenderStepped:Wait()
        end
    end)
    
    spawn(function()
        while LoadingGui.Parent do
            local pulseOut = TweenService:Create(LogoCircle, TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                Size = UDim2.new(0, 110, 0, 110)
            })
            pulseOut:Play()
            pulseOut.Completed:Wait()
            
            local pulseIn = TweenService:Create(LogoCircle, TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                Size = UDim2.new(0, 100, 0, 100)
            })
            pulseIn:Play()
            pulseIn.Completed:Wait()
        end
    end)
    
    spawn(function()
        local rotation = 0
        while LoadingGui.Parent do
            rotation = rotation + 1
            TitleGradient.Rotation = rotation
            LoadingGradient.Rotation = rotation * 2
            wait(0.03)
        end
    end)
    
    wait(0.5)
    
    TweenService:Create(Title, TweenInfo.new(0.8, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
        TextTransparency = 0
    }):Play()
    
    wait(0.3)
    
    TweenService:Create(Subtitle, TweenInfo.new(0.8, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
        TextTransparency = 0
    }):Play()
    
    wait(0.3)
    
    TweenService:Create(Creator, TweenInfo.new(0.8, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
        TextTransparency = 0
    }):Play()
    
    wait(0.3)
    
    local loadingSteps = {
        {text = "Initializing...", progress = 0.2},
        {text = "Loading modules...", progress = 0.4},
        {text = "Preparing features...", progress = 0.6},
        {text = "Setting up UI...", progress = 0.8},
        {text = "Almost ready...", progress = 0.95},
        {text = "Done!", progress = 1}
    }
    
    for _, step in ipairs(loadingSteps) do
        LoadingText.Text = step.text
        TweenService:Create(LoadingBarFill, TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
            Size = UDim2.new(step.progress, 0, 1, 0)
        }):Play()
        wait(0.5)
    end
    
    wait(0.3)
    
    TweenService:Create(Background, TweenInfo.new(0.8, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
        BackgroundTransparency = 1
    }):Play()
    
    for _, child in pairs(CenterContainer:GetChildren()) do
        if child:IsA("TextLabel") then
            TweenService:Create(child, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                TextTransparency = 1
            }):Play()
        elseif child:IsA("Frame") then
            TweenService:Create(child, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                BackgroundTransparency = 1
            }):Play()
        elseif child:IsA("ImageLabel") then
            TweenService:Create(child, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                ImageTransparency = 1
            }):Play()
        end
    end
    
    TweenService:Create(LogoCircle, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
        BackgroundTransparency = 1
    }):Play()
    
    TweenService:Create(SpinRing, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
        ImageTransparency = 1
    }):Play()
    
    TweenService:Create(LogoGlow, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
        ImageTransparency = 1
    }):Play()
    
    TweenService:Create(VolleyballEmoji, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
        TextTransparency = 1
    }):Play()
    
    wait(0.8)
    
    LoadingGui:Destroy()
end

CreateLoadingScreen()

-- LOAD RAYFIELD
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- VARIABLES
local HitboxEnabled = false
local HitboxSize = 5.9
local HitboxColor = Color3.fromRGB(0, 255, 0)

local JumpESPEnabled = false
local JumpESPColor = Color3.fromRGB(255, 0, 0)

local PredictAimEnabled = false
local PredictAimColor = Color3.fromRGB(255, 255, 0)
local PredictAimLength = 15

local AutoStrongServeEnabled = false

local JumpESPObjects = {}
local PredictAimObjects = {}

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
    local spikeDirection = (lookVector + Vector3.new(0, -0.5, 0)).Unit
    
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
    point.Parent = workspace
    
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
        local spikeDirection = (lookVector + Vector3.new(0, -0.5, 0)).Unit
        
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
                        existingHitbox.CFrame = part.CFrame
                    else
                        local hitbox = Instance.new("Part")
                        hitbox.Name = "ExtendedHitbox"
                        hitbox.Size = Vector3.new(HitboxSize, HitboxSize, HitboxSize)
                        hitbox.Transparency = 0.8
                        hitbox.Color = HitboxColor
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
                    if isJumping(player) then
                        if not PredictAimObjects[player] then
                            createPredictLine(player)
                        else
                            updatePredictLine(player)
                        end
                    else
                        removePredictLine(player)
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
    CurrentValue = false,
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
    CurrentValue = 5.9,
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
    CurrentValue = false,
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
    CurrentValue = 15,
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
