--==============================================================--
--                       AIMBOT V1                              --
--                                                              --
--==============================================================--
--==============================================================--

local Players =
	game:GetService("Players")

local RunService =
	game:GetService("RunService")

local UserInputService =
	game:GetService("UserInputService")

local TweenService =
	game:GetService("TweenService")

local LocalPlayer =
	Players.LocalPlayer

local PlayerGui =
	LocalPlayer:WaitForChild("PlayerGui")

--==============================================================--
-- SETTINGS
--==============================================================--

local Settings = {

	AimEnabled = false,

	ESPEnabled = true,

	FOV = 180,

	Smooth = 0.18,

	MaxDistance = 500,

	RequireVisible = true,

	ESPColor =
		Color3.fromRGB(
			75,
			160,
			255
		),

	TargetColor =
		Color3.fromRGB(
			70,
			255,
			145
		)
}

--==============================================================--
-- COLORS
--==============================================================--

local Colors = {

	Background =
		Color3.fromRGB(
			10,
			12,
			18
		),

	Panel =
		Color3.fromRGB(
			17,
			20,
			29
		),

	Panel2 =
		Color3.fromRGB(
			22,
			27,
			39
		),

	Header =
		Color3.fromRGB(
			20,
			27,
			42
		),

	Blue =
		Color3.fromRGB(
			70,
			155,
			255
		),

	Blue2 =
		Color3.fromRGB(
			45,
			95,
			180
		),

	Green =
		Color3.fromRGB(
			50,
			200,
			115
		),

	Red =
		Color3.fromRGB(
			220,
			65,
			75
		),

	Text =
		Color3.fromRGB(
			245,
			248,
			255
		),

	SubText =
		Color3.fromRGB(
			145,
			153,
			170
		),

	Bar =
		Color3.fromRGB(
			35,
			41,
			55
		),

	Stroke =
		Color3.fromRGB(
			65,
			80,
			105
		)
}

--==============================================================--
-- VARIABLES
--==============================================================--

local CurrentTarget = nil

local ESPObjects = {}

local PanelOpen = false

local PanelMinimized = false

local DraggingLogo = false

local DraggingPanel = false

--==============================================================--
-- GUI
--==============================================================--

local GUI =
	Instance.new("ScreenGui")

GUI.Name =
	"AimbotV1"

GUI.ResetOnSpawn = false

GUI.IgnoreGuiInset = true

GUI.ZIndexBehavior =
	Enum.ZIndexBehavior.Sibling

GUI.Parent =
	PlayerGui

--==============================================================--
-- FOV CIRCLE
--==============================================================--

local FOV =
	Instance.new("Frame")

FOV.Name =
	"FOVCircle"

FOV.AnchorPoint =
	Vector2.new(
		0.5,
		0.5
	)

FOV.Position =
	UDim2.fromScale(
		0.5,
		0.5
	)

FOV.Size =
	UDim2.fromOffset(
		Settings.FOV * 2,
		Settings.FOV * 2
	)

FOV.BackgroundTransparency =
	1

FOV.BorderSizePixel =
	0

FOV.Parent =
	GUI

local FOVCorner =
	Instance.new("UICorner")

FOVCorner.CornerRadius =
	UDim.new(
		1,
		0
	)

FOVCorner.Parent =
	FOV

local FOVStroke =
	Instance.new("UIStroke")

FOVStroke.Color =
	Colors.Blue

FOVStroke.Thickness =
	2

FOVStroke.Transparency =
	0.15

FOVStroke.Parent =
	FOV

-- Glow

local FOVGlow =
	Instance.new("UIStroke")

FOVGlow.Color =
	Colors.Blue

FOVGlow.Thickness =
	6

FOVGlow.Transparency =
	0.9

FOVGlow.Parent =
	FOV

--==============================================================--
-- CROSSHAIR
--==============================================================--

local Crosshair =
	Instance.new("TextLabel")

Crosshair.Name =
	"Crosshair"

Crosshair.AnchorPoint =
	Vector2.new(
		0.5,
		0.5
	)

Crosshair.Position =
	UDim2.fromScale(
		0.5,
		0.5
	)

Crosshair.Size =
	UDim2.fromOffset(
		35,
		35
	)

Crosshair.BackgroundTransparency =
	1

Crosshair.Text =
	"+"

Crosshair.TextColor3 =
	Colors.Text

Crosshair.TextStrokeTransparency =
	0.4

Crosshair.TextSize =
	25

Crosshair.Font =
	Enum.Font.GothamBold

Crosshair.Parent =
	GUI

--==============================================================--
-- LOGO
--==============================================================--

local Logo =
	Instance.new("TextButton")

Logo.Name =
	"AimbotLogo"

Logo.AnchorPoint =
	Vector2.new(
		0.5,
		0
	)

Logo.Position =
	UDim2.new(
		0.5,
		0,
		0,
		55
	)

Logo.Size =
	UDim2.fromOffset(
		155,
		48
	)

Logo.BackgroundColor3 =
	Colors.Header

