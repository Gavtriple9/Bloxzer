--Copyright (C) 2016  A - S t a r  G a m e s
--GSR
print( "Copyright (C) 2016  A - S t a r  G a m e s" )

display.setStatusBar( display.HiddenStatusBar )

local widget = require( "widget" )
local composer = require ("composer")

CenterX = display.contentCenterX
CenterY = display.contentCenterY
Width = display.contentWidth
Height = display.contentHeight


local value = 290
local HighScore = 115
local score = 20



-- Make a game over menu with score, high score, restart button, home button, leaderboard button?, facebook button. Take time and make it look good.
-- Make the buttons functions empty, I will put the functions needed in them.

local scene = composer.newScene()
 
-- create()
function scene:create( event ) 
    local sceneGroup = self.view


	local Circle3 = display.newImageRect( "Images/Circle.png", 50, 50 )
    sceneGroup:insert(Circle3)
    Circle3.x = CenterX/1.3 
    Circle3.y = CenterY*1.77
    local Circle4 = display.newImageRect( "Images/Circle.png", 50, 50 )
    sceneGroup:insert(Circle4)
    Circle4.x = CenterX*1.24 
    Circle4.y = CenterY*1.77
    local Circle5 = display.newImageRect( "Images/Circle.png", 50, 50 )
    sceneGroup:insert(Circle5)
    Circle5.x = CenterX*1.7 
    Circle5.y = CenterY*1.77
    local Circle5 = display.newImageRect( "Images/Circle.png", 50, 50 )
    sceneGroup:insert(Circle5)
    Circle5.x = CenterX/3.4 
    Circle5.y = CenterY*1.77


	Picture = display.newImageRect( "Images/Circle.png", 200, 200 )
	sceneGroup:insert(Picture)
	Picture:toBack()
	Picture.x = CenterX
	Picture.y = CenterY



    local Circle = display.newImageRect( "Images/Circle.png", 130, 130 )
    sceneGroup:insert(Circle)
    local Circle2 = display.newImageRect( "Images/Circle.png", 115, 115 )
	sceneGroup:insert(Circle2)
	Circle:setFillColor( 1, 0.4, 0 )

    Circle2.x = CenterX
    Circle2.y = CenterY*1.4
    Circle.x = CenterX
    Circle.y = CenterY*1.4

    -- Circle2.fill.effect = "filter.hue"
    -- Circle2.fill.effect.angle = -200



    local background = display.newRect(  CenterX, CenterY, Width*1.5, Height*1.5 )
    sceneGroup:insert(background)
	background:setFillColor( 0, 0.5, 1 )

    -- function setHue()
    --     background.fill.effect.angle = value
    --     value = value + 1
    -- end
    -- hue = timer.performWithDelay( 300, setHue, -1 )



	local function handleButtonEvent5( event )
	 
	    if ( "ended" == event.phase ) then
 			
	    end
	end
	 									

	local shareButton = widget.newButton(
	    {
	        width = 65,
	        height = 65,
	        defaultFile = "Images/share.png",
	        overFile = "Images/shareHOVER.png",
	        onEvent = handleButtonEvent5
	    }
	)

	function hideshareButton()
        shareButton.alpha = 0
	end
	-- Center the button
	shareButton.x = CenterX/1.3
	shareButton.y = CenterY*1.77
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
	volumeButton.y = CenterY*1.77
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
	        defaultFile = "Images/menu.png",
	        overFile = "Images/menuHOVER.png",
	        onEvent = handleButtonEvent4
	    }
	)

	function hidemenuButton()
        menuButton.alpha = 0
	end
	-- Center the button
	menuButton.x = CenterX*1.7
	menuButton.y = CenterY*1.77
	menuButton.alpha = 1
	sceneGroup:insert(menuButton)



	local function handleButtonEvent3( event )
	 
	    if ( "ended" == event.phase ) then

	    end
	end
	 									

	local retryButton = widget.newButton(
	    {
	        width = 130,
	        height = 130,
	        defaultFile = "Images/retry.png",
	        overFile = "Images/retryHOVER.png",
	        onEvent = handleButtonEvent3
	    }
	)

	-- Center the button
	retryButton.x = CenterX
	retryButton.y = CenterY*1.4
	retryButton.alpha = 1
	retryButton:toFront()
	sceneGroup:insert(retryButton)





	local function handleButtonEvent2( event )
	    if ( "ended" == event.phase ) then

	    end
	end


	local leaderButton = widget.newButton(
	    {
	        width = 50,
	        height = 50,
	        defaultFile = "Images/LeaderboardIcon.png",
	        overFile = "Images/LeaderboardIcon.png",
	        onEvent = handleButtonEvent2
	    }
	)

	function hideLeaderButton()
        leaderButton.alpha = 0
	end
	-- Center the button
	leaderButton.x = CenterX/3.4 
	leaderButton.y = CenterY*1.77
	leaderButton.alpha = 1
	sceneGroup:insert(leaderButton)

	
	local BloxzerT = display.newText("Bloxzer", CenterX, CenterY/4, "koliko-Bold.ttf", 80 )
	local BloxzerShadowT = display.newText("Bloxzer", BloxzerT.x, BloxzerT.y-1, "koliko-Bold.ttf", 80 )
	local BloxzerShadowT = display.newText("Bloxzer", BloxzerT.x, BloxzerT.y-2, "koliko-Bold.ttf", 80 )
	local BloxzerShadowT = display.newText("Bloxzer", BloxzerT.x, BloxzerT.y-3, "koliko-Bold.ttf", 80 )
	BloxzerShadowT:setTextColor( 1, 0.5, 0.314 )
	BloxzerT:setTextColor( 1, 1, 1 )





	
	local ScoreText = display.newText( "BEST", CenterX/1.3, CenterY/1.05, "koliko-Regular.ttf", 30 )
	ScoreText:toFront()
	ScoreText:setTextColor( 1, 0.6, 0.4 )

	
	local scoreT = display.newText( score, CenterX, CenterY/1.4, "KeepCalm-Medium.ttf", 50 )
	scoreT:setTextColor( 1, 1, 1 )


	sceneGroup:insert( scoreT )


	function SetText()
		scoreT.text = score
		scoreT:toFront( )
	end
	SetTextTimer = timer.performWithDelay( 300, SetText, -1 )



	local HScoreText = display.newText( "GAME  OVER", CenterX, CenterY/2.4, "KeepCalm-Medium.ttf", 20 )
	HScoreText:toFront()
	HScoreText:setTextColor( 1, 0.5, 0.314 )


	local HighScoreT = display.newText( HighScore, CenterX*1.25, CenterY/1.09, "KeepCalm-Medium.ttf", 30 )
	HighScoreT:toFront()
	HighScoreT:setTextColor( 1, 0.6, 0.4 )

	sceneGroup:insert( HighScoreT )



	function SetBestText()
		HighScoreT.text = HighScore
	end
	SetBestTextTimer = timer.performWithDelay( 300, SetBestText, -1 )
    background:toBack()

	













 
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