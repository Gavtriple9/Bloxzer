local composer = require( "composer" )
local scene = composer.newScene()
local widget = require( "widget" )

display.setDefault( "isAnchorClamped", false )

local physics = require( "physics" )
physics.start()

physics.setGravity( 0, 0 )

--physics.setDrawMode( "hybrid" )

----------------------------------
CenterX = display.contentCenterX
CenterY = display.contentCenterY
Width = display.contentWidth
height = display.contentHeight
Finished = false
TimerY = false

local ballCollisionFilter = { categoryBits = 1, maskBits = 6 }
local spikeCollisionFilter = { categoryBits = 2, maskBits = 1 }
local platformCollisionFilter = { categoryBits = 4, maskBits = 1 }
local pivotCollisionFilter = { categoryBits = 8, maskBits = 0 }

local ballBody = {density = 0,radius = 7.5, friction = 0, bounce = 1, filter = ballCollisionFilter}
local platformBody = {friction = 0, bounce=1,filter = platformCollisionFilter}
local pivotBody = {friction = 0, bounce=1,filter = pivotCollisionFilter}

local spikeside = { 0,-9, -12.5,9, 12.5,9}

local spikeBody = {friction = 0, bounce = 1,filter = spikeCollisionFilter, shape=spikeside}

local platBody = {friction = 0, bounce = 1,filter = spikeCollisionFilter}


_G.score = 0
direction = 1
yes = 0
retreat = -100
extend = 100
wait= 60
time = 15000
rot = 0
bool = -1



-- create()
function scene:create( event )
    local sceneGroup = self.view

---------------------------------------------------------------------------------------------------------------

    -- local MainPresets = {
    --     channel = 1,
    --     loops = -1,
    --     duration = 300000,
    --     fadeit = 5000, 
    -- }
    -- local MainMusic = audio.loadSound( "Sounds/Music.m4a" )
    -- audio.play( MainMusic, MainPresets )

---------------------------------------------------------------------------------------------------------------    

---------------------------------------------------------------------------------------------------------------

    value = math.random( 0,300 )

    local background = display.newImageRect( "Images/background.png", Width*1.5, height*1.5 )
    background.x = CenterX
    background.y = CenterY
    background.fill.effect = "filter.hue"
    background.fill.effect.angle = value
    sceneGroup:insert(background)



    function setHue()
        background.fill.effect.angle = value
        value = value + 1
    end
    hue = timer.performWithDelay( 300, setHue, -1 )

 
    local backhoop = display.newImageRect("Images/hoop2.png", 800,800)
    backhoop:setFillColor(1,1,1,.6)
    backhoop.x = CenterX
    backhoop.y = CenterY
    sceneGroup:insert(backhoop)






    local inhoop = display.newImageRect("Images/hoop.png", 310,310)
    inhoop:setFillColor(1,1,1,.6)
    inhoop.x = CenterX
    inhoop.y = CenterY
    sceneGroup:insert(inhoop)



    local growlock = 0;





    local function backhoopungrow()
        if growlock == 0 then   
            local transBHU = transition.scaleTo( backhoop, {time = 750 ,xScale = .85, yScale = .85,  onComplete= backhoopgrow} )
        end
    end
    function backhoopgrow()
        if growlock == 0 then
            local transBH =transition.scaleTo( backhoop, {time = 750 ,xScale = 1.1, yScale = 1.1,  onComplete= backhoopungrow} )
        end
    end
    backhoopgrow()





    local function inhoopungrow()
        if growlock == 0 then   
            local transIHU =transition.scaleTo( inhoop, {time = 750 ,xScale = .85, yScale = .85,  onComplete= inhoopgrow} )
        end
    end
    function inhoopgrow()
        if growlock == 0 then
            local transIH = transition.scaleTo( inhoop, {time = 750 ,xScale = 1.1, yScale = 1.1,  onComplete= inhoopungrow} )
        end
    end
    inhoopgrow()


	local scoretext = display.newText( 0, display.contentCenterX, display.contentCenterY, native.systemFont, 100 )
	scoretext:setFillColor(1,1,1,.6)
	sceneGroup:insert(scoretext)

    local function growlockon()
        growlock = 0
        inhoopgrow()
        backhoopgrow()

        transition.resume( transBHU )
        transition.resume( transBH )
        transition.resume( transIHU )
        transition.resume( transIH )
    end

    local function getbacktopostion()
        inhoop:scale(.001,.001)
        backhoop:scale(.001,.001)
        local inhoopback =transition.scaleTo( inhoop, {time = 400 ,xScale = 1.1, yScale = 1.1} )  
        local backhoopback = transition.scaleTo( backhoop, {time = 400 ,xScale = 1.1, yScale = 1.1,onComplete=growlockon} ) 
    end
    local function scoreupanim()
        growlock = 1;
        transition.pause( transBHU )
        transition.pause( transBH )
        transition.pause( transIHU )
        transition.pause( transIH )

        local inhoopout = transition.scaleTo( inhoop, {time = 400 ,xScale = 5, yScale = 5} )  
        local backhoopout = transition.scaleTo( backhoop, {time = 400 ,xScale = 5, yScale = 5, onComplete=getbacktopostion} ) 
    end





	local function addscore()
		score = score + .5
        
        if score % 5 == 0 and score ~= 0 then
            scoreupanim()
        end
        
		scoretext.text = math.round(score)
	end




    local ball = display.newImageRect( "Images/ball1.png", 15, 15 )
    ball.myName = "ball"
    ball.x = CenterX
    ball.y = CenterY
    physics.addBody( ball, "dynamic", ballBody )
    sceneGroup:insert(ball)

