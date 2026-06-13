-- Shelly's Museum V2.1 [Custom Performance Edition]
-- Fixes: Highlight Limits, Persistent Toggle Engine, Added Items ESP

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:FindFirstChildOfClass("PlayerGui") or LocalPlayer:WaitForChild("PlayerGui")

-- Instantly clear any older active versions
if PlayerGui:FindFirstChild("ShellyMuseumV21") then
    PlayerGui.ShellyMuseumV21:Destroy()
end

-- Core UI Layer Setup
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ShellyMuseumV21"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = PlayerGui

-- Global State Machine Tables
local Flags = {
    TwistedESP = false,
    GeneratorESP = false,
    ItemESP = false
}

local RenderTracker = {
    Twisteds = {},
    Generators = {},
    Items = {}
}

-- Target Identification Keywords (Dandy's World Workspace Strings)
local ItemNames = {"tape", "medkit", "candy", "speed", "bandage", "capsule", "health"}

-- ==========================================
-- STAGE 1: LOGO BUTTON ENGAGEMENT ENGINE
-- ==========================================
local LogoToggleBtn = Instance.new("TextButton")
LogoToggleBtn.Name = "LogoToggleBtn"
LogoToggleBtn.Size = UDim2.new(0, 50, 0, 50)
LogoToggleBtn.Position = UDim2.new(0, 15, 0.4, 0)
LogoToggleBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 36)
LogoToggleBtn.Text = "S"
LogoToggleBtn.TextColor3 = Color3.fromRGB(242, 102, 102)
LogoToggleBtn.TextSize = 22
LogoToggleBtn.Font = Enum.Font.FredokaOne
LogoToggleBtn.Visible = false  -- Visible only when main window is closed
LogoToggleBtn.Parent = ScreenGui
Instance.new("UICorner", LogoToggleBtn).CornerRadius = UDim.new(0, 12)

local LogoStroke = Instance.new("UIStroke")
LogoStroke.Color = Color3.fromRGB(50, 50, 60)
LogoStroke.Thickness = 2
LogoStroke.Parent = LogoToggleBtn

-- ==========================================
-- STAGE 2: MAIN DASHBOARD STRUCTURING
-- ==========================================
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 360, 0, 260)
MainFrame.Position = UDim2.new(0.5, -180, 0.5, -130)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 24)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Parent = ScreenGui
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)

local PanelStroke = Instance.new("UIStroke")
PanelStroke.Color = Color3.fromRGB(40, 40, 48)
PanelStroke.Thickness = 1
PanelStroke.Parent = MainFrame

-- Header
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 42)
Header.BackgroundColor3 = Color3.fromRGB(28, 28, 34)
Header.BorderSizePixel = 0
Header.Parent = MainFrame
Instance.new("UICorner", Header).CornerRadius = UDim.new(0, 10)

local HeaderTitle = Instance.new("TextLabel")
HeaderTitle.Size = UDim2.new(1, -50, 1, 0)
HeaderTitle.Position = UDim2.new(0, 14, 0, 0)
HeaderTitle.BackgroundTransparency = 1
HeaderTitle.Text = "SHELLY'S HUB — V2.1"
HeaderTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
HeaderTitle.TextSize = 14
HeaderTitle.Font = Enum.Font.SourceSansBold
HeaderTitle.TextXAlignment = Enum.TextXAlignment.Left
HeaderTitle.Parent = Header

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 26, 0, 26)
CloseBtn.Position = UDim2.new(1, -36, 0, 8)
CloseBtn.BackgroundColor3 = Color3.fromRGB(38, 38, 46)
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
CloseBtn.TextSize = 12
CloseBtn.Font = Enum.Font.SourceSansBold
CloseBtn.Parent = Header
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 6)

-- Container Layout
local ContentLayout = Instance.new("Frame")
ContentLayout.Size = UDim2.new(1, 0, 1, -42)
ContentLayout.Position = UDim2.new(0, 0, 0, 42)
ContentLayout.BackgroundTransparency = 1
ContentLayout.Parent = MainFrame

local ListPadding = Instance.new("UIPadding")
ListPadding.PaddingTop = UDim.new(0, 12)
ListPadding.PaddingLeft = UDim.new(0, 14)
ListPadding.PaddingRight = UDim.new(0, 14)
ListPadding.Parent = ContentLayout

local UIList = Instance.new("UIListLayout")
UIList.SortOrder = Enum.SortOrder.LayoutOrder
UIList.Padding = UDim.new(0, 10)
UIList.Parent = ContentLayout

