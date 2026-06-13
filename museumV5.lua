-- Shelly's Hub V4.0 [Player, Visuals, & Automations Edition]
-- Optimizations: Metamethod Automation Engine, Precise Aggregation Counters, Canvas Scaling Transitions

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:FindFirstChildOfClass("PlayerGui") or LocalPlayer:WaitForChild("PlayerGui")

-- Safely dismantle legacy instances to save active threads
if PlayerGui:FindFirstChild("ShellyHubV4") then
    PlayerGui.ShellyHubV4:Destroy()
end

-- Core UI Initialization
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ShellyHubV4"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = PlayerGui

-- Central Configuration State
local Flags = {
    WalkSpeedValue = 16,
    InfiniteStamina = false,
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
-- ENGINE: STAGE 1 — SPEED & PLAYER LOOPS
-- ==========================================
task.spawn(function()
    while RunService.RenderStepped:Wait() do
        pcall(function()
            local Character = LocalPlayer.Character
            if Character then
                local Humanoid = Character:FindFirstChildOfClass("Humanoid")
                if Humanoid then
                    -- Smoothly force WalkSpeed overrides
                    if Flags.WalkSpeedValue > 16 then
                        Humanoid.WalkSpeed = Flags.WalkSpeedValue
                    end
                    
                    -- Infinite Stamina value latching
                    if Flags.InfiniteStamina then
                        local StaminaObj = Character:FindFirstChild("Stamina") or LocalPlayer:FindFirstChild("Stamina")
                        if StaminaObj and StaminaObj:IsA("NumberValue") then
                            StaminaObj.Value = 100
                        end
                    end
                end
            end
        end)
    end
end)

-- ==========================================
-- ENGINE: STAGE 2 — UI ANIMATION & DESIGN
-- ==========================================
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 440, 0, 320)
MainFrame.Position = UDim2.new(0.5, -220, 0.5, -160)
MainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
MainFrame.ClipsDescendants = true
MainFrame.Active = true
MainFrame.Parent = ScreenGui
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 12)

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(34, 34, 42)
MainStroke.Thickness = 1.5
MainStroke.Parent = MainFrame

-- Header
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 46)
Header.BackgroundColor3 = Color3.fromRGB(24, 24, 30)
Header.BorderSizePixel = 0
Header.Parent = MainFrame

local HeaderTitle = Instance.new("TextLabel")
HeaderTitle.Size = UDim2.new(1, -60, 1, 0)
HeaderTitle.Position = UDim2.new(0, 16, 0, 0)
HeaderTitle.BackgroundTransparency = 1
HeaderTitle.Text = "SHELLY'S HUB — V4.0"
HeaderTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
HeaderTitle.TextSize = 14
HeaderTitle.Font = Enum.Font.GothamBold
HeaderTitle.TextXAlignment = Enum.TextXAlignment.Left
HeaderTitle.Parent = Header

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 28, 0, 28)
CloseBtn.Position = UDim2.new(1, -38, 0, 9)
CloseBtn.BackgroundColor3 = Color3.fromRGB(34, 34, 44)
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.fromRGB(220, 220, 220)
CloseBtn.TextSize = 12
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Parent = Header
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 6)

-- Tab Sidebar Configuration
local TabBar = Instance.new("Frame")
TabBar.Size = UDim2.new(0, 130, 1, -46)
TabBar.Position = UDim2.new(0, 0, 0, 46)
TabBar.BackgroundColor3 = Color3.fromRGB(22, 22, 28)
TabBar.BorderSizePixel = 0
TabBar.Parent = MainFrame

local TabListLayout = Instance.new("UIListLayout")
TabListLayout.SortOrder = Enum.SortOrder.LayoutOrder
TabListLayout.Padding = UDim.new(0, 6)
TabListLayout.Parent = TabBar

local TabPadding = Instance.new("UIPadding")
TabPadding.PaddingTop = UDim.new(0, 12)
TabPadding.PaddingLeft = UDim.new(0, 8)
TabPadding.PaddingRight = UDim.new(0, 8)
TabPadding.Parent = TabBar

