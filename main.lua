
local MyUILibrary = {}
MyUILibrary.__index = MyUILibrary

--[[
    ТЕМЫ ОФОРМЛЕНИЯ
    1. Dark - Темная тема (по умолчанию)
    2. Light - Светлая тема
    3. Blue - Синяя тема
    4. Red - Красная тема
    5. Green - Зеленая тема
    6. Purple - Фиолетовая тема
    7. Cyber - Киберпанк тема
    8. Sunset - Закатная тема
    9. Ocean - Океанская тема
]]

MyUILibrary.Themes = {
    Dark = {
        Primary = Color3.fromRGB(25, 25, 25),
        Secondary = Color3.fromRGB(35, 35, 35),
        Accent = Color3.fromRGB(0, 120, 215),
        Text = Color3.fromRGB(255, 255, 255),
        SubText = Color3.fromRGB(200, 200, 200),
        Success = Color3.fromRGB(0, 255, 0),
        Error = Color3.fromRGB(255, 0, 0),
        Border = Color3.fromRGB(60, 60, 60)
    },
    Light = {
        Primary = Color3.fromRGB(240, 240, 240),
        Secondary = Color3.fromRGB(220, 220, 220),
        Accent = Color3.fromRGB(0, 120, 215),
        Text = Color3.fromRGB(0, 0, 0),
        SubText = Color3.fromRGB(80, 80, 80),
        Success = Color3.fromRGB(0, 200, 0),
        Error = Color3.fromRGB(255, 0, 0),
        Border = Color3.fromRGB(180, 180, 180)
    },
    Blue = {
        Primary = Color3.fromRGB(25, 25, 45),
        Secondary = Color3.fromRGB(35, 35, 65),
        Accent = Color3.fromRGB(0, 150, 255),
        Text = Color3.fromRGB(255, 255, 255),
        SubText = Color3.fromRGB(200, 200, 220),
        Success = Color3.fromRGB(0, 255, 200),
        Error = Color3.fromRGB(255, 100, 100),
        Border = Color3.fromRGB(60, 60, 100)
    },
    Red = {
        Primary = Color3.fromRGB(45, 25, 25),
        Secondary = Color3.fromRGB(65, 35, 35),
        Accent = Color3.fromRGB(255, 50, 50),
        Text = Color3.fromRGB(255, 255, 255),
        SubText = Color3.fromRGB(220, 200, 200),
        Success = Color3.fromRGB(0, 255, 100),
        Error = Color3.fromRGB(255, 80, 80),
        Border = Color3.fromRGB(100, 60, 60)
    },
    Green = {
        Primary = Color3.fromRGB(25, 45, 25),
        Secondary = Color3.fromRGB(35, 65, 35),
        Accent = Color3.fromRGB(50, 255, 50),
        Text = Color3.fromRGB(255, 255, 255),
        SubText = Color3.fromRGB(200, 220, 200),
        Success = Color3.fromRGB(0, 255, 100),
        Error = Color3.fromRGB(255, 100, 100),
        Border = Color3.fromRGB(60, 100, 60)
    },
    Purple = {
        Primary = Color3.fromRGB(35, 25, 45),
        Secondary = Color3.fromRGB(55, 35, 65),
        Accent = Color3.fromRGB(180, 80, 255),
        Text = Color3.fromRGB(255, 255, 255),
        SubText = Color3.fromRGB(220, 200, 220),
        Success = Color3.fromRGB(180, 255, 100),
        Error = Color3.fromRGB(255, 100, 180),
        Border = Color3.fromRGB(80, 60, 100)
    },
    Cyber = {
        Primary = Color3.fromRGB(10, 15, 30),
        Secondary = Color3.fromRGB(20, 25, 45),
        Accent = Color3.fromRGB(0, 255, 255),
        Text = Color3.fromRGB(255, 255, 255),
        SubText = Color3.fromRGB(180, 220, 255),
        Success = Color3.fromRGB(0, 255, 150),
        Error = Color3.fromRGB(255, 50, 100),
        Border = Color3.fromRGB(0, 200, 200)
    },
    Sunset = {
        Primary = Color3.fromRGB(45, 25, 35),
        Secondary = Color3.fromRGB(65, 35, 50),
        Accent = Color3.fromRGB(255, 150, 50),
        Text = Color3.fromRGB(255, 255, 255),
        SubText = Color3.fromRGB(255, 220, 200),
        Success = Color3.fromRGB(255, 200, 0),
        Error = Color3.fromRGB(255, 100, 100),
        Border = Color3.fromRGB(200, 100, 50)
    },
    Ocean = {
        Primary = Color3.fromRGB(25, 35, 45),
        Secondary = Color3.fromRGB(35, 50, 65),
        Accent = Color3.fromRGB(0, 180, 255),
        Text = Color3.fromRGB(255, 255, 255),
        SubText = Color3.fromRGB(200, 220, 240),
        Success = Color3.fromRGB(0, 255, 200),
        Error = Color3.fromRGB(255, 100, 150),
        Border = Color3.fromRGB(0, 150, 200)
    }
}

