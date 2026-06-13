-- Shelly's Museum V2.0 
-- Built from scratch | Guaranteed Execution | 100% Mobile Fluid Layout

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:FindFirstChildOfClass("PlayerGui") or LocalPlayer:WaitForChild("PlayerGui")

-- Clean up any lingering UI instances instantly
if PlayerGui:FindFirstChild("ShellyMuseumV2") then
    PlayerGui.ShellyMuseumV2:Destroy()
end

-- Top-level UI Engine
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ShellyMuseumV2"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = PlayerGui

-- ==========================================
-- STAGE 1: IMMERSIVE SYSTEM LOADING SCREEN
-- ==========================================
local LoaderContainer = Instance.new("Frame")
LoaderContainer.Name = "LoaderContainer"
LoaderContainer.Size = UDim2.new(0, 240, 0, 85)
LoaderContainer.Position = UDim2.new(0.5, -120, 0.5, -42) -- Perfect screen center
LoaderContainer.BackgroundColor3 = Color3.fromRGB(24, 23, 20)
LoaderContainer.BorderSizePixel = 0
LoaderContainer.Parent = ScreenGui

local LoaderCorner = Instance.new("UICorner")
LoaderCorner.CornerRadius = UDim.new(0, 8)
LoaderCorner.Parent = LoaderContainer

local LoaderLabel = Instance.new("TextLabel")
LoaderLabel.Size = UDim2.new(1, 0, 0, 40)
LoaderLabel.Position = UDim2.new(0, 0, 0, 10)
LoaderLabel.BackgroundTransparency = 1
LoaderLabel.Text = "Synchronizing Data..."
LoaderLabel.TextColor3 = Color3.fromRGB(245, 195, 115) -- Amber Gold
LoaderLabel.TextSize = 12
LoaderLabel.Font = Enum.Font.GothamBold
LoaderLabel.Parent = LoaderContainer

local ProgressTrack = Instance.new("Frame")
ProgressTrack.Size = UDim2.new(0.8, 0, 0, 4)
ProgressTrack.Position = UDim2.new(0.1, 0, 0, 52)
ProgressTrack.BackgroundColor3 = Color3.fromRGB(38, 33, 27)
ProgressTrack.BorderSizePixel = 0
ProgressTrack.Parent = LoaderContainer
Instance.new("UICorner", ProgressTrack).CornerRadius = UDim.new(0, 2)

local ProgressFill = Instance.new("Frame")
ProgressFill.Size = UDim2.new(0, 0, 1, 0)
ProgressFill.BackgroundColor3 = Color3.fromRGB(205, 145, 65)
ProgressFill.BorderSizePixel = 0
ProgressFill.Parent = ProgressTrack
Instance.new("UICorner", ProgressFill).CornerRadius = UDim.new(0, 2)

-- Handle linear interpolation loading bar safely
local LoadBarAnimation = TweenService:Create(ProgressFill, TweenInfo.new(1.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(1, 0, 1, 0)})
LoadBarAnimation:Play()
LoadBarAnimation.Completed:Wait()
task.wait(0.15)
LoaderContainer:Destroy()

-- ==========================================
-- STAGE 2: MAIN CONTROL ARCHITECTURE
-- ==========================================
local WindowFrame = Instance.new("Frame")
WindowFrame.Name = "WindowFrame"
WindowFrame.Size = UDim2.new(0, 360, 0, 220)
WindowFrame.Position = UDim2.new(0.5, -180, 0.5, -110)
WindowFrame.BackgroundColor3 = Color3.fromRGB(24, 23, 20)
WindowFrame.BorderSizePixel = 0
WindowFrame.Active = true
WindowFrame.Parent = ScreenGui

local WindowCorner = Instance.new("UICorner")
WindowCorner.CornerRadius = UDim.new(0, 8)
WindowCorner.Parent = WindowFrame

-- Header Bar Component
local HeaderBar = Instance.new("Frame")
HeaderBar.Name = "HeaderBar"
HeaderBar.Size = UDim2.new(1, 0, 0, 36)
HeaderBar.BackgroundColor3 = Color3.fromRGB(38, 33, 27)
HeaderBar.BorderSizePixel = 0
HeaderBar.Parent = WindowFrame

local HeaderCorner = Instance.new("UICorner")
HeaderCorner.CornerRadius = UDim.new(0, 8)
HeaderCorner.Parent = HeaderBar

local HeaderTitle = Instance.new("TextLabel")
HeaderTitle.Size = UDim2.new(1, -50, 1, 0)
HeaderTitle.Position = UDim2.new(0, 12, 0, 0)
HeaderTitle.BackgroundTransparency = 1
HeaderTitle.Text = "Shelly's Museum V2.0"
HeaderTitle.TextColor3 = Color3.fromRGB(245, 195, 115)
HeaderTitle.TextSize = 13
HeaderTitle.Font = Enum.Font.GothamBold
HeaderTitle.TextXAlignment = Enum.TextXAlignment.Left
HeaderTitle.Parent = HeaderBar

local ExitBtn = Instance.new("TextButton")
ExitBtn.Size = UDim2.new(0, 22, 0, 22)
ExitBtn.Position = UDim2.new(1, -30, 0, 7)
ExitBtn.BackgroundColor3 = Color3.fromRGB(180, 60, 60)
ExitBtn.Text = "✕"
ExitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ExitBtn.TextSize = 10
ExitBtn.Font = Enum.Font.GothamBold
ExitBtn.Parent = HeaderBar
Instance.new("UICorner", ExitBtn).CornerRadius = UDim.new(0, 4)

