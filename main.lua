-- Hajaz Hub GUI Library - No Tabs Version
local Library = {}

-- Services
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

-- Library Variables
Library.Theme = {
    Background = Color3.new(0.1, 0.1, 0.1),
    Header = Color3.new(0.2, 0.2, 0.2),
    Text = Color3.new(1, 1, 1),
    Accent = Color3.new(0, 0.5, 1),
    ToggleOn = Color3.new(0, 1, 0),
    ToggleOff = Color3.new(1, 0, 0),
    Notification = Color3.new(0.15, 0.15, 0.25)
}

Library.Notifications = {}

-- Animation Functions
function Library:SlideIn(guiObject, direction, duration)
    local startPosition = guiObject.Position
    local slideFrom
    
    if direction == "left" then
        slideFrom = UDim2.new(-1, -guiObject.AbsoluteSize.X, startPosition.Y.Scale, startPosition.Y.Offset)
    elseif direction == "right" then
        slideFrom = UDim2.new(1, guiObject.AbsoluteSize.X, startPosition.Y.Scale, startPosition.Y.Offset)
    elseif direction == "top" then
        slideFrom = UDim2.new(startPosition.X.Scale, startPosition.X.Offset, -1, -guiObject.AbsoluteSize.Y)
    elseif direction == "bottom" then
        slideFrom = UDim2.new(startPosition.X.Scale, startPosition.X.Offset, 1, guiObject.AbsoluteSize.Y)
    end
    
    guiObject.Position = slideFrom
    guiObject.Visible = true
    
    local tween = TweenService:Create(guiObject, TweenInfo.new(duration or 0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = startPosition})
    tween:Play()
    return tween
end

function Library:FadeIn(guiObject, duration)
    guiObject.BackgroundTransparency = 1
    if guiObject:IsA("TextLabel") or guiObject:IsA("TextButton") then
        guiObject.TextTransparency = 1
    end
    guiObject.Visible = true
    
    local tween = TweenService:Create(guiObject, TweenInfo.new(duration or 0.3, Enum.EasingStyle.Quad), {
        BackgroundTransparency = 0,
        TextTransparency = 0
    })
    tween:Play()
    return tween
end

function Library:ScaleIn(guiObject, duration)
    local originalSize = guiObject.Size
    guiObject.Size = UDim2.new(0, 0, 0, 0)
    guiObject.Visible = true
    
    local tween = TweenService:Create(guiObject, TweenInfo.new(duration or 0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = originalSize})
    tween:Play()
    return tween
end

-- Notification System (Bottom Left)
function Library:Notify(title, text, duration)
    duration = duration or 3
    
    local NotificationGui = Instance.new("ScreenGui")
    NotificationGui.Name = "Notification_" .. tick()
    NotificationGui.Parent = game.CoreGui
    
    local NotificationFrame = Instance.new("Frame")
    NotificationFrame.Size = UDim2.new(0, 300, 0, 80)
    NotificationFrame.Position = UDim2.new(0, 10, 1, 10) -- Bottom left
    NotificationFrame.BackgroundColor3 = self.Theme.Notification
    NotificationFrame.BorderSizePixel = 0
    NotificationFrame.ClipsDescendants = true
    NotificationFrame.Parent = NotificationGui
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 8)
    Corner.Parent = NotificationFrame
    
    local Stroke = Instance.new("UIStroke")
    Stroke.Color = self.Theme.Accent
    Stroke.Thickness = 2
    Stroke.Parent = NotificationFrame
    
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
    
    -- Animate in from bottom
    local slideTween = TweenService:Create(NotificationFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Position = UDim2.new(0, 10, 1, -90) -- Slide up from bottom
    })
    slideTween:Play()
    
    -- Auto remove
    task.spawn(function()
        task.wait(duration)
        
        local fadeTween = TweenService:Create(NotificationFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quad), {
            Position = UDim2.new(0, 10, 1, 10), -- Slide down
            BackgroundTransparency = 1
        })
        fadeTween:Play()
        
        fadeTween.Completed:Wait()
        NotificationGui:Destroy()
    end)
    
    return NotificationGui
end