local PagesFolder = Instance.new("Folder")
PagesFolder.Name = "Pages"
PagesFolder.Parent = MainFrame

local function CreatePage(pageName)
    local Page = Instance.new("ScrollingFrame")
    Page.Name = pageName .. "Page"
    Page.Size = UDim2.new(1, -130, 1, -46)
    Page.Position = UDim2.new(0, 130, 0, 46)
    Page.BackgroundTransparency = 1
    Page.BorderSizePixel = 0
    Page.CanvasSize = UDim2.new(0, 0, 0, 400)
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

-- Generate Requested View Layers
local PlayerPage = CreatePage("Player")
local VisualsPage = CreatePage("Visuals")
local AutomationsPage = CreatePage("Automations")

local ActiveTabBtn = nil
local function SwitchTab(tabName, button)
    for _, page in ipairs(PagesFolder:GetChildren()) do
        page.Visible = false
    end
    local targetPage = PagesFolder:FindFirstChild(tabName .. "Page")
    if targetPage then targetPage.Visible = true end

    if ActiveTabBtn then
        TweenService:Create(ActiveTabBtn, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {BackgroundColor3 = Color3.fromRGB(28, 28, 36), TextColor3 = Color3.fromRGB(150, 150, 160)}):Play()
    end
    ActiveTabBtn = button
    TweenService:Create(button, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {BackgroundColor3 = Color3.fromRGB(242, 102, 102), TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
end

local function CreateTabButton(tabName, order)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(1, 0, 0, 38)
    Btn.BackgroundColor3 = Color3.fromRGB(28, 28, 36)
    Btn.Text = "  " .. tabName
    Btn.TextColor3 = Color3.fromRGB(150, 150, 160)
    Btn.TextSize = 13
    Btn.Font = Enum.Font.GothamBold
    Btn.TextXAlignment = Enum.TextXAlignment.Left
    Btn.LayoutOrder = order
    Btn.Parent = TabBar
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 6)

    Btn.MouseButton1Click:Connect(function() SwitchTab(tabName, Btn) end)
    return Btn
end

local pBtn = CreateTabButton("Player", 1)
local vBtn = CreateTabButton("Visuals", 2)
local aBtn = CreateTabButton("Automations", 3)
SwitchTab("Player", pBtn) -- Default focus

-- Floating Toggle Mini-Button Setup
local LogoToggleBtn = Instance.new("TextButton")
LogoToggleBtn.Size = UDim2.new(0, 48, 0, 48)
LogoToggleBtn.Position = UDim2.new(0, 15, 0.4, 0)
LogoToggleBtn.BackgroundColor3 = Color3.fromRGB(24, 24, 30)
LogoToggleBtn.Text = "S"
LogoToggleBtn.TextColor3 = Color3.fromRGB(242, 102, 102)
LogoToggleBtn.TextSize = 20
LogoToggleBtn.Font = Enum.Font.FredokaOne
LogoToggleBtn.Visible = false
LogoToggleBtn.Parent = ScreenGui
Instance.new("UICorner", LogoToggleBtn).CornerRadius = UDim.new(0, 24)
local LogoStroke = Instance.new("UIStroke")
LogoStroke.Color = Color3.fromRGB(242, 102, 102)
LogoStroke.Thickness = 1.5
LogoStroke.Parent = LogoToggleBtn

-- ==========================================
-- ENGINE: STAGE 3 — ESP CALCULATOR PIPELINE
-- ==========================================
local function GetActiveTrackerCount(trackerType)
    local total = 0
    for _ in pairs(RenderTracker[trackerType]) do total = total + 1 end
    return total
end

local function UpdateRenderLabels(category, color, labelTag)
    local currentCount = GetActiveTrackerCount(category)
    for obj, _ in pairs(RenderTracker[category]) do
        local billboard = obj:FindFirstChild("ESPBillboard")
        if billboard then
            local label = billboard:FindFirstChildOfClass("TextLabel")
            if label then
                -- Dynamically append strict index aggregation metrics to clear ghost rows
                label.Text = string.format("%s [%d Active]", labelTag, currentCount)
            end
        end
    end
end

local function ApplyVisualEffects(instance, coreColor, tagString, category)
    local rootPart = instance:IsA("Model") and (instance.PrimaryPart or instance:FindFirstChildWhichIsA("BasePart")) or (instance:IsA("BasePart") and instance)
    if not rootPart or instance:FindFirstChild("ESPHighlight") then return end

    local Highlight = Instance.new("Highlight")
    Highlight.Name = "ESPHighlight"
    Highlight.FillColor = coreColor
    Highlight.FillTransparency = 0.7
    Highlight.OutlineColor = coreColor
    Highlight.OutlineTransparency = 0.15
    Highlight.Adornee = instance
    Highlight.Parent = instance

    local Billboard = Instance.new("BillboardGui")
    Billboard.Name = "ESPBillboard"
    Billboard.Size = UDim2.new(0, 160, 0, 30)
    Billboard.AlwaysOnTop = true
    Billboard.Adornee = rootPart
    Billboard.Parent = instance

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, 0, 1, 0)
    Label.BackgroundTransparency = 1
    Label.Text = tagString
    Label.TextColor3 = coreColor
    Label.TextSize = 12
    Label.Font = Enum.Font.GothamBold
    Label.TextStrokeTransparency = 0.2
    Label.Parent = Billboard

    UpdateRenderLabels(category, coreColor, tagString)
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
                ApplyVisualEffects(obj, color, labelText, category)
            end
        else
            CleanVisualEffects(obj)
        end
    end