Logo.BorderSizePixel =
	0

Logo.Text =
	"AIMBOT  V1"

Logo.TextColor3 =
	Colors.Text

Logo.TextSize =
	15

Logo.Font =
	Enum.Font.GothamBold

Logo.AutoButtonColor =
	false

Logo.Parent =
	GUI

local LogoCorner =
	Instance.new("UICorner")

LogoCorner.CornerRadius =
	UDim.new(
		0,
		13
	)

LogoCorner.Parent =
	Logo

local LogoGradient =
	Instance.new("UIGradient")

LogoGradient.Color =
	ColorSequence.new({

		ColorSequenceKeypoint.new(
			0,
			Color3.fromRGB(
				27,
				53,
				94
			)
		),

		ColorSequenceKeypoint.new(
			0.5,
			Color3.fromRGB(
				50,
				105,
				190
			)
		),

		ColorSequenceKeypoint.new(
			1,
			Color3.fromRGB(
				24,
				45,
				80
			)
		)
	})

LogoGradient.Rotation =
	25

LogoGradient.Parent =
	Logo

local LogoStroke =
	Instance.new("UIStroke")

LogoStroke.Color =
	Colors.Blue

LogoStroke.Thickness =
	1.5

LogoStroke.Transparency =
	0.2

LogoStroke.Parent =
	Logo

--==============================================================--
-- LOGO STATUS DOT
--==============================================================--

local LogoDot =
	Instance.new("Frame")

LogoDot.Size =
	UDim2.fromOffset(
		8,
		8
	)

LogoDot.Position =
	UDim2.fromOffset(
		15,
		20
	)

LogoDot.BackgroundColor3 =
	Colors.Red

LogoDot.BorderSizePixel =
	0

LogoDot.Parent =
	Logo

local LogoDotCorner =
	Instance.new("UICorner")

LogoDotCorner.CornerRadius =
	UDim.new(
		1,
		0
	)

LogoDotCorner.Parent =
	LogoDot

--==============================================================--
-- MAIN PANEL
--==============================================================--

local Panel =
	Instance.new("Frame")

Panel.Name =
	"MainPanel"

Panel.AnchorPoint =
	Vector2.new(
		0.5,
		0.5
	)

Panel.Position =
	UDim2.fromScale(
		0.5,
		0.5
	)

Panel.Size =
	UDim2.fromOffset(
		320,
		390
	)

Panel.BackgroundColor3 =
	Colors.Panel

Panel.BackgroundTransparency =
	0.04

Panel.BorderSizePixel =
	0

Panel.Visible =
	false

Panel.ClipsDescendants =
	true

Panel.Parent =
	GUI

local PanelCorner =
	Instance.new("UICorner")

PanelCorner.CornerRadius =
	UDim.new(
		0,
		16
	)

PanelCorner.Parent =
	Panel

local PanelStroke =
	Instance.new("UIStroke")

PanelStroke.Color =
	Colors.Stroke

PanelStroke.Thickness =
	1.2

PanelStroke.Transparency =
	0.25

PanelStroke.Parent =
	Panel

--==============================================================--
-- PANEL GRADIENT
--==============================================================--

local PanelGradient =
	Instance.new("UIGradient")

PanelGradient.Color =
	ColorSequence.new({

		ColorSequenceKeypoint.new(
			0,
			Color3.fromRGB(
				20,
				27,
				40
			)
		),

		ColorSequenceKeypoint.new(
			0.45,
			Color3.fromRGB(
				17,
				20,
				29
			)
		),

		ColorSequenceKeypoint.new(
			1,
			Color3.fromRGB(
				12,
				15,
				22
			)
		)
	})

PanelGradient.Rotation =
	35

PanelGradient.Parent =
	Panel

--==============================================================--
-- HEADER
--==============================================================--

local Header =
	Instance.new("Frame")

Header.Size =
	UDim2.new(
		1,
		0,
		0,
		64
	)

Header.BackgroundColor3 =
	Colors.Header

Header.BorderSizePixel =
	0

Header.Parent =
	Panel

local HeaderCorner =
	Instance.new("UICorner")

HeaderCorner.CornerRadius =
	UDim.new(
		0,
		16
	)

HeaderCorner.Parent =
	Header

local HeaderGradient =
	Instance.new("UIGradient")

HeaderGradient.Color =
	ColorSequence.new({

		ColorSequenceKeypoint.new(
			0,
			Color3.fromRGB(
				25,
				43,
				70
			)
		),

		ColorSequenceKeypoint.new(
			0.5,
			Color3.fromRGB(
				20,
				28,
				43
			)
		),

		ColorSequenceKeypoint.new(
			1,
			Color3.fromRGB(
				16,
				19,
				28
			)
		)
	})

HeaderGradient.Rotation =
	15

HeaderGradient.Parent =
	Header

--==============================================================--
-- HEADER LINE
--==============================================================--

local HeaderLine =
	Instance.new("Frame")

HeaderLine.Size =
	UDim2.new(
		1,
		-30,
		0,
		1
	)