-- Create Main Window
function Library:CreateWindow(name)
    local Window = {}
    
    -- GUI
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "HajazHub"
    ScreenGui.Parent = game.CoreGui

    local MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.new(0, 350, 0, 400)
    MainFrame.Position = UDim2.new(0, 10, 0.5, -200)
    MainFrame.BackgroundColor3 = self.Theme.Background
    MainFrame.BorderSizePixel = 0
    MainFrame.ClipsDescendants = true
    MainFrame.Parent = ScreenGui
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 8)
    Corner.Parent = MainFrame
    
    local Stroke = Instance.new("UIStroke")
    Stroke.Color = self.Theme.Accent
    Stroke.Thickness = 2
    Stroke.Parent = MainFrame

    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, 0, 0, 30)
    Title.BackgroundColor3 = self.Theme.Header
    Title.Text = name
    Title.TextColor3 = self.Theme.Text
    Title.TextSize = 18
    Title.Font = Enum.Font.GothamBold
    Title.Parent = MainFrame

    -- Minimize button with animation
    local MinimizeButton = Instance.new("TextButton")
    MinimizeButton.Size = UDim2.new(0, 20, 0, 20)
    MinimizeButton.Position = UDim2.new(1, -25, 0, 5)
    MinimizeButton.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
    MinimizeButton.Text = "_"
    MinimizeButton.TextColor3 = self.Theme.Text
    MinimizeButton.Font = Enum.Font.GothamBold
    MinimizeButton.Parent = Title
    
    local MinCorner = Instance.new("UICorner")
    MinCorner.CornerRadius = UDim.new(0, 4)
    MinCorner.Parent = MinimizeButton

    -- Close button with animation
    local CloseButton = Instance.new("TextButton")
    CloseButton.Size = UDim2.new(0, 20, 0, 20)
    CloseButton.Position = UDim2.new(1, -50, 0, 5)
    CloseButton.BackgroundColor3 = Color3.new(1, 0.2, 0.2)
    CloseButton.Text = "X"
    CloseButton.TextColor3 = self.Theme.Text
    CloseButton.Font = Enum.Font.GothamBold
    CloseButton.Parent = Title
    
    local CloseCorner = Instance.new("UICorner")
    CloseCorner.CornerRadius = UDim.new(0, 4)
    CloseCorner.Parent = CloseButton

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

    -- Window Properties
    Window.Gui = ScreenGui
    Window.MainFrame = MainFrame
    Window.ContentFrame = ContentFrame
    Window.Minimized = false
    Window.Elements = {}

    -- Add Button with animations
    function Window:AddButton(name, callback)
        local ButtonFrame = Instance.new("Frame")
        ButtonFrame.Size = UDim2.new(1, 0, 0, 35)
        ButtonFrame.BackgroundTransparency = 1
        ButtonFrame.Parent = ContentFrame

        local Button = Instance.new("TextButton")
        Button.Size = UDim2.new(1, 0, 0, 30)
        Button.Position = UDim2.new(0, 0, 0, 2)
        Button.BackgroundColor3 = Library.Theme.Accent
        Button.Text = name
        Button.TextColor3 = Library.Theme.Text
        Button.TextSize = 14
        Button.Font = Enum.Font.Gotham
        Button.Parent = ButtonFrame
        
        local ButtonCorner = Instance.new("UICorner")
        ButtonCorner.CornerRadius = UDim.new(0, 6)
        ButtonCorner.Parent = Button

        -- Button animations
        Button.MouseEnter:Connect(function()
            TweenService:Create(Button, TweenInfo.new(0.2), {
                BackgroundColor3 = Color3.new(0.2, 0.6, 1),
                Size = UDim2.new(1, -5, 0, 32)
            }):Play()
        end)
        
        Button.MouseLeave:Connect(function()
            TweenService:Create(Button, TweenInfo.new(0.2), {
                BackgroundColor3 = Library.Theme.Accent,
                Size = UDim2.new(1, 0, 0, 30)
            }):Play()
        end)
        
        Button.MouseButton1Click:Connect(function()
            -- Click animation
            TweenService:Create(Button, TweenInfo.new(0.1), {
                BackgroundColor3 = Color3.new(0.1, 0.3, 0.6),
                Size = UDim2.new(0.95, 0, 0, 28)
            }):Play()
            
            task.wait(0.1)
            
            TweenService:Create(Button, TweenInfo.new(0.1), {
                BackgroundColor3 = Library.Theme.Accent,
                Size = UDim2.new(1, 0, 0, 30)
            }):Play()
            
            callback()
        end)
        
        -- Animate button in
        task.spawn(function()
            task.wait(#Window.Elements * 0.1)
            Library:SlideIn(ButtonFrame, "left", 0.3)
        end)
        
        table.insert(Window.Elements, ButtonFrame)
        return Button
    end

    -- Add Toggle with animations
    function Window:AddToggle(name, default, callback)
        local ToggleFrame = Instance.new("Frame")
        ToggleFrame.Size = UDim2.new(1, 0, 0, 35)
        ToggleFrame.BackgroundTransparency = 1
        ToggleFrame.Parent = ContentFrame

        local ToggleLabel = Instance.new("TextLabel")
        ToggleLabel.Size = UDim2.new(0.7, 0, 1, 0)
        ToggleLabel.BackgroundTransparency = 1
        ToggleLabel.Text = name
        ToggleLabel.TextColor3 = Library.Theme.Text
        ToggleLabel.TextSize = 14
        ToggleLabel.Font = Enum.Font.Gotham
        ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
        ToggleLabel.Parent = ToggleFrame

        local ToggleButton = Instance.new("TextButton")
        ToggleButton.Size = UDim2.new(0, 50, 0, 25)
        ToggleButton.Position = UDim2.new(0.7, 0, 0.5, -12)
        ToggleButton.BackgroundColor3 = default and Library.Theme.ToggleOn or Library.Theme.ToggleOff
        ToggleButton.Text = default and "ON" : "OFF"
        ToggleButton.TextColor3 = Library.Theme.Text
        ToggleButton.TextSize = 12
        ToggleButton.Font = Enum.Font.GothamBold
        ToggleButton.Parent = ToggleFrame
        
        local ToggleCorner = Instance.new("UICorner")
        ToggleCorner.CornerRadius = UDim.new(0, 6)
        ToggleCorner.Parent = ToggleButton

        local state = default

        ToggleButton.MouseButton1Click:Connect(function()
            state = not state
            -- Toggle animation
            Library:ScaleIn(ToggleButton, 0.2)
            ToggleButton.BackgroundColor3 = state and Library.Theme.ToggleOn or Library.Theme.ToggleOff
            ToggleButton.Text = state and "ON" or "OFF"
            callback(state)
        end)
        
        -- Animate toggle in
        task.spawn(function()
            task.wait(#Window.Elements * 0.1)
            Library:SlideIn(ToggleFrame, "left", 0.3)
        end)
        
        table.insert(Window.Elements, ToggleFrame)
        return {Value = state, Button = ToggleButton}
    end

    -- Add Slider with animations
    function Window:AddSlider(name, min, max, default, callback)
        local SliderFrame = Instance.new("Frame")
        SliderFrame.Size = UDim2.new(1, 0, 0, 50)
        SliderFrame.BackgroundTransparency = 1
        SliderFrame.Parent = ContentFrame

        local SliderLabel = Instance.new("TextLabel")
        SliderLabel.Size = UDim2.new(1, 0, 0, 20)
        SliderLabel.BackgroundTransparency = 1
        SliderLabel.Text = name .. ": " .. default
        SliderLabel.TextColor3 = Library.Theme.Text
        SliderLabel.TextSize = 14
        SliderLabel.Font = Enum.Font.Gotham
        SliderLabel.TextXAlignment = Enum.TextXAlignment.Left
        SliderLabel.Parent = SliderFrame

        local SliderBackground = Instance.new("Frame")
        SliderBackground.Size = UDim2.new(1, 0, 0, 12)
        SliderBackground.Position = UDim2.new(0, 0, 0, 25)
        SliderBackground.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
        SliderBackground.Parent = SliderFrame
        
        local SliderCorner = Instance.new("UICorner")
        SliderCorner.CornerRadius = UDim.new(0, 6)
        SliderCorner.Parent = SliderBackground

        local SliderValue = Instance.new("Frame")
        SliderValue.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
        SliderValue.BackgroundColor3 = Library.Theme.Accent
        SliderValue.Parent = SliderBackground
        
        local ValueCorner = Instance.new("UICorner")
        ValueCorner.CornerRadius = UDim.new(0, 6)
        ValueCorner.Parent = SliderValue

        local dragging = false
        local value = default

        local function UpdateSlider(x)
            local relativeX = math.clamp(x - SliderBackground.AbsolutePosition.X, 0, SliderBackground.AbsoluteSize.X)
            value = math.floor(min + (relativeX / SliderBackground.AbsoluteSize.X) * (max - min))
            SliderLabel.Text = name .. ": " .. value
            SliderValue.Size = UDim2.new((value - min) / (max - min), 0, 1, 0)
            callback(value)
        end

        SliderBackground.InputBegan:Connect(function(input)
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
        
        -- Animate slider in
        task.spawn(function()
            task.wait(#Window.Elements * 0.1)
            Library:SlideIn(SliderFrame, "left", 0.3)
        end)
        
        table.insert(Window.Elements, SliderFrame)
        return {Value = value}
    end

    -- GUI Controls with animations
    MinimizeButton.MouseButton1Click:Connect(function()
        Window.Minimized = not Window.Minimized
        
        if Window.Minimized then
            TweenService:Create(ContentFrame, TweenInfo.new(0.3), {
                Size = UDim2.new(1, -10, 0, 0)
            }):Play()
            TweenService:Create(MainFrame, TweenInfo.new(0.3), {
                Size = UDim2.new(0, 350, 0, 30)
            }):Play()
        else
            TweenService:Create(ContentFrame, TweenInfo.new(0.3), {
                Size = UDim2.new(1, -10, 1, -70)
            }):Play()
            TweenService:Create(MainFrame, TweenInfo.new(0.3), {
                Size = UDim2.new(0, 350, 0, 400)
            }):Play()
        end
    end)

    CloseButton.MouseButton1Click:Connect(function()
        Library:Notify("Hajaz Hub", "Меню закрыто", 2)
        -- Close animation
        local closeTween = TweenService:Create(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quad), {
            Position = UDim2.new(-1, -MainFrame.AbsoluteSize.X, MainFrame.Position.Y.Scale, MainFrame.Position.Y.Offset)
        })
        closeTween:Play()
        
        closeTween.Completed:Wait()
        ScreenGui:Destroy()
    end)

    -- Make GUI draggable
    local dragging = false
    local dragInput, dragStart, startPos

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

    -- Animate window in
    task.spawn(function()
        Library:SlideIn(MainFrame, "left", 0.5)
        Library:Notify("Hajaz Hub", "Библиотека загружена!", 3)
    end)

    return Window
end

return Library
