-- Shelly's Museum V3.2 [Automation & Visuals Edition]
-- Fixes: Dynamic Twisted Detection, Active Generator Filtering, Tab Layout
-- New: Auto Skill Check Engine

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:FindFirstChildOfClass("PlayerGui") or LocalPlayer:WaitForChild("PlayerGui")

-- Instantly clear older instances
if PlayerGui:FindFirstChild("ShellyMuseumV32") then
    PlayerGui.ShellyMuseumV32:Destroy()
end

-- Core UI Layer Setup
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ShellyMuseumV32"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = PlayerGui

-- Global State Toggles
local Flags = {
    TwistedESP = false,
    GeneratorESP = false,
    ItemESP = false,
    AutoSkillCheck = false
}

local RenderTracker = {
    Twisteds = {},
    Generators = {},
    Items = {}
}

local ItemKeywords = {"tape", "medkit", "candy", "speed", "bandage", "capsule", "health"}

-- ==========================================
-- STAGE 1: FLOATING LOGO BUTTON TOGGLE
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
LogoToggleBtn.Visible = false
LogoToggleBtn.Parent = ScreenGui
Instance.new("UICorner", LogoToggleBtn).CornerRadius = UDim.new(0, 12)

local LogoStroke = Instance.new("UIStroke")
LogoStroke.Color = Color3.fromRGB(50, 50, 60)
LogoStroke.Thickness = 2
LogoStroke.Parent = LogoToggleBtn

-- ==========================================
-- STAGE 2: MAIN DASHBOARD DESIGN
-- ==========================================
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 420, 0, 300)
MainFrame.Position = UDim2.new(0.5, -210, 0.5, -150)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 24)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Parent = ScreenGui
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)

local PanelStroke = Instance.new("UIStroke")
PanelStroke.Color = Color3.fromRGB(40, 40, 48)
PanelStroke.Thickness = 1
PanelStroke.Parent = MainFrame

-- Header Panel
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
HeaderTitle.Text = "SHELLY'S HUB — V3.2"
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

-- Side Tab Navigation Bar
local TabBar = Instance.new("Frame")
TabBar.Size = UDim2.new(0, 120, 1, -42)
TabBar.Position = UDim2.new(0, 0, 0, 42)
TabBar.BackgroundColor3 = Color3.fromRGB(24, 24, 30)
TabBar.BorderSizePixel = 0
TabBar.Parent = MainFrame

local TabListLayout = Instance.new("UIListLayout")
TabListLayout.SortOrder = Enum.SortOrder.LayoutOrder
TabListLayout.Padding = UDim.new(0, 4)
TabListLayout.Parent = TabBar

local TabPadding = Instance.new("UIPadding")
TabPadding.PaddingTop = UDim.new(0, 10)
TabPadding.PaddingLeft = UDim.new(0, 8)
TabPadding.PaddingRight = UDim.new(0, 8)
TabPadding.Parent = TabBar

-- Content Pages Containers
local PagesFolder = Instance.new("Folder")
PagesFolder.Name = "Pages"
PagesFolder.Parent = MainFrame

local function CreatePage(pageName)
    local Page = Instance.new("ScrollingFrame")
    Page.Name = pageName .. "Page"
    Page.Size = UDim2.new(1, -120, 1, -42)
    Page.Position = UDim2.new(0, 120, 0, 42)
    Page.BackgroundTransparency = 1
    Page.BorderSizePixel = 0
    Page.CanvasSize = UDim2.new(0, 0, 0, 0)
    Page.ScrollBarThickness = 2
    Page.Visible = false
    Page.Parent = PagesFolder

    local PagePadding = Instance.new("UIPadding")
    PagePadding.PaddingTop = UDim.new(0, 12)
    PagePadding.PaddingLeft = UDim.new(0, 12)
    PagePadding.PaddingRight = UDim.new(0, 12)
    PagePadding.Parent = Page

    local PageList = Instance.new("UIListLayout")
    PageList.SortOrder = Enum.SortOrder.LayoutOrder
    PageList.Padding = UDim.new(0, 8)
    PageList.Parent = Page

    return Page
end

local VisualsPage = CreatePage("Visuals")
local AutomationsPage = CreatePage("Automations")

