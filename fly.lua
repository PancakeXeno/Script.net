--============================================================
-- FLY GUI - SPACE EDITION
-- GUI + OPEN BUTTON TERPISAH
-- CLOSE GUI TIDAK MEMATIKAN FLY
--============================================================

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

local Player = Players.LocalPlayer

--============================================================
-- SETTINGS
--============================================================

local Speed = 1
local MAX_SPEED = 100

local Flying = false
local UpHeld = false
local DownHeld = false

local BodyVelocity
local BodyGyro
local FlyConnection

local IsClosed = false

--============================================================
-- GUI
--============================================================

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "FlyGui"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.DisplayOrder = 999999
ScreenGui.Parent = Player:WaitForChild("PlayerGui")

--============================================================
-- MAIN GUI
--============================================================

local Main = Instance.new("Frame")
Main.Name = "Main"
Main.Size = UDim2.fromOffset(300,100)
Main.Position = UDim2.new(0.5,-150,0.72,0)
Main.BackgroundTransparency = 1
Main.BorderSizePixel = 0
Main.Parent = ScreenGui

-- Posisi GUI BESAR disimpan sendiri
local SavedGUIPosition = Main.Position

--============================================================
-- CONTENT
--============================================================

local Content = Instance.new("Frame")
Content.Name = "Content"
Content.Size = UDim2.fromOffset(300,100)
Content.Position = UDim2.fromOffset(0,0)
Content.BackgroundTransparency = 1
Content.BorderSizePixel = 0
Content.ClipsDescendants = true
Content.Parent = Main

--============================================================
-- BOX CREATOR
--============================================================

local function CreateBox(Name,Text,X,Y,W,H,Color)

	local Button = Instance.new("TextButton")

	Button.Name = Name
	Button.Position = UDim2.fromOffset(X,Y)
	Button.Size = UDim2.fromOffset(W,H)

	Button.BackgroundColor3 = Color
	Button.BackgroundTransparency = 0

	Button.BorderSizePixel = 1
	Button.BorderColor3 = Color3.fromRGB(50,50,50)

	Button.Text = Text
	Button.TextColor3 = Color3.fromRGB(20,20,20)

	Button.Font = Enum.Font.SourceSans
	Button.TextSize = 20

	Button.AutoButtonColor = true

	Button.Parent = Content

	return Button
end

--============================================================
-- COLORS
--============================================================

local Green = Color3.fromRGB(70,255,120)
local Blue = Color3.fromRGB(120,150,255)
local Purple = Color3.fromRGB(220,60,230)
local LightGreen = Color3.fromRGB(220,255,70)
local Cyan = Color3.fromRGB(70,230,230)
local Orange = Color3.fromRGB(255,90,30)
local Yellow = Color3.fromRGB(255,240,60)

--============================================================
-- TOP ROW
--============================================================

local UP = CreateBox(
	"UP",
	"UP",
	0,
	0,
	75,
	50,
	Green
)

local PLUS = CreateBox(
	"PLUS",
	"+",
	75,
	0,
	75,
	50,
	Blue
)

local MADE = CreateBox(
	"MADE",
	"",
	150,
	0,
	150,
	50,
	Purple
)

--============================================================
-- MADE BY
--============================================================

local MadeText = Instance.new("TextLabel")

MadeText.Name = "MadeByText"
MadeText.Size = UDim2.fromScale(1,1)
MadeText.Position = UDim2.fromScale(0,0)

MadeText.BackgroundTransparency = 1
MadeText.BorderSizePixel = 0

MadeText.Text = "made by rip_arfa0102"
MadeText.TextColor3 = Color3.fromRGB(255,255,255)

MadeText.Font = Enum.Font.SourceSansBold
MadeText.TextSize = 17

MadeText.TextXAlignment = Enum.TextXAlignment.Center
MadeText.TextYAlignment = Enum.TextYAlignment.Center

MadeText.Parent = MADE

--============================================================
-- BOTTOM ROW
--============================================================

local DOWN = CreateBox(
	"DOWN",
	"DOWN",
	0,
	50,
	75,
	50,
	LightGreen
)

local MINUS = CreateBox(
	"MINUS",
	"-",
	75,
	50,
	75,
	50,
	Cyan
)

local NUMBER = CreateBox(
	"NUMBER",
	"1",
	150,
	50,
	75,
	50,
	Orange
)

local FLY = CreateBox(
	"FLY",
	"fly",
	225,
	50,
	75,
	50,
	Yellow
)

