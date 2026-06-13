-- Shelly's Museum V2.0 [Rayfield Edition]
-- Optimized Event-Driven Architecture | Real-Time Render Tracking

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:FindFirstChildOfClass("PlayerGui") or LocalPlayer:WaitForChild("PlayerGui")

-- Instantly purge previous interface footprints
if PlayerGui:FindFirstChild("ShellyMuseumV2") then
    PlayerGui.ShellyMuseumV2:Destroy()
end

-- Top-Level UI Environment
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ShellyMuseumV2"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = PlayerGui

-- Global State Machine Tables
local Flags = {
    TwistedESP = false,
    GeneratorESP = false
}

local RenderCache = {
    Twisteds = {},
    Generators = {}
}

-- ==========================================
-- STAGE 1: RAYFIELD-STYLE SPRING LOADING
-- ==========================================
local LoaderContainer = Instance.new("Frame")
LoaderContainer.Name = "LoaderContainer"
LoaderContainer.Size = UDim2.new(0, 260, 0, 90)
LoaderContainer.Position = UDim2.new(0.5, -130, 0.5, -45)
LoaderContainer.BackgroundColor3 = Color3.fromRGB(21, 21, 24)
LoaderContainer.BorderSizePixel = 0
LoaderContainer.ClipsDescendants = true
LoaderContainer.Parent = ScreenGui
Instance.new("UICorner", LoaderContainer).CornerRadius = UDim.new(0, 9)

local LoaderStroke = Instance.new("UIStroke")
LoaderStroke.Color = Color3.fromRGB(38, 38, 44)
LoaderStroke.Thickness = 1
LoaderStroke.Parent = LoaderContainer

local LoaderLabel = Instance.new("TextLabel")
LoaderLabel.Size = UDim2.new(1, 0, 0, 45)
LoaderLabel.Position = UDim2.new(0, 0, 0, 10)
LoaderLabel.BackgroundTransparency = 1
LoaderLabel.Text = "Rayfield UI Engine initializing..."
LoaderLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
LoaderLabel.TextSize = 13
LoaderLabel.Font = Enum.Font.Ubuntu
LoaderLabel.Parent = LoaderContainer

local ProgressTrack = Instance.new("Frame")
ProgressTrack.Size = UDim2.new(0.85, 0, 0, 5)
ProgressTrack.Position = UDim2.new(0.075, 0, 0, 55)
ProgressTrack.BackgroundColor3 = Color3.fromRGB(29, 29, 35)
ProgressTrack.BorderSizePixel = 0
ProgressTrack.Parent = LoaderContainer
Instance.new("UICorner", ProgressTrack).CornerRadius = UDim.new(0, 3)

local ProgressFill = Instance.new("Frame")
ProgressFill.Size = UDim2.new(0, 0, 1, 0)
ProgressFill.BackgroundColor3 = Color3.fromRGB(74, 114, 226) -- Signature Rayfield Accent Blue
ProgressFill.BorderSizePixel = 0
ProgressFill.Parent = ProgressTrack
Instance.new("UICorner", ProgressFill).CornerRadius = UDim.new(0, 3)

-- Rayfield Exponential In-Out Easing Sequence
local LoadAnim = TweenService:Create(ProgressFill, TweenInfo.new(1.2, Enum.EasingStyle.Exponential, Enum.EasingDirection.InOut), {Size = UDim2.new(1, 0, 1, 0)})
LoadAnim:Play()
LoadAnim.Completed:Wait()
task.wait(0.1)

-- Shrink Dismissal Frame Effect
local DismissAnim = TweenService:Create(LoaderContainer, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Size = UDim2.new(0, 0, 0, 0)})
DismissAnim:Play()
DismissAnim.Completed:Wait()
LoaderContainer:Destroy()

-- ==========================================
-- STAGE 2: MAIN RAYFIELD DASHBOARD CONTROL
-- ==========================================
local WindowFrame = Instance.new("Frame")
WindowFrame.Name = "WindowFrame"
WindowFrame.Size = UDim2.new(0, 400, 0, 240)
WindowFrame.Position = UDim2.new(0.5, -200, 0.5, -120)
WindowFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
WindowFrame.BorderSizePixel = 0
WindowFrame.Active = true
WindowFrame.Parent = ScreenGui
Instance.new("UICorner", WindowFrame).CornerRadius = UDim.new(0, 9)

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(35, 35, 42)
MainStroke.Thickness = 1
MainStroke.Parent = WindowFrame