local emitterParams = {
    startColorAlpha = 0,
    startParticleSizeVariance = 0,
    startColorGreen = 0,
    emitterType = 1,
    yCoordFlipped = 0,
    blendFuncSource = 770,
    rotatePerSecondVariance = 0,
    particleLifespan = 1,
    tangentialAcceleration = 0,
    finishColorBlue = 1,
    finishColorGreen = 1,
    blendFuncDestination = 1,
    startParticleSize = 8,
    startColorRed = 0,
    textureFileName = "Images/particle.png",
    startColorVarianceAlpha = 0,
    startColorAlpha = 1,
    maxParticles = 100,
    finishParticleSize = 0,
    duration = -1,
    finishColorRed = 1,
    maxRadiusVariance = 0,
    finishParticleSizeVariance = 0,
    gravityy = 0,
    speedVariance = 0,
    tangentialAccelVariance = 0,
    angleVariance = 0,
    angle = 0,
    absolutePosition = true,
    speed = 0,
}
 
-- Create the emitter
local emitter = display.newEmitter( emitterParams )
sceneGroup:insert(emitter) 
-- Center the emitter within the content area
ball:toFront()

local function trail()
	emitter.x = ball.x;
	emitter.y = ball.y;
end
Runtime:addEventListener( "enterFrame", trail )




	scoretext.text = 3 ;
	local initforceangle = math.random(1,360)
	local counterst = 0;
	local function countdown()
 		counterst = counterst + 1;
 		scoretext.text = 3 - counterst
 		if counterst == 3 then
 			ball:setLinearVelocity(  100*(math.cos( (initforceangle)*(math.pi/180) )) , 100*(math.sin( (initforceangle)*(math.pi/180))))
 		end
	end
	local countdowntimer = timer.performWithDelay(1000, countdown, 3)



---------------------------------------------------------------------------------------------------------------    
    

    local pivotpoint = display.newRect( CenterX, CenterY, 0, 0 )
    pivotpoint.x = CenterX
    pivotpoint.y = CenterY
    physics.addBody( pivotpoint,"kinematic", pivotBody)
    pivotpoint.gravityScale = 0
    sceneGroup:insert(pivotpoint)
---------------------------------------------------------------------------------------------------------------
    
    local spike1 = display.newImageRect( "Images/Spike.png", 25, 18 )
    spike1.myName = "Spike1"
    spike1.x = CenterX + 91
    spike1.y = CenterY - 10
    spike1.rotation = 270
    physics.addBody( spike1, "dynamic" , spikeBody)
    sceneGroup:insert(spike1)
    
    local spike2 = display.newImageRect( "Images/Spike.png", 25, 18 )
    spike2.myName = "Spike2"
    spike2.x = CenterX - 91
    spike2.y = CenterY -15
    spike2.rotation = 90
    physics.addBody( spike2, "dynamic", spikeBody )
    sceneGroup:insert(spike2)
    
    local spike3 = display.newImageRect( "Images/Spike.png", 25, 18 )
    spike3.myName = "Spike3"
    spike3.x = CenterX - 35
    spike3.y = CenterY + 91
    spike3.rotation = 0
    physics.addBody( spike3, "dynamic", spikeBody )
    sceneGroup:insert(spike3)

    local spike4 = display.newImageRect( "Images/Spike.png", 25, 18 )
    spike4.myName = "Spike4"
    spike4.x = CenterX - 40
    spike4.y = CenterY - 91
    spike4.rotation = 180
    physics.addBody( spike4, "dynamic", spikeBody )
    sceneGroup:insert(spike4)

    local spike5 = display.newImageRect( "Images/Spike.png", 25, 18 )
    spike5.myName = "Spike5"
    spike5.x = CenterX + 91
    spike5.y = CenterY + 65
    spike5.rotation = 270
    physics.addBody( spike5, "dynamic" , spikeBody)
    sceneGroup:insert(spike5)

    local spike6 = display.newImageRect( "Images/Spike.png", 25, 18 )
    spike6.myName = "Spike6"
    spike6.x = CenterX - 91
    spike6.y = CenterY - 65
    spike6.rotation = 90
    physics.addBody( spike6, "dynamic", spikeBody )
    sceneGroup:insert(spike6)

    local spike7 = display.newImageRect( "Images/Spike.png", 25, 18 )
    spike7.myName = "Spike7"
    spike7.x = CenterX - 60
    spike7.y = CenterY + 91
    spike7.rotation = 0
    physics.addBody( spike7, "dynamic", spikeBody )
    sceneGroup:insert(spike7)

    local spike8 = display.newImageRect( "Images/Spike.png", 25, 18 )
    spike8.myName = "Spike8"
    spike8.x = CenterX + 60
    spike8.y = CenterY - 91
    spike8.rotation = 180
    physics.addBody( spike8, "dynamic", spikeBody )
    sceneGroup:insert(spike8)


    local spike9 = display.newImageRect( "Images/Spike.png", 25, 18 )
    spike9.myName = "Spike9"
    spike9.x = CenterX + 35
    spike9.y = CenterY - 91
    spike9.rotation = 180
    physics.addBody( spike9, "dynamic", spikeBody )
    sceneGroup:insert(spike9)
    
    local spike10 = display.newImageRect( "Images/Spike.png", 25, 18 )
    spike10.myName = "Spike10"
    spike10.x = CenterX + 10
    spike10.y = CenterY - 91
    spike10.rotation = 180
    physics.addBody( spike10, "dynamic", spikeBody )
    sceneGroup:insert(spike10)

    local spike11 = display.newImageRect( "Images/Spike.png", 25, 18 )
    spike11.myName = "Spike11"
    spike11.x = CenterX - 15
    spike11.y = CenterY - 91
    spike11.rotation = 180
    physics.addBody( spike11, "dynamic", spikeBody )
    sceneGroup:insert(spike11)

    local spike12 = display.newImageRect( "Images/Spike.png", 25, 18 )
    spike12.myName = "Spike12"
    spike12.x = CenterX - 65
    spike12.y = CenterY - 91
    spike12.rotation = 180
    physics.addBody( spike12, "dynamic", spikeBody )
    sceneGroup:insert(spike12)


    local spike13 = display.newImageRect( "Images/Spike.png", 25, 18 )
    spike13.myName = "Spike13"
    spike13.x = CenterX + 91
    spike13.y = CenterY + 15
    spike13.rotation = 270
    physics.addBody( spike13, "dynamic" , spikeBody)
    sceneGroup:insert(spike13)

    local spike14 = display.newImageRect( "Images/Spike.png", 25, 18 )
    spike14.myName = "Spike14"
    spike14.x = CenterX + 91
    spike14.y = CenterY + 40
    spike14.rotation = 270
    physics.addBody( spike14, "dynamic" , spikeBody)
    sceneGroup:insert(spike14)


    local spike15 = display.newImageRect( "Images/Spike.png", 25, 18 )
    spike15.myName = "Spike15"
    spike15.x = CenterX + 91
    spike15.y = CenterY - 35
    spike15.rotation = 270
    physics.addBody( spike15, "dynamic" , spikeBody)
    sceneGroup:insert(spike15)

    local spike16 = display.newImageRect( "Images/Spike.png", 25, 18 )
    spike16.myName = "Spike16"
    spike16.x = CenterX + 91
    spike16.y = CenterY - 60
    spike16.rotation = 270
    physics.addBody( spike16, "dynamic" , spikeBody)
    sceneGroup:insert(spike16)

    local spike17 = display.newImageRect( "Images/Spike.png", 25, 18 )
    spike17.myName = "Spike17"
    spike17.x = CenterX - 91
    spike17.y = CenterY - 40
    spike17.rotation = 90
    physics.addBody( spike17, "dynamic", spikeBody )
    sceneGroup:insert(spike17)

    local spike18 = display.newImageRect( "Images/Spike.png", 25, 18 )
    spike18.myName = "Spike18"
    spike18.x = CenterX - 91
    spike18.y = CenterY + 10
    spike18.rotation = 90
    physics.addBody( spike18, "dynamic", spikeBody )
    sceneGroup:insert(spike18)

    local spike19 = display.newImageRect( "Images/Spike.png", 25, 18 )
    spike19.myName = "Spike19"
    spike19.x = CenterX - 91
    spike19.y = CenterY + 35
    spike19.rotation = 90
    physics.addBody( spike19, "dynamic", spikeBody )
    sceneGroup:insert(spike19)

    local spike20 = display.newImageRect( "Images/Spike.png", 25, 18 )
    spike20.myName = "Spike20"
    spike20.x = CenterX - 91
    spike20.y = CenterY + 60
    spike20.rotation = 90
    physics.addBody( spike20, "dynamic", spikeBody )
    sceneGroup:insert(spike20)
    
    local spike21 = display.newImageRect( "Images/Spike.png", 25, 18 )
    spike21.myName = "Spike21"
    spike21.x = CenterX - 10
    spike21.y = CenterY + 91
    spike21.rotation = 0
    physics.addBody( spike21, "dynamic", spikeBody )
    sceneGroup:insert(spike21)

    local spike22 = display.newImageRect( "Images/Spike.png", 25, 18 )
    spike22.myName = "Spike22"
    spike22.x = CenterX + 15
    spike22.y = CenterY + 91
    spike22.rotation = 0
    physics.addBody( spike22, "dynamic", spikeBody )
    sceneGroup:insert(spike22)

    local spike23 = display.newImageRect( "Images/Spike.png", 25, 18 )
    spike23.myName = "Spike23"
    spike23.x = CenterX + 40
    spike23.y = CenterY + 91
    spike23.rotation = 0
    physics.addBody( spike23, "dynamic", spikeBody )
    sceneGroup:insert(spike23)

    local spike24 = display.newImageRect( "Images/Spike.png", 25, 18 )
    spike24.myName = "Spike24"
    spike24.x = CenterX + 65
    spike24.y = CenterY + 91
    spike24.rotation = 0
    physics.addBody( spike24, "dynamic", spikeBody )
    sceneGroup:insert(spike24)
    