HeaderLine.Position =
	UDim2.new(
		0,
		15,
		1,
		-1
	)

HeaderLine.BackgroundColor3 =
	Colors.Blue

HeaderLine.BorderSizePixel =
	0

HeaderLine.Parent =
	Header

--==============================================================--
-- TITLE
--==============================================================--

local Title =
	Instance.new("TextLabel")

Title.Size =
	UDim2.new(
		1,
		-110,
		0,
		25
	)

Title.Position =
	UDim2.fromOffset(
		18,
		12
	)

Title.BackgroundTransparency =
	1

Title.Text =
	"AIMBOT  V1"

Title.TextColor3 =
	Colors.Text

Title.TextSize =
	17

Title.Font =
	Enum.Font.GothamBold

Title.TextXAlignment =
	Enum.TextXAlignment.Left

Title.Parent =
	Header

--==============================================================--
-- SUBTITLE
--==============================================================--

local Subtitle =
	Instance.new("TextLabel")

Subtitle.Size =
	UDim2.new(
		1,
		-110,
		0,
		18
	)

Subtitle.Position =
	UDim2.fromOffset(
		18,
		35
	)

Subtitle.BackgroundTransparency =
	1

Subtitle.Text =
	"NEON CONTROL PANEL"

Subtitle.TextColor3 =
	Colors.SubText

Subtitle.TextSize =
	9

Subtitle.Font =
	Enum.Font.GothamMedium

Subtitle.TextXAlignment =
	Enum.TextXAlignment.Left

Subtitle.Parent =
	Header

--==============================================================--
-- MINIMIZE
--==============================================================--

local Minimize =
	Instance.new("TextButton")

Minimize.Size =
	UDim2.fromOffset(
		32,
		32
	)

Minimize.Position =
	UDim2.new(
		1,
		-75,
		0,
		16
	)

Minimize.BackgroundColor3 =
	Colors.Panel2

Minimize.BorderSizePixel =
	0

Minimize.Text =
	"−"

Minimize.TextColor3 =
	Colors.Text

Minimize.TextSize =
	20

Minimize.Font =
	Enum.Font.GothamBold

Minimize.AutoButtonColor =
	false

Minimize.Parent =
	Header

local MinCorner =
	Instance.new("UICorner")

MinCorner.CornerRadius =
	UDim.new(
		0,
		8
	)

MinCorner.Parent =
	Minimize

--==============================================================--
-- CLOSE
--==============================================================--

local Close =
	Instance.new("TextButton")

Close.Size =
	UDim2.fromOffset(
		32,
		32
	)

Close.Position =
	UDim2.new(
		1,
		-38,
		0,
		16
	)

Close.BackgroundColor3 =
	Color3.fromRGB(
		110,
		35,
		45
	)

Close.BorderSizePixel =
	0

Close.Text =
	"×"

Close.TextColor3 =
	Colors.Text

Close.TextSize =
	20

Close.Font =
	Enum.Font.GothamBold

Close.AutoButtonColor =
	false

Close.Parent =
	Header

local CloseCorner =
	Instance.new("UICorner")

CloseCorner.CornerRadius =
	UDim.new(
		0,
		8
	)

CloseCorner.Parent =
	Close

--==============================================================--
-- STATUS
--==============================================================--

local Status =
	Instance.new("TextLabel")

Status.Size =
	UDim2.new(
		1,
		-30,
		0,
		30
	)

Status.Position =
	UDim2.fromOffset(
		15,
		75
	)

Status.BackgroundColor3 =
	Color3.fromRGB(
		13,
		17,
		25
	)

Status.BorderSizePixel =
	0

Status.Text =
	"  ●  TARGET : NONE"

Status.TextColor3 =
	Colors.SubText

Status.TextSize =
	11

Status.Font =
	Enum.Font.GothamMedium

Status.TextXAlignment =
	Enum.TextXAlignment.Left

Status.Parent =
	Panel

local StatusCorner =
	Instance.new("UICorner")

StatusCorner.CornerRadius =
	UDim.new(
		0,
		8
	)

StatusCorner.Parent =
	Status

local StatusStroke =
	Instance.new("UIStroke")

StatusStroke.Color =
	Colors.Stroke

StatusStroke.Transparency =
	0.45

StatusStroke.Parent =
	Status

--==============================================================--
-- BUTTON CREATOR
--==============================================================--

