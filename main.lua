local physics = require("physics")
local screenWidth, screenHeght = display.contentWidth, display.contentHeight
local redCollisionFilter = { categoryBits = 2, maskBits = 3 } -- collides with (2 & 1) only
local blueCollisionFilter = { categoryBits = 4, maskBits = 5 } -- collides with (4 & 1) only

local redBody = { density=0.2, friction=0, bounce=0.95, radius=43.0, filter=redCollisionFilter }
local blueBody = { density=0.2, friction=0, bounce=0.95, radius=43.0, filter=blueCollisionFilter }

function pushObjectFromLeftSide()
	local circle = display.newCircle(0, screenHeght/2, 10)
	circle:setFillColor(0.3, 0.7, 0.9)
	physics.addBody(circle, redBody)
	circle:applyLinearImpulse( 6, -10, 0, 0 )
end

function pushObjectFromRightSide()
	local circle = display.newCircle(screenWidth, screenHeght/2, 10)
	circle:setFillColor(0.9, 0.1, 0.9)
	physics.addBody(circle, blueBody)
	circle:applyLinearImpulse( -6, -10, 0, 0 )
end

function main()
	physics.start()
	timer.performWithDelay(1000, pushObjectFromLeftSide, 0)
	timer.performWithDelay(1000, pushObjectFromRightSide, 0)
end

--run main
main()