--============================================================
-- CLOSE BUTTON
--============================================================

local CloseButton = Instance.new("TextButton")

CloseButton.Name = "CloseButton"

CloseButton.Size = UDim2.fromOffset(32,32)
CloseButton.Position = UDim2.fromOffset(264,-37)

CloseButton.BackgroundColor3 = Color3.fromRGB(8,10,40)

CloseButton.BorderSizePixel = 1
CloseButton.BorderColor3 = Color3.fromRGB(150,80,230)

CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255,255,255)

CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextSize = 18

CloseButton.AutoButtonColor = false
CloseButton.ZIndex = 50

CloseButton.Parent = Main

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0,8)
CloseCorner.Parent = CloseButton

local CloseGradient = Instance.new("UIGradient")

CloseGradient.Rotation = 35

CloseGradient.Color = ColorSequence.new({

	ColorSequenceKeypoint.new(
		0,
		Color3.fromRGB(5,8,30)
	),

	ColorSequenceKeypoint.new(
		0.5,
		Color3.fromRGB(80,20,130)
	),

	ColorSequenceKeypoint.new(
		1,
		Color3.fromRGB(10,50,100)
	)

})

CloseGradient.Parent = CloseButton

--============================================================
-- OPEN BUTTON
--============================================================

local OpenButton = Instance.new("TextButton")

OpenButton.Name = "SpaceOpenButton"

OpenButton.Size = UDim2.fromOffset(58,58)

-- Posisi tombol kecil SENDIRI
OpenButton.Position = UDim2.new(
	SavedGUIPosition.X.Scale,
	SavedGUIPosition.X.Offset,
	SavedGUIPosition.Y.Scale,
	SavedGUIPosition.Y.Offset
)

OpenButton.BackgroundColor3 =
	Color3.fromRGB(8,10,40)

OpenButton.BorderSizePixel = 0

OpenButton.Text = ""
OpenButton.AutoButtonColor = false

OpenButton.Visible = false

OpenButton.ZIndex = 100

OpenButton.Parent = ScreenGui

--============================================================
-- OPEN BUTTON CORNER
--============================================================

local OpenCorner = Instance.new("UICorner")

OpenCorner.CornerRadius =
	UDim.new(0,18)

OpenCorner.Parent = OpenButton

--============================================================
-- OPEN BUTTON STROKE
--============================================================

local OpenStroke = Instance.new("UIStroke")

OpenStroke.Thickness = 2
OpenStroke.Color =
	Color3.fromRGB(160,100,255)

OpenStroke.Parent = OpenButton

--============================================================
-- SPACE GRADIENT
--============================================================

local OpenGradient = Instance.new("UIGradient")

OpenGradient.Rotation = 35

OpenGradient.Color = ColorSequence.new({

	ColorSequenceKeypoint.new(
		0,
		Color3.fromRGB(5,10,45)
	),

	ColorSequenceKeypoint.new(
		0.3,
		Color3.fromRGB(35,15,85)
	),

	ColorSequenceKeypoint.new(
		0.65,
		Color3.fromRGB(90,20,140)
	),

	ColorSequenceKeypoint.new(
		1,
		Color3.fromRGB(10,55,105)
	)

})

OpenGradient.Parent = OpenButton

--============================================================
-- OPEN TEXT
--============================================================

local OpenText = Instance.new("TextLabel")

OpenText.Size = UDim2.fromScale(1,1)

OpenText.BackgroundTransparency = 1

OpenText.Text = "FLY"

OpenText.TextColor3 =
	Color3.fromRGB(255,255,255)

OpenText.Font = Enum.Font.GothamBold
OpenText.TextSize = 16

OpenText.ZIndex = 110

OpenText.Parent = OpenButton

--============================================================
-- STARS
--============================================================

local Stars = Instance.new("Frame")

Stars.Size = UDim2.fromScale(1,1)

Stars.BackgroundTransparency = 1
Stars.BorderSizePixel = 0

Stars.ClipsDescendants = true
Stars.ZIndex = 105

Stars.Parent = OpenButton

