----------------------------------------------------------------------------------
--
-- scenetemplate.lua
--
----------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()
local function onSceneTouch( self, event )


  -- if self.phase == "began" then



    -- display.getCurrentStage():setFocus( self.target, self.id ) --Set focus on object using unique touch ID
    -- self.target.numTouches = self.target.numTouches + 1
    -- if self.target.numTouches >= 3 then
      -- print( "This object is being multi-touched." )
      -- composer.gotoScene( "scene1", "slideRight", 500 )
      -- self.target.numTouches = self.target.numTouches - 3
    -- end

  -- elseif self.phase == "cancelled" or self.phase == "ended" then
    -- display.getCurrentStage():setFocus( self.target, nil )

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

        elseif self.xStart < self.x and swipeLength > 50 then
          print ("swiped right")
		  composer.gotoScene( "scene1", "slideRight", 500 )
        end

    end

    --print("backgroundSet has been pressed")
    return true
  end
-- end
---------------------------------------------------------------------------------

local function showScene1()
  local options = {
    effect = "flip",
    time = 500
  }
  composer.gotoScene("scene1", options)
end

function scene:create( event )
  local sceneGroup = self.view
  
  local background2 = display.newImage ("images/whiteBackground.png")
  background2.x = display.contentCenterX
  background2.y = display.contentCenterY
  background2.width = 480
  background2.height = 854
  background2: addEventListener("touch", onSceneTouch)
  background2.alpha = 0.9
  sceneGroup: insert (background2)
  
  local backgroundSet = display.newImage ("images/scene2Example.png")
  backgroundSet.x = display.contentCenterX
  backgroundSet.y = display.contentCenterY
  backgroundSet.width = 300
  backgroundSet.height = 550
  backgroundSet: addEventListener("touch", onSceneTouch)
  backgroundSet.numTouches = 0
  sceneGroup: insert (backgroundSet)

  backgroundSet.touch = onSceneTouch
  
  --------------------------------------
  
  
end

function scene:show( event )
  local sceneGroup = self.view
  local phase = event.phase

  if phase == "will" then

	
    --local textOfScene1 = display.newText("Hello world here is scene 2", )

  elseif phase == "did" then
    --timer.performWithDelay(3000, showScene1)
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