local function CreateButton(
	Text,
	Y
)

	local Button =
		Instance.new("TextButton")

	Button.Size =
		UDim2.new(
			1,
			-30,
			0,
			42
		)

	Button.Position =
		UDim2.fromOffset(
			15,
			Y
		)

	Button.BackgroundColor3 =
		Colors.Panel2

	Button.BorderSizePixel =
		0

	Button.Text =
		Text

	Button.TextColor3 =
		Colors.Text

	Button.TextSize =
		12

	Button.Font =
		Enum.Font.GothamBold

	Button.AutoButtonColor =
		false

	Button.Parent =
		Panel

	local Corner =
		Instance.new("UICorner")

	Corner.CornerRadius =
		UDim.new(
			0,
			9
		)

	Corner.Parent =
		Button

	local Stroke =
		Instance.new("UIStroke")

	Stroke.Color =
		Colors.Stroke

	Stroke.Transparency =
		0.35

	Stroke.Parent =
		Button

	-- Hover

	Button.MouseEnter:Connect(
		function()

			TweenService:Create(
				Button,
				TweenInfo.new(
					0.12
				),
				{
					BackgroundColor3 =
						Color3.fromRGB(
							35,
							47,
							67
						)
				}
			):Play()

		end
	)

	Button.MouseLeave:Connect(
		function()

			TweenService:Create(
				Button,
				TweenInfo.new(
					0.12
				),
				{
					BackgroundColor3 =
						Colors.Panel2
				}
			):Play()

		end
	)

	return Button
end

--==============================================================--
-- AIM BUTTON
--==============================================================--

local AimButton =
	CreateButton(
		"AIM  :  OFF",
		115
	)

--==============================================================--
-- ESP BUTTON
--==============================================================--

local ESPButton =
	CreateButton(
		"ESP  :  ON",
		165
	)

--==============================================================--
-- SLIDER CREATOR
--==============================================================--

local function CreateSlider(
	Name,
	Y,
	MinValue,
	MaxValue,
	DefaultValue,
	Decimals
)

	local Container =
		Instance.new("Frame")

	Container.Size =
		UDim2.new(
			1,
			-30,
			0,
			58
		)

	Container.Position =
		UDim2.fromOffset(
			15,
			Y
		)

	Container.BackgroundTransparency =
		1

	Container.Parent =
		Panel

	-- Label

	local Label =
		Instance.new("TextLabel")

	Label.Size =
		UDim2.new(
			1,
			0,
			0,
			20
		)

	Label.BackgroundTransparency =
		1

	Label.TextColor3 =
		Colors.Text

	Label.TextSize =
		11

	Label.Font =
		Enum.Font.GothamBold

	Label.TextXAlignment =
		Enum.TextXAlignment.Left

	Label.Parent =
		Container

	-- Bar

	local Bar =
		Instance.new("Frame")

	Bar.Size =
		UDim2.new(
			1,
			0,
			0,
			7
		)

	Bar.Position =
		UDim2.fromOffset(
			0,
			34
		)

	Bar.BackgroundColor3 =
		Colors.Bar

	Bar.BorderSizePixel =
		0

	Bar.Parent =
		Container

	local BarCorner =
		Instance.new("UICorner")

	BarCorner.CornerRadius =
		UDim.new(
			1,
			0
		)

	BarCorner.Parent =
		Bar

	-- Fill

	local Fill =
		Instance.new("Frame")

	Fill.Size =
		UDim2.new(
			0,
			0,
			1,
			0
		)

	Fill.BackgroundColor3 =
		Colors.Blue

	Fill.BorderSizePixel =
		0

	Fill.Parent =
		Bar

	local FillCorner =
		Instance.new("UICorner")

	FillCorner.CornerRadius =
		UDim.new(
			1,
			0
		)

	FillCorner.Parent =
		Fill

	-- Knob

	local Knob =
		Instance.new("TextButton")

	Knob.Size =
		UDim2.fromOffset(
			17,
			17
		)

	Knob.AnchorPoint =
		Vector2.new(
			0.5,
			0.5
		)

	Knob.Position =
		UDim2.new(
			0,
			0,
			0.5,
			0
		)

	Knob.BackgroundColor3 =
		Colors.Text

	Knob.BorderSizePixel =
		0

	Knob.Text =
		""

	Knob.AutoButtonColor =
		false

	Knob.ZIndex =
		5

	Knob.Parent =
		Bar

	local KnobCorner =
		Instance.new("UICorner")

	KnobCorner.CornerRadius =
		UDim.new(
			1,
			0
		)

	KnobCorner.Parent =
		Knob

	-- Knob glow

	local KnobStroke =
		Instance.new("UIStroke")

	KnobStroke.Color =
		Colors.Blue

	KnobStroke.Thickness =
		2

	KnobStroke.Parent =
		Knob

	-- Value

	local CurrentValue =
		DefaultValue

	local Dragging =
		false

	local function Format(
		Value
	)

		if Decimals == 0 then

			return tostring(
				math.floor(
					Value + 0.5
				)
			)

		end

		return string.format(
			"%." ..
			Decimals ..
			"f",
			Value
		)

	end

	local function SetValue(
		Value
	)

		Value =
			math.clamp(
				Value,
				MinValue,
				MaxValue
			)

		CurrentValue =
			Value

		local Alpha =
			(
				Value -
				MinValue
			)
			/
			(
				MaxValue -
				MinValue
			)

		Fill.Size =
			UDim2.new(
				Alpha,
				0,
				1,
				0
			)

		Knob.Position =
			UDim2.new(
				Alpha,
				0,
				0.5,
				0
			)

		Label.Text =
			Name ..
			"    " ..
			Format(
				Value
			)

	end

	local function Update(
		Input
	)

		local MouseX =
			Input.Position.X

		local StartX =
			Bar.AbsolutePosition.X

		local Width =
			Bar.AbsoluteSize.X

		local Alpha =
			math.clamp(
				(
					MouseX -
					StartX
				)
				/
				Width,
				0,
				1
			)

		local Value =
			MinValue
			+
			(
				MaxValue -
				MinValue
			)
			*
			Alpha

		SetValue(
			Value
		)

	end

	Bar.InputBegan:Connect(
		function(Input)

			if
				Input.UserInputType ==
				Enum.UserInputType.MouseButton1
				or
				Input.UserInputType ==
				Enum.UserInputType.Touch
			then

				Dragging =
					true

				Update(
					Input
				)

			end

		end
	)

	Knob.InputBegan:Connect(
		function(Input)

			if
				Input.UserInputType ==
				Enum.UserInputType.MouseButton1
				or
				Input.UserInputType ==
				Enum.UserInputType.Touch
			then

				Dragging =
					true

			end

		end
	)

	UserInputService.InputChanged:Connect(
		function(Input)

			if not Dragging then
				return
			end

			if
				Input.UserInputType ==
				Enum.UserInputType.MouseMovement
				or
				Input.UserInputType ==
				Enum.UserInputType.Touch
			then

				Update(
					Input
				)

			end

		end
	)

	UserInputService.InputEnded:Connect(
		function(Input)

			if
				Input.UserInputType ==
				Enum.UserInputType.MouseButton1
				or
				Input.UserInputType ==
				Enum.UserInputType.Touch
			then

				Dragging =
					false

			end

		end
	)

	SetValue(
		DefaultValue
	)

	return {

		GetValue =
			function()

				return CurrentValue

			end,

		SetValue =
			SetValue,

		Container =
			Container
	}
