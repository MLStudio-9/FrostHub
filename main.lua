-- Fixed Hajaz Hub GUI Library
local Library = {}

-- Services
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

-- Library Variables
Library.Theme = {
    Background = Color3.new(0.1, 0.1, 0.1),
    Header = Color3.new(0.2, 0.2, 0.2),
    Text = Color3.new(1, 1, 1),
    Accent = Color3.new(0, 0.5, 1),
    ToggleOn = Color3.new(0, 1, 0),
    ToggleOff = Color3.new(1, 0, 0)
}

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
    MinimizeButton.TextColor3 = Color3.new(1, 1, 1)
    MinimizeButton.Parent = Title

    -- Close button
    local CloseButton = Instance.new("TextButton")
    CloseButton.Size = UDim2.new(0, 20, 0, 20)
    CloseButton.Position = UDim2.new(1, -50, 0, 5)
    CloseButton.BackgroundColor3 = Color3.new(1, 0.2, 0.2)
    CloseButton.Text = "X"
    CloseButton.TextColor3 = Color3.new(1, 1, 1)
    CloseButton.Parent = Title

    -- Tabs Container
    local TabsContainer = Instance.new("Frame")
    TabsContainer.Size = UDim2.new(1, 0, 0, 30)
    TabsContainer.Position = UDim2.new(0, 0, 0, 30)
    TabsContainer.BackgroundColor3 = Color3.new(0.15, 0.15, 0.15)
    TabsContainer.BorderSizePixel = 0
    TabsContainer.Parent = MainFrame

    local TabsList = Instance.new("UIListLayout")
    TabsList.FillDirection = Enum.FillDirection.Horizontal
    TabsList.Parent = TabsContainer

    -- Content Frame
    local ContentFrame = Instance.new("ScrollingFrame")
    ContentFrame.Size = UDim2.new(1, -10, 1, -70)
    ContentFrame.Position = UDim2.new(0, 5, 0, 65)
    ContentFrame.BackgroundTransparency = 1
    ContentFrame.ScrollBarThickness = 5
    ContentFrame.Parent = MainFrame

    local ContentList = Instance.new("UIListLayout")
    ContentList.Parent = ContentFrame

    -- Window Properties
    Window.Gui = ScreenGui
    Window.MainFrame = MainFrame
    Window.TabsContainer = TabsContainer
    Window.ContentFrame = ContentFrame
    Window.Tabs = {}
    Window.CurrentTab = nil

    -- Add Tab function
    function Window:AddTab(name)
        local Tab = {}
        
        local TabButton = Instance.new("TextButton")
        TabButton.Size = UDim2.new(0, 80, 1, 0)
        TabButton.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
        TabButton.Text = name
        TabButton.TextColor3 = Color3.new(1, 1, 1)
        TabButton.TextSize = 14
        TabButton.Parent = TabsContainer

        local TabContent = Instance.new("Frame")
        TabContent.Size = UDim2.new(1, 0, 1, 0)
        TabContent.BackgroundTransparency = 1
        TabContent.Visible = false
        TabContent.Parent = ContentFrame

        local TabList = Instance.new("UIListLayout")
        TabList.Parent = TabContent

        Tab.Button = TabButton
        Tab.Content = TabContent
        Tab.Name = name

        -- Tab click event
        TabButton.MouseButton1Click:Connect(function()
            if Window.CurrentTab then
                Window.CurrentTab.Content.Visible = false
                Window.CurrentTab.Button.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
            end
            
            Tab.Content.Visible = true
            Tab.Button.BackgroundColor3 = Library.Theme.Accent
            Window.CurrentTab = Tab
        end)

        table.insert(Window.Tabs, Tab)
        
        -- Select first tab
        if #Window.Tabs == 1 then
            TabButton.MouseButton1Click:Fire()
        end
        
        -- Add Button function to Tab
        function Tab:AddButton(name, callback)
            local Button = Instance.new("TextButton")
            Button.Size = UDim2.new(1, -10, 0, 30)
            Button.Position = UDim2.new(0, 5, 0, #Tab.Content:GetChildren() * 35)
            Button.BackgroundColor3 = Library.Theme.Accent
            Button.Text = name
            Button.TextColor3 = Color3.new(1, 1, 1)
            Button.TextSize = 14
            Button.Parent = TabContent
            
            Button.MouseButton1Click:Connect(callback)
            
            return Button
        end
        
        -- Add Toggle function to Tab
        function Tab:AddToggle(name, default, callback)
            local ToggleFrame = Instance.new("Frame")
            ToggleFrame.Size = UDim2.new(1, 0, 0, 30)
            ToggleFrame.BackgroundTransparency = 1
            ToggleFrame.Parent = TabContent

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
        
        -- Add Slider function to Tab
        function Tab:AddSlider(name, min, max, default, callback)
            local SliderFrame = Instance.new("Frame")
            SliderFrame.Size = UDim2.new(1, 0, 0, 50)
            SliderFrame.BackgroundTransparency = 1
            SliderFrame.Parent = TabContent

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
        
        return Tab
    end

    -- GUI Controls
    MinimizeButton.MouseButton1Click:Connect(function()
        ContentFrame.Visible = not ContentFrame.Visible
        TabsContainer.Visible = not TabsContainer.Visible
        MainFrame.Size = ContentFrame.Visible and UDim2.new(0, 350, 0, 400) or UDim2.new(0, 350, 0, 30)
    end)

    CloseButton.MouseButton1Click:Connect(function()
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

    return Window
end

return Library
