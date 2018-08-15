--require the widget library
local widget = require ("widget")
--set the maxLength of the display area to 42 chr
local maxLength = 42
--requrire composer library
local composer = require( "composer" )
--creaste a new scene object
local scene = composer.newScene()
--set fullh = the conten Height
local fullh = display.contentHeight
-- set fullw = the content Width
local fullw = display.contentWidth
-- set centerX
local centerX = display.contentCenterX
-- set centerY
local centerY = display.contentCenterY
-- List of all colors
local colors = require("classes.colors")
-- Loading our helper classes : button, calculator display and math helper
local newButton = require("classes.button").newButton
local newScreen = require("classes.screen").newScreen
local calculator = require("classes.calculator")
-- Store a local reference to the buttons. We need this to support key events
local buttons = {}
-- create category images
local categoryIcon
-- inconPostion for creating category ICon
local iconPostion = 80

--button locations
local buttonWidth = display.actualContentWidth / 5
local buttonHeight = math.floor(buttonWidth * 0.75)
display.setStatusBar(display.TranslucentStatusBar)

-- Functional button pressed flag
local isLastFunctional = true
-- display string
local displayStr = "0"
-- How many symbols will fit on screen
local maxLength = 42
--variable for display screen
local calcScreen

--activate multitouch
--system.activate( "multitouch" )
---------------------------------------------------------------------------------
-- the array of button data
local numberButtonsArray = {
    --{centerX, centerY + 20, 1},
    {label = "1", action = 1, key = "1", backgroundColor = colors.numpadBackground, labelColor = colors.numpadLabel},
    {label = "2", action = 2, key = "1", backgroundColor = colors.numpadBackground, labelColor = colors.numpadLabel},
    {label = "3", action = 3, key = "1", backgroundColor = colors.numpadBackground, labelColor = colors.numpadLabel},
    {label = "4", action = 4, key = "1", backgroundColor = colors.numpadBackground, labelColor = colors.numpadLabel},
    {label = "5", action = 5, key = "1", backgroundColor = colors.numpadBackground, labelColor = colors.numpadLabel},
    {label = "6", action = 6, key = "1", backgroundColor = colors.numpadBackground, labelColor = colors.numpadLabel},
    {label = "7", action = 7, key = "1", backgroundColor = colors.numpadBackground, labelColor = colors.numpadLabel},
    {label = "8", action = 8, key = "1", backgroundColor = colors.numpadBackground, labelColor = colors.numpadLabel},
    {label = "9", action = 9, key = "1", backgroundColor = colors.numpadBackground, labelColor = colors.numpadLabel},
    {label = "0", action = 0, key = "1", backgroundColor = colors.numpadBackground, labelColor = colors.numpadLabel},
    {label = "+/-", action = "sign", key = "sign", backgroundColor = colors.numpadBackground, labelColor = colors.numpadLabel},
    --{label = "-", action = 1, key = "1", backgroundColor = colors.numpadBackground, labelColor = colors.numpadLabel},
    {label = "backspace", action = 1, key = "1", backgroundColor = colors.numpadBackground, labelColor = colors.numpadLabel},
}

local categoryArray = {
    {fileLocation = "images/food.png"},
    {fileLocation = "images/stationary.png"},
    {fileLocation = "images/entertainment_Color.png"},
    {fileLocation = "images/entertainment_Color.png"},
    {fileLocation = "images/entertainment_Color.png"},
    {fileLocation = "images/entertainment_Color.png"},
    {fileLocation = "images/entertainment_Color.png"},
    {fileLocation = "images/entertainment_Color.png"},
    {fileLocation = "images/entertainment_Color.png"},
}

------------------------------------------------------------------------------
--------------Function Area---------------

local function categoryTouch (event)
    local phase = event.phase
    if (phase == "ended") then
        print ("category test complete")
    end
    return true
end

local function categoryScroll (event)
    local phase = event.phase
    if (phase == "began") then print ("Scroll view was touched")
    elseif (pahse == "moved") then print ("scroll view was moved")
    elseif (phase == "ended") then print ("scroll view was released")
    end

    if (event.limitReached) then
        if (event.direction == "up") then print ("reached bottom limit")
        elseif (event.direction == "down") then print ("reached top limit")
        elseif (event.direction == "left") then print ("reached right limit")
        elseif (event.direction == "right") then print ("reached left limit ")
        end

    end

end


local function buttonTouch (self,event)

  local action = self.target.action
    print (self.target.action)
    local phase = self.phase
    --print (phase)
if  ("ended" == phase) then
    print ("number button test has been preseed")
  if type(action) == "number" then
    print ("number action test passed")

    if displayStr and displayStr: len () < maxLength then
      displayStr = displayStr .. action
      --display the number
      calcScreen: setLabel (displayStr)
    end


  end
end

end

local function onSceneTouch( self, event )

    local swipeLength = math.abs(self.x- self.xStart)
	local phase = self.phase
    --print (phase, swipeLength)
    local t = self.target
   

    if "began" == phase then
        return true
      elseif "moved" == phase then
        --print("move finish")
      elseif "ended" == phase or "cancelled" == phase then
        --print (self.target.xStart,self.target.x)
        if self.xStart > self.x and swipeLength > 50 then
          print("swiped left")
		  composer.gotoScene( "scene2", "slideLeft", 500 )
        elseif self.xStart < self.x and swipeLength > 50 then
          print ("swiped right")
        end

    end

    --print("backgroundSet has been pressed") --for testing
    return true
    -- if self.phase == "began" then


    --Set focus on object using unique touch ID
    -- display.getCurrentStage():setFocus( self.target, self.id )   --Set focus on object using unique touch ID
    -- self.target.numTouches = self.target.numTouches + 1
    -- if self.target.numTouches >= 3 then
    -- print( "This object is being multi-touched." )
    -- composer.gotoScene( "scene2", "slideLeft", 500 )
    -- self.target.numTouches = self.target.numTouches - 3
    -- end

    -- elseif self.phase == "cancelled" or self.phase == "ended" then
    -- display.getCurrentStage():setFocus( self.target, nil )


    -- if self.target.numTouches <= 0 then
    -- display.getCurrentStage():setFocus( nil )
    -- end