end

--==============================================================--
-- FOV SLIDER
--==============================================================--

local FOVSlider =
	CreateSlider(
		"FOV",
		220,
		30,
		400,
		180,
		0
	)

--==============================================================--
-- SMOOTH SLIDER
--==============================================================--

local SmoothSlider =
	CreateSlider(
		"SMOOTH",
		285,
		0.01,
		1,
		0.18,
		2
	)

--==============================================================--
-- DRAG SYSTEM
--==============================================================--

local function MakeDraggable(
	Object,
	Handle
)

	local Dragging =
		false

	local DragStart

	local StartPosition

	Handle.InputBegan:Connect(
		function(Input)

			if
				Input.UserInputType ==
				Enum.UserInputType.MouseButton1
				or
				Input.UserInputType ==
				Enum.UserInputType.Touch
			then

				Dragging =
					true

				DragStart =
					Input.Position

				StartPosition =
					Object.Position

			end

		end
	)

	UserInputService.InputChanged:Connect(
		function(Input)

			if not Dragging then
				return
			end

			if
				Input.UserInputType ==
				Enum.UserInputType.MouseMovement
				or
				Input.UserInputType ==
				Enum.UserInputType.Touch
			then

				local Delta =
					Input.Position -
					DragStart

				Object.Position =
					UDim2.new(

						StartPosition.X.Scale,

						StartPosition.X.Offset
							+
							Delta.X,

						StartPosition.Y.Scale,

						StartPosition.Y.Offset
							+
							Delta.Y
					)

			end

		end
	)

	UserInputService.InputEnded:Connect(
		function(Input)

			if
				Input.UserInputType ==
				Enum.UserInputType.MouseButton1
				or
				Input.UserInputType ==
				Enum.UserInputType.Touch
			then

				Dragging =
					false

			end

		end
	)
end

MakeDraggable(
	Logo,
	Logo
)

MakeDraggable(
	Panel,
	Header
)

--==============================================================--
-- BUTTON UPDATE
--==============================================================--

local function UpdateButtons()

	if Settings.AimEnabled then

		AimButton.Text =
			"AIM  :  ON"

		AimButton.BackgroundColor3 =
			Color3.fromRGB(
				35,
				125,
				78
			)

		LogoDot.BackgroundColor3 =
			Colors.Green

	else

		AimButton.Text =
			"AIM  :  OFF"

		AimButton.BackgroundColor3 =
			Colors.Panel2

		LogoDot.BackgroundColor3 =
			Colors.Red

	end

	if Settings.ESPEnabled then

		ESPButton.Text =
			"ESP  :  ON"

		ESPButton.BackgroundColor3 =
			Color3.fromRGB(
				35,
				125,
				78
			)

	else

		ESPButton.Text =
			"ESP  :  OFF"

		ESPButton.BackgroundColor3 =
			Colors.Panel2

	end
end

--==============================================================--
-- OPEN PANEL
--==============================================================--

