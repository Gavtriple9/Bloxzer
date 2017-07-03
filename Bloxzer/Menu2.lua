--Copyright (C) 2016-17  A - S t a r  G a m e s
--GSR
print( "Copyright (C) 2016  A - S t a r  G a m e s" )

display.setStatusBar( display.HiddenStatusBar )

local widget = require( "widget" )
local composer = require ("composer")

local physics = require( "physics" )

CenterX = display.contentCenterX
CenterY = display.contentCenterY
Width = display.actualContentWidth
Height = display.actualContentHeight

physics.start()
physics.setGravity( 0, 0 )
physics.setDrawMode( "hybrid" )

local value = 290
local HighScore = 115
local score = 20
local rot = 0
local exp = 50


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




    local gameOver = display.newText( "GAME OVER", CenterX, CenterY/2, "koliko-Bold.ttf", CenterX/4, CenterY/4 )
    sceneGroup:insert(gameOver)




		local function spawnBalls()
	 
	    	local ball = display.newCircle( 0, 0, 10 )
	 		sceneGroup:insert( ball )

	   	 	ball.x = math.random( 0, display.actualContentWidth )
	    	ball.y = math.random( 0, display.actualContentHeight )

	    	xVelocity = math.random( -200, 200 )
	    	yVelocity = math.random( -200, 200 )

	    	physics.addBody( ball, "dynamic", {bounce = 1} )
	    	ball:setLinearVelocity( xVelocity, yVelocity )

		end

		timer.performWithDelay( 1, spawnBalls, 5 )


	local wall1 = display.newRect( display.actualContentWidth, CenterY, 1, display.actualContentHeight )
    sceneGroup:insert( wall1 )
	physics.addBody( wall1, "static" )

	local wall2 = display.newRect( 0, CenterY, 1, display.actualContentHeight )
    sceneGroup:insert( wall2 )
	physics.addBody( wall2, "static" )

	local wall3 = display.newRect( CenterX, display.actualContentHeight/1.084, display.actualContentWidth, 1 )
    sceneGroup:insert( wall3 )
	physics.addBody( wall3, "static" )

	local wall4 = display.newRect( CenterX, -44, display.actualContentWidth, 1  )
    sceneGroup:insert( wall4 )
	physics.addBody( wall4, "static" )







	local function handleButtonEvent5( event )
	 
	    if ( "ended" == event.phase ) then
 			
	    end
	end
	 									

	local shareButton = widget.newButton(
	    {
	        width = 50,
	        height = 50,
	        defaultFile = "Images/home.png",
	        overFile = "Images/homeHOVER.png",
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
	volumeButton.x = CenterX/5
	volumeButton.y = 0
	volumeButton.alpha = 1
	sceneGroup:insert(volumeButton)





	local function handleButtonEvent4( event )
	 
	    if ( "ended" == event.phase ) then
 			
	    end
	end
	 									

	local menuButton = widget.newButton(
	    {
	        width = 50,
	        height = 50,
	        defaultFile = "Images/home.png",
	        overFile = "Images/homeHOVER.png",
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
	        width = 50,
	        height = 50,
	        defaultFile = "Images/home.png",
	        overFile = "Images/homeHOVER.png",
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
	leaderButton.x = display.actualContentWidth/1.1
	leaderButton.y = 0
	leaderButton.alpha = 1
	sceneGroup:insert( leaderButton )



	local function Rotation()
		function actRot()
			rot = rot - 1
		end
		rotTimer = timer.performWithDelay( 10, actRot, -1 )
		function updateRot()
			retryButton.rotation = rot
		end
		rotUpdaterTimer = timer.performWithDelay( 10, updateRot, -1 )

	end
	Rotation()



	local function Expand()
		function actExp()
			exp = exp + 1
		end
		expTimer = timer.performWithDelay( 10, actRot, -1 )
		function updateRot()
			shareButton:scale( exp, exp )
		end
		expUpdaterTimer = timer.performWithDelay( 10, updateRot, -1 )
	end








	
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