--------------------------------------------------------------------------------------------------------

    local pivotpoint2 = display.newRect( CenterX, CenterY, 0, 0 )
    pivotpoint2.x = CenterX
    pivotpoint2.y = CenterY
    pivotpoint2.rotation = 0
    physics.addBody( pivotpoint2,"kinematic", pivotBody)
    sceneGroup:insert(pivotpoint2)

------------------------------------------------------------------------------------------------------------


    local plat1 = display.newImageRect( "Images/Platform.png", 202, 26 )
    plat1.myName = "Plat1"
    plat1.x = CenterX
    plat1.y = CenterY + 88
    plat1.rotation = 0
    physics.addBody( plat1, "dynamic", platBody)
    sceneGroup:insert(plat1)
    

    local plat2 = display.newImageRect( "Images/Platform.png", 202, 26 )
    plat2.myName = "Plat2"
    plat2.x = CenterX 
    plat2.y = CenterY - 88
    plat2.rotation = 0
    physics.addBody( plat2, "dynamic", platBody)
    sceneGroup:insert(plat2)
    

    local plat3 = display.newImageRect( "Images/Platform.png", 150, 26 )
    plat3.myName = "Plat3"
    plat3.x = CenterX + 88
    plat3.y = CenterY
    plat3.rotation = 90
    physics.addBody( plat3, "dynamic", platBody)
    sceneGroup:insert(plat3)
    

    local plat4 = display.newImageRect( "Images/Platform.png", 150, 26 )
    plat4.myName = "Plat4"
    plat4.x = CenterX - 88
    plat4.y = CenterY
    plat4.rotation = 90
    physics.addBody( plat4, "dynamic", platBody)
    sceneGroup:insert(plat4)
    



