module(..., package.seeall)

function suite_setup()
  Hexagon = require("hexagon")
end

function test_isNotNull()
   assert_not_nil(Hexagon.new)
end

function test_cube_coordinates_generated()
    local first = Hexagon.new(1, 1, 30)
    local second = Hexagon.new(1, 2, 30)
    assert_true(first.cubeCoords.x == 0)
    assert_true(first.cubeCoords.y == 0)
    assert_true(second.cubeCoords.x == 0)
    assert_true(second.cubeCoords.y == 1)
end

function test_axial_coordinates_generated()
    local first = Hexagon.new(1, 1, 30)
    local second = Hexagon.new(1, 2, 30)
    assert_true(first.axialCoords.x == 0)
    assert_true(first.axialCoords.y == 0)
    assert_true(first.axialCoords.z == 0)
    assert_true(second.axialCoords.x == 0)
    assert_true(second.axialCoords.y == 1)
    assert_true(second.axialCoords.z == -1)
end