for i = 1,18 do

	local Star = Instance.new("Frame")

	local Size = math.random(1,3)

	Star.Size =
		UDim2.fromOffset(Size,Size)

	Star.Position = UDim2.new(
		math.random(),
		0,
		math.random(),
		0
	)

	Star.BackgroundColor3 =
		Color3.fromRGB(230,235,255)

	Star.BorderSizePixel = 0
	Star.ZIndex = 106

	Star.Parent = Stars

	local Corner = Instance.new("UICorner")

	Corner.CornerRadius =
		UDim.new(1,0)

	Corner.Parent = Star

	task.spawn(function()

		while Star.Parent do

			local Fade1 =
				TweenService:Create(
					Star,
					TweenInfo.new(
						math.random(4,10)/10,
						Enum.EasingStyle.Sine,
						Enum.EasingDirection.InOut
					),
					{
						BackgroundTransparency = 0.85
					}
				)

			local Fade2 =
				TweenService:Create(
					Star,
					TweenInfo.new(
						math.random(4,10)/10,
						Enum.EasingStyle.Sine,
						Enum.EasingDirection.InOut
					),
					{
						BackgroundTransparency = 0
					}
				)

			Fade1:Play()
			Fade1.Completed:Wait()

			if not Star.Parent then
				break
			end

			Fade2:Play()
			Fade2.Completed:Wait()

		end

	end)

end

--============================================================
-- ORBIT
--============================================================

local Orbit = Instance.new("Frame")

Orbit.AnchorPoint =
	Vector2.new(0.5,0.5)

Orbit.Position =
	UDim2.fromScale(0.5,0.5)

Orbit.Size =
	UDim2.fromScale(0.86,0.86)

Orbit.BackgroundTransparency = 1
Orbit.BorderSizePixel = 0

Orbit.ZIndex = 107

Orbit.Parent = OpenButton

local OrbitStroke = Instance.new("UIStroke")

OrbitStroke.Thickness = 1
OrbitStroke.Transparency = 0.25

OrbitStroke.Color =
	Color3.fromRGB(180,130,255)

OrbitStroke.Parent = Orbit

local OrbitCorner = Instance.new("UICorner")

OrbitCorner.CornerRadius =
	UDim.new(1,0)

OrbitCorner.Parent = Orbit

task.spawn(function()

	while Orbit.Parent do

		Orbit.Rotation += 1.2

		RunService.RenderStepped:Wait()

	end

end)

--============================================================
-- GLOW
--============================================================

local Glow = Instance.new("Frame")

Glow.AnchorPoint =
	Vector2.new(0.5,0.5)

Glow.Position =
	UDim2.fromScale(0.5,0.5)

Glow.Size =
	UDim2.fromScale(1.05,1.05)

Glow.BackgroundTransparency = 0.88

Glow.BackgroundColor3 =
	Color3.fromRGB(140,80,255)

Glow.BorderSizePixel = 0

Glow.ZIndex = 99

Glow.Parent = OpenButton

local GlowCorner = Instance.new("UICorner")

GlowCorner.CornerRadius =
	UDim.new(1,0)

GlowCorner.Parent = Glow

task.spawn(function()

	while Glow.Parent do

		local Grow =
			TweenService:Create(
				Glow,
				TweenInfo.new(
					1.2,
					Enum.EasingStyle.Sine,
					Enum.EasingDirection.InOut
				),
				{
					Size =
						UDim2.fromScale(1.18,1.18),

					BackgroundTransparency = 0.94
				}
			)

		local Shrink =
			TweenService:Create(
				Glow,
				TweenInfo.new(
					1.2,
					Enum.EasingStyle.Sine,
					Enum.EasingDirection.InOut
				),
				{
					Size =
						UDim2.fromScale(1.05,1.05),

					BackgroundTransparency = 0.88
				}
			)

		Grow:Play()
		Grow.Completed:Wait()

		if not Glow.Parent then
			break
		end

		Shrink:Play()
		Shrink.Completed:Wait()

	end

end)

--============================================================
-- GUI DRAG
--============================================================

local DraggingGUI = false
local GUIStart
local GUIDragStart

MADE.InputBegan:Connect(function(Input)

	if Input.UserInputType ==
		Enum.UserInputType.MouseButton1

		or

		Input.UserInputType ==
		Enum.UserInputType.Touch
	then

		DraggingGUI = true

		GUIDragStart =
			Input.Position

		GUIStart =
			Main.Position

	end

end)

MADE.InputEnded:Connect(function(Input)

	if Input.UserInputType ==
		Enum.UserInputType.MouseButton1

		or

		Input.UserInputType ==
		Enum.UserInputType.Touch
	then

		DraggingGUI = false

	end

end)