local function OpenPanel()

	if PanelOpen then
		return
	end

	PanelOpen =
		true

	Panel.Visible =
		true

	Panel.Size =
		UDim2.fromOffset(
			270,
			330
		)

	Panel.BackgroundTransparency =
		1

	TweenService:Create(

		Panel,

		TweenInfo.new(
			0.25,
			Enum.EasingStyle.Quart,
			Enum.EasingDirection.Out
		),

		{
			Size =
				UDim2.fromOffset(
					320,
					390
				),

			BackgroundTransparency =
				0
		}

	):Play()
end

--==============================================================--
-- CLOSE PANEL
--==============================================================--

local function ClosePanel()

	if not PanelOpen then
		return
	end

	PanelOpen =
		false

	local Tween =
		TweenService:Create(

			Panel,

			TweenInfo.new(
				0.18,
				Enum.EasingStyle.Quad,
				Enum.EasingDirection.In
			),

			{
				Size =
					UDim2.fromOffset(
						270,
						330
					),

				BackgroundTransparency =
					1
			}
		)

	Tween:Play()

	Tween.Completed:Connect(
		function()

			if not PanelOpen then

				Panel.Visible =
					false

			end

		end
	)
end

--==============================================================--
-- LOGO CLICK
--==============================================================--

Logo.MouseButton1Click:Connect(
	function()

		if PanelOpen then

			ClosePanel()

		else

			OpenPanel()

		end

	end
)

--==============================================================--
-- CLOSE CLICK
--==============================================================--

Close.MouseButton1Click:Connect(
	function()

		ClosePanel()

	end
)

--==============================================================--
-- MINIMIZE
--==============================================================--

Minimize.MouseButton1Click:Connect(
	function()

		PanelMinimized =
			not PanelMinimized

		if PanelMinimized then

			Minimize.Text =
				"+"

			Status.Visible =
				false

			AimButton.Visible =
				false

			ESPButton.Visible =
				false

			FOVSlider.Container.Visible =
				false

			SmoothSlider.Container.Visible =
				false

			TweenService:Create(

				Panel,

				TweenInfo.new(
					0.2,
					Enum.EasingStyle.Quart
				),

				{
					Size =
						UDim2.fromOffset(
							320,
							64
						)
				}

			):Play()

		else

			Minimize.Text =
				"−"

			TweenService:Create(

				Panel,

				TweenInfo.new(
					0.2,
					Enum.EasingStyle.Quart
				),

				{
					Size =
						UDim2.fromOffset(
							320,
							390
						)
				}

			):Play()

			Status.Visible =
				true

			AimButton.Visible =
				true

			ESPButton.Visible =
				true

			FOVSlider.Container.Visible =
				true

			SmoothSlider.Container.Visible =
				true

		end

	end
)

--==============================================================--
-- AIM TOGGLE
--==============================================================--

AimButton.MouseButton1Click:Connect(
	function()

		Settings.AimEnabled =
			not Settings.AimEnabled

		if not Settings.AimEnabled then

			CurrentTarget =
				nil

			Status.Text =
				"  ●  TARGET : NONE"

		end

		UpdateButtons()

	end
)

--==============================================================--
-- ESP TOGGLE
--==============================================================--

ESPButton.MouseButton1Click:Connect(
	function()

		Settings.ESPEnabled =
			not Settings.ESPEnabled

		UpdateButtons()

	end
)

--==============================================================--
-- CHARACTER DATA
--==============================================================--

local function GetCharacterData(
	Player
)

	if not Player then
		return nil
	end

	if Player ==
		LocalPlayer then

		return nil
	end

	local Character =
		Player.Character

	if not Character then
		return nil
	end

	local Humanoid =
		Character:FindFirstChildOfClass(
			"Humanoid"
		)

	local Head =
		Character:FindFirstChild(
			"Head"
		)

	local Root =
		Character:FindFirstChild(
			"HumanoidRootPart"
		)

	if
		not Humanoid
		or
		not Head
		or
		not Root
	then

		return nil

	end

	-- Player mati tidak dihitung

	if Humanoid.Health <= 0 then
		return nil
	end

	if Humanoid:GetState() ==
		Enum.HumanoidStateType.Dead
	then

		return nil

	end

	return {

		Character =
			Character,

		Humanoid =
			Humanoid,

		Head =
			Head,

		Root =
			Root
	}
end

--==============================================================--
-- VISIBILITY
--==============================================================--

local function IsVisible(
	Data
)

	if not Settings.RequireVisible then
		return true
	end

	local Camera =
		workspace.CurrentCamera

	if not Camera then
		return false
	end

	local Origin =
		Camera.CFrame.Position

	local Direction =
		Data.Head.Position -
		Origin

	local Params =
		RaycastParams.new()

	Params.FilterType =
		Enum.RaycastFilterType.Exclude

	Params.FilterDescendantsInstances =
		{
			LocalPlayer.Character
		}

	local Result =
		workspace:Raycast(
			Origin,
			Direction,
			Params
		)

	if not Result then
		return true
	end

	return Result.Instance:IsDescendantOf(
		Data.Character
	)
end

--==============================================================--
-- FIND TARGET
--==============================================================--