function MyUILibrary:CreateInstance(className, properties)
    local instance = Instance.new(className)
    for property, value in pairs(properties) do
        instance[property] = value
    end
    return instance
end

function MyUILibrary:Tween(object, properties, duration, style)
    local tweenInfo = TweenInfo.new(duration or 0.2, style or Enum.EasingStyle.Quad)
    local tween = game:GetService("TweenService"):Create(object, tweenInfo, properties)
    tween:Play()
    return tween
end

function MyUILibrary:RoundCorners(object, cornerRadius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(cornerRadius or 0.1, 0)
    corner.Parent = object
    return corner
end

function MyUILibrary:CreateStroke(object, color, thickness)
    local stroke = Instance.new("UIStroke")
    stroke.Color = color or Color3.fromRGB(255, 255, 255)
    stroke.Thickness = thickness or 1
    stroke.Parent = object
    return stroke
end

function MyUILibrary:CreateWindow(options)
    local window = setmetatable({}, self)
    window.Name = options.Name or "MyUI Window"
    window.Theme = options.Theme and self.Themes[options.Theme] or self.Themes.Dark
    window.Tabs = {}
    window.Elements = {}
    
    window.ScreenGui = self:CreateInstance("ScreenGui", {
        Name = "MyUIScreen",
        ResetOnSpawn = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        Parent = options.Parent or game.Players.LocalPlayer:WaitForChild("PlayerGui")
    })

    window.MainFrame = self:CreateInstance("Frame", {
        Name = "MainFrame",
        Size = UDim2.new(0, 500, 0, 400),
        Position = UDim2.new(0.5, -250, 0.5, -200),
        BackgroundColor3 = window.Theme.Primary,
        BorderSizePixel = 0,
        Parent = window.ScreenGui
    })
    self:RoundCorners(window.MainFrame, 0.05)
    self:CreateStroke(window.MainFrame, window.Theme.Border, 2)
    
    window.Title = self:CreateInstance("TextLabel", {
        Name = "Title",
        Size = UDim2.new(1, 0, 0, 40),
        BackgroundColor3 = window.Theme.Secondary,
        BorderSizePixel = 0,
        Text = window.Name,
        TextColor3 = window.Theme.Text,
        TextSize = 16,
        Font = Enum.Font.GothamBold,
        Parent = window.MainFrame
    })
    self:RoundCorners(window.Title, 0.05)
    
    window.TabButtons = self:CreateInstance("ScrollingFrame", {
        Name = "TabButtons",
        Size = UDim2.new(1, 0, 0, 40),
        Position = UDim2.new(0, 0, 0, 40),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        CanvasSize = UDim2.new(0, 0, 0, 0),
        ScrollBarThickness = 0,
        Parent = window.MainFrame
    })
    
    local uiListLayout = self:CreateInstance("UIListLayout", {
        Parent = window.TabButtons,
        FillDirection = Enum.FillDirection.Horizontal,
        SortOrder = Enum.SortOrder.LayoutOrder
    })
    
    window.ContentFrame = self:CreateInstance("ScrollingFrame", {
        Name = "ContentFrame",
        Size = UDim2.new(1, 0, 1, -80),
        Position = UDim2.new(0, 0, 0, 80),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        CanvasSize = UDim2.new(0, 0, 0, 0),
        ScrollBarThickness = 4,
        ScrollBarImageColor3 = window.Theme.Accent,
        Parent = window.MainFrame
    })
    
    local contentListLayout = self:CreateInstance("UIListLayout", {
        Parent = window.ContentFrame,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 10)
    })
    
    contentListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        window.ContentFrame.CanvasSize = UDim2.new(0, 0, 0, contentListLayout.AbsoluteContentSize.Y + 20)
    end)
    
    return window