UIS.InputChanged:Connect(function(Input)

	if not DraggingGUI then
		return
	end

	if Input.UserInputType ==
		Enum.UserInputType.MouseMovement

		or

		Input.UserInputType ==
		Enum.UserInputType.Touch
	then

		local Delta =
			Input.Position -
			GUIDragStart

		Main.Position =
			UDim2.new(

				GUIStart.X.Scale,
				GUIStart.X.Offset +
					Delta.X,

				GUIStart.Y.Scale,
				GUIStart.Y.Offset +
					Delta.Y
			)

		SavedGUIPosition =
			Main.Position

	end

end)

--============================================================
-- OPEN BUTTON DRAG
--============================================================

local DraggingOpen = false
local OpenStart
local OpenDragStart
local OpenMoved = false

local DRAG_THRESHOLD = 8

OpenButton.InputBegan:Connect(function(Input)

	if Input.UserInputType ==
		Enum.UserInputType.MouseButton1

		or

		Input.UserInputType ==
		Enum.UserInputType.Touch
	then

		DraggingOpen = true
		OpenMoved = false

		OpenDragStart =
			Input.Position

		OpenStart =
			OpenButton.Position

	end

end)

UIS.InputChanged:Connect(function(Input)

	if not DraggingOpen then
		return
	end

	if Input.UserInputType ==
		Enum.UserInputType.MouseMovement

		or

		Input.UserInputType ==
		Enum.UserInputType.Touch
	then

		local Delta =
			Input.Position -
			OpenDragStart

		if Delta.Magnitude >
			DRAG_THRESHOLD
		then

			OpenMoved = true

		end

		OpenButton.Position =
			UDim2.new(

				OpenStart.X.Scale,
				OpenStart.X.Offset +
					Delta.X,

				OpenStart.Y.Scale,
				OpenStart.Y.Offset +
					Delta.Y
			)

	end

end)

OpenButton.InputEnded:Connect(function(Input)

	if Input.UserInputType ==
		Enum.UserInputType.MouseButton1

		or

		Input.UserInputType ==
		Enum.UserInputType.Touch
	then

		DraggingOpen = false

	end

end)

--============================================================
-- SPEED
--============================================================

local function UpdateSpeed()

	NUMBER.Text =
		tostring(Speed)

end

PLUS.MouseButton1Click:Connect(function()

	if Speed < MAX_SPEED then

		Speed += 1

		UpdateSpeed()

	end

end)

MINUS.MouseButton1Click:Connect(function()

	if Speed > 1 then

		Speed -= 1

		UpdateSpeed()

	end

end)

--============================================================
-- UP / DOWN
--============================================================

UP.MouseButton1Down:Connect(function()

	UpHeld = true

end)

UP.MouseButton1Up:Connect(function()

	UpHeld = false

end)

UP.MouseLeave:Connect(function()

	UpHeld = false

end)

DOWN.MouseButton1Down:Connect(function()

	DownHeld = true

end)

DOWN.MouseButton1Up:Connect(function()

	DownHeld = false

end)

DOWN.MouseLeave:Connect(function()

	DownHeld = false

end)

--============================================================
-- STOP FLY
--============================================================

local function StopFly()

	Flying = false

	if FlyConnection then

		FlyConnection:Disconnect()
		FlyConnection = nil

	end

	if BodyVelocity then

		BodyVelocity:Destroy()
		BodyVelocity = nil

	end

	if BodyGyro then

		BodyGyro:Destroy()
		BodyGyro = nil

	end

	local Character =
		Player.Character

	if Character then

		local Humanoid =
			Character:FindFirstChildOfClass(
				"Humanoid"
			)

		if Humanoid then

			Humanoid.PlatformStand =
				false

		end

	end

	FLY.Text = "fly"

end

--============================================================
-- START FLY
--============================================================