-- Safe Grid Windows (Using strict percentages to prevent overflow glitches)
local NavigationPanel = Instance.new("Frame")
NavigationPanel.Size = UDim2.new(0.28, 0, 1, -36)
NavigationPanel.Position = UDim2.new(0, 0, 0, 36)
NavigationPanel.BackgroundColor3 = Color3.fromRGB(31, 29, 25)
NavigationPanel.BorderSizePixel = 0
NavigationPanel.Parent = WindowFrame

local WorkspacePanel = Instance.new("Frame")
WorkspacePanel.Size = UDim2.new(0.72, 0, 1, -36)
WorkspacePanel.Position = UDim2.new(0.28, 0, 0, 36)
WorkspacePanel.BackgroundTransparency = 1
WorkspacePanel.Parent = WindowFrame

local WorkspacePadding = Instance.new("UIPadding")
WorkspacePadding.Parent = WorkspacePanel
WorkspacePadding.PaddingTop = UDim.new(0, 12)
WorkspacePadding.PaddingLeft = UDim.new(0, 12)
WorkspacePadding.PaddingRight = UDim.new(0, 12)

local WorkspaceLayout = Instance.new("UIListLayout")
WorkspaceLayout.Parent = WorkspacePanel
WorkspaceLayout.SortOrder = Enum.SortOrder.LayoutOrder
WorkspaceLayout.Padding = UDim.new(0, 8)

-- Static Visual Category Designator
local NavCategoryIndicator = Instance.new("TextButton")
NavCategoryIndicator.Size = UDim2.new(0.85, 0, 0, 30)
NavCategoryIndicator.Position = UDim2.new(0.075, 0, 0, 10)
NavCategoryIndicator.BackgroundColor3 = Color3.fromRGB(43, 38, 31)
NavCategoryIndicator.Text = "Visual"
NavCategoryIndicator.TextColor3 = Color3.fromRGB(245, 195, 115)
NavCategoryIndicator.TextSize = 11
NavCategoryIndicator.Font = Enum.Font.GothamBold
NavCategoryIndicator.Parent = NavigationPanel
Instance.new("UICorner", NavCategoryIndicator).CornerRadius = UDim.new(0, 4)

-- ==========================================
-- STAGE 3: INTERACTIVE MODULE CONFIGURATOR
-- ==========================================
local function BuildToggleElement(labelText)
    local ElementRow = Instance.new("Frame")
    ElementRow.Size = UDim2.new(1, 0, 0, 36)
    ElementRow.BackgroundColor3 = Color3.fromRGB(28, 26, 23)
    ElementRow.BorderSizePixel = 0
    ElementRow.Parent = WorkspacePanel
    Instance.new("UICorner", ElementRow).CornerRadius = UDim.new(0, 4)
    
    local ElementLabel = Instance.new("TextLabel")
    ElementLabel.Size = UDim2.new(0.65, 0, 1, 0)
    ElementLabel.Position = UDim2.new(0, 10, 0, 0)
    ElementLabel.BackgroundTransparency = 1
    ElementLabel.Text = labelText
    ElementLabel.TextColor3 = Color3.fromRGB(185, 180, 170)
    ElementLabel.TextSize = 11
    ElementLabel.Font = Enum.Font.Gotham
    ElementLabel.TextXAlignment = Enum.TextXAlignment.Left
    ElementLabel.Parent = ElementRow
    
    local ActionTrigger = Instance.new("TextButton")
    ActionTrigger.Size = UDim2.new(0, 45, 0, 20)
    ActionTrigger.Position = UDim2.new(1, -55, 0.5, -10)
    ActionTrigger.BackgroundColor3 = Color3.fromRGB(45, 42, 37)
    ActionTrigger.Text = "OFF"
    ActionTrigger.TextColor3 = Color3.fromRGB(220, 90, 90)
    ActionTrigger.TextSize = 9
    ActionTrigger.Font = Enum.Font.GothamBold
    ActionTrigger.Parent = ElementRow
    Instance.new("UICorner", ActionTrigger).CornerRadius = UDim.new(0, 4)
    
    -- Fluid Linear State Transitions
    local CoreToggleState = false
    ActionTrigger.MouseButton1Click:Connect(function()
        CoreToggleState = not CoreToggleState
        local ColorGoal = CoreToggleState and Color3.fromRGB(75, 160, 95) or Color3.fromRGB(45, 42, 37)
        local TextGoal = CoreToggleState and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(220, 90, 90)
        
        TweenService:Create(ActionTrigger, TweenInfo.new(0.1, Enum.EasingStyle.Linear), {
            BackgroundColor3 = ColorGoal,
            TextColor3 = TextGoal
        }):Play()
        
        ActionTrigger.Text = CoreToggleState and "ON" or "OFF"
    end)
end

-- Load pure, scannable elements inside absolute layout space
BuildToggleElement("Toon Tracker ESP")
BuildToggleElement("Wall-Chams Engine")

-- ==========================================
-- STAGE 4: HARDWARE DRAG INTEGRATION
-- ==========================================
ExitBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

local TouchDraggingActive, DeviceInputSource, ScreenStartPoints, InitialFramePositions
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
        TweenService:Create(WindowFrame, TweenInfo.new(0.04, Enum.EasingStyle.Linear), {
            Position = UDim2.new(InitialFramePositions.X.Scale, InitialFramePositions.X.Offset + InputDelta.X, InitialFramePositions.Y.Scale, InitialFramePositions.Y.Offset + InputDelta.Y)
        }):Play()
    end
end)