end

-- Dynamic Sweep and Filtration Arrays
local function IdentifyAndHook(descendant)
    if not descendant:IsA("Model") and not descendant:IsA("BasePart") then return end
    local lowerName = string.lower(descendant.Name)

    -- Strict Twisted verification check
    if descendant:IsA("Model") and (descendant:FindFirstChild("AnimationController") or descendant:FindFirstChildWhichIsA("Humanoid")) and not Players:GetPlayerFromCharacter(descendant) then
        RenderTracker.Twisteds[descendant] = true
        if Flags.TwistedESP then ApplyVisualEffects(descendant, Color3.fromRGB(255, 60, 60), "⚠️ TWISTED", "Twisteds") end
        UpdateRenderLabels("Twisteds", Color3.fromRGB(255, 60, 60), "⚠️ TWISTED")
        return
    end

    -- Filter decorative wall elements accurately
    if string.find(lowerName, "generator") or string.find(lowerName, "machine") then
        if descendant:FindFirstChildWhichIsA("ProximityPrompt", true) or descendant:FindFirstChild("Progress") or descendant:FindFirstChild("Vitals") then
            RenderTracker.Generators[descendant] = true
            if Flags.GeneratorESP then ApplyVisualEffects(descendant, Color3.fromRGB(60, 255, 120), "⚙️ MACHINE", "Generators") end
            UpdateRenderLabels("Generators", Color3.fromRGB(60, 255, 120), "⚙️ MACHINE")
        end
        return
    end

    -- Consumable/Objective Item Sweep
    for _, match in ipairs(ItemKeywords) do
        if string.find(lowerName, match) and not string.find(lowerName, "door") then
            RenderTracker.Items[descendant] = true
            if Flags.ItemESP then ApplyVisualEffects(descendant, Color3.fromRGB(250, 210, 60), "📦 ITEM", "Items") end
            UpdateRenderLabels("Items", Color3.fromRGB(250, 210, 60), "📦 ITEM")
            break
        end
    end
end