-- Tab Controller Function
local ActiveTabBtn = nil
local function SwitchTab(tabName, button)
    for _, page in ipairs(PagesFolder:GetChildren()) do
        page.Visible = false
    end
    local targetPage = PagesFolder:FindFirstChild(tabName .. "Page")
    if targetPage then targetPage.Visible = true end

    if ActiveTabBtn then
        TweenService:Create(ActiveTabBtn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(28, 28, 34), TextColor3 = Color3.fromRGB(160, 160, 170)}):Play()
    end
    ActiveTabBtn = button
    TweenService:Create(button, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(242, 102, 102), TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
end

local function CreateTabButton(tabName, order)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(1, 0, 0, 36)
    Btn.BackgroundColor3 = Color3.fromRGB(28, 28, 34)
    Btn.Text = tabName
    Btn.TextColor3 = Color3.fromRGB(160, 160, 170)
    Btn.TextSize = 13
    Btn.Font = Enum.Font.SourceSansBold
    Btn.LayoutOrder = order
    Btn.Parent = TabBar
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 6)

    Btn.MouseButton1Click:Connect(function()
        SwitchTab(tabName, Btn)
    end)
    return Btn
end

local visBtn = CreateTabButton("Visuals", 1)
local autoBtn = CreateTabButton("Automations", 2)
SwitchTab("Visuals", visBtn) -- Initialize defaults

-- ==========================================
-- STAGE 3: CHAMS & RENDERING LOGIC (FIXED)
-- ==========================================
local function ApplyVisualEffects(instance, coreColor, tagString)
    local rootPart = instance:IsA("Model") and (instance.PrimaryPart or instance:FindFirstChildWhichIsA("BasePart")) or (instance:IsA("BasePart") and instance)
    if not rootPart or instance:FindFirstChild("ESPHighlight") then return end

    local Highlight = Instance.new("Highlight")
    Highlight.Name = "ESPHighlight"
    Highlight.FillColor = coreColor
    Highlight.FillTransparency = 0.65
    Highlight.OutlineColor = coreColor
    Highlight.OutlineTransparency = 0.1
    Highlight.Adornee = instance
    Highlight.Parent = instance

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
-- STAGE 4: STRICT MAP SCANNER (FIXED ACCURACY)
-- ==========================================
local function IdentifyAndHook(descendant)
    if not descendant:IsA("Model") and not descendant:IsA("BasePart") then return end
    local lowerName = string.lower(descendant.Name)

    -- FIX: Strict Character Model / Twisted Targeting Environment Rules
    if descendant:IsA("Model") and (descendant:FindFirstChild("AnimationController") or descendant:FindFirstChildWhichIsA("Humanoid")) and not Players:GetPlayerFromCharacter(descendant) then
        RenderTracker.Twisteds[descendant] = true
        if Flags.TwistedESP then ApplyVisualEffects(descendant, Color3.fromRGB(255, 50, 50), "⚠️ TWISTED") end
        return
    end

    -- FIX: Filter out non-interactable wall structures. Require an active prompt engine or specific interactive values.
    if string.find(lowerName, "generator") or string.find(lowerName, "machine") then
        if descendant:FindFirstChildWhichIsA("ProximityPrompt", true) or descendant:FindFirstChild("Progress") or descendant:FindFirstChild("Vitals") then
            RenderTracker.Generators[descendant] = true
            if Flags.GeneratorESP then ApplyVisualEffects(descendant, Color3.fromRGB(50, 255, 120), "⚙️ MACHINE") end
        end
        return
    end

    -- Items Discovery Sweep
    for _, match in ipairs(ItemKeywords) do
        if string.find(lowerName, match) and not string.find(lowerName, "door") then
            RenderTracker.Items[descendant] = true
            if Flags.ItemESP then ApplyVisualEffects(descendant, Color3.fromRGB(240, 200, 50), "📦 " .. string.upper(descendant.Name)) end
            break
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

for _, item in ipairs(Workspace:GetDescendants()) do
    task.spawn(IdentifyAndHook, item)
end
Workspace.DescendantAdded:Connect(IdentifyAndHook)
Workspace.DescendantRemoving:Connect(UnhookAndPurge)

-- ==========================================
-- STAGE 5: AUTO SKILL CHECK (AUTOMATIONS)
-- ==========================================
-- Monitors local mini-game prompts or system check GUI interfaces natively
task.spawn(function()
    while task.wait() do
        if Flags.AutoSkillCheck then
            pcall(function()
                local MinigameGui = PlayerGui:FindFirstChild("MinigameGui") or PlayerGui:FindFirstChild("SkillCheckGui")
                if MinigameGui and MinigameGui.Enabled then
                    -- Pinpoint target success slider components instantly
                    local bar = MinigameGui:FindFirstChild("Bar", true)
                    local pointer = MinigameGui:FindFirstChild("Pointer", true)
                    local zone = MinigameGui:FindFirstChild("Zone", true) or MinigameGui:FindFirstChild("SuccessZone", true)

                    if pointer and zone then
                        -- Instantly fires interaction inputs when needle enters success frame bounds
                        if pointer.Position.X.Scale >= zone.Position.X.Scale and pointer.Position.X.Scale <= (zone.Position.X.Scale + zone.Size.X.Scale) then
                            local Remote = ReplicatedStorage:FindFirstChild("SkillCheckRemote") or ReplicatedStorage:FindFirstChild("MinigameResult")
                            if Remote then
                                Remote:FireServer(true) -- Directly fire success confirmation vector
                            end
                        end
                    end
                end
            end)
        end
    end
end)

