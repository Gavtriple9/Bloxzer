local composer = require( "composer" )
local scene = composer.newScene()
 
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
 
 
 
 
-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------




 
-- create()
function scene:create( event )
 
    local sceneGroup = self.view
    CenterX = display.contentCenterX
	CenterY = display.contentCenterY
	Width = display.contentWidth
	Heigth = display.contentHeight

	Scale = 0.4

	ScaleX, ScaleY = Scale, 0.3

	local background = display.newImageRect( "Images/MainArt.png", 300, 480 )
	background.x = CenterX
	background.y = CenterY + 20
	background:scale( 1.2,1.2 )
	sceneGroup:insert(background)

	local startButton = display.newImageRect( "Images/PlayButton.png", 300, 150)
	startButton.x = CenterX
	startButton.y = CenterY*1.8
	startButton:scale( ScaleX, ScaleY )
	sceneGroup:insert(startButton)

	local startText = display.newText( "Press to Start", 100, 200, native.systemFont, 13 )
	startText.x = startButton.x
	startText.y = startButton.y
	startText:setFillColor( 1, 1, 1 )
	sceneGroup:insert(startText)



	function startButton:touch( event )
	    if event.phase == "began" then
	        composer.gotoScene( "scene1" )
	    end
	end
	startButton:addEventListener( "touch", startButton )
 

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
        composer.removeScene( "home" )
    end
end
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