end

function MyUILibrary:CreateTab(name)
    local tab = {}
    tab.Name = name
    tab.Visible = false
    tab.Elements = {}
    
    tab.Button = self:CreateInstance("TextButton", {
        Name = name .. "TabButton",
        Size = UDim2.new(0, 100, 1, 0),
        BackgroundColor3 = self.Theme.Secondary,
        BorderSizePixel = 0,
        Text = name,
        TextColor3 = self.Theme.Text,
        TextSize = 14,
        Font = Enum.Font.Gotham,
        Parent = self.TabButtons
    })
    self:RoundCorners(tab.Button, 0.05)
    
    tab.Content = self:CreateInstance("Frame", {
        Name = name .. "Content",
        Size = UDim2.new(1, -20, 0, 0),
        Position = UDim2.new(0, 10, 0, 0),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Visible = false,
        Parent = self.ContentFrame
    })
    
    local tabListLayout = self:CreateInstance("UIListLayout", {
        Parent = tab.Content,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 15)
    })
    
    tabListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        tab.Content.Size = UDim2.new(1, -20, 0, tabListLayout.AbsoluteContentSize.Y)
    end)
    
    tab.Button.MouseButton1Click:Connect(function()
        self:SwitchTab(tab)
    end)
    
    table.insert(self.Tabs, tab)
    
    if #self.Tabs == 1 then
        self:SwitchTab(tab)
    end
    
    self.TabButtons.CanvasSize = UDim2.new(0, #self.Tabs * 100, 0, 0)
    
    return tab
end

function MyUILibrary:SwitchTab(tab)
    for _, otherTab in ipairs(self.Tabs) do
        otherTab.Visible = false
        otherTab.Content.Visible = false
        self:Tween(otherTab.Button, {BackgroundColor3 = self.Theme.Secondary}, 0.2)
    end
    
    tab.Visible = true
    tab.Content.Visible = true
    self:Tween(tab.Button, {BackgroundColor3 = self.Theme.Accent}, 0.2)
end

function MyUILibrary:CreateSection(tab, name)
    local section = {}
    
    section.Frame = self:CreateInstance("Frame", {
        Name = name .. "Section",
        Size = UDim2.new(1, 0, 0, 0),
        BackgroundColor3 = self.Theme.Secondary,
        BorderSizePixel = 0,
        Parent = tab.Content
    })
    self:RoundCorners(section.Frame, 0.05)
    self:CreateStroke(section.Frame, self.Theme.Border, 1)
    
    section.Title = self:CreateInstance("TextLabel", {
        Name = "Title",
        Size = UDim2.new(1, -20, 0, 30),
        Position = UDim2.new(0, 10, 0, 5),
        BackgroundTransparency = 1,
        Text = name,
        TextColor3 = self.Theme.Text,
        TextSize = 14,
        Font = Enum.Font.GothamBold,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = section.Frame
    })
    
    section.Content = self:CreateInstance("Frame", {
        Name = "Content",
        Size = UDim2.new(1, -20, 0, 0),
        Position = UDim2.new(0, 10, 0, 40),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Parent = section.Frame
    })
    
    local sectionListLayout = self:CreateInstance("UIListLayout", {
        Parent = section.Content,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 10)
    })
    
    sectionListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        section.Content.Size = UDim2.new(1, 0, 0, sectionListLayout.AbsoluteContentSize.Y)
        section.Frame.Size = UDim2.new(1, 0, 0, sectionListLayout.AbsoluteContentSize.Y + 50)
    end)
    
    return section