-- ==========================================
-- STAGE 3: CHAMS & HIGHLIGHT GRAPHICS ENGINE
-- ==========================================
local function ApplyVisualEffects(instance, coreColor, tagString)
    -- Locate valid assignment model root structural bounds
    local rootPart = instance:IsA("Model") and (instance.PrimaryPart or instance:FindFirstChildWhichIsA("BasePart")) or (instance:IsA("BasePart") and instance)
    if not rootPart or instance:FindFirstChild("ESPHighlight") then return end

    -- TRUE ENGINE OUTLINE RENDERING: Uses clean global Highlight components instead of box clusters
    local Highlight = Instance.new("Highlight")
    Highlight.Name = "ESPHighlight"
    Highlight.FillColor = coreColor
    Highlight.FillTransparency = 0.65
    Highlight.OutlineColor = coreColor
    Highlight.OutlineTransparency = 0.1
    Highlight.Adornee = instance
    Highlight.Parent = instance

    -- Tag Label Render Overlays
    local Billboard = Instance.new("BillboardGui")
    Billboard.Name = "ESPBillboard"
    Billboard.Size = UDim2.new(0, 150, 0, 30)
    Billboard.AlwaysOnTop = true
    Billboard.Adornee = rootPart
    Billboard.Parent = instance

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, 0, 1, 0)
    Label.BackgroundTransparency = 1
    Label.Text = tagString
    Label.TextColor3 = coreColor
    Label.TextSize = 13
    Label.Font = Enum.Font.SourceSansBold
    Label.TextStrokeTransparency = 0.2
    Label.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    Label.Parent = Billboard
end

local function CleanVisualEffects(instance)
    local high = instance:FindFirstChild("ESPHighlight")
    local bill = instance:FindFirstChild("ESPBillboard")
    if high then high:Destroy() end
    if bill then bill:Destroy() end
end

-- Efficient Dynamic State Toggles
local function RefreshTrackingStates(category, flagValue, color, labelText)
    for obj, _ in pairs(RenderTracker[category]) do
        if flagValue then
            if not obj:FindFirstChild("ESPHighlight") then
                ApplyVisualEffects(obj, color, labelText)
            end
        else
            CleanVisualEffects(obj)
        end
    end
end

-- ==========================================
-- STAGE 4: AUTOMATED DISCOVERY SCANNER
-- ==========================================
local function IdentifyAndHook(descendant)
    local lowerName = string.lower(descendant.Name)
    
    -- Twisteds Identification
    if string.find(lowerName, "twisted") then
        RenderTracker.Twisteds[descendant] = true
        if Flags.TwistedESP then ApplyVisualEffects(descendant, Color3.fromRGB(255, 50, 50), "⚠️ TWISTED") end
        
    -- Generators Identification
    elseif string.find(lowerName, "generator") or string.find(lowerName, "machine") then
        RenderTracker.Generators[descendant] = true
        if Flags.GeneratorESP then ApplyVisualEffects(descendant, Color3.fromRGB(50, 255, 120), "⚙️ GENERATOR") end
        
    -- Items Identification Engine
    else
        for _, match in ipairs(ItemNames) do
            if string.find(lowerName, match) then
                RenderTracker.Items[descendant] = true
                if Flags.ItemESP then ApplyVisualEffects(descendant, Color3.fromRGB(240, 200, 50), "📦 " .. string.upper(descendant.Name)) end
                break
            end
        end
    end
end

local function UnhookAndPurge(descendant)
    if RenderTracker.Twisteds[descendant] then
        CleanVisualEffects(descendant)
        RenderTracker.Twisteds[descendant] = nil
    elseif RenderTracker.Generators[descendant] then
        CleanVisualEffects(descendant)
        RenderTracker.Generators[descendant] = nil
    elseif RenderTracker.Items[descendant] then
        CleanVisualEffects(descendant)
        RenderTracker.Items[descendant] = nil
    end
end

-- Immediate Environment Scan Sweep Execution
for _, item in ipairs(Workspace:GetDescendants()) do
    task.spawn(IdentifyAndHook, item)
end

Workspace.DescendantAdded:Connect(IdentifyAndHook)
Workspace.DescendantRemoving:Connect(UnhookAndPurge)