local function StartFly()

	if Flying then
		return
	end

	local Character =
		Player.Character

	if not Character then
		return
	end

	local Humanoid =
		Character:FindFirstChildOfClass(
			"Humanoid"
		)

	local Root =
		Character:FindFirstChild(
			"HumanoidRootPart"
		)

	if not Humanoid or not Root then
		return
	end

	Flying = true

	FLY.Text = "STOP"

	Humanoid.PlatformStand =
		true

	BodyVelocity =
		Instance.new("BodyVelocity")

	BodyVelocity.MaxForce =
		Vector3.new(
			math.huge,
			math.huge,
			math.huge
		)

	BodyVelocity.Velocity =
		Vector3.zero

	BodyVelocity.Parent =
		Root

	BodyGyro =
		Instance.new("BodyGyro")

	BodyGyro.MaxTorque =
		Vector3.new(
			math.huge,
			math.huge,
			math.huge
		)

	BodyGyro.P = 10000
	BodyGyro.D = 500

	BodyGyro.Parent =
		Root

	FlyConnection =
		RunService.RenderStepped:Connect(
			function()

				if not Flying
					or not Root.Parent
				then

					StopFly()
					return

				end

				local Camera =
					workspace.CurrentCamera

				if not Camera then
					return
				end

				local Direction =
					Vector3.zero

				--================================================
				-- FORWARD / BACK
				--================================================

				if UIS:IsKeyDown(
					Enum.KeyCode.W
				) then

					Direction +=
						Camera.CFrame.LookVector

				end

				if UIS:IsKeyDown(
					Enum.KeyCode.S
				) then

					Direction -=
						Camera.CFrame.LookVector

				end

				--================================================
				-- LEFT / RIGHT
				--================================================

				if UIS:IsKeyDown(
					Enum.KeyCode.A
				) then

					Direction -=
						Camera.CFrame.RightVector

				end

				if UIS:IsKeyDown(
					Enum.KeyCode.D
				) then

					Direction +=
						Camera.CFrame.RightVector

				end

				--================================================
				-- UP
				--================================================

				if UIS:IsKeyDown(
					Enum.KeyCode.Space
				)
				or UpHeld
				then

					Direction +=
						Vector3.new(0,1,0)

				end

				--================================================
				-- DOWN
				--================================================

				if UIS:IsKeyDown(
					Enum.KeyCode.LeftControl
				)
				or DownHeld
				then

					Direction -=
						Vector3.new(0,1,0)

				end

				--================================================
				-- NORMALIZE
				--================================================

				if Direction.Magnitude > 0 then

					Direction =
						Direction.Unit

				end

				BodyVelocity.Velocity =
					Direction *
					(Speed * 25)

				BodyGyro.CFrame =
					CFrame.new(
						Root.Position,

						Root.Position +
							Camera.CFrame.LookVector
					)

			end
		)

end

--============================================================
-- FLY BUTTON
-- HANYA INI YANG MENGUBAH STATUS FLY
--============================================================

FLY.MouseButton1Click:Connect(function()

	if Flying then

		StopFly()

	else

		StartFly()

	end

end)

--============================================================
-- CLOSE GUI
--============================================================

local function CloseGUI()

	if IsClosed then
		return
	end

	IsClosed = true

	--========================================================
	-- JANGAN StopFly() DI SINI!
	--
	-- Kalau sedang terbang:
	-- GUI ditutup = TETAP TERBANG
	--
	-- Kalau tidak terbang:
	-- GUI ditutup = tetap tidak terbang
	--========================================================

	SavedGUIPosition =
		Main.Position

	--========================================================
	-- FADE TEXT
	--========================================================

	for _,Object in
		Content:GetDescendants()
	do

		if Object:IsA("TextButton")
			or Object:IsA("TextLabel")
		then

			TweenService:Create(
				Object,

				TweenInfo.new(
					0.15,
					Enum.EasingStyle.Quad,
					Enum.EasingDirection.Out
				),

				{
					TextTransparency = 1
				}

			):Play()

		end

	end

	--========================================================
	-- FADE X
	--========================================================

	TweenService:Create(

		CloseButton,

		TweenInfo.new(
			0.18,
			Enum.EasingStyle.Quad,
			Enum.EasingDirection.Out
		),

		{
			BackgroundTransparency = 1,
			TextTransparency = 1
		}

	):Play()

	--========================================================
	-- SHRINK GUI
	--========================================================

	local Shrink =
		TweenService:Create(

			Main,

			TweenInfo.new(
				0.5,
				Enum.EasingStyle.Back,
				Enum.EasingDirection.In
			),

			{
				Size =
					UDim2.fromOffset(5,5)
			}

		)

	Shrink:Play()

	Shrink.Completed:Wait()

	Main.Visible = false
	Content.Visible = false
	CloseButton.Visible = false

	--========================================================
	-- OPEN BUTTON
	-- TETAP DI POSISI TERAKHIRNYA
	--========================================================

	OpenButton.Visible = true

	OpenButton.Size =
		UDim2.fromOffset(2,2)

	OpenButton.BackgroundTransparency = 1

	OpenText.TextTransparency = 1

	OpenStroke.Transparency = 1

	Glow.BackgroundTransparency = 1

	--========================================================
	-- OPEN BUTTON ANIMATION
	--========================================================

	TweenService:Create(

		OpenButton,

		TweenInfo.new(
			0.7,
			Enum.EasingStyle.Elastic,
			Enum.EasingDirection.Out
		),

		{
			Size =
				UDim2.fromOffset(58,58),

			BackgroundTransparency = 0
		}

	):Play()

	TweenService:Create(

		OpenText,

		TweenInfo.new(0.3),

		{
			TextTransparency = 0
		}

	):Play()

	TweenService:Create(

		OpenStroke,

		TweenInfo.new(0.3),

		{
			Transparency = 0
		}

	):Play()

	TweenService:Create(

		Glow,

		TweenInfo.new(0.4),

		{
			BackgroundTransparency = 0.88
		}

	):Play()