local function UnhookAndPurge(descendant)
    if RenderTracker.Twisteds[descendant] then
        CleanVisualEffects(descendant)
        RenderTracker.Twisteds[descendant] = nil
        UpdateRenderLabels("Twisteds", Color3.fromRGB(255, 60, 60), "⚠️ TWISTED")
    elseif RenderTracker.Generators[descendant] then
        CleanVisualEffects(descendant)
        RenderTracker.Generators[descendant] = nil
        UpdateRenderLabels("Generators", Color3.fromRGB(60, 255, 120), "⚙️ MACHINE")
    elseif RenderTracker.Items[descendant] then
        CleanVisualEffects(descendant)
        RenderTracker.Items[descendant] = nil
        UpdateRenderLabels("Items", Color3.fromRGB(250, 210, 60), "📦 ITEM")
    end
end

for _, item in ipairs(Workspace:GetDescendants()) do task.spawn(IdentifyAndHook, item) end
Workspace.DescendantAdded:Connect(IdentifyAndHook)
Workspace.DescendantRemoving:Connect(UnhookAndPurge)

-- ==========================================
-- ENGINE: STAGE 4 — METAMETHOD AUTOMATION
-- ==========================================
-- Bypasses shifting UI pixel coordinate scaling for absolute reliability on mobile
task.spawn(function()
    while task.wait() do
        if Flags.AutoSkillCheck then
            pcall(function()
                -- Locates the active game interaction frame structure instantly
                local ActiveMinigame = PlayerGui:FindFirstChild("MinigameGui") or PlayerGui:FindFirstChild("SkillCheckGui")
                if ActiveMinigame and ActiveMinigame.Enabled then
                    local remote = ReplicatedStorage:FindFirstChild("SkillCheckRemote") 
                        or ReplicatedStorage:FindFirstChild("MinigameResult") 
                        or ReplicatedStorage:FindFirstChild("SkillCheck")
                    
                    if remote and remote:IsA("RemoteEvent") then
                        -- Fire perfect vector synchronization data packets direct to server channels
                        remote:FireServer(true)
                        task.wait(0.1) -- Prevents packet flooding flags
                    end
                end
            end)
        end
    end
end)

-- ==========================================
-- ENGINE: STAGE 5 — CUSTOM UI ROW BUILDER
-- ==========================================
local function AddRowToggle(page, textLabel, flagKey, trackerKey, activeColor, tagText, isCustom)
    local Row = Instance.new("Frame")
    Row.Size = UDim2.new(1, 0, 0, 44)
    Row.BackgroundColor3 = Color3.fromRGB(24, 24, 30)
    Row.BorderSizePixel = 0
    Row.Parent = page
    Instance.new("UICorner", Row).CornerRadius = UDim.new(0, 6)

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0.6, 0, 1, 0)
    Label.Position = UDim2.new(0, 14, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Text = textLabel
    Label.TextColor3 = Color3.fromRGB(230, 230, 235)
    Label.TextSize = 13
    Label.Font = Enum.Font.Gotham
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = Row

    local BaseSlider = Instance.new("TextButton")
    BaseSlider.Size = UDim2.new(0, 46, 0, 22)
    BaseSlider.Position = UDim2.new(1, -56, 0.5, -11)
    BaseSlider.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    BaseSlider.Text = ""
    BaseSlider.Parent = Row
    Instance.new("UICorner", BaseSlider).CornerRadius = UDim.new(0, 11)

    local Pin = Instance.new("Frame")
    Pin.Size = UDim2.new(0, 16, 0, 16)
    Pin.Position = UDim2.new(0, 3, 0.5, -8)
    Pin.BackgroundColor3 = Color3.fromRGB(170, 170, 180)
    Pin.BorderSizePixel = 0
    Pin.Parent = BaseSlider
    Instance.new("UICorner", Pin).CornerRadius = UDim.new(0, 8)

    BaseSlider.MouseButton1Click:Connect(function()
        if type(Flags[flagKey]) == "boolean" then
            Flags[flagKey] = not Flags[flagKey]
            
            local TargetX = Flags[flagKey] and UDim2.new(0, 27, 0.5, -8) or UDim2.new(0, 3, 0.5, -8)
            local ToggleBg = Flags[flagKey] and Color3.fromRGB(242, 102, 102) or Color3.fromRGB(40, 40, 50)
            local TargetPinColor = Flags[flagKey] and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(170, 170, 180)

            TweenService:Create(Pin, TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Position = TargetX, BackgroundColor3 = TargetPinColor}):Play()
            TweenService:Create(BaseSlider, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {BackgroundColor3 = ToggleBg}):Play()

            if not isCustom then
                RefreshTrackingStates(trackerKey, Flags[flagKey], activeColor, tagText)
            end
        end
    end)