local function FindBestTarget()

	local Camera =
		workspace.CurrentCamera

	if not Camera then
		return nil
	end

	local Center =
		Vector2.new(
			Camera.ViewportSize.X / 2,
			Camera.ViewportSize.Y / 2
		)

	local BestTarget =
		nil

	local BestDistance =
		Settings.FOV

	for _, Player in ipairs(
		Players:GetPlayers()
	) do

		if Player ~= LocalPlayer then

			local Data =
				GetCharacterData(
					Player
				)

			if Data then

				local MyCharacter =
					LocalPlayer.Character

				local MyRoot =
					MyCharacter
					and
					MyCharacter:FindFirstChild(
						"HumanoidRootPart"
					)

				local Distance3D =
					0

				if MyRoot then

					Distance3D =
						(
							Data.Root.Position -
							MyRoot.Position
						).Magnitude

				end

				if Distance3D <=
					Settings.MaxDistance
				then

					local Point,
						Visible =
						Camera:WorldToViewportPoint(
							Data.Head.Position
						)

					if
						Visible
						and
						Point.Z > 0
					then

						local Screen =
							Vector2.new(
								Point.X,
								Point.Y
							)

						local Distance2D =
							(
								Screen -
								Center
							).Magnitude

						if
							Distance2D <=
							BestDistance
							and
							IsVisible(Data)
						then

							BestDistance =
								Distance2D

							BestTarget =
								Player

						end
					end
				end
			end
		end
	end

	return BestTarget
end

--==============================================================--
-- AIM
--==============================================================--

local function AimAtTarget(
	Player
)

	local Data =
		GetCharacterData(
			Player
		)

	if not Data then

		CurrentTarget =
			nil

		Status.Text =
			"  ●  TARGET : NONE"

		return

	end

	local Camera =
		workspace.CurrentCamera

	if not Camera then
		return
	end

	local TargetCFrame =
		CFrame.lookAt(
			Camera.CFrame.Position,
			Data.Head.Position
		)

	Camera.CFrame =
		Camera.CFrame:Lerp(
			TargetCFrame,
			Settings.Smooth
		)

	Status.Text =
		"  ●  TARGET :  "
		..
		Player.DisplayName

end

--==============================================================--
-- REMOVE ESP
--==============================================================--

local function RemoveESP(
	Player
)

	local Data =
		ESPObjects[Player]

	if not Data then
		return
	end

	if Data.Highlight then

		Data.Highlight:Destroy()

	end

	if Data.Billboard then

		Data.Billboard:Destroy()

	end

	ESPObjects[Player] =
		nil
end

--==============================================================--
-- CREATE ESP
--==============================================================--

local function CreateESP(
	Player
)

	local Data =
		GetCharacterData(
			Player
		)

	if not Data then

		RemoveESP(
			Player
		)

		return
	end

	RemoveESP(
		Player
	)

	local Highlight =
		Instance.new(
			"Highlight"
		)

	Highlight.Name =
		"AimbotESP"

	Highlight.Adornee =
		Data.Character

	Highlight.FillColor =
		Settings.ESPColor

	Highlight.OutlineColor =
		Colors.Text

	Highlight.FillTransparency =
		0.78

	Highlight.OutlineTransparency =
		0.15

	Highlight.DepthMode =
		Enum.HighlightDepthMode.AlwaysOnTop

	Highlight.Parent =
		Data.Character

	local Billboard =
		Instance.new(
			"BillboardGui"
		)

	Billboard.Name =
		"AimbotInfo"

	Billboard.Adornee =
		Data.Head

	Billboard.Size =
		UDim2.fromOffset(
			180,
			40
		)

	Billboard.StudsOffset =
		Vector3.new(
			0,
			2.7,
			0
		)

	Billboard.AlwaysOnTop =
		true

	Billboard.Parent =
		Data.Head

	local Text =
		Instance.new(
			"TextLabel"
		)

	Text.Size =
		UDim2.fromScale(
			1,
			1
		)

	Text.BackgroundTransparency =
		1

	Text.TextColor3 =
		Settings.ESPColor

	Text.TextStrokeTransparency =
		0.35

	Text.TextSize =
		12

	Text.Font =
		Enum.Font.GothamBold

	Text.Parent =
		Billboard

	ESPObjects[Player] =
		{
			Highlight =
				Highlight,

			Billboard =
				Billboard,

			Text =
				Text
		}
end

--==============================================================--
-- UPDATE ESP
--==============================================================--

