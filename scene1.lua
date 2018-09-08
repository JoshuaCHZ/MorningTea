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
local buttonWidth = 220/ 3
local buttonHeight = 200/4--math.floor(buttonWidth * 0.75)
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
    {label = "+", action = "add", key = "+", backgroundColor = colors.primaryBackground, labelColor = colors.primaryLabel},
    {label = "–", action = "subtract", key = "-", backgroundColor = colors.primaryBackground, labelColor = colors.primaryLabel},
    {label = "AC", action = "reset", key = "c", backgroundColor = colors.secondaryBackground, labelColor = colors.secondaryLabel},
}

local categoryArray = {
    --{fileLocation = "images/food.png"},
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
    --print ("test done")

    if (event.limitReached) then


    end
    return false

end


local function buttonTouch (self,event)
  local action = self.target.action
--    print (self.target.action)
--print(action)
    local phase = self.phase
    --print (phase)
if  ("ended" == phase) then
--    print ("number button test has been preseed")
  if type(action) == "number" then
--    print ("number action test passed")

    print("befor < test" .. displayStr)
    if displayStr and displayStr: len () < maxLength then

--        if tonumber(displayStr) == 0 then
--            print("passtest")
--            displayStr = action
--        else
--            displayStr = displayStr .. action
--        end
        if displayStr == "0" then
        displayStr = ""
        end
        displayStr = displayStr .. action

      --display the number
      calcScreen: setLabel (displayStr)
    end
  elseif ("clear" == action) then
      displayStr = "0"
      calcScreen: setLabel (displayStr)
  else
      if displayStr and displayStr: len () < maxLength then
          if displayStr == "0" then
              displayStr = ""
          end
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
        else
            return false
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

        if displayStr == "0" then
                displayStr = ""
        end
        print (displayStr)

        local resultValue = tonumber (displayStr)
        print(resultValue)

--        local action = event.target.action
--        -- set the current displaystr to calculator class
--        calculator.setOperand(displayStr)
--        print(calculator.setOperator(action), action)
--        -- Pass current math operator to the calculator class and see if there is a result available
--        if calculator.setOperator(action) then
--            -- Get the result from the calculator class
--            displayStr = calculator.getResult()
--            print("got result")
--            -- If there is an error (division by zero) - display "Error" on the screen
--            if calculator.error then
--                displayStr = "ERROR"
--            end
--        end

        calcScreen:setLabel(displayStr)
        calcScreen:blink()

        local testResult = 0



    end

end


function scene:create( event )
    local sceneGroup = self.view

    local topSwipe = display.newRect (centerX,centerY,fullw,fullh)
    --topSwipe: setFillColor (0.5)
    topSwipe: addEventListener("touch", onSceneTouch)
    topSwipe.isVisible =false
    topSwipe.isHitTestable = true
    sceneGroup: insert(topSwipe)


    local backgroundSet = display.newImage ("images/whiteBackground.png")   --display new background use the local image
    backgroundSet.x = display.contentCenterX    --set x location
    backgroundSet.y = display.contentCenterY    --set y location
    backgroundSet.width = 480   -- set width
    backgroundSet.height = 854 -- set height
   -- backgroundSet: addEventListener("touch", onSceneTouch)
    backgroundSet.isHitTestable = true  -- i don't understand
    backgroundSet.alpha = 0.95  -- make the background 0.95 transperment
    --ackgroundSet.touch = onSceneTouch -- link backgroundSet to onSceneTouch function when the touch happened
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
--    local ScrollBackground = display.newImage("images/whiteBackground.png")
--    categoryView: insert (ScrollBackground)
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
    -- set action for enter button
    EnterButton.action = "result"
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
        -- number function
      function number (numberValue,xValue,yValue)
          local numbers = newButton (numberButtonsArray[numberValue].label, w, h,numberButtonsArray[numberValue],backgroundColor, numberButtonsArray[numberValue].labelColor)
          numbers.x = xValue
          numbers.y = yValue
          numbers.action = numberValue
          numbers:addEventListener("touch", buttonTouch)
          sceneGroup: insert(numbers)
      end

    --create the test number button
    local testButton = newButton(data.label, w, h, data.backgroundColor, data.labelColor)
    testButton: addEventListener("touch", buttonTouch)
    sceneGroup: insert(testButton)
    testButton.x = 100+(buttonWidth/2)
    testButton.y = centerY+ 25
    testButton.action = data.action

    local number2 = newButton(numberButtonsArray[2].label, w,h,numberButtonsArray[2].backgroundColor,numberButtonsArray[2].labelColor)
    sceneGroup: insert (number2)
    number2: addEventListener("touch", buttonTouch)
    number2.x = 100+ 1.5*buttonWidth
    number2.y = centerY + 25
    number2.action = 2

    local number3 = newButton (numberButtonsArray[3].label,w,h,numberButtonsArray[3].backgroundColor,numberButtonsArray[3].labelColor)
    number3: addEventListener("touch", buttonTouch)
    sceneGroup: insert(number3)
    number3.x = 100+ 2.5*buttonWidth
    number3.y = centerY+ 25
    number3.action = 3

    --number (4,100+(buttonWidth/2),centerY+85)

      local number4 = newButton (numberButtonsArray[4].label,w,h,numberButtonsArray[4].backgroundColor,numberButtonsArray[4].labelColor)
      number4: addEventListener("touch",buttonTouch)
      sceneGroup: insert(number4)
      number4.x = 100+buttonWidth/2
        number4.y = centerY+25+buttonHeight
      number4.action = 4


    local number5 = newButton (numberButtonsArray[5].label,w,h,numberButtonsArray[5].backgroundColor,numberButtonsArray[5].labelColor)
    number5: addEventListener("touch",buttonTouch)
    sceneGroup: insert(number5)
    number5.x = 100+1.5*buttonWidth
    number5.y = centerY+ 25+buttonHeight
    number5.action = 5

      local number6 = newButton (numberButtonsArray[6].label,w,h,numberButtonsArray[6].backgroundColor,numberButtonsArray[6].labelColor)
      number6: addEventListener("touch",buttonTouch)
      sceneGroup: insert(number6)
      number6.x = 100+2.5*buttonWidth
      number6.y = centerY+ 25+buttonHeight
      number6.action = 6
      local number7 = newButton (numberButtonsArray[7].label,w,h,numberButtonsArray[7].backgroundColor,numberButtonsArray[7].labelColor)
      number7: addEventListener("touch",buttonTouch)
      sceneGroup: insert(number7)
      number7.x = 100+buttonWidth/2
      number7.y = centerY+ 25+buttonHeight*2
      number7.action = 7
      local number8 = newButton (numberButtonsArray[8].label,w,h,numberButtonsArray[8].backgroundColor,numberButtonsArray[8].labelColor)
      number8: addEventListener("touch",buttonTouch)
      sceneGroup: insert(number8)
      number8.x = 100+1.5*buttonWidth
      number8.y = centerY+ 25+buttonHeight*2
      number8.action = 8
      local number9 = newButton (numberButtonsArray[9].label,w,h,numberButtonsArray[9].backgroundColor,numberButtonsArray[9].labelColor)
      number9: addEventListener("touch",buttonTouch)
      sceneGroup: insert(number9)
      number9.x = 100+2.5*buttonWidth
      number9.y = centerY+ 25+buttonHeight*2
      number9.action = 9
      local number0 = newButton (numberButtonsArray[10].label,w,h,numberButtonsArray[10].backgroundColor,numberButtonsArray[10].labelColor)
      number0: addEventListener("touch",buttonTouch)
      sceneGroup: insert(number0)
      number0.x = 100+1.5*buttonWidth
      number0.y = centerY+25+buttonHeight*3
      number0.action = 0
  local PlusButton = newButton(numberButtonsArray[12].label,w/2,h,numberButtonsArray[12].backgroundColor,numberButtonsArray[12].labelColor)
    PlusButton: addEventListener("touch",buttonTouch)
    sceneGroup: insert(PlusButton)
    PlusButton.x = 100+w/4
    PlusButton.y = centerY+25+buttonHeight*3
    PlusButton.action = "+"
  local clear = newButton(numberButtonsArray[14].label,w,h,numberButtonsArray[14].backgroundColor,numberButtonsArray[14].labelColor)
    clear.x = 100+2.5*buttonWidth
    clear.y = centerY+25+buttonHeight*3
    clear.action = "clear"
    clear: addEventListener("touch",buttonTouch)
    sceneGroup: insert(clear)
  local minus = newButton(numberButtonsArray[13].label,w/2,h,numberButtonsArray[13].backgroundColor,numberButtonsArray[13].labelColor)
    minus.x = 100+w/1.35
    minus.y = centerY+25+buttonHeight*3
    minus.action = "-"
    minus: addEventListener("touch",buttonTouch)
    sceneGroup: insert(minus)

  --return testButton.action

    -- Called when the scene is still off screen and is about to move on screen
  elseif phase == "did" then

  end
end

function scene:hide( event )
  local sceneGroup = self.view
  local phase = event.phase

  if event.phase == "will" then


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
