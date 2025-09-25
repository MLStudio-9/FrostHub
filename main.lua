-- Hajaz Hub GUI Library - Complete Version
local Library = {}

-- Services
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

-- Theme
Library.Theme = {
    Background = Color3.new(0.1, 0.1, 0.1),
    Header = Color3.new(0.2, 0.2, 0.2),
    Text = Color3.new(1, 1, 1),
    Accent = Color3.new(0, 0.5, 1),
    ToggleOn = Color3.new(0, 1, 0),
    ToggleOff = Color3.new(1, 0, 0),
    Notification = Color3.new(0.15, 0.15, 0.25)
}

-- Animation Functions
function Library:SlideIn(guiObject, direction, duration)
    local startPosition = guiObject.Position
    local slideFrom
    
    if direction == "left" then
        slideFrom = UDim2.new(-1, -guiObject.AbsoluteSize.X, startPosition.Y.Scale, startPosition.Y.Offset)
    elseif direction == "right" then
        slideFrom = UDim2.new(1, guiObject.AbsoluteSize.X, startPosition.Y.Scale, startPosition.Y.Offset)
    end
    
    guiObject.Position = slideFrom
    guiObject.Visible = true
    
    local tween = TweenService:Create(guiObject, TweenInfo.new(duration or 0.3), {Position = startPosition})
    tween:Play()
end

-- Notification System
function Library:Notify(title, text, duration)
    duration = duration or 3
    
    local NotificationGui = Instance.new("ScreenGui")
    NotificationGui.Parent = game.CoreGui
    
    local NotificationFrame = Instance.new("Frame")
    NotificationFrame.Size = UDim2.new(0, 300, 0, 80)
    NotificationFrame.Position = UDim2.new(0, 10, 1, 10)
    NotificationFrame.BackgroundColor3 = self.Theme.Notification
    NotificationFrame.BorderSizePixel = 0
    NotificationFrame.Parent = NotificationGui
    
    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Size = UDim2.new(1, -20, 0, 25)
    TitleLabel.Position = UDim2.new(0, 10, 0, 5)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Text = title
    TitleLabel.TextColor3 = self.Theme.Accent
    TitleLabel.TextSize = 16
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    TitleLabel.Parent = NotificationFrame
    
    local TextLabel = Instance.new("TextLabel")
    TextLabel.Size = UDim2.new(1, -20, 1, -35)
    TextLabel.Position = UDim2.new(0, 10, 0, 30)
    TextLabel.BackgroundTransparency = 1
    TextLabel.Text = text
    TextLabel.TextColor3 = self.Theme.Text
    TextLabel.TextSize = 14
    TextLabel.Font = Enum.Font.Gotham
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left
    TextLabel.TextYAlignment = Enum.TextYAlignment.Top
    TextLabel.TextWrapped = true
    TextLabel.Parent = NotificationFrame
    
    -- Animate in
    local slideTween = TweenService:Create(NotificationFrame, TweenInfo.new(0.5), {
        Position = UDim2.new(0, 10, 1, -90)
    })
    slideTween:Play()
    
    -- Auto remove
    task.spawn(function()
        task.wait(duration)
        local fadeTween = TweenService:Create(NotificationFrame, TweenInfo.new(0.5), {
            Position = UDim2.new(0, 10, 1, 10)
        })
        fadeTween:Play()
        fadeTween.Completed:Wait()
        NotificationGui:Destroy()
    end)
end

