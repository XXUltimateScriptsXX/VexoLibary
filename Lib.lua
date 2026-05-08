[[
Vexo Libary, read to know how to use!
Made by Vexo, solo Developer!
Spent long time making it! Hope yall like it.
]]

local Library = {}
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local HttpService = game:GetService("HttpService")

-- Asset Downloader Helper
local function fetchAsset(url)
    if type(url) ~= "string" or url == "" then return "" end
    if url:find("rbxassetid://") or url:find("http") == nil then return url end

    local fileName = "Asset_" .. tick() .. ".png"
    if not isfile(fileName) then
        local success, result = pcall(function()
            return game:HttpGet(url)
        end)
        if success then
            writefile(fileName, result)
        else
            warn("Failed to download asset: " .. url)
            return "" 
        end
    end
    return getcustomasset(fileName)
end

function Library:CreateWindow(Config)
    local Title = Config.Title or "UI Library"
    local IconURL = Config.Icon or ""
    
    local gui = Instance.new("ScreenGui")
    gui.Name = "Vexo_" .. HttpService:GenerateGUID(false)
    gui.ResetOnSpawn = false
    gui.Parent = CoreGui
    
    local main = Instance.new("Frame")
    main.Size = UDim2.new(0, 520, 0, 420)
    main.Position = UDim2.new(0.5, -260, 0.5, -210)
    main.BackgroundColor3 = Color3.fromRGB(15,15,15)
    main.BorderSizePixel = 0
    main.Parent = gui
    Instance.new("UICorner", main).CornerRadius = UDim.new(0,16)
    
    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(120,70,255)
    stroke.Thickness = 2
    stroke.Parent = main
    
    local header = Instance.new("Frame")
    header.Size = UDim2.new(1, 0, 0, 50)
    header.BackgroundTransparency = 1
    header.Parent = main
    
    local crownImg = Instance.new("ImageLabel")
    crownImg.Size = UDim2.new(0, 24, 0, 24)
    crownImg.Position = UDim2.new(0, 15, 0.5, -12)
    crownImg.BackgroundTransparency = 1
    crownImg.Image = fetchAsset(IconURL)
    crownImg.ImageColor3 = Color3.fromRGB(220, 180, 255)
    crownImg.Parent = header
    
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(0, 250, 1, 0)
    titleLabel.Position = UDim2.new(0, 45, 0, 0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = Title
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextSize = 22
    titleLabel.TextColor3 = Color3.fromRGB(170,120,255)
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Parent = header

    local sidebar = Instance.new("Frame")
    sidebar.Size = UDim2.new(0,130,1,-50)
    sidebar.Position = UDim2.new(0,0,0,50)
    sidebar.BackgroundColor3 = Color3.fromRGB(20,20,20)
    sidebar.Parent = main
    Instance.new("UICorner", sidebar).CornerRadius = UDim.new(0,14)

    local sidebarLayout = Instance.new("UIListLayout", sidebar)
    sidebarLayout.Padding = UDim.new(0,5)
    sidebarLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1,-150,1,-70)
    container.Position = UDim2.new(0,140,0,60)
    container.BackgroundTransparency = 1
    container.Parent = main

    -- Dragging Logic
    local dragging, dragStart, startPos
    header.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true dragStart = input.Position startPos = main.Position
        end
    end)
    UIS.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end end)
    UIS.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)

    local Tabs = {}
    local firstTab = true

    function Tabs:CreateTab(name)
        local page = Instance.new("ScrollingFrame")
        page.Size = UDim2.new(1,0,1,0)
        page.BackgroundTransparency = 1
        page.Visible = firstTab
        page.ScrollBarThickness = 0
        page.Parent = container
        Instance.new("UIListLayout", page).Padding = UDim.new(0,10)
        
        local tabBtn = Instance.new("TextButton")
        tabBtn.Size = UDim2.new(1,-10,0,45)
        tabBtn.BackgroundColor3 = firstTab and Color3.fromRGB(40,40,40) or Color3.fromRGB(30,30,30)
        tabBtn.Text = name
        tabBtn.TextColor3 = Color3.new(1,1,1)
        tabBtn.Font = Enum.Font.GothamBold
        tabBtn.Parent = sidebar
        Instance.new("UICorner", tabBtn).CornerRadius = UDim.new(0,8)
        
        tabBtn.MouseButton1Click:Connect(function()
            for _, p in pairs(container:GetChildren()) do p.Visible = false end
            for _, b in pairs(sidebar:GetChildren()) do 
                if b:IsA("TextButton") then b.BackgroundColor3 = Color3.fromRGB(30,30,30) end 
            end
            page.Visible = true
            tabBtn.BackgroundColor3 = Color3.fromRGB(40,40,40)
        end)
        
        firstTab = false
        local Modules = {}
        
        function Modules:CreateButton(config)
            local frame = Instance.new("Frame")
            frame.Size = UDim2.new(1,-10,0,60)
            frame.BackgroundColor3 = Color3.fromRGB(25,25,25)
            frame.Parent = page
            Instance.new("UICorner", frame)
            
            local icon = Instance.new("ImageLabel")
            icon.Size = UDim2.new(0, 30, 0, 30)
            icon.Position = UDim2.new(0, 10, 0.5, -15)
            icon.BackgroundTransparency = 1
            icon.Image = fetchAsset(config.Icon)
            icon.Parent = frame

            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(0.5,0,1,0)
            label.Position = UDim2.new(0,50,0,0)
            label.BackgroundTransparency = 1
            label.Text = config.Name
            label.TextColor3 = Color3.new(1,1,1)
            label.Font = Enum.Font.GothamBold
            label.TextXAlignment = Enum.TextXAlignment.Left
            label.Parent = frame
            
            local btn = Instance.new("TextButton")
            btn.Size = UDim2.new(0,90,0,35)
            btn.Position = UDim2.new(1,-100,0.5,-17)
            btn.BackgroundColor3 = Color3.fromRGB(120,70,255)
            btn.Text = "Execute"
            btn.TextColor3 = Color3.new(1,1,1)
            btn.Parent = frame
            Instance.new("UICorner", btn)
            
            btn.MouseButton1Click:Connect(config.Callback)
        end

        function Modules:CreateToggle(config)
            local active = false
            local frame = Instance.new("Frame")
            frame.Size = UDim2.new(1,-10,0,60)
            frame.BackgroundColor3 = Color3.fromRGB(25,25,25)
            frame.Parent = page
            Instance.new("UICorner", frame)

            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(0.5,0,1,0)
            label.Position = UDim2.new(0,15,0,0)
            label.BackgroundTransparency = 1
            label.Text = config.Name
            label.TextColor3 = Color3.new(1,1,1)
            label.Font = Enum.Font.GothamBold
            label.TextXAlignment = Enum.TextXAlignment.Left
            label.Parent = frame
            
            local btn = Instance.new("TextButton")
            btn.Size = UDim2.new(0,90,0,35)
            btn.Position = UDim2.new(1,-100,0.5,-17)
            btn.BackgroundColor3 = Color3.fromRGB(50,50,50)
            btn.Text = "OFF"
            btn.TextColor3 = Color3.new(1,1,1)
            btn.Parent = frame
            Instance.new("UICorner", btn)
            
            btn.MouseButton1Click:Connect(function()
                active = not active
                btn.Text = active and "ON" or "OFF"
                btn.BackgroundColor3 = active and Color3.fromRGB(120,70,255) or Color3.fromRGB(50,50,50)
                task.spawn(function()
                    while active do
                        config.Callback()
                        task.wait(config.Delay or 0.1)
                    end
                end)
            end)
        end

        function Modules:CreateDropdown(config)
            local selected = nil
            local frame = Instance.new("Frame")
            frame.Size = UDim2.new(1,-10,0,60)
            frame.BackgroundColor3 = Color3.fromRGB(25,25,25)
            frame.ClipsDescendants = true
            frame.Parent = page
            Instance.new("UICorner", frame)
            
            local dropBtn = Instance.new("TextButton")
            dropBtn.Size = UDim2.new(1,-110,0,35)
            dropBtn.Position = UDim2.new(0,10,0,12)
            dropBtn.BackgroundColor3 = Color3.fromRGB(40,40,40)
            dropBtn.Text = config.Name .. ": Select..."
            dropBtn.TextColor3 = Color3.new(1,1,1)
            dropBtn.Parent = frame
            Instance.new("UICorner", dropBtn)

            local runBtn = Instance.new("TextButton")
            runBtn.Size = UDim2.new(0,90,0,35)
            runBtn.Position = UDim2.new(1,-100,0,12)
            runBtn.BackgroundColor3 = Color3.fromRGB(120,70,255)
            runBtn.Text = config.RunText or "Run"
            runBtn.TextColor3 = Color3.new(1,1,1)
            runBtn.Parent = frame
            Instance.new("UICorner", runBtn)

            local listFrame = Instance.new("ScrollingFrame")
            listFrame.Size = UDim2.new(1,-20,0,100)
            listFrame.Position = UDim2.new(0,10,0,55)
            listFrame.BackgroundTransparency = 1
            listFrame.ScrollBarThickness = 2
            listFrame.Parent = frame
            Instance.new("UIListLayout", listFrame)

            local open = false
            dropBtn.MouseButton1Click:Connect(function()
                open = not open
                TweenService:Create(frame, TweenInfo.new(0.3), {Size = open and UDim2.new(1,-10,0,160) or UDim2.new(1,-10,0,60)}):Play()
            end)

            for _, item in pairs(config.Options) do
                local b = Instance.new("TextButton")
                b.Size = UDim2.new(1,0,0,30)
                b.BackgroundTransparency = 1
                b.Text = item
                b.TextColor3 = Color3.fromRGB(200,200,200)
                b.Parent = listFrame
                b.MouseButton1Click:Connect(function()
                    selected = item
                    dropBtn.Text = config.Name .. ": " .. item
                    open = false
                    TweenService:Create(frame, TweenInfo.new(0.3), {Size = UDim2.new(1,-10,0,60)}):Play()
                end)
            end

            runBtn.MouseButton1Click:Connect(function()
                if selected then config.Callback(selected) end
            end)
        end
        
        return Modules
    end
    return Tabs
end

return Library -- CRITICAL: DO NOT DELETE THIS LINE