-- Header Construction
local HeaderBar = Instance.new("Frame")
HeaderBar.Name = "HeaderBar"
HeaderBar.Size = UDim2.new(1, 0, 0, 40)
HeaderBar.BackgroundColor3 = Color3.fromRGB(24, 24, 28)
HeaderBar.BorderSizePixel = 0
HeaderBar.Parent = WindowFrame
Instance.new("UICorner", HeaderBar).CornerRadius = UDim.new(0, 9)

local HeaderTitle = Instance.new("TextLabel")
HeaderTitle.Size = UDim2.new(1, -60, 1, 0)
HeaderTitle.Position = UDim2.new(0, 14, 0, 0)
HeaderTitle.BackgroundTransparency = 1
HeaderTitle.Text = "Shelly's Museum v2.0 — Rayfield Framework"
HeaderTitle.TextColor3 = Color3.fromRGB(240, 240, 245)
HeaderTitle.TextSize = 13
HeaderTitle.Font = Enum.Font.Ubuntu
HeaderTitle.TextXAlignment = Enum.TextXAlignment.Left
HeaderTitle.Parent = HeaderBar

local ExitBtn = Instance.new("TextButton")
ExitBtn.Size = UDim2.new(0, 24, 0, 24)
ExitBtn.Position = UDim2.new(1, -34, 0, 8)
ExitBtn.BackgroundColor3 = Color3.fromRGB(28, 28, 34)
ExitBtn.Text = "✕"
ExitBtn.TextColor3 = Color3.fromRGB(150, 150, 160)
ExitBtn.TextSize = 11
ExitBtn.Font = Enum.Font.Ubuntu
ExitBtn.Parent = HeaderBar
Instance.new("UICorner", ExitBtn).CornerRadius = UDim.new(0, 5)

local ExitStroke = Instance.new("UIStroke")
ExitStroke.Color = Color3.fromRGB(45, 45, 52)
ExitStroke.Thickness = 1
ExitStroke.Parent = ExitBtn

-- Structural Panels
local NavigationPanel = Instance.new("Frame")
NavigationPanel.Size = UDim2.new(0.28, 0, 1, -40)
NavigationPanel.Position = UDim2.new(0, 0, 0, 40)
NavigationPanel.BackgroundColor3 = Color3.fromRGB(21, 21, 25)
NavigationPanel.BorderSizePixel = 0
NavigationPanel.Parent = WindowFrame

local WorkspacePanel = Instance.new("Frame")
WorkspacePanel.Size = UDim2.new(0.72, 0, 1, -40)
WorkspacePanel.Position = UDim2.new(0.28, 0, 0, 40)
WorkspacePanel.BackgroundTransparency = 1
WorkspacePanel.Parent = WindowFrame

local WorkspacePadding = Instance.new("UIPadding")
WorkspacePadding.Parent = WorkspacePanel
WorkspacePadding.PaddingTop = UDim.new(0, 14)
WorkspacePadding.PaddingLeft = UDim.new(0, 14)
WorkspacePadding.PaddingRight = UDim.new(0, 14)

local WorkspaceLayout = Instance.new("UIListLayout")
WorkspaceLayout.Parent = WorkspacePanel
WorkspaceLayout.SortOrder = Enum.SortOrder.LayoutOrder
WorkspaceLayout.Padding = UDim.new(0, 9)

-- Tab Sidebar Anchor
local ActiveTabIndicator = Instance.new("TextButton")
ActiveTabIndicator.Size = UDim2.new(0.85, 0, 0, 32)
ActiveTabIndicator.Position = UDim2.new(0.075, 0, 0, 12)
ActiveTabIndicator.BackgroundColor3 = Color3.fromRGB(28, 33, 48)
ActiveTabIndicator.Text = "Visuals"
ActiveTabIndicator.TextColor3 = Color3.fromRGB(110, 148, 242)
ActiveTabIndicator.TextSize = 12
ActiveTabIndicator.Font = Enum.Font.Ubuntu
ActiveTabIndicator.Parent = NavigationPanel
Instance.new("UICorner", ActiveTabIndicator).CornerRadius = UDim.new(0, 5)

local TabStroke = Instance.new("UIStroke")
TabStroke.Color = Color3.fromRGB(44, 56, 92)
TabStroke.Thickness = 1
TabStroke.Parent = ActiveTabIndicator