-- Create Window
function Library:CreateWindow(name)
    local Window = {}
    
    -- GUI
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Parent = game.CoreGui

    local MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.new(0, 350, 0, 400)
    MainFrame.Position = UDim2.new(0, 10, 0.5, -200)
    MainFrame.BackgroundColor3 = self.Theme.Background
    MainFrame.BorderSizePixel = 0
    MainFrame.Parent = ScreenGui

    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, 0, 0, 30)
    Title.BackgroundColor3 = self.Theme.Header
    Title.Text = name
    Title.TextColor3 = self.Theme.Text
    Title.TextSize = 18
    Title.Font = Enum.Font.GothamBold
    Title.Parent = MainFrame

    -- Minimize button
    local MinimizeButton = Instance.new("TextButton")
    MinimizeButton.Size = UDim2.new(0, 20, 0, 20)
    MinimizeButton.Position = UDim2.new(1, -25, 0, 5)
    MinimizeButton.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
    MinimizeButton.Text = "_"
    MinimizeButton.TextColor3 = self.Theme.Text
    MinimizeButton.Parent = Title

    -- Close button
    local CloseButton = Instance.new("TextButton")
    CloseButton.Size = UDim2.new(0, 20, 0, 20)
    CloseButton.Position = UDim2.new(1, -50, 0, 5)
    CloseButton.BackgroundColor3 = Color3.new(1, 0.2, 0.2)
    CloseButton.Text = "X"
    CloseButton.TextColor3 = self.Theme.Text
    CloseButton.Parent = Title

    -- Content Frame
    local ContentFrame = Instance.new("ScrollingFrame")
    ContentFrame.Size = UDim2.new(1, -10, 1, -70)
    ContentFrame.Position = UDim2.new(0, 5, 0, 35)
    ContentFrame.BackgroundTransparency = 1
    ContentFrame.ScrollBarThickness = 5
    ContentFrame.Parent = MainFrame

    local ContentList = Instance.new("UIListLayout")
    ContentList.Padding = UDim.new(0, 5)
    ContentList.Parent = ContentFrame

    -- Add Button
    function Window:AddButton(name, callback)
        local Button = Instance.new("TextButton")
        Button.Size = UDim2.new(1, 0, 0, 30)
        Button.BackgroundColor3 = Library.Theme.Accent
        Button.Text = name
        Button.TextColor3 = Color3.new(1, 1, 1)
        Button.TextSize = 14
        Button.Parent = ContentFrame
        
        Button.MouseButton1Click:Connect(callback)
        
        return Button
    end

    -- Add Toggle
    function Window:AddToggle(name, default, callback)
        local ToggleFrame = Instance.new("Frame")
        ToggleFrame.Size = UDim2.new(1, 0, 0, 30)
        ToggleFrame.BackgroundTransparency = 1
        ToggleFrame.Parent = ContentFrame

        local ToggleLabel = Instance.new("TextLabel")
        ToggleLabel.Size = UDim2.new(0.7, 0, 1, 0)
        ToggleLabel.BackgroundTransparency = 1
        ToggleLabel.Text = name
        ToggleLabel.TextColor3 = Color3.new(1, 1, 1)
        ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
        ToggleLabel.Parent = ToggleFrame

        local ToggleButton = Instance.new("TextButton")
        ToggleButton.Size = UDim2.new(0, 50, 0, 20)
        ToggleButton.Position = UDim2.new(0.7, 0, 0.5, -10)
        ToggleButton.BackgroundColor3 = default and Library.Theme.ToggleOn or Library.Theme.ToggleOff
        ToggleButton.Text = default and "ON" or "OFF"
        ToggleButton.TextColor3 = Color3.new(1, 1, 1)
        ToggleButton.Parent = ToggleFrame

        local state = default

        ToggleButton.MouseButton1Click:Connect(function()
            state = not state
            ToggleButton.BackgroundColor3 = state and Library.Theme.ToggleOn or Library.Theme.ToggleOff
            ToggleButton.Text = state and "ON" or "OFF"
            callback(state)
        end)
        
        return {Value = state}
    end

    -- Add Slider
    function Window:AddSlider(name, min, max, default, callback)
        local SliderFrame = Instance.new("Frame")
        SliderFrame.Size = UDim2.new(1, 0, 0, 50)
        SliderFrame.BackgroundTransparency = 1
        SliderFrame.Parent = ContentFrame

        local SliderLabel = Instance.new("TextLabel")
        SliderLabel.Size = UDim2.new(1, 0, 0, 20)
        SliderLabel.BackgroundTransparency = 1
        SliderLabel.Text = name .. ": " .. default
        SliderLabel.TextColor3 = Color3.new(1, 1, 1)
        SliderLabel.TextXAlignment = Enum.TextXAlignment.Left
        SliderLabel.Parent = SliderFrame

        local Slider = Instance.new("Frame")
        Slider.Size = UDim2.new(1, 0, 0, 10)
        Slider.Position = UDim2.new(0, 0, 0, 25)
        Slider.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
        Slider.Parent = SliderFrame

        local SliderValue = Instance.new("Frame")
        SliderValue.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
        SliderValue.BackgroundColor3 = Library.Theme.Accent
        SliderValue.Parent = Slider

        local dragging = false
        local value = default

        local function UpdateSlider(x)
            local relativeX = math.clamp(x - Slider.AbsolutePosition.X, 0, Slider.AbsoluteSize.X)
            value = math.floor(min + (relativeX / Slider.AbsoluteSize.X) * (max - min))
            SliderLabel.Text = name .. ": " .. value
            SliderValue.Size = UDim2.new((value - min) / (max - min), 0, 1, 0)
            callback(value)
        end

        Slider.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = true
                UpdateSlider(input.Position.X)
            end
        end)

        UserInputService.InputChanged:Connect(function(input)
            if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                UpdateSlider(input.Position.X)
            end
        end)

        UserInputService.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = false
            end
        end)
        
        return {Value = value}
    end

    -- GUI Controls
    MinimizeButton.MouseButton1Click:Connect(function()
        ContentFrame.Visible = not ContentFrame.Visible
        MainFrame.Size = ContentFrame.Visible and UDim2.new(0, 350, 0, 400) or UDim2.new(0, 350, 0, 30)
    end)

    CloseButton.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
    end)

    -- Make draggable
    local dragging = false
    local dragStart, startPos

    Title.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = MainFrame.Position
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)

    -- Animate in
    self:SlideIn(MainFrame, "left", 0.5)
    self:Notify("Hajaz Hub", "Готов к работе!", 3)

    return Window
end
