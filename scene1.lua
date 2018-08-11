----------------------------------------------------------------------------------
--
-- scenetemplate.lua
--
----------------------------------------------------------------------------------
local maxLength = 42
local composer = require( "composer" )
local scene = composer.newScene()
--activate multitouch
--system.activate( "multitouch" )
---------------------------------------------------------------------------------



local function buttonTouch (self,event)
  print ("number button test has been preseed")
  print (numberbutton)
  local action = self.actoin
  if type(action) == "number" then
    print ("number action test passed")

    if displayStr and displayStr: len () < maxLength then
      displayStr = displayStr .. action
      --display the number
      calcScreen: setLable (displayStr)
    end


  end
end

local function onSceneTouch( self, event )

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
	
	
	
    ------------------------------------
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
  end


function scene:create( event )
  local sceneGroup = self.view
  local backgroundSet = display.newImage ("images/whiteBackground.png")
  backgroundSet.x = display.contentCenterX
  backgroundSet.y = display.contentCenterY
  backgroundSet.width = 480
  backgroundSet.height = 854
  backgroundSet: addEventListener("touch", onSceneTouch)
  backgroundSet.numTouches = 0
  backgroundSet.isHitTestable = true
  backgroundSet.alpha = 0.95
  sceneGroup: insert (backgroundSet)

  backgroundSet.touch = onSceneTouch
end

function scene:show( event )
  local sceneGroup = self.view
  local phase = event.phase

  if phase == "will" then

    local fullh = display.contentHeight
    local fullw = display.contentWidth

    local centerX = display.contentCenterX
    local centerY = display.contentCenterY

    display.setStatusBar(display.TranslucentStatusBar)
    -- List of all colors
    local colors = require("classes.colors")
    -- Loading our helper classes : button, calculator display and math helper
    local newButton = require("classes.button").newButton
    local newScreen = require("classes.screen").newScreen
    local calculator = require("classes.calculator")


    local buttons = {}

    --button locations
    local buttonWidth = display.actualContentWidth / 5
    local buttonHeight = math.floor(buttonWidth * 0.75)



    -------------------------------------------------------------------------------------------
    local inputValue = "0"



    -- Functional button pressed flag
    local isLastFunctional = true
    -- display string
    local displayStr = "0"
    -- How many symbols will fit on screen
    local maxLength = 42

    --Creating display screen
    local calcScreen = newScreen(50, 220)
    --insert the calcScreen into the scenegroup
    sceneGroup:insert(calcScreen)

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




    local function buttonListener (event) --the main function that i use to set what will happend after i touch the button
      local id = event.target.id
     --print (numberButtonsArray[1].action)
      if("ended" == event.phase) then
        print ("actoin: " .. numberButtonsArray[1].action)
        --print("inputValue")
        --showScene2()
      end

    end


    local EnterButton = display.newImage("images/EnterButton.png")
    EnterButton.x = centerX + 50
    EnterButton.y = centerY + 255
    EnterButton.id = "EnterButton"
    EnterButton.width = 220
    EnterButton.height = 60
    EnterButton: addEventListener("touch", buttonListener)
    sceneGroup: insert(EnterButton)

    local w, h = buttonWidth, buttonHeight

    local data = numberButtonsArray[1]

    local position  = 0

    local testButton = newButton(data.label, w, h, data.backgroundColor, data.labelColor)
    testButton: addEventListener("touch", buttonTouch)
    sceneGroup: insert(testButton)
    testButton.x = centerX- 25
    testButton.y = centerY+ 25
    testButton.action = data.action






    --  display.setDefault( "background", 0.5 )
    text1 = display.newText( "Scene 1", 2, 0, native.systemFontBold, 24 )
    text1:setFillColor( 255 )
    text1.x, text1.y = display.contentWidth * 0.5, 50
    sceneGroup:insert( text1 )
  return testButton.action

    -- Called when the scene is still off screen and is about to move on screen
  elseif phase == "did" then
    --  timer.performWithDelay(3000, showScene2)
    -- Called when the scene is now on screen
    --
    -- INSERT code here to make the scene come alive
    -- e.g. start timers, begin animation, play audio, etc.
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

  -- Called prior to the removal of scene's "view" (sceneGroup)
  --
  -- INSERT code here to cleanup the scene
  -- e.g. remove display objects, remove touch listeners, save state, etc.
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

---------------------------------------------------------------------------------

return scene