end

function MyUILibrary:CreateToggle(section, options)
    local toggle = {}
    toggle.Name = options.Name or "Toggle"
    toggle.CurrentValue = options.CurrentValue or false
    toggle.Callback = options.Callback or function() end
    
    toggle.Frame = self:CreateInstance("Frame", {
        Name = toggle.Name .. "Toggle",
        Size = UDim2.new(1, 0, 0, 30),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Parent = section.Content
    })
    
    toggle.Label = self:CreateInstance("TextLabel", {
        Name = "Label",
        Size = UDim2.new(0.7, 0, 1, 0),
        BackgroundTransparency = 1,
        Text = toggle.Name,
        TextColor3 = self.Theme.Text,
        TextSize = 14,
        Font = Enum.Font.Gotham,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = toggle.Frame
    })
    
    toggle.Background = self:CreateInstance("Frame", {
        Name = "Background",
        Size = UDim2.new(0, 50, 0, 25),
        Position = UDim2.new(0.7, 0, 0.5, -12.5),
        BackgroundColor3 = self.Theme.Secondary,
        BorderSizePixel = 0,
        Parent = toggle.Frame
    })
    self:RoundCorners(toggle.Background, 0.5)
    
    toggle.Thumb = self:CreateInstance("Frame", {
        Name = "Thumb",
        Size = UDim2.new(0, 20, 0, 20),
        Position = UDim2.new(0, 3, 0.5, -10),
        BackgroundColor3 = self.Theme.Error,
        BorderSizePixel = 0,
        Parent = toggle.Background
    })
    self:RoundCorners(toggle.Thumb, 0.5)
    
    function toggle:Update()
        if self.CurrentValue then
            self:Tween(self.Thumb, {
                Position = UDim2.new(1, -23, 0.5, -10),
                BackgroundColor3 = self.Theme.Success
            }, 0.2)
            self:Tween(self.Background, {
                BackgroundColor3 = Color3.fromRGB(
                    math.floor(self.Theme.Success.R * 255 * 0.3),
                    math.floor(self.Theme.Success.G * 255 * 0.3),
                    math.floor(self.Theme.Success.B * 255 * 0.3)
                )
            }, 0.2)
        else
            self:Tween(self.Thumb, {
                Position = UDim2.new(0, 3, 0.5, -10),
                BackgroundColor3 = self.Theme.Error
            }, 0.2)
            self:Tween(self.Background, {
                BackgroundColor3 = self.Theme.Secondary
            }, 0.2)
        end
    end
    
    toggle.Background.MouseButton1Click:Connect(function()
        toggle.CurrentValue = not toggle.CurrentValue
        toggle:Update()
        toggle.Callback(toggle.CurrentValue)
    end)
    
    toggle:Update()
    table.insert(self.Elements, toggle)
    
    return toggle
end

