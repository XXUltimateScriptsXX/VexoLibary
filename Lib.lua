[[
Vexo Libary, read to know how to use!
Made by Vexo, solo Developer!
Spent long time making it! Hope yall like it.
]]

-- VEXO LIBRARY V6 (FIXED DROPDOWN TEXT)
local Library = {}
Library.__index = Library

local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")

local function getImg(url)
    if type(url) ~= "string" or url == "" then return "" end
    if url:find("rbxassetid://") or tonumber(url) then
        return url:find("rbxassetid://") and url or "rbxassetid://" .. url
    end
    local name = "VexoAsset_" .. tick() .. ".png"
    if not isfile(name) then
        local s, res = pcall(function() return game:HttpGet(url) end)
        if s then writefile(name, res) else return "" end
    end
    return getcustomasset(name)
end

function Library:CreateWindow(cfg)
    local cfg = cfg or {}
    local gui = Instance.new("ScreenGui", CoreGui)
    gui.Name = "Vexo_" .. math.random(1,999)
    gui.ResetOnSpawn = false

    local main = Instance.new("Frame", gui)
    main.Size = UDim2.new(0, 520, 0, 420)
    main.Position = UDim2.new(0.5, -260, 0.5, -210)
    main.BackgroundColor3 = Color3.fromRGB(15,15,15)
    main.BorderSizePixel = 0
    Instance.new("UICorner", main).CornerRadius = UDim.new(0,16)
    
    local stroke = Instance.new("UIStroke", main)
    stroke.Color = Color3.fromRGB(120,70,255)
    stroke.Thickness = 2

    local head = Instance.new("Frame", main)
    head.Size = UDim2.new(1, 0, 0, 50)
    head.BackgroundTransparency = 1

    local title = Instance.new("TextLabel", head)
    title.Size = UDim2.new(1, -60, 1, 0)
    title.Position = UDim2.new(0, 45, 0, 0)
    title.Text = cfg.Title or "Vexo Library"
    title.TextColor3 = Color3.fromRGB(170,120,255)
    title.Font = Enum.Font.GothamBold
    title.TextSize = 22
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.BackgroundTransparency = 1

    local icon = Instance.new("ImageLabel", head)
    icon.Size = UDim2.new(0, 24, 0, 24)
    icon.Position = UDim2.new(0, 15, 0.5, -12)
    icon.Image = getImg(cfg.Icon)
    icon.ImageColor3 = Color3.fromRGB(220, 180, 255)
    icon.BackgroundTransparency = 1

    local sidebar = Instance.new("Frame", main)
    sidebar.Size = UDim2.new(0, 130, 1, -60)
    sidebar.Position = UDim2.new(0, 10, 0, 50)
    sidebar.BackgroundColor3 = Color3.fromRGB(20,20,20)
    Instance.new("UICorner", sidebar).CornerRadius = UDim.new(0,14)
    Instance.new("UIListLayout", sidebar).Padding = UDim.new(0, 5)

    local container = Instance.new("Frame", main)
    container.Size = UDim2.new(1, -160, 1, -70)
    container.Position = UDim2.new(0, 150, 0, 60)
    container.BackgroundTransparency = 1

    -- Dragging
    local d, ds, sp
    head.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then d = true ds = i.Position sp = main.Position end end)
    UIS.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then d = false end end)
    UIS.InputChanged:Connect(function(i) if d and i.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = i.Position - ds
        main.Position = UDim2.new(sp.X.Scale, sp.X.Offset + delta.X, sp.Y.Scale, sp.Y.Offset + delta.Y)
    end end)

    local Tabs = {}
    local first = true
    function Tabs:CreateTab(name)
        local page = Instance.new("ScrollingFrame", container)
        page.Size = UDim2.new(1, 0, 1, 0)
        page.Visible = first
        page.BackgroundTransparency = 1
        page.ScrollBarThickness = 0
        Instance.new("UIListLayout", page).Padding = UDim.new(0, 10)

        local tBtn = Instance.new("TextButton", sidebar)
        tBtn.Size = UDim2.new(1, -10, 0, 45)
        tBtn.Text = name
        tBtn.BackgroundColor3 = first and Color3.fromRGB(40,40,40) or Color3.fromRGB(30,30,30)
        tBtn.TextColor3 = Color3.new(1,1,1)
        tBtn.Font = Enum.Font.GothamBold
        tBtn.TextSize = 16
        Instance.new("UICorner", tBtn).CornerRadius = UDim.new(0,8)

        tBtn.MouseButton1Click:Connect(function()
            for _, v in pairs(container:GetChildren()) do v.Visible = false end
            for _, v in pairs(sidebar:GetChildren()) do if v:IsA("TextButton") then v.BackgroundColor3 = Color3.fromRGB(30,30,30) end end
            page.Visible = true
            tBtn.BackgroundColor3 = Color3.fromRGB(40,40,40)
        end)

        first = false
        local Mods = {}
        
        -- MODULE: BUTTON
        function Mods:CreateButton(c)
            local f = Instance.new("Frame", page)
            f.Size = UDim2.new(1, -10, 0, 70)
            f.BackgroundColor3 = Color3.fromRGB(25,25,25)
            Instance.new("UICorner", f).CornerRadius = UDim.new(0,12)
            
            local img = Instance.new("ImageLabel", f)
            img.Size = UDim2.new(0, 35, 0, 35)
            img.Position = UDim2.new(0, 10, 0.5, -17)
            img.Image = getImg(c.Icon)
            img.BackgroundTransparency = 1

            local l = Instance.new("TextLabel", f)
            l.Text = c.Name
            l.Position = UDim2.new(0, 55, 0, 0)
            l.Size = UDim2.new(0.5, 0, 1, 0)
            l.TextColor3 = Color3.new(1,1,1)
            l.Font = Enum.Font.GothamBold
            l.TextSize = 18
            l.TextXAlignment = "Left"
            l.BackgroundTransparency = 1

            local b = Instance.new("TextButton", f)
            b.Size = UDim2.new(0, 100, 0, 40)
            b.Position = UDim2.new(1, -110, 0.5, -20)
            b.BackgroundColor3 = Color3.fromRGB(140,90,255)
            b.Text = "Execute"
            b.TextColor3 = Color3.new(1,1,1)
            b.Font = Enum.Font.GothamBold
            b.TextSize = 14
            Instance.new("UICorner", b).CornerRadius = UDim.new(0,8)
            b.MouseButton1Click:Connect(c.Callback)
        end

        -- MODULE: TOGGLE
        function Mods:CreateToggle(c)
            local active = false
            local f = Instance.new("Frame", page)
            f.Size = UDim2.new(1, -10, 0, 70)
            f.BackgroundColor3 = Color3.fromRGB(25,25,25)
            Instance.new("UICorner", f).CornerRadius = UDim.new(0,12)

            local l = Instance.new("TextLabel", f)
            l.Text = "  " .. c.Name
            l.Size = UDim2.new(0.5, 0, 1, 0)
            l.TextColor3 = Color3.new(1,1,1)
            l.Font = Enum.Font.GothamBold
            l.TextSize = 18
            l.TextXAlignment = "Left"
            l.BackgroundTransparency = 1

            local b = Instance.new("TextButton", f)
            b.Size = UDim2.new(0, 100, 0, 40)
            b.Position = UDim2.new(1, -110, 0.5, -20)
            b.BackgroundColor3 = Color3.fromRGB(50,50,50)
            b.Text = "OFF"
            b.TextColor3 = Color3.new(1,1,1)
            b.Font = Enum.Font.GothamBold
            b.TextSize = 14
            Instance.new("UICorner", b).CornerRadius = UDim.new(0,8)

            b.MouseButton1Click:Connect(function()
                active = not active
                b.Text = active and "ON" or "OFF"
                b.BackgroundColor3 = active and Color3.fromRGB(140,90,255) or Color3.fromRGB(50,50,50)
                task.spawn(function()
                    while active do c.Callback() task.wait(c.Delay or 0.1) end
                end)
            end)
        end

        -- MODULE: DROPDOWN
        function Mods:CreateDropdown(c)
            local selected = nil
            local f = Instance.new("Frame", page)
            f.Size = UDim2.new(1, -10, 0, 70)
            f.BackgroundColor3 = Color3.fromRGB(25,25,25)
            f.ClipsDescendants = true
            Instance.new("UICorner", f).CornerRadius = UDim.new(0,12)
            
            local dropBtn = Instance.new("TextButton", f)
            dropBtn.Size = UDim2.new(1, -120, 0, 40)
            dropBtn.Position = UDim2.new(0, 10, 0, 15)
            dropBtn.BackgroundColor3 = Color3.fromRGB(40,40,40)
            dropBtn.Text = c.Name .. ": Select..."
            dropBtn.TextColor3 = Color3.new(1,1,1)
            dropBtn.Font = Enum.Font.GothamBold
            dropBtn.TextSize = 16 -- LARGER TEXT
            Instance.new("UICorner", dropBtn)

            local runBtn = Instance.new("TextButton", f)
            runBtn.Size = UDim2.new(0, 90, 0, 40)
            runBtn.Position = UDim2.new(1, -100, 0, 15)
            runBtn.BackgroundColor3 = Color3.fromRGB(140,90,255)
            runBtn.Text = c.RunText or "Run"
            runBtn.TextColor3 = Color3.new(1,1,1)
            runBtn.Font = Enum.Font.GothamBold
            runBtn.TextSize = 14
            Instance.new("UICorner", runBtn)

            local listFrame = Instance.new("ScrollingFrame", f)
            listFrame.Size = UDim2.new(1, -20, 0, 100)
            listFrame.Position = UDim2.new(0, 10, 0, 65)
            listFrame.BackgroundTransparency = 1
            listFrame.ScrollBarThickness = 2
            Instance.new("UIListLayout", listFrame)

            local open = false
            dropBtn.MouseButton1Click:Connect(function()
                open = not open
                TweenService:Create(f, TweenInfo.new(0.3), {Size = open and UDim2.new(1, -10, 0, 180) or UDim2.new(1, -10, 0, 70)}):Play()
            end)

            for _, item in pairs(c.Options) do
                local b = Instance.new("TextButton", listFrame)
                b.Size = UDim2.new(1, 0, 0, 35) -- TALLER BUTTONS
                b.BackgroundTransparency = 1
                b.Text = item
                b.TextColor3 = Color3.fromRGB(200,200,200)
                b.Font = Enum.Font.GothamBold
                b.TextSize = 16 -- LARGER OPTION TEXT
                b.MouseButton1Click:Connect(function()
                    selected = item
                    dropBtn.Text = c.Name .. ": " .. item
                    open = false
                    TweenService:Create(f, TweenInfo.new(0.3), {Size = UDim2.new(1, -10, 0, 70)}):Play()
                end)
            end

            runBtn.MouseButton1Click:Connect(function()
                if selected then c.Callback(selected) end
            end)
        end
        return Mods
    end
    return Tabs
end

return Library
