-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- hide the status bar
display.setStatusBar( display.HiddenStatusBar )

-- include the Corona "storyboard" module
local storyboard = require "storyboard"

require("libs.lunatest")

local function runTests()
    print("\n\n*********\n")
    lunatest.suite("tests.hexagon_test")
    lunatest.run()
    print("\n")
end
runTests()
print("\n\n*********\n")

-- load menu screen
storyboard.gotoScene( "menu" )