-- ==========================================
-- STAGE 6: DYNAMIC TOGGLE COMPONENT UI BUILDER
-- ==========================================
local function CreateRowToggle(parentPage, labelText, flagKey, trackerKey, activeColor, espTagText, isAutomation)
    local Row = Instance.new("Frame")
    Row.Size = UDim2.new(1, 0, 0, 42)
    Row.BackgroundColor3 = Color3.fromRGB(26, 26, 32)
    Row.BorderSizePixel = 0
    Row.Parent = parentPage
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
    SliderFrame.Size = UDim2.new(0, 44, 0, 20)
    SliderFrame.Position = UDim2.new(1, -54, 0.5, -10)
    SliderFrame.BackgroundColor3 = Color3.fromRGB(44, 44, 54)
    SliderFrame.Text = ""
    SliderFrame.Parent = Row
    Instance.new("UICorner", SliderFrame).CornerRadius = UDim.new(0, 10)

    local IndicatorPin = Instance.new("Frame")
    IndicatorPin.Size = UDim2.new(0, 14, 0, 14)
    IndicatorPin.Position = UDim2.new(0, 3, 0.5, -7)
    IndicatorPin.BackgroundColor3 = Color3.fromRGB(160, 160, 170)
    IndicatorPin.BorderSizePixel = 0
    IndicatorPin.Parent = SliderFrame
    Instance.new("UICorner", IndicatorPin).CornerRadius = UDim.new(0, 7)

    SliderFrame.MouseButton1Click:Connect(function()
        Flags[flagKey] = not Flags[flagKey]
        
        local TargetX = Flags[flagKey] and UDim2.new(0, 27, 0.5, -7) or UDim2.new(0, 3, 0.5, -7)
        local BaseColor = Flags[flagKey] and Color3.fromRGB(242, 102, 102) or Color3.fromRGB(44, 44, 54)
        local PinColor = Flags[flagKey] and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(160, 160, 170)

        TweenService:Create(IndicatorPin, TweenInfo.new(0.16, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = TargetX, BackgroundColor3 = PinColor}):Play()
        TweenService:Create(SliderFrame, TweenInfo.new(0.16, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundColor3 = BaseColor}):Play()

        if not isAutomation then
            RefreshTrackingStates(trackerKey, Flags[flagKey], activeColor, espTagText)
        end
    end)
end

-- Render Visual Toggles
CreateRowToggle(VisualsPage, "Twisted Outline ESP", "TwistedESP", "Twisteds", Color3.fromRGB(255, 50, 50), "⚠️ TWISTED", false)
CreateRowToggle(VisualsPage, "Active Machine ESP", "GeneratorESP", "Generators", Color3.fromRGB(50, 255, 120), "⚙️ MACHINE", false)
CreateRowToggle(VisualsPage, "Item Tracker ESP", "ItemESP", "Items", Color3.fromRGB(240, 200, 50), "📦 ITEM", false)

-- Render Automation Toggles
CreateRowToggle(AutomationsPage, "Auto Skill Check", "AutoSkillCheck", nil, nil, nil, true)

-- ==========================================
-- STAGE 7: SCREEN VISIBILITY ENGINE
-- ==========================================
local function ShiftMenuVisibility(hideMain)
    if hideMain then
        local MainTween = TweenService:Create(MainFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            Position = UDim2.new(0, -450, 0.5, -150)
        })
        MainTween:Play()
        MainTween.Completed:Wait()
        MainFrame.Visible = false
        
        LogoToggleBtn.Visible = true
        LogoToggleBtn.Position = UDim2.new(0, -60, 0.4, 0)
        TweenService:Create(LogoToggleBtn, TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Position = UDim2.new(0, 15, 0.4, 0)
        }):Play()
    else
        local LogoTween = TweenService:Create(LogoToggleBtn, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            Position = UDim2.new(0, -60, 0.4, 0)
        })
        LogoTween:Play()
        LogoTween.Completed:Wait()
        LogoToggleBtn.Visible = false
        
        MainFrame.Visible = true
        TweenService:Create(MainFrame, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Position = UDim2.new(0.5, -210, 0.5, -150)
        }):Play()
    end
end

CloseBtn.MouseButton1Click:Connect(function() ShiftMenuVisibility(true) end)
LogoToggleBtn.MouseButton1Click:Connect(function() ShiftMenuVisibility(false) end)

-- Smooth Touch/Mouse Dragging Configuration
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