-- ==========================================
-- STAGE 3: CORE WORKSPACE VECTOR PROCESSING
-- ==========================================
local function GenerateTrackingAdornment(targetInstance, coreColor, identificationTag)
    if not targetInstance:IsA("Model") and not targetInstance:IsA("BasePart") then return end
    
    local AttachmentRoot = targetInstance:IsA("Model") and targetInstance.PrimaryPart or targetInstance
    if not AttachmentRoot then
        AttachmentRoot = targetInstance:FindFirstChildWhichIsA("BasePart")
    end
    if not AttachmentRoot or AttachmentRoot:FindFirstChild("TrackingModule") then return end

    local BillboardGui = Instance.new("BillboardGui")
    BillboardGui.Name = "TrackingModule"
    BillboardGui.AlwaysOnTop = true
    BillboardGui.Size = UDim2.new(0, 120, 0, 25)
    BillboardGui.Adornee = AttachmentRoot
    BillboardGui.Parent = AttachmentRoot

    local TagLabel = Instance.new("TextLabel")
    TagLabel.Size = UDim2.new(1, 0, 1, 0)
    TagLabel.BackgroundTransparency = 1
    TagLabel.Text = identificationTag
    TagLabel.TextColor3 = coreColor
    TagLabel.TextSize = 11
    TagLabel.Font = Enum.Font.Ubuntu
    TagLabel.TextStrokeTransparency = 0.4
    TagLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    TagLabel.Parent = BillboardGui
    
    -- High-performance Box Highlight overlay
    local BoxHighlight = Instance.new("BoxHandleAdornment")
    BoxHighlight.Name = "VisualHighlight"
    BoxHighlight.Size = targetInstance:IsA("Model") and targetInstance:GetExtentsSize() or targetInstance.Size
    BoxHighlight.AlwaysOnTop = true
    BoxHighlight.ZIndex = 5
    BoxHighlight.Adornee = AttachmentRoot
    BoxHighlight.Color3 = coreColor
    BoxHighlight.Transparency = 0.72
    BoxHighlight.Parent = AttachmentRoot

    return {Billboard = BillboardGui, Highlight = BoxHighlight}
end

local function ClearTrackingAdornment(targetInstance)
    local AttachmentRoot = targetInstance:IsA("Model") and targetInstance.PrimaryPart or targetInstance
    if not AttachmentRoot then AttachmentRoot = targetInstance:FindFirstChildWhichIsA("BasePart") end
    if AttachmentRoot then
        local foundBillboard = AttachmentRoot:FindFirstChild("TrackingModule")
        local foundHighlight = AttachmentRoot:FindFirstChild("VisualHighlight")
        if foundBillboard then foundBillboard:Destroy() end
        if foundHighlight then foundHighlight:Destroy() end
    end
end

-- Efficient Dynamic State Toggles
local function ProcessTrackingStateChange(trackingType, globalFlag)
    local structuralCache = RenderCache[trackingType]
    for targetObj, elements in pairs(structuralCache) do
        if globalFlag then
            if not targetObj:FindFirstChild("TrackingModule") then
                local labelName = (trackingType == "Twisteds") and "⚠️ [Twisted]" or "⚙️ [Generator]"
                local themeColor = (trackingType == "Twisteds") and Color3.fromRGB(242, 102, 102) or Color3.fromRGB(102, 242, 137)
                RenderCache[trackingType][targetObj] = GenerateTrackingAdornment(targetObj, themeColor, labelName)
            end
        else
            ClearTrackingAdornment(targetObj)
        end
    end
end

-- ==========================================
-- STAGE 4: DISCOVERY PIPELINES (EVENT-DRIVEN)
-- ==========================================
local function CategorizeAndHookInstance(descendant)
    local targetName = string.lower(descendant.Name)
    
    if string.find(targetName, "twisted") then
        RenderCache.Twisteds[descendant] = true
        if Flags.TwistedESP then
            RenderCache.Twisteds[descendant] = GenerateTrackingAdornment(descendant, Color3.fromRGB(242, 102, 102), "⚠️ [Twisted]")
        end
    elseif string.find(targetName, "generator") or string.find(targetName, "machine") then
        RenderCache.Generators[descendant] = true
        if Flags.GeneratorESP then
            RenderCache.Generators[descendant] = GenerateTrackingAdornment(descendant, Color3.fromRGB(102, 242, 137), "⚙️ [Generator]")
        end
    end
end

local function DecoupleAndPurgeInstance(descendant)
    if RenderCache.Twisteds[descendant] then
        ClearTrackingAdornment(descendant)
        RenderCache.Twisteds[descendant] = nil
    elseif RenderCache.Generators[descendant] then
        ClearTrackingAdornment(descendant)
        RenderCache.Generators[descendant] = nil
    end
end

-- Map current loaded environment spaces instantly
for _, item in ipairs(Workspace:GetDescendants()) do
    task.spawn(CategorizeAndHookInstance, item)