function MyUILibrary:CreateSlider(section, options)
    local slider = {}
    slider.Name = options.Name or "Slider"
    slider.Range = options.Range or {0, 100}
    slider.Increment = options.Increment or 1
    slider.CurrentValue = options.CurrentValue or slider.Range[1]
    slider.Callback = options.Callback or function() end
    slider.Suffix = options.Suffix or ""
    
    slider.Frame = self:CreateInstance("Frame", {
        Name = slider.Name .. "Slider",
        Size = UDim2.new(1, 0, 0, 60),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Parent = section.Content
    })
    
    slider.Label = self:CreateInstance("TextLabel", {
        Name = "Label",
        Size = UDim2.new(1, 0, 0, 20),
        BackgroundTransparency = 1,
        Text = slider.Name,
        TextColor3 = self.Theme.Text,
        TextSize = 14,
        Font = Enum.Font.Gotham,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = slider.Frame
    })
    
    slider.ValueLabel = self:CreateInstance("TextLabel", {
        Name = "ValueLabel",
        Size = UDim2.new(1, 0, 0, 20),
        Position = UDim2.new(0, 0, 0, 20),
        BackgroundTransparency = 1,
        Text = tostring(slider.CurrentValue) .. slider.Suffix,
        TextColor3 = self.Theme.SubText,
        TextSize = 12,
        Font = Enum.Font.Gotham,
        TextXAlignment = Enum.TextXAlignment.Right,
        Parent = slider.Frame
    })
    
    slider.Track = self:CreateInstance("Frame", {
        Name = "Track",
        Size = UDim2.new(1, 0, 0, 5),
        Position = UDim2.new(0, 0, 0, 45),
        BackgroundColor3 = self.Theme.Secondary,
        BorderSizePixel = 0,
        Parent = slider.Frame
    })
    self:RoundCorners(slider.Track, 0.5)
    
    slider.Fill = self:CreateInstance("Frame", {
        Name = "Fill",
        Size = UDim2.new(0, 0, 1, 0),
        BackgroundColor3 = self.Theme.Accent,
        BorderSizePixel = 0,
        Parent = slider.Track
    })
    self:RoundCorners(slider.Fill, 0.5)
    
    slider.Thumb = self:CreateInstance("Frame", {
        Name = "Thumb",
        Size = UDim2.new(0, 15, 0, 15),
        Position = UDim2.new(0, 0, 0.5, -7.5),
        BackgroundColor3 = self.Theme.Text,
        BorderSizePixel = 0,
        Parent = slider.Track
    })
    self:RoundCorners(slider.Thumb, 0.5)
    
    function slider:Update(value)
        value = math.clamp(value, self.Range[1], self.Range[2])
        value = math.floor(value / self.Increment) * self.Increment
        
        self.CurrentValue = value
        self.ValueLabel.Text = tostring(value) .. self.Suffix
        
        local percentage = (value - self.Range[1]) / (self.Range[2] - self.Range[1])
        self.Fill.Size = UDim2.new(percentage, 0, 1, 0)
        self.Thumb.Position = UDim2.new(percentage, -7.5, 0.5, -7.5)
        
        self.Callback(value)
    end
    
    local isDragging = false
    
    slider.Thumb.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            isDragging = true
        end
    end)
    
    slider.Thumb.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            isDragging = false
        end
    end)
    
    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if isDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local mousePos = game:GetService("UserInputService"):GetMouseLocation()
            local trackAbsPos = slider.Track.AbsolutePosition
            local trackAbsSize = slider.Track.AbsoluteSize
            
            local relativeX = math.clamp((mousePos.X - trackAbsPos.X) / trackAbsSize.X, 0, 1)
            local value = slider.Range[1] + relativeX * (slider.Range[2] - slider.Range[1])
            
            slider:Update(value)
        end
    end)
    
    slider.Track.MouseButton1Down:Connect(function()
        local mousePos = game:GetService("UserInputService"):GetMouseLocation()
        local trackAbsPos = slider.Track.AbsolutePosition
        local trackAbsSize = slider.Track.AbsoluteSize
        
        local relativeX = math.clamp((mousePos.X - trackAbsPos.X) / trackAbsSize.X, 0, 1)
        local value = slider.Range[1] + relativeX * (slider.Range[2] - slider.Range[1])
        
        slider:Update(value)
    end)
    
    slider:Update(slider.CurrentValue)
    table.insert(self.Elements, slider)
    
    return slider
