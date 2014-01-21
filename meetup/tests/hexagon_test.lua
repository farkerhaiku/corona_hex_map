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

function test_axial_coordinates_distance_calculation()
    local first = Hexagon.new(1, 1, 30)
    local second = Hexagon.new(1, 2, 30)
    local third = Hexagon.new(1, 3, 30)
    local fourth = Hexagon.new(2, 3, 30)
    assert_equal(1, fourth.axialCoords.x)
    assert_equal(2, fourth.axialCoords.y)
    assert_equal(-3, fourth.axialCoords.z)
    assert_equal(1, first:distanceBetween(second), "distance between 0,0 and 0,1 should be 1")
    assert_equal(2, first:distanceBetween(third), "distance between 0,0 and 0,2 should be 2")
    assert_equal(3, first:distanceBetween(fourth), "distance between 0,0 and 1,2 should be 3")
end