-- ==========================================
-- STAGE 5: COMPONENT LAYOUT DESIGNER
-- ==========================================
local function CreateRowToggle(labelText, flagKey, trackerKey, activeColor, espTagText)
    local Row = Instance.new("Frame")
    Row.Size = UDim2.new(1, 0, 0, 44)
    Row.BackgroundColor3 = Color3.fromRGB(26, 26, 32)
    Row.BorderSizePixel = 0
    Row.Parent = ContentLayout
    Instance.new("UICorner", Row).CornerRadius = UDim.new(0, 6)
    
    local RowStroke = Instance.new("UIStroke")
    RowStroke.Color = Color3.fromRGB(36, 36, 44)
    RowStroke.Thickness = 1
    RowStroke.Parent = Row

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0.6, 0, 1, 0)
    Label.Position = UDim2.new(0, 12, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Text = labelText
    Label.TextColor3 = Color3.fromRGB(220, 220, 225)
    Label.TextSize = 13
    Label.Font = Enum.Font.SourceSans
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = Row

    local SliderFrame = Instance.new("TextButton")
    SliderFrame.Size = UDim2.new(0, 46, 0, 22)
    SliderFrame.Position = UDim2.new(1, -58, 0.5, -11)
    SliderFrame.BackgroundColor3 = Color3.fromRGB(44, 44, 54)
    SliderFrame.Text = ""
    SliderFrame.Parent = Row
    Instance.new("UICorner", SliderFrame).CornerRadius = UDim.new(0, 11)

    local IndicatorPin = Instance.new("Frame")
    IndicatorPin.Size = UDim2.new(0, 16, 0, 16)
    IndicatorPin.Position = UDim2.new(0, 3, 0.5, -8)
    IndicatorPin.BackgroundColor3 = Color3.fromRGB(160, 160, 170)
    IndicatorPin.BorderSizePixel = 0
    IndicatorPin.Parent = SliderFrame
    Instance.new("UICorner", IndicatorPin).CornerRadius = UDim.new(0, 8)

    SliderFrame.MouseButton1Click:Connect(function()
        Flags[flagKey] = not Flags[flagKey]
        
        -- Non-blocking UI Sliding Tween Animations
        local TargetX = Flags[flagKey] and UDim2.new(0, 27, 0.5, -8) or UDim2.new(0, 3, 0.5, -8)
        local BaseColor = Flags[flagKey] and Color3.fromRGB(242, 102, 102) or Color3.fromRGB(44, 44, 54)
        local PinColor = Flags[flagKey] and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(160, 160, 170)

        TweenService:Create(IndicatorPin, TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = TargetX, BackgroundColor3 = PinColor}):Play()
        TweenService:Create(SliderFrame, TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundColor3 = BaseColor}):Play()

        RefreshTrackingStates(trackerKey, Flags[flagKey], activeColor, espTagText)
    end)
end

-- Render Construction Commands
CreateRowToggle("Twisted ESP (Outlines)", "TwistedESP", "Twisteds", Color3.fromRGB(255, 50, 50), "⚠️ TWISTED")
CreateRowToggle("Generator ESP (Outlines)", "GeneratorESP", "Generators", Color3.fromRGB(50, 255, 120), "⚙️ GENERATOR")
CreateRowToggle("Item Tracker ESP (Tapes/Candy/Medkits)", "ItemESP", "Items", Color3.fromRGB(240, 200, 50), "📦 ITEM")

-- ==========================================
-- STAGE 6: PERSISTENT COMPACT VISUAL TOGGLES
-- ==========================================
local function ShiftMenuVisibility(hideMain)
    if hideMain then
        -- Scale and minimize the panel cleanly off to the left side
        local MainTween = TweenService:Create(MainFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            Position = UDim2.new(0, -400, 0.5, -130)
        })
        MainTween:Play()
        MainTween.Completed:Wait()
        MainFrame.Visible = false
        
        -- Bring out the floating toggle emblem button
        LogoToggleBtn.Visible = true
        LogoToggleBtn.Position = UDim2.new(0, -60, 0.4, 0)
        TweenService:Create(LogoToggleBtn, TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Position = UDim2.new(0, 15, 0.4, 0)
        }):Play()
    else
        -- Animate and retract the logo emblem out
        local LogoTween = TweenService:Create(LogoToggleBtn, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            Position = UDim2.new(0, -60, 0.4, 0)
        })
        LogoTween:Play()
        LogoTween.Completed:Wait()
        LogoToggleBtn.Visible = false
        
        -- Restore the primary workspace UI control interface panel
        MainFrame.Visible = true
        TweenService:Create(MainFrame, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Position = UDim2.new(0.5, -180, 0.5, -130)
        }):Play()
    end
end

CloseBtn.MouseButton1Click:Connect(function() ShiftMenuVisibility(true) end)
LogoToggleBtn.MouseButton1Click:Connect(function() ShiftMenuVisibility(false) end)

-- Smooth Dragging Core Engine Integration
local ActiveDragging, DragStartPoint, StartFramePos
Header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        ActiveDragging = true
        DragStartPoint = input.Position
        StartFramePos = MainFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then ActiveDragging = false end
        end)
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if ActiveDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local Delta = input.Position - DragStartPoint
        MainFrame.Position = UDim2.new(StartFramePos.X.Scale, StartFramePos.X.Offset + Delta.X, StartFramePos.Y.Scale, StartFramePos.Y.Offset + Delta.Y)
    end
end)