end

function MyUILibrary:CreateCheckbox(section, options)
    local checkbox = {}
    checkbox.Name = options.Name or "Checkbox"
    checkbox.CurrentValue = options.CurrentValue or false
    checkbox.Callback = options.Callback or function() end
    
    checkbox.Frame = self:CreateInstance("Frame", {
        Name = checkbox.Name .. "Checkbox",
        Size = UDim2.new(1, 0, 0, 30),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Parent = section.Content
    })
    
    checkbox.Label = self:CreateInstance("TextLabel", {
        Name = "Label",
        Size = UDim2.new(0.8, 0, 1, 0),
        BackgroundTransparency = 1,
        Text = checkbox.Name,
        TextColor3 = self.Theme.Text,
        TextSize = 14,
        Font = Enum.Font.Gotham,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = checkbox.Frame
    })
    
    checkbox.Box = self:CreateInstance("Frame", {
        Name = "Box",
        Size = UDim2.new(0, 20, 0, 20),
        Position = UDim2.new(0.8, 0, 0.5, -10),
        BackgroundColor3 = self.Theme.Secondary,
        BorderSizePixel = 0,
        Parent = checkbox.Frame
    })
    self:RoundCorners(checkbox.Box, 0.2)
    self:CreateStroke(checkbox.Box, self.Theme.Border, 1)
    
    checkbox.Check = self:CreateInstance("TextLabel", {
        Name = "Check",
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        Text = "✓",
        TextColor3 = self.Theme.Success,
        TextSize = 16,
        Font = Enum.Font.GothamBold,
        Visible = false,
        Parent = checkbox.Box
    })
    
    function checkbox:Update()
        if self.CurrentValue then
            self.Check.Visible = true
            self:Tween(self.Box, {
                BackgroundColor3 = Color3.fromRGB(
                    math.floor(self.Theme.Success.R * 255 * 0.3),
                    math.floor(self.Theme.Success.G * 255 * 0.3),
                    math.floor(self.Theme.Success.B * 255 * 0.3)
                )
            }, 0.2)
        else
            self.Check.Visible = false
            self:Tween(self.Box, {
                BackgroundColor3 = self.Theme.Secondary
            }, 0.2)
        end
    end
    
    checkbox.Box.MouseButton1Click:Connect(function()
        checkbox.CurrentValue = not checkbox.CurrentValue
        checkbox:Update()
        checkbox.Callback(checkbox.CurrentValue)
    end)
    
    checkbox:Update()
    table.insert(self.Elements, checkbox)
    
    return checkbox
end

function MyUILibrary:CreateInput(section, options)
    local input = {}
    input.Name = options.Name or "Input"
    input.Placeholder = options.Placeholder or "Type here..."
    input.CurrentValue = options.CurrentValue or ""
    input.Callback = options.Callback or function() end
    
    input.Frame = self:CreateInstance("Frame", {
        Name = input.Name .. "Input",
        Size = UDim2.new(1, 0, 0, 40),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Parent = section.Content
    })
    
    input.Label = self:CreateInstance("TextLabel", {
        Name = "Label",
        Size = UDim2.new(1, 0, 0, 20),
        BackgroundTransparency = 1,
        Text = input.Name,
        TextColor3 = self.Theme.Text,
        TextSize = 14,
        Font = Enum.Font.Gotham,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = input.Frame
    })
    
    input.TextBox = self:CreateInstance("TextBox", {
        Name = "TextBox",
        Size = UDim2.new(1, 0, 0, 30),
        Position = UDim2.new(0, 0, 0, 20),
        BackgroundColor3 = self.Theme.Secondary,
        TextColor3 = self.Theme.Text,
        PlaceholderText = input.Placeholder,
        PlaceholderColor3 = self.Theme.SubText,
        TextSize = 14,
        Font = Enum.Font.Gotham,
        Text = input.CurrentValue,
        Parent = input.Frame
    })
    self:RoundCorners(input.TextBox, 0.05)
    
    input.TextBox.FocusLost:Connect(function()
        input.CurrentValue = input.TextBox.Text
        input.Callback(input.CurrentValue)
    end)
    
    table.insert(self.Elements, input)
    
    return input
end

function MyUILibrary:CreateButton(section, options)
    local button = {}
    button.Name = options.Name or "Button"
    button.Callback = options.Callback or function() end
    
    button.Frame = self:CreateInstance("TextButton", {
        Name = button.Name .. "Button",
        Size = UDim2.new(1, 0, 0, 35),
        BackgroundColor3 = self.Theme.Accent,
        BorderSizePixel = 0,
        Text = button.Name,
        TextColor3 = self.Theme.Text,
        TextSize = 14,
        Font = Enum.Font.GothamBold,
        Parent = section.Content
    })
    self:RoundCorners(button.Frame, 0.05)
    
    button.Frame.MouseEnter:Connect(function()
        self:Tween(button.Frame, {
            BackgroundColor3 = Color3.fromRGB(
                math.min(255, math.floor(self.Theme.Accent.R * 255 * 1.2)),
                math.min(255, math.floor(self.Theme.Accent.G * 255 * 1.2)),
                math.min(255, math.floor(self.Theme.Accent.B * 255 * 1.2))
            )
        }, 0.1)
    end)
    
    button.Frame.MouseLeave:Connect(function()
        self:Tween(button.Frame, {
            BackgroundColor3 = self.Theme.Accent
        }, 0.1)
    end)
    
    button.Frame.MouseButton1Click:Connect(function()
        self:Tween(button.Frame, {
            BackgroundColor3 = Color3.fromRGB(
                math.max(0, math.floor(self.Theme.Accent.R * 255 * 0.8)),
                math.max(0, math.floor(self.Theme.Accent.G * 255 * 0.8)),
                math.max(0, math.floor(self.Theme.Accent.B * 255 * 0.8))
            )
        }, 0.1)
        
        wait(0.1)
        
        self:Tween(button.Frame, {
            BackgroundColor3 = self.Theme.Accent
        }, 0.1)
        
        button.Callback()
    end)
    
    table.insert(self.Elements, button)
    
    return button
end

function MyUILibrary:CreateLabel(section, options)
    local label = {}
    label.Text = options.Text or "Label"
    label.Color = options.Color or self.Theme.Text
    
    label.Frame = self:CreateInstance("TextLabel", {
        Name = "Label",
        Size = UDim2.new(1, 0, 0, 20),
        BackgroundTransparency = 1,
        Text = label.Text,
        TextColor3 = label.Color,
        TextSize = options.TextSize or 14,
        Font = options.Font or Enum.Font.Gotham,
        TextXAlignment = options.Alignment or Enum.TextXAlignment.Left,
        Parent = section.Content
    })
    
    return label
end

function MyUILibrary:SetTheme(themeName)
    local newTheme = self.Themes[themeName] or self.Themes.Dark
    self.Theme = newTheme
    
    self:UpdateTheme()
end

function MyUILibrary:UpdateTheme()
    self.MainFrame.BackgroundColor3 = self.Theme.Primary
    self.Title.BackgroundColor3 = self.Theme.Secondary
    self.Title.TextColor3 = self.Theme.Text
    self.ContentFrame.ScrollBarImageColor3 = self.Theme.Accent
    
    for _, element in ipairs(self.Elements) do
        if element.UpdateTheme then
            element:UpdateTheme(self.Theme)
        end
    end
end

function MyUILibrary:Destroy()
    if self.ScreenGui then
        self.ScreenGui:Destroy()
    end
end

return MyUILibrary
