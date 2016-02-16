local physics = require("physics")
--physics.setDrawMode("hybrid")
local screenWidth, screenHeight = display.contentWidth, display.contentHeight
local collisionFilter = { groupIndex = -1 }

function initBackground()
	local backgtound = display.newRect(screenWidth/2, screenHeight/2, screenWidth, screenHeight)
	backgtound:setFillColor(0.3, 0.2, 0.1)
end

function initPlatform()
	local platform1 = display.newRect(screenWidth/4, screenHeight*5/6, screenWidth/4, screenHeight/96)
	physics.addBody(platform1, "static", {bounce = 0.3})
	
	local platform2 = display.newRect(screenWidth*3/4, screenHeight*5/6, screenWidth/4, screenHeight/96)
	physics.addBody(platform2, "static", {bounce = 0.3})
end

function initObjectsPhysicOptions()
	physicOptions = {density = 4, frictions = 0.1, bounce = 0.4,
		filter = collisionFilter, radius = screenWidth/16}

	objects = {}
	objects[#objects + 1] = "res/nat.png"
	objects[#objects + 1] = "res/bomb.png"
end

function initObjectImpulse()
	leftImpulse = {}
	leftImpulse.startCoordinate = leftStartCordinate
	leftImpulse[1] = road1LeftImpulse
	leftImpulse[2] = road2LeftImpulse
	leftImpulse[3] = road3LeftImpulse
	
	rightImpulse = {}
	rightImpulse.startCoordinate = rightStartCoordinate
	rightImpulse[1] = road1RightImpulse
	rightImpulse[2] = road2RightImpulse
	rightImpulse[3] = road3RightImpulse
	
	impulse = {}
	impulse[1] = leftImpulse
	impulse[2] = rightImpulse
end

leftStartCordinate = function()
	return 0, screenHeight/4
end

rightStartCoordinate = function()
	return screenWidth, screenHeight/4
end

road1LeftImpulse = function()
	return 170, -140, 0, 0
end

road2LeftImpulse = function()
	return 300, 111, 0, 0
end

road1RightImpulse = function()
	return -170, -140, 0, 0
end

road2RightImpulse = function()
	return -300, 110, 0, 0
end

function pushObject()
	local objects = objects[math.random(2)]
	local impulseDirection = impulse[math.random(2)]
	
	local object = display.newImage(objects)
	object.width = screenWidth/8
	object.height = object.width
	object.x, object.y = impulseDirection.startCoordinate()
	
	physics.addBody(object, physicOptions)
	object:applyLinearImpulse(impulseDirection[math.random(2)]())
end

function main()
	physics.start()
	physics.setScale(45)
	initBackground()
	initPlatform()
	initObjectImpulse()
	initObjectsPhysicOptions()
	pushObject()
	timer.performWithDelay(500, pushObject, 0)
end

--run main
main()