end

local function buttonListener (event) --the main function that i use to set what will happend after i touch the button
    local id = event.target.id
    --print (numberButtonsArray[1].action)
    if("ended" == event.phase) then
        print ("actoin: " .. numberButtonsArray[1].action)

    end

end


function scene:create( event )
    local sceneGroup = self.view

    local backgroundSet = display.newImage ("images/whiteBackground.png")   --display new background use the local image
    backgroundSet.x = display.contentCenterX    --set x location
    backgroundSet.y = display.contentCenterY    --set y location
    backgroundSet.width = 480   -- set width
    backgroundSet.height = 854 -- set height
    backgroundSet: addEventListener("touch", onSceneTouch)
    backgroundSet.isHitTestable = true  -- i don't understand
    backgroundSet.alpha = 0.95  -- make the background 0.95 transperment
    backgroundSet.touch = onSceneTouch -- link backgroundSet to onSceneTouch function when the touch happened
    sceneGroup: insert (backgroundSet)-- insert backgroundSet into the secene group

    -- create the widget
    local categoryView = widget.newScrollView(
        {
            top = 215,
            left = 0,
            width = 100,
            height =310,
            horizontalScrollDisabled = true,
            --scrollHeight = 2000,
            listener = categoryScroll
        }
    )
    local ScrollBackground = display.newImage("images/whiteBackground.png")
    categoryView: insert (ScrollBackground)
    sceneGroup: insert (categoryView)
     --create income area
    local incomeView = widget.newScrollView(
        {
            top = 10,
            left = 0,
            width = centerX,
            height = 205,
            horizontalScrollDisabled = true,
            scrollHeight = 2000,
            listener = categoryScroll
        }
    )
    local incomeBackground = display.newImage("images/whiteBackground.png")
    incomeView: insert (incomeBackground)
    sceneGroup: insert (incomeView)
    -- create consumptino area
    local consumptionView = widget.newScrollView(
        {
            top = 10,
            left = centerX,
            width = centerX,
            height = 205,
            horizontalScrollDisabled = true,
            scrollHeight = 2000,
            listener = categoryScroll
        }
    )
    local incomeBackground = display.newImage("images/testImage.png")
    consumptionView: insert (incomeBackground)
    sceneGroup: insert (consumptionView)


    --Creating display screen
    calcScreen = newScreen(50, 220)
    --insert the calcScreen into the scenegroup
    sceneGroup:insert(calcScreen)

    --create the progress bar
    local compareBar = widget.newProgressView(
        {
            left = 50,
            top = -20,
            width = 220,
            isAnimated = true
        }
    )

    -- Set the progress to 50%
    compareBar:setProgress( 0.5 )
    -- insert compareBar into sceneGroup
    sceneGroup: insert (compareBar)
    -- set EnterButton
    local EnterButton = display.newImage("images/EnterButton.png")
    --x location
    EnterButton.x = centerX + 50
    --y location
    EnterButton.y = centerY + 255
    -- the button id
    EnterButton.id = "EnterButton"
    -- width of the button
    EnterButton.width = 220
    -- height of the button
    EnterButton.height = 60
    --link enterbutton with buttonlistener function
    EnterButton: addEventListener("touch", buttonListener)
    -- insert neterbutton into the scene group
    sceneGroup: insert(EnterButton)

    -- create all the category icon
    for i = 1 , #categoryArray do
        local cd = categoryArray[i]
        categoryIcon = display.newImage(cd.fileLocation, 50, centerY+ ((i-1)*iconPostion)- 200)
        categoryView: insert (categoryIcon)
        categoryIcon: addEventListener("touch",categoryTouch )
        categoryView: setScrollHeight(i * iconPostion)
    end

end


function scene:show( event )
  local sceneGroup = self.view
  local phase = event.phase

  if phase == "will" then
      -- set w = buttonWidth and h = buttonHeight
    local w, h = buttonWidth, buttonHeight
    -- set data = numberButtonArray when useing it in a for loop will replace the index by i
    local data = numberButtonsArray[1]
    -- when placing the button will use this
    local position  = 0
    --create the test number button
    local testButton = newButton(data.label, w, h, data.backgroundColor, data.labelColor)
    testButton: addEventListener("touch", buttonTouch)
    sceneGroup: insert(testButton)
    testButton.x = centerX- 25
    testButton.y = centerY+ 25
    testButton.action = data.action

  return testButton.action

    -- Called when the scene is still off screen and is about to move on screen
  elseif phase == "did" then

  end
end

function scene:hide( event )
  local sceneGroup = self.view
  local phase = event.phase

  if event.phase == "will" then

    -- Called when the scene is on screen and is about to move off screen
    --
    -- INSERT code here to pause the scene
    -- e.g. stop timers, stop animation, unload sounds, etc.)
  elseif phase == "did" then

    -- Called when the scene is now off screen
  end
end


function scene:destroy( event )
  local sceneGroup = self.view

end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

---------------------------------------------------------------------------------

return scene