end

Workspace.DescendantAdded:Connect(CategorizeAndHookInstance)
Workspace.DescendantRemoving:Connect(DecoupleAndPurgeInstance)

-- ==========================================
-- STAGE 5: COMPONENT BUILDER & ELEMENT COMPOSITION
-- ==========================================
local function BuildRayfieldToggle(labelText, controlFlagKey, trackingTypeKey)
    local ElementRow = Instance.new("Frame")
    ElementRow.Size = UDim2.new(1, 0, 0, 38)
    ElementRow.BackgroundColor3 = Color3.fromRGB(24, 24, 28)
    ElementRow.BorderSizePixel = 0
    ElementRow.Parent = WorkspacePanel
    Instance.new("UICorner", ElementRow).CornerRadius = UDim.new(0, 5)
    
    local RowStroke = Instance.new("UIStroke")
    RowStroke.Color = Color3.fromRGB(33, 33, 38)
    RowStroke.Thickness = 1
    RowStroke.Parent = ElementRow
    
    local ElementLabel = Instance.new("TextLabel")
    ElementLabel.Size = UDim2.new(0.65, 0, 1, 0)
    ElementLabel.Position = UDim2.new(0, 12, 0, 0)
    ElementLabel.BackgroundTransparency = 1
    ElementLabel.Text = labelText
    ElementLabel.TextColor3 = Color3.fromRGB(200, 200, 205)
    ElementLabel.TextSize = 12
    ElementLabel.Font = Enum.Font.Ubuntu
    ElementLabel.TextXAlignment = Enum.TextXAlignment.Left
    ElementLabel.Parent = ElementRow
    
    local ToggleHousing = Instance.new("TextButton")
    ToggleHousing.Size = UDim2.new(0, 42, 0, 22)
    ToggleHousing.Position = UDim2.new(1, -54, 0.5, -11)
    ToggleHousing.BackgroundColor3 = Color3.fromRGB(35, 35, 42)
    ToggleHousing.Text = ""
    ToggleHousing.Parent = ElementRow
    Instance.new("UICorner", ToggleHousing).CornerRadius = UDim.new(0, 11)
    
    local SwitchPin = Instance.new("Frame")
    SwitchPin.Size = UDim2.new(0, 16, 0, 16)
    SwitchPin.Position = UDim2.new(0, 3, 0.5, -8)
    SwitchPin.BackgroundColor3 = Color3.fromRGB(150, 150, 160)
    SwitchPin.BorderSizePixel = 0
    SwitchPin.Parent = ToggleHousing
    Instance.new("UICorner", SwitchPin).CornerRadius = UDim.new(0, 8)
    
    ToggleHousing.MouseButton1Click:Connect(function()
        Flags[controlFlagKey] = not Flags[controlFlagKey]
        
        -- High-Fidelity Fluid Spring Animations
        local MatchPinX = Flags[controlFlagKey] and UDim2.new(0, 23, 0.5, -8) or UDim2.new(0, 3, 0.5, -8)
        local MatchHousingColor = Flags[controlFlagKey] and Color3.fromRGB(74, 114, 226) or Color3.fromRGB(35, 35, 42)
        local MatchPinColor = Flags[controlFlagKey] and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(150, 150, 160)
        
        TweenService:Create(SwitchPin, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = MatchPinX, BackgroundColor3 = MatchPinColor}):Play()
        TweenService:Create(ToggleHousing, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundColor3 = MatchHousingColor}):Play()
        
        ProcessTrackingStateChange(trackingTypeKey, Flags[controlFlagKey])
    end)
end

BuildRayfieldToggle("Twisted ESP", "TwistedESP", "Twisteds")
BuildRayfieldToggle("Generator ESP", "GeneratorESP", "Generators")

-- ==========================================
-- STAGE 6: DRAG & DISMISSAL ROUTINES
-- ==========================================
ExitBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

local TouchDraggingActive, ScreenStartPoints, InitialFramePositions
HeaderBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        TouchDraggingActive = true
        ScreenStartPoints = input.Position
        InitialFramePositions = WindowFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then TouchDraggingActive = false end
        end)
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if TouchDraggingActive and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local InputDelta = input.Position - ScreenStartPoints
        TweenService:Create(WindowFrame, TweenInfo.new(0.05, Enum.EasingStyle.Linear), {
            Position = UDim2.new(InitialFramePositions.X.Scale, InitialFramePositions.X.Offset + InputDelta.X, InitialFramePositions.Y.Scale, InitialFramePositions.Y.Offset + InputDelta.Y)
        }):Play()
    end
end)