end

--============================================================
-- OPEN GUI
--============================================================

local function OpenGUI()

	if not IsClosed then
		return
	end

	IsClosed = false

	--========================================================
	-- HIDE OPEN BUTTON
	--========================================================

	local HideButton =
		TweenService:Create(

			OpenButton,

			TweenInfo.new(
				0.25,
				Enum.EasingStyle.Back,
				Enum.EasingDirection.In
			),

			{
				Size =
					UDim2.fromOffset(2,2),

				BackgroundTransparency = 1
			}

		)

	HideButton:Play()

	HideButton.Completed:Wait()

	OpenButton.Visible = false

	--========================================================
	-- GUI BALIK KE POSISI GUI SENDIRI
	-- BUKAN KE POSISI OPEN BUTTON
	--========================================================

	Main.Position =
		SavedGUIPosition

	Main.Visible = true
	Content.Visible = true
	CloseButton.Visible = true

	Main.Size =
		UDim2.fromOffset(5,5)

	Content.Size =
		UDim2.fromOffset(5,5)

	CloseButton.BackgroundTransparency = 1
	CloseButton.TextTransparency = 1

	--========================================================
	-- RESET TEXT
	--========================================================

	for _,Object in
		Content:GetDescendants()
	do

		if Object:IsA("TextButton")
			or Object:IsA("TextLabel")
		then

			Object.TextTransparency = 1

		end

	end

	--========================================================
	-- MAIN ANIMATION
	--========================================================

	TweenService:Create(

		Main,

		TweenInfo.new(
			0.65,
			Enum.EasingStyle.Elastic,
			Enum.EasingDirection.Out
		),

		{
			Size =
				UDim2.fromOffset(300,100)
		}

	):Play()

	TweenService:Create(

		Content,

		TweenInfo.new(
			0.55,
			Enum.EasingStyle.Back,
			Enum.EasingDirection.Out
		),

		{
			Size =
				UDim2.fromOffset(300,100)
		}

	):Play()

	--========================================================
	-- TEXT ANIMATION
	--========================================================

	task.delay(
		0.18,

		function()

			for _,Object in
				Content:GetDescendants()
			do

				if Object:IsA("TextButton")
					or Object:IsA("TextLabel")
				then

					TweenService:Create(

						Object,

						TweenInfo.new(
							0.35,
							Enum.EasingStyle.Quad,
							Enum.EasingDirection.Out
						),

						{
							TextTransparency = 0
						}

					):Play()

				end

			end

		end
	)

	--========================================================
	-- X ANIMATION
	--========================================================

	task.delay(
		0.25,

		function()

			TweenService:Create(

				CloseButton,

				TweenInfo.new(
					0.4,
					Enum.EasingStyle.Back,
					Enum.EasingDirection.Out
				),

				{
					BackgroundTransparency = 0,
					TextTransparency = 0
				}

			):Play()

		end
	)

end

--============================================================
-- X CLICK
--============================================================

CloseButton.MouseButton1Click:Connect(function()

	CloseGUI()

end)

--============================================================
-- OPEN BUTTON CLICK
--============================================================

OpenButton.Activated:Connect(function()

	-- Kalau tadi tombol digeser,
	-- jangan dianggap sebagai klik buka.
	if OpenMoved then

		OpenMoved = false
		return

	end

	if IsClosed then

		OpenGUI()

	end

end)

--============================================================
-- INITIAL
--============================================================

UpdateSpeed()

Main.Visible = true
Content.Visible = true
CloseButton.Visible = true

OpenButton.Visible = false