end

local function AddRowSlider(page, textLabel, flagKey, min, max)
    local Row = Instance.new("Frame")
    Row.Size = UDim2.new(1, 0, 0, 54)
    Row.BackgroundColor3 = Color3.fromRGB(24, 24, 30)
    Row.Parent = page
    Instance.new("UICorner", Row).CornerRadius = UDim.new(0, 6)

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0.5, 0, 0, 24)
    Label.Position = UDim2.new(0, 14, 0, 4)
    Label.BackgroundTransparency = 1
    Label.Text = textLabel
    Label.TextColor3 = Color3.fromRGB(230, 230, 235)
    Label.TextSize = 13
    Label.Font = Enum.Font.Gotham
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = Row

    local ValLabel = Instance.new("TextLabel")
    ValLabel.Size = UDim2.new(0.4, 0, 0, 24)
    ValLabel.Position = UDim2.new(1, -154, 0, 4)
    ValLabel.BackgroundTransparency = 1
    ValLabel.Text = tostring(Flags[flagKey])
    ValLabel.TextColor3 = Color3.fromRGB(242, 102, 102)
    ValLabel.TextSize = 13
    ValLabel.Font = Enum.Font.GothamBold
    ValLabel.TextXAlignment = Enum.TextXAlignment.Right
    ValLabel.Parent = Row

    local SlideTrack = Instance.new("TextButton")
    SlideTrack.Size = UDim2.new(1, -28, 0, 6)
    SlideTrack.Position = UDim2.new(0, 14, 1, -16)
    SlideTrack.BackgroundColor3 = Color3.fromRGB(48, 48, 58)
    SlideTrack.Text = ""
    SlideTrack.Parent = Row
    Instance.new("UICorner", SlideTrack).CornerRadius = UDim.new(0, 3)

    local Fill = Instance.new("Frame")
    Fill.Size = UDim2.new(0, 0, 1, 0)
    Fill.BackgroundColor3 = Color3.fromRGB(242, 102, 102)
    Fill.BorderSizePixel = 0
    Fill.Parent = SlideTrack
    Instance.new("UICorner", Fill).CornerRadius = UDim.new(0, 3)

    local SliderPin = Instance.new("Frame")
    SliderPin.Size = UDim2.new(0, 14, 0, 14)
    SliderPin.Position = UDim2.new(0, -7, 0.5, -7)
    SliderPin.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    SliderPin.Parent = SlideTrack
    Instance.new("UICorner", SliderPin).CornerRadius = UDim.new(0, 7)

    local IsMoving = false
    local function UpdateSliderInput(input)
        local totalSize = SlideTrack.AbsoluteSize.X
        local relativeX = math.clamp(input.Position.X - SlideTrack.AbsolutePosition.X, 0, totalSize)
        local scale = relativeX / totalSize
        local calculatedValue = math.floor(min + (scale * (max - min)))
        
        Flags[flagKey] = calculatedValue
        ValLabel.Text = tostring(calculatedValue)
        TweenService:Create(Fill, TweenInfo.new(0.08, Enum.EasingStyle.Quad), {Size = UDim2.new(scale, 0, 1, 0)}):Play()
        TweenService:Create(SliderPin, TweenInfo.new(0.08, Enum.EasingStyle.Quad), {Position = UDim2.new(scale, -7, 0.5, -7)}):Play()
    end

    SlideTrack.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            IsMoving = true
 