---------------------------------------------------------------------------------------------------------------

    local pivotJoint1 = physics.newJoint( "pivot", pivotpoint, plat1, plat1.x, plat1.y )
    pivotJoint1.isLimitEnabled = true
    pivotJoint1.isMotorEnabled = true
    pivotJoint1.maxMotorForce = 100

    local pivotJoint2 = physics.newJoint( "pivot", pivotpoint, plat2, plat2.x, plat2.y )
    pivotJoint2.isLimitEnabled = true
    pivotJoint2.isMotorEnabled = true
    pivotJoint2.maxMotorForce = 100

    local pivotJoint3 = physics.newJoint( "pivot", pivotpoint, plat3, plat3.x, plat3.y )
    pivotJoint3.isLimitEnabled = true
    pivotJoint3.isMotorEnabled = true
    pivotJoint3.maxMotorForce = 100

    local pivotJoint4 = physics.newJoint( "pivot", pivotpoint, plat4, plat4.x, plat4.y )
    pivotJoint4.isLimitEnabled = true
    pivotJoint4.isMotorEnabled = true
    pivotJoint4.maxMotorForce = 100

---------------------------------------------------------------------------------------------------------------


---------------------------------------------------------------------------------------------------------------

	

    local pistonJoint1 = physics.newJoint( "piston", pivotpoint2, spike1, spike1.x, spike1.y, -1, 0 )
    pistonJoint1.isLimitEnabled = true
    pistonJoint1.isMotorEnabled = true
    pistonJoint1.maxMotorForce = 1000

    local pistonJoint2 = physics.newJoint( "piston", pivotpoint2, spike2, spike2.x, spike2.y, 1, 0 )
    pistonJoint2.isLimitEnabled = true
    pistonJoint2.isMotorEnabled = true
    pistonJoint2.maxMotorForce = 1000

    local pistonJoint3 = physics.newJoint( "piston", pivotpoint2, spike3, spike3.x, spike3.y, 0, -1 )
    pistonJoint3.isLimitEnabled = true
    pistonJoint3.isMotorEnabled = true
    pistonJoint3.maxMotorForce = 1000

    local pistonJoint4 = physics.newJoint( "piston", pivotpoint2, spike4, spike4.x, spike4.y, 0, 1 )
    pistonJoint4.isLimitEnabled = true
    pistonJoint4.isMotorEnabled = true
    pistonJoint4.maxMotorForce = 1000

    local pistonJoint5 = physics.newJoint( "piston", pivotpoint2, spike5, spike5.x, spike5.y, -1, 0 )
    pistonJoint5.isLimitEnabled = true
    pistonJoint5.isMotorEnabled = true
    pistonJoint5.maxMotorForce = 1000

    local pistonJoint6 = physics.newJoint( "piston", pivotpoint2, spike6, spike6.x, spike6.y, 1, 0 )
    pistonJoint6.isLimitEnabled = true
    pistonJoint6.isMotorEnabled = true
    pistonJoint6.maxMotorForce = 1000

    local pistonJoint7 = physics.newJoint( "piston", pivotpoint2, spike7, spike7.x, spike7.y, 0, -1 )
    pistonJoint7.isLimitEnabled = true
    pistonJoint7.isMotorEnabled = true
    pistonJoint7.maxMotorForce = 1000

    local pistonJoint8 = physics.newJoint( "piston", pivotpoint2, spike8, spike8.x, spike8.y, 0, 1 )
    pistonJoint8.isLimitEnabled = true
    pistonJoint8.isMotorEnabled = true
    pistonJoint8.maxMotorForce = 1000

    local pistonJoint9 = physics.newJoint( "piston", pivotpoint2, spike9, spike9.x, spike9.y, 0, 1 )
    pistonJoint9.isLimitEnabled = true
    pistonJoint9.isMotorEnabled = true
    pistonJoint9.maxMotorForce = 1000

    local pistonJoint10 = physics.newJoint( "piston", pivotpoint2, spike10, spike10.x, spike10.y, 0, 1 )
    pistonJoint10.isLimitEnabled = true
    pistonJoint10.isMotorEnabled = true
    pistonJoint10.maxMotorForce = 1000

    local pistonJoint11 = physics.newJoint( "piston", pivotpoint2, spike11, spike11.x, spike11.y, 0, 1 )
    pistonJoint11.isLimitEnabled = true
    pistonJoint11.isMotorEnabled = true
    pistonJoint11.maxMotorForce = 1000

    local pistonJoint12 = physics.newJoint( "piston", pivotpoint2, spike12, spike12.x, spike12.y, 0, 1 )
    pistonJoint12.isLimitEnabled = true
    pistonJoint12.isMotorEnabled = true
    pistonJoint12.maxMotorForce = 1000    

    local pistonJoint13 = physics.newJoint( "piston", pivotpoint2, spike13, spike13.x, spike13.y, -1, 0 )
    pistonJoint13.isLimitEnabled = true
    pistonJoint13.isMotorEnabled = true
    pistonJoint13.maxMotorForce = 1000    

    local pistonJoint14 = physics.newJoint( "piston", pivotpoint2, spike14, spike14.x, spike14.y, -1,0)
    pistonJoint14.isLimitEnabled = true
    pistonJoint14.isMotorEnabled = true
    pistonJoint14.maxMotorForce = 1000    

    local pistonJoint15 = physics.newJoint( "piston", pivotpoint2, spike15, spike15.x, spike15.y, -1,0 )
    pistonJoint15.isLimitEnabled = true
    pistonJoint15.isMotorEnabled = true
    pistonJoint15.maxMotorForce = 1000    

    local pistonJoint16 = physics.newJoint( "piston", pivotpoint2, spike16, spike16.x, spike16.y, -1,0 )
    pistonJoint16.isLimitEnabled = true
    pistonJoint16.isMotorEnabled = true
    pistonJoint16.maxMotorForce = 1000    

    local pistonJoint17 = physics.newJoint( "piston", pivotpoint2, spike17, spike17.x, spike17.y, 1,0 )
    pistonJoint17.isLimitEnabled = true
    pistonJoint17.isMotorEnabled = true
    pistonJoint17.maxMotorForce = 1000    

    local pistonJoint18 = physics.newJoint( "piston", pivotpoint2, spike18, spike18.x, spike18.y, 1,0 )
    pistonJoint18.isLimitEnabled = true
    pistonJoint18.isMotorEnabled = true
    pistonJoint18.maxMotorForce = 1000    

    local pistonJoint19 = physics.newJoint( "piston", pivotpoint2, spike19, spike19.x, spike19.y, 1,0 )
    pistonJoint19.isLimitEnabled = true
    pistonJoint19.isMotorEnabled = true
    pistonJoint19.maxMotorForce = 1000    

    local pistonJoint20 = physics.newJoint( "piston", pivotpoint2, spike20, spike20.x, spike20.y, 1,0 )
    pistonJoint20.isLimitEnabled = true
    pistonJoint20.isMotorEnabled = true
    pistonJoint20.maxMotorForce = 1000 

    local pistonJoint21 = physics.newJoint( "piston", pivotpoint2, spike21, spike21.x, spike21.y, 0, -1 )
    pistonJoint21.isLimitEnabled = true
    pistonJoint21.isMotorEnabled = true
    pistonJoint21.maxMotorForce = 1000

    local pistonJoint22 = physics.newJoint( "piston", pivotpoint2, spike22, spike22.x, spike22.y, 0, -1 )
    pistonJoint22.isLimitEnabled = true
    pistonJoint22.isMotorEnabled = true
    pistonJoint22.maxMotorForce = 1000

    local pistonJoint23 = physics.newJoint( "piston", pivotpoint2, spike23, spike23.x, spike23.y, 0, -1 )
    pistonJoint23.isLimitEnabled = true
    pistonJoint23.isMotorEnabled = true
    pistonJoint23.maxMotorForce = 1000

    local pistonJoint24 = physics.newJoint( "piston", pivotpoint2, spike24, spike24.x, spike24.y, 0, -1 )
    pistonJoint24.isLimitEnabled = true
    pistonJoint24.isMotorEnabled = true
    pistonJoint24.maxMotorForce = 1000





    	pistonJoint1:setLimits( 0, 20 )
    	pistonJoint2:setLimits( 0, 20 )
    	pistonJoint3:setLimits( 0, 20 )
    	pistonJoint4:setLimits( 0, 20 )
    	pistonJoint5:setLimits( 0, 20 )
    	pistonJoint6:setLimits( 0, 20 )
    	pistonJoint7:setLimits( 0, 20 )
    	pistonJoint8:setLimits( 0, 20 )
    	pistonJoint9:setLimits( 0, 20 )
		pistonJoint10:setLimits( 0, 20 )
		pistonJoint11:setLimits( 0, 20 )
		pistonJoint12:setLimits( 0, 20 )
		pistonJoint13:setLimits( 0, 20 )
		pistonJoint14:setLimits( 0, 20 )
		pistonJoint15:setLimits( 0, 20 )
		pistonJoint16:setLimits( 0, 20 )
		pistonJoint17:setLimits( 0, 20 )
		pistonJoint18:setLimits( 0, 20 )
		pistonJoint19:setLimits( 0, 20 )
		pistonJoint20:setLimits( 0, 20 )
		pistonJoint21:setLimits( 0, 20 )
		pistonJoint22:setLimits( 0, 20 )
		pistonJoint23:setLimits( 0, 20 )
		pistonJoint24:setLimits( 0, 20 )

    	pistonJoint1.motorSpeed = -100 
    	pistonJoint2.motorSpeed = -100
    	pistonJoint3.motorSpeed = -100
    	pistonJoint4.motorSpeed = -100
    	pistonJoint5.motorSpeed = -100
    	pistonJoint6.motorSpeed = -100
    	pistonJoint7.motorSpeed = -100
    	pistonJoint8.motorSpeed = -100
    	pistonJoint9.motorSpeed = -100
    	pistonJoint10.motorSpeed = -100
    	pistonJoint11.motorSpeed = -100
    	pistonJoint12.motorSpeed = -100
    	pistonJoint13.motorSpeed = -100
    	pistonJoint14.motorSpeed = -100
    	pistonJoint15.motorSpeed = -100
    	pistonJoint16.motorSpeed = -100
    	pistonJoint17.motorSpeed = -100    	
    	pistonJoint18.motorSpeed = -100
    	pistonJoint19.motorSpeed = -100
    	pistonJoint20.motorSpeed = -100
    	pistonJoint21.motorSpeed = -100
    	pistonJoint22.motorSpeed = -100
    	pistonJoint23.motorSpeed = -100
    	pistonJoint24.motorSpeed = -100

    local function pistonlimitfunc(a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16, a17, a18, a19, a20, a21, a22, a23, a24)

    	pistonJoint1:setLimits( 0, a1 )
    	pistonJoint2:setLimits( 0, a2 )
    	pistonJoint3:setLimits( 0, a3 )
    	pistonJoint4:setLimits( 0, a4 )
    	pistonJoint5:setLimits( 0, a5 )
    	pistonJoint6:setLimits( 0, a6 )
    	pistonJoint7:setLimits( 0, a7 )
    	pistonJoint8:setLimits( 0, a8 )
    	pistonJoint9:setLimits( 0, a9 )
    	pistonJoint10:setLimits( 0, a10 )
    	pistonJoint11:setLimits( 0, a11 )
    	pistonJoint12:setLimits( 0, a12 )
    	pistonJoint13:setLimits( 0, a13 )
    	pistonJoint14:setLimits( 0, a14 )
    	pistonJoint15:setLimits( 0, a15 )
    	pistonJoint16:setLimits( 0, a16 )
    	pistonJoint17:setLimits( 0, a17 )    	
    	pistonJoint18:setLimits( 0, a18 )
    	pistonJoint19:setLimits( 0, a19 )
    	pistonJoint20:setLimits( 0, a20 )
    	pistonJoint20:setLimits( 0, a21 )
    	pistonJoint20:setLimits( 0, a22 )
    	pistonJoint20:setLimits( 0, a23 )
    	pistonJoint20:setLimits( 0, a24 )    	

    end

	local speedup = 100;

	local random1 = {}

	random1[0] = -1
	random1[1] = -1
	random1[2] = -1
	random1[3] = -1
	random1[4] = 1

	local randinterval = 4;


	--print( random1[math.random(0,1)] )
	 
	 
    local function pistonextenfunc(a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16, a17, a18, a19, a20, a21, a22, a23, a24)
    	
    	if score >= 100 then
    		random1[0] = -1
			random1[1] = -1
			random1[2] = 1
			random1[3] = 1
			random1[4] = 1
    	elseif score >= 10 then
    		random1[0] = -1
			random1[1] = -1
			random1[2] = -1
			random1[3] = 1
			random1[4] = 1
    	end


	    if a1 == -100 then	
	    	pistonJoint1.motorSpeed = a1
	    else
			pistonJoint1.motorSpeed = a1 * random1[math.random(0,randinterval)]
	    end	


	    if a2 == -100 then 
	    	pistonJoint2.motorSpeed = a2
	    else	
	    	pistonJoint2.motorSpeed = a2 * random1[math.random(0,randinterval)]
	    end	


	    if a3 == -100 then 
	    	pistonJoint3.motorSpeed = a3
	    else	
	    	pistonJoint3.motorSpeed = a3 * random1[math.random(0,randinterval)]
	    end


	    if a4 == -100 then
	    	pistonJoint4.motorSpeed = a4
	    else
	    	pistonJoint4.motorSpeed = a4 * random1[math.random(0,randinterval)] 
	    end


	    if a5 == -100 then
	    	pistonJoint5.motorSpeed = a5
	    else
	    	pistonJoint5.motorSpeed = a5 * random1[math.random(0,randinterval)]
	    end


	    if a6 == -100 then
	    	pistonJoint6.motorSpeed = a6
	    else 
	    	pistonJoint6.motorSpeed = a6 * random1[math.random(0,randinterval)]
	    end


	    if a7 == -100 then
	    	pistonJoint7.motorSpeed = a7
	    else
	    	pistonJoint7.motorSpeed = a7 * random1[math.random(0,randinterval)]
	    end


	    if a8 == -100 then
	    	pistonJoint8.motorSpeed = a8	
	    else 
	    	pistonJoint8.motorSpeed = a8 * random1[math.random(0,randinterval)]
	    end


	    if a9 == -100 then
	    	pistonJoint9.motorSpeed = a9
	    else
	    	pistonJoint9.motorSpeed = a9 * random1[math.random(0,randinterval)]
	    end


	    if a10 == -100 then
	    	pistonJoint10.motorSpeed = a10
	    else
	    	pistonJoint10.motorSpeed = a10 * random1[math.random(0,randinterval)]
		end	    	


		if a11 == -100 then
			pistonJoint11.motorSpeed = a11
		else
			pistonJoint11.motorSpeed = a11 * random1[math.random(0,randinterval)]
		end


		if a12 == -100 then
	    	pistonJoint12.motorSpeed = a12
	    else
	    	pistonJoint12.motorSpeed = a12 * random1[math.random(0,randinterval)]
	    end


	    if a13 == -100 then
	    	pistonJoint13.motorSpeed = a13
	    else
	    	pistonJoint13.motorSpeed = a13 * random1[math.random(0,randinterval)]
	    end



	    if a14 == -100 then
	    	pistonJoint14.motorSpeed = a14
	    else
	    	pistonJoint14.motorSpeed = a14 * random1[math.random(0,randinterval)]
	    end


	    if a15 == -100 then
	    	pistonJoint15.motorSpeed = a15
	    else
	    	pistonJoint15.motorSpeed = a15 * random1[math.random(0,randinterval)]
		end
	    

		if a16 == -100 then
	    	pistonJoint16.motorSpeed = a16
	    else
	    	pistonJoint16.motorSpeed = a16 * random1[math.random(0,randinterval)]
	    end


	    if a17 == -100 then
	    	pistonJoint17.motorSpeed = a17
	    else
	    	pistonJoint17.motorSpeed = a17 * random1[math.random(0,randinterval)]
	    end


	    if a18 == -100 then
	    	pistonJoint18.motorSpeed = a18
	    else
	    	pistonJoint18.motorSpeed = a18 * random1[math.random(0,randinterval)]
	    end


	    if a19 == -100 then
	    	pistonJoint19.motorSpeed = a19
	    else
	    	pistonJoint19.motorSpeed = a19 * random1[math.random(0,randinterval)]
	    end


	    if a20 == -100 then
	    	pistonJoint20.motorSpeed = a20
	    else
			pistonJoint20.motorSpeed = a20 * random1[math.random(0,randinterval)]
	    end


	    if a21 == -100 then
	    	pistonJoint21.motorSpeed = a21
	   	else
	     	pistonJoint21.motorSpeed = a21* random1[math.random(0,randinterval)]
	    end


	    if a22 == -100 then
	    	pistonJoint22.motorSpeed = a22
	   	else
	     	pistonJoint22.motorSpeed = a22* random1[math.random(0,randinterval)]
	    end

	    if a23 == -100 then
	    	pistonJoint23.motorSpeed = a23
	   	else
	     	pistonJoint23.motorSpeed = a23* random1[math.random(0,randinterval)]
	    end


	    if a24 == -100 then
	    	pistonJoint24.motorSpeed = a24
	   	else
	     	pistonJoint24.motorSpeed = a24* random1[math.random(0,randinterval)]
	    end



    	if speedup <= 200 then
    		speedup= speedup + .5
    	end
    	
    end

