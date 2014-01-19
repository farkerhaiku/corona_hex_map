module(..., package.seeall)

function suite_setup()
  Hexagon = require("hexagon")
end

function test_isNotNull()
   assert_not_nil(Hexagon.new)
end

function test_cube_coordinates_generated()
--    assert_true(first:equals(second))
end