local function UpdateESP()

	for _, Player in ipairs(
		Players:GetPlayers()
	) do

		if Player ~= LocalPlayer then

			local Data =
				GetCharacterData(
					Player
				)

			if not Data then

				RemoveESP(
					Player
				)

			elseif Settings.ESPEnabled then

				if not ESPObjects[Player] then

					CreateESP(
						Player
					)

				end

				local ESP =
					ESPObjects[Player]

				if ESP then

					local MyCharacter =
						LocalPlayer.Character

					local MyRoot =
						MyCharacter
						and
						MyCharacter:FindFirstChild(
							"HumanoidRootPart"
						)

					local Distance =
						0

					if MyRoot then

						Distance =
							math.floor(
								(
									Data.Root.Position -
									MyRoot.Position
								).Magnitude
							)

					end

					if Player ==
						CurrentTarget
					then

						ESP.Highlight.FillColor =
							Settings.TargetColor

						ESP.Text.TextColor3 =
							Settings.TargetColor

					else

						ESP.Highlight.FillColor =
							Settings.ESPColor

						ESP.Text.TextColor3 =
							Settings.ESPColor

					end

					ESP.Text.Text =
						Player.DisplayName
						..
						"\n"
						..
						Distance
						..
						" studs"

				end

			else

				RemoveESP(
					Player
				)

			end
		end
	end
end

--==============================================================--
-- PLAYER SETUP
--==============================================================--

local function SetupPlayer(
	Player
)

	if Player ==
		LocalPlayer
	then

		return

	end

	Player.CharacterAdded:Connect(
		function(
			Character
		)

			task.wait(
				0.2
			)

			local Humanoid =
				Character:FindFirstChildOfClass(
					"Humanoid"
				)

			if Humanoid then

				Humanoid.Died:Connect(
					function()

						RemoveESP(
							Player
						)

						if CurrentTarget ==
							Player
						then

							CurrentTarget =
								nil

							Status.Text =
								"  ●  TARGET : NONE"

						end
					end
				)

			end

			if Settings.ESPEnabled then

				task.wait(
					0.15
				)

				CreateESP(
					Player
				)

			end
		end
	)
end

for _, Player in ipairs(
	Players:GetPlayers()
) do

	SetupPlayer(
		Player
	)

end

Players.PlayerAdded:Connect(
	SetupPlayer
)

Players.PlayerRemoving:Connect(
	function(
		Player
	)

		RemoveESP(
			Player
		)

		if CurrentTarget ==
			Player
		then

			CurrentTarget =
				nil

		end
	end
)

--==============================================================--
-- GUI HOVER EFFECTS
--==============================================================--

Close.MouseEnter:Connect(
	function()

		TweenService:Create(
			Close,
			TweenInfo.new(
				0.12
			),
			{
				BackgroundColor3 =
					Color3.fromRGB(
						175,
						50,
						65
					)
			}
		):Play()

	end
)

Close.MouseLeave:Connect(
	function()

		TweenService:Create(
			Close,
			TweenInfo.new(
				0.12
			),
			{
				BackgroundColor3 =
					Color3.fromRGB(
						110,
						35,
						45
					)
			}
		):Play()

	end
)

Minimize.MouseEnter:Connect(
	function()

		TweenService:Create(
			Minimize,
			TweenInfo.new(
				0.12
			),
			{
				BackgroundColor3 =
					Color3.fromRGB(
						50,
						65,
						90
					)
			}
		):Play()

	end
)

Minimize.MouseLeave:Connect(
	function()

		TweenService:Create(
			Minimize,
			TweenInfo.new(
				0.12
			),
			{
				BackgroundColor3 =
					Colors.Panel2
			}
		):Play()

	end
)

Logo.MouseEnter:Connect(
	function()

		TweenService:Create(
			Logo,
			TweenInfo.new(
				0.15
			),
			{
				Size =
					UDim2.fromOffset(
						162,
						50
					)
			}
		):Play()

	end
)

Logo.MouseLeave:Connect(
	function()

		TweenService:Create(
			Logo,
			TweenInfo.new(
				0.15
			),
			{
				Size =
					UDim2.fromOffset(
						155,
						48
					)
			}
		):Play()

	end
)

--==============================================================--
-- RENDER LOOP
--==============================================================--

RunService:BindToRenderStep(
	"AimbotV1_Render",
	Enum.RenderPriority.Camera.Value + 1,
	function()

		-- Slider → setting

		Settings.FOV =
			FOVSlider.GetValue()

		Settings.Smooth =
			SmoothSlider.GetValue()

		-- Update FOV

		FOV.Size =
			UDim2.fromOffset(
				Settings.FOV * 2,
				Settings.FOV * 2
			)

		FOV.Visible = Settings.AimEnabled

		-- ESP

		UpdateESP()

		-- AIM

		if not Settings.AimEnabled then

			CurrentTarget =
				nil

			Status.Text =
				"  ●  TARGET : NONE"

			return

		end

		--======================================================--
		-- NO STICKY
		-- Target dicari ulang setiap frame.
		-- Player mati otomatis hilang.
		--======================================================--

		CurrentTarget =
			FindBestTarget()

		if CurrentTarget then

			AimAtTarget(
				CurrentTarget
			)

		else

			Status.Text =
				"  ●  TARGET : NONE"

		end
	end
)

--==============================================================--
-- INITIAL STATE
--==============================================================--

UpdateButtons()

Panel.Visible =
	false

FOV.Visible =
	Settings.AimEnabled

Crosshair.Visible =
	true

print(
	"[AIMBOT V1] Neon Glass Edition Loaded"
)