---------------------------------------------------------------------------------------------------------------
--[[
bottom --- 1
top    --- 2
right  --- 3
left   --- 4

pistonJoint1 --3
pistonJoint2 --4
pistonJoint3 --1
pistonJoint4 --2
pistonJoint5 --3
pistonJoint6 --4
pistonJoint7 --1
pistonJoint8 --2
]]--
------------------------------    





local value = 0;

local lastpos = 0;

local object = display.newCircle( display.contentCenterX, display.contentCenterY, display.contentHeight*2 )
object.alpha = 0
object.isHitTestable = true
sceneGroup:insert(object)


local side = 0;


local function pistonextender()
	if side == 1 then
		addscore()
		--print("side111")
		pistonlimitfunc(20, 20, 0, 20, 20, 20, 0, 20, 20, 20, 20, 20,20,20,20,20,20,20,20,20,0,0,0,0)
		pistonextenfunc(100, 100, -100, 100, 100, 100, -100, 100, 100, 100, 100, 100,100,100,100,100,100,100,100,100,-100,-100,-100,-100)
	elseif side == 2 then
		addscore()
		--print("side222")
		pistonlimitfunc(20, 20, 20, 0, 20, 20, 20, 0, 0, 0, 0, 0,20,20,20,20,20,20,20,20,20,20,20,20)
		pistonextenfunc(100, 100, 100, -100, 100, 100, 100, -100,-100,-100,-100,-100,100,100,100,100,100,100,100,100,100,100,100,100)
	elseif side == 3 then
		addscore()
		--print("side333")
		pistonlimitfunc(0, 20, 20, 20, 0, 20, 20, 20,20,20,20,20,0,0,0,0,20,20,20,20,20,20,20,20)
		pistonextenfunc(-100, 100, 100, 100, -100, 100, 100, 100, 100, 100, 100, 100,-100,-100,-100,-100,100,100,100,100,100,100,100,100)	
	elseif side == 4 then		
		addscore()
		--print("side444")
		pistonlimitfunc(20, 0, 20, 20, 20, 0, 20, 20,20,20,20,20,20,20,20,20,0,0,0,0,20,20,20,20)
		pistonextenfunc(100, -100, 100, 100, 100, -100, 100, 100, 100, 100, 100, 100,100,100,100,100,-100,-100,-100,-100,100,100,100,100)			
	end
