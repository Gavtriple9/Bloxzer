--Copyright (C) 2016-17  A - S t a r  G a m e s
--GSR
print( "Copyright (C) 2016  A - S t a r  G a m e s" )

display.setStatusBar( display.HiddenStatusBar )

local widget = require( "widget" )
local composer = require ("composer")

CenterX = display.contentCenterX
CenterY = display.contentCenterY
Width = display.actualContentWidth
Height = display.actualContentHeight


local value = 290
local HighScore = 115
local score = 20



-- Make a game over menu with score, high score, restart button, home button, leaderboard button?, facebook button. Take time and make it look good.
-- Make the buttons functions empty, I will put the functions needed in them.

local scene = composer.newScene()
 
-- create()
function scene:create( event ) 
    local sceneGroup = self.view

    local background = display.newImageRect( "Images/background.png", Width, Height )

    background.x = CenterX
    background.y = CenterY
    sceneGroup:insert( background )






	local function handleButtonEvent5( event )
	 
	    if ( "ended" == event.phase ) then
 			
	    end
	end
	 									

	local shareButton = widget.newButton(
	    {
	        width = 75,
	        height = 75,
	        defaultFile = "Images/share.png",
	        overFile = "Images/shareHOVER.png",
	        onEvent = handleButtonEvent5
	    }
	)

	function hideshareButton()
        shareButton.alpha = 0
	end
	-- Center the button
	shareButton.x = CenterX*1.56
	shareButton.y = CenterY*1.74
	shareButton.alpha = 1
	sceneGroup:insert(shareButton)




	local function handleButtonEvent6( event )
	 
	    if ( "ended" == event.phase ) then
 			
	    end
	end
	 									

	local volumeButton = widget.newButton(
	    {
	        width = 50,
	        height = 25,
	        defaultFile = "Images/volumeon.png",
	        overFile = "Images/volumeoff.png",
	        onEvent = handleButtonEvent5
	    }
	)

	function hideButton()
        volumeButton.alpha = 0
	end
	-- Center the button
	volumeButton.x = CenterX*1.24
	volumeButton.y = CenterY/1.74
	volumeButton.alpha = 1
	sceneGroup:insert(volumeButton)





	local function handleButtonEvent4( event )
	 
	    if ( "ended" == event.phase ) then
 			
	    end
	end
	 									

	local menuButton = widget.newButton(
	    {
	        width = 75,
	        height = 75,
	        defaultFile = "Images/HomeButton.png",
	        overFile = "Images/HomeButtonHOVER.png",
	        onEvent = handleButtonEvent4
	    }
	)

	function hidemenuButton()
        menuButton.alpha = 0
	end
	-- Center the button
	menuButton.x = CenterX/2.2
	menuButton.y = CenterY*1.74
	menuButton.alpha = 1
	sceneGroup:insert(menuButton)



	local function handleButtonEvent3( event )
	 
	    if ( "ended" == event.phase ) then

	    end
	end
	 									

	local retryButton = widget.newButton(
	    {
	        width = 130,
	        height = 130/2,
	        defaultFile = "Images/retry2.png",
	        overFile = "Images/retry2HOVER.png",
	        onEvent = handleButtonEvent3
	    }
	)

	-- Center the button
	retryButton.x = CenterX
	retryButton.y = CenterY*1.74
	retryButton.alpha = 1
	retryButton:toFront()
	sceneGroup:insert(retryButton)





	local function handleButtonEvent2( event )
	    if ( "ended" == event.phase ) then

	    end
	end


	local leaderButton = widget.newButton(
	    {
	        width = 25,
	        height = 25,
	        defaultFile = "Images/Options.png",
	        overFile = "Images/Options.png",
	        onEvent = handleButtonEvent2
	    }
	)

	function hideLeaderButton()
        leaderButton.alpha = 0
	end
	-- Center the button
	leaderButton.x = CenterX*2.03 
	leaderButton.y = CenterY/16
	leaderButton.alpha = 1
	sceneGroup:insert( leaderButton )




	
end

 
 
-- show()
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
 
    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
 
    end
end
 
 
-- hide()
function scene:hide( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is on screen (but is about to go off screen)
 
    elseif ( phase == "did" ) then
        -- Code here runs immediately after the scene goes entirely off screen
 
    end
end
 
 
-- destroy()
function scene:destroy( event )
 
    local sceneGroup = self.view
    -- Code here runs prior to the removal of scene's view
 
end
 
 
-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------
 
return scene