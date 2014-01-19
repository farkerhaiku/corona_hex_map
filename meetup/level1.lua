local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local Hexagon = require("hexagon")

local screenW, screenH, halfW = display.contentWidth, display.contentHeight, display.contentWidth*0.5

function scene:createScene( event )
	local group = self.view

	-- create a grey rectangle as the backdrop
	local background = display.newRect( 0, 0, screenW, screenH )
	background.anchorX = 0
	background.anchorY = 0
	background:setFillColor( .5 )
	
	group:insert( background )
	local hexes = {}
	local hexHeight = 20
	
	local hex = Hexagon.new(1, 1, hexHeight)
	local hexWidth = hex.width
	local maxHexesWidth = screenW / hexWidth
	local maxHexesHeight = screenH / (hexHeight *1.5)
	for j=1, maxHexesHeight do
    	for i=1, maxHexesWidth do
    	   hex = Hexagon.new(i, j, hexHeight)
    	   hex:draw()
    	   hexes[#hexes + 1] = hex
    	end
	end
end

function scene:enterScene( event )
	local group = self.view
end

function scene:exitScene( event )
	local group = self.view
end

function scene:destroyScene( event )
	local group = self.view
end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )
scene:addEventListener( "destroyScene", scene )

return scene