end




 
local function handleSwipe( event )
		
		value = event.x-event.xStart;
		--print(pistonlimit)
		direction = lastpos/4 + value/4;


	     --print("the value is:".." "..value.." ; "..event.x.." "..event.xStart)

	     if event.phase == "ended" or event.phase == "cancelled" then
	     	if value ~= 0 then
	     		
	     		lastpos = lastpos + value
	     		--print("lastpos".." ".. lastpos)


	 		end
	 	end
    return true
end
 
object:addEventListener( "touch", handleSwipe )










    function rotate()

		pivotpoint2.rotation = direction;
		pivotpoint.rotation = direction;
    end
  local rotateT = timer.performWithDelay( .1, rotate, -1)



---------------------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------------------
    local function force(x,y)
        --ball:applyForce( 0, .1, ball.x, ball.y )

    	ball:setLinearVelocity( speedup*x, speedup*y )

    end

    --timer.performWithDelay( 1, force, 1 )
    --ball:applyForce( 0, .2, ball.x, ball.y )







---------------------------------------------------------------------------------------------------------------

    -- function sep2()
    --     print("-------------------------")
    -- end
    -- timer.performWithDelay( 500, sep2, -1 )

---------------------------------------------------------------------------------------------------------------


	-- Create the particle system
	local particleSystem = physics.newParticleSystem{
	    filename = "Images/particle2.png",
	    radius = 5.75,
	    imageRadius = 4.5
	}


	-- Paramaters for particle faucet
	local particleParams =
	{
	    flags = "water",
	    linearVelocityX = 0,
	    linearVelocityY = 0,
	    color = { 0, 0, 0, 1 },
	    x = ball.x,
	    y = ball.y,
	    lifetime = 100000.0,
	    radius = 30,
	}
	sceneGroup:insert(particleSystem)

	local shakeamount = 30;
	local sceneGrouporiginalX = sceneGroup.x;
	local sceneGrouporiginalY = sceneGroup.y;
    local function shakescreen()
		if shakeamount > 0 then
		    local shake = math.random( shakeamount )
		    sceneGroup.x = sceneGrouporiginalX + math.random( -shake, shake )
		    sceneGroup.y = sceneGrouporiginalY + math.random( -shake, shake )
		    shakeamount = shakeamount - 1
		end
	end

	--repositions everything
	local function shakefix()
		sceneGroup.x = sceneGrouporiginalX
		sceneGroup.y = sceneGrouporiginalY
	end

    local whiteoverlay = display.newRect(display.contentCenterX,display.contentCenterY, display.actualContentWidth*2.5, display.actualContentHeight*2.5)
    whiteoverlay:setFillColor(1,1,1)
    whiteoverlay.alpha = 0
    sceneGroup:insert(whiteoverlay)

    local function screenflash()
    	whiteoverlay.alpha = 1
		transition.to( whiteoverlay, { time=700, alpha=0} )
  	end

	-- Generate particles on repeating timer
	local function deathanim()
		screenflash()
		timer.performWithDelay(40, shakescreen, 15)
		timer.performWithDelay(800, shakefix)
		particleSystem:createGroup( particleParams )
		ball.alpha = 0
		emitter.alpha = 0
		ball.isBodyActive = false
		physics.setGravity( 0, 6 )


	end






	local counterr = 0
    local function finish()
        --physics.pause()
       -- timer.cancel(hue)
       -- timer.cancel(rotateT)
       -- timer.cancel(spikeT)
        --Finished = true
        counterr = counterr + 1
        if counterr == 2 then
        	particleParams.x = ball.x
        	particleParams.y = ball.y
      	 	timer.performWithDelay(1, deathanim)

       	end
        print("spike!!!")

    end





    n = 0

    local function onLocalCollision( self, event )
        if event.other.myName == "Spike1" or event.other.myName == "Spike2" or event.other.myName == "Spike3" or event.other.myName == "Spike4" or event.other.myName == "Spike5" or event.other.myName == "Spike6" or event.other.myName == "Spike7" or event.other.myName == "Spike8" or event.other.myName == "Spike9" or event.other.myName == "Spike10" or event.other.myName == "Spike11" or event.other.myName == "Spike12" or event.other.myName == "Spike13" or event.other.myName == "Spike14" or event.other.myName == "Spike15" or event.other.myName == "Spike16" or event.other.myName == "Spike17" or event.other.myName == "Spike18" or event.other.myName == "Spike19" or event.other.myName == "Spike20" or event.other.myName == "Spike21" or event.other.myName == "Spike22" or event.other.myName == "Spike23" or event.other.myName == "Spike24" then
            finish()
        	
        elseif event.other.myName == "Plat1" then
         -- print("Plat111 hit")
			 
			--print(math.round(( math.sin( (direction-90)*(math.pi/180) ) )*1000)/1000 )
         	side = 1;
        	pistonextender() 	
         	force(math.round(( math.cos( (direction-90)*(math.pi/180) ) )*1000)/1000 ,math.round(( math.sin( (direction-90)*(math.pi/180) ) )*1000)/1000)
        elseif event.other.myName == "Plat2" then
           -- print("Plat222 hit")
           side = 2;
           pistonextender()
           --print(math.round(( math.cos( (direction+90)*(math.pi/180) ) )*1000)/1000 )
           force(math.round(( math.cos( (direction+90)*(math.pi/180) ) )*1000)/1000 ,math.round(( math.sin( (direction+90)*(math.pi/180) ) )*1000)/1000 )
        elseif event.other.myName == "Plat3" then
           --print("Plat333 hit")
           --print(math.round(( math.cos( (direction-180)*(math.pi/180) ) )*1000)/1000 )
           side = 3;
           pistonextender()
           force(math.round(( math.cos( (direction-180)*(math.pi/180) ) )*1000)/1000 ,math.round(( math.sin( (direction-180)*(math.pi/180) ) )*1000)/1000 )
        elseif event.other.myName == "Plat4" then
           -- print("Plat444 hit")
           side = 4;
           pistonextender()
           --print(math.round(( math.cos( (direction)*(math.pi/180) ) )*1000)/1000 )
           force(math.round(( math.cos( (direction)*(math.pi/180) ) )*1000)/1000 , math.round(( math.sin( (direction)*(math.pi/180) ) )*1000)/1000 )
        end


	     if event.phase == "ended" or event.phase == "cancelled" then
	 	end



    end
    ball.collision = onLocalCollision
    ball:addEventListener( "collision" )
---------------------------------------------------------------------------------------------------------------
    

---------------------------------------------------------------------------------------------------------------


    local blackoverlay = display.newRect(display.contentCenterX,display.contentCenterY, display.actualContentWidth*2.5, display.actualContentHeight*2.5)
    blackoverlay:setFillColor(0,0,0)
    blackoverlay.alpha = 0
	sceneGroup:insert(blackoverlay)







	local function handleButtonEvent4( event )
	 
	    if ( "ended" == event.phase ) then
 			composer.gotoScene( "Menu2" )
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
	menuButton.x = CenterX - 60
	menuButton.y = CenterY
	menuButton.alpha = 0
	sceneGroup:insert(menuButton)

























	local function handleButtonEvent3( event )
	 
	    if ( "ended" == event.phase ) then
 			composer.gotoScene( "restartfile" )
	    end
	end
	 									

	local retryButton = widget.newButton(
	    {
	        width = 50,
	        height = 50,
	        defaultFile = "Images/retry.png",
	        overFile = "Images/retryHOVER.png",
	        onEvent = handleButtonEvent3
	    }
	)

	-- Center the button
	retryButton.x = CenterX
	retryButton.y = CenterY
	retryButton.alpha = 0
	sceneGroup:insert(retryButton)













	local function handleButtonEvent2( event )
	 
	    if ( "ended" == event.phase ) then
	    		hideplaybutton()
                menuButton.alpha = 0
                retryButton.alpha = 0
        		showpausebutton()				
       	  		emitter:start()
                physics.start()
                timer.resume(countdowntimer)
                timer.resume(hue)
                blackoverlay.alpha = 0
	    end
	end
	 									

	local playButton = widget.newButton(
	    {
	        width = 50,
	        height = 50,
	        defaultFile = "Images/play.png",
	        overFile = "Images/playHOVER.png",
	        onEvent = handleButtonEvent2
	    }
	)

	function hideplaybutton()
        playButton.alpha = 0
	end
	-- Center the button
	playButton.x = CenterX + 60
	playButton.y = CenterY
	playButton.alpha = 0
	sceneGroup:insert(playButton)






	local function handleButtonEvent1( event )
	 
	    if ( "ended" == event.phase ) then
                playButton.alpha = 1
                menuButton.alpha = 1
                retryButton.alpha = 1
     			hidepausebutton()    		
         		emitter:pause()
         		timer.pause(countdowntimer)
				timer.pause(hue)
                physics.pause()
                blackoverlay.alpha = .5
	    end
	end
	 

	local pauseButton = widget.newButton(
	    {
	        width = 40,
	        height = 40,
	        defaultFile = "Images/pause.png",
	        overFile = "Images/pauseHOVER.png",
	        onEvent = handleButtonEvent1
	    }
	)
	function hidepausebutton()
		pauseButton.alpha = 0
	end
	function showpausebutton()
		pauseButton.alpha = 1
	end	
	-- Center the button
	pauseButton.x = display.contentCenterX + (display.actualContentWidth/2) - 30;
	pauseButton.y = display.contentCenterY - (display.actualContentHeight/2) + 30;
	sceneGroup:insert(pauseButton)




















end

---------------------------------------------------------------------------------------------------------------
 

 


-- show()
function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then

    elseif ( phase == "did" ) then

    end
end


-- hide()
function scene:hide( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        
    elseif ( phase == "did" ) then
        --print("it worked")
        Runtime:removeEventListener( "enterFrame", trail )
        transition.cancel( transBHU )
        transition.cancel( transBH )
        transition.cancel( transIHU )
        transition.cancel( transIH )
        transition.cancel( inhoopback )
        transition.cancel( backhoopback )
        transition.cancel( inhoopout )
        transition.cancel( backhoopout )

       -- composer.removeScene( "scene1" ) 

    end
end


-- destroy()
function scene:destroy( event )

    local sceneGroup = self.view
    Runtime:removeEventListener( "enterFrame", trail )
end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene

