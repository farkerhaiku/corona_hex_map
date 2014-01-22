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
    assert_equal(0, first.cubeCoords.x)
    assert_equal(0, first.cubeCoords.y)
    assert_equal(-1, second.cubeCoords.x)
    assert_equal(1, second.cubeCoords.y)
end

function test_axial_coordinates_generated()
    local first = Hexagon.new(1, 1, 30)
    local second = Hexagon.new(1, 2, 30)
    assert_equal(0, first.axialCoords.x)
    assert_equal(0, first.axialCoords.y)
    assert_equal(0, first.axialCoords.z)
    assert_equal(-1, second.axialCoords.x, "1,2 should equal -1,1 in this coordinate system")
    assert_equal(1, second.axialCoords.y)
    assert_equal(0, second.axialCoords.z)
end

function test_axial_coordinates_distance_calculation_between_first_and_second()
    local first = Hexagon.new(1, 1, 30) -- 0,0
    local second = Hexagon.new(1, 2, 30) -- 0,1
    assert_equal(-1, second.axialCoords.x, "second x should be -1")
    assert_equal(1, second.axialCoords.y, "second y should be 1")
    assert_equal(0, second.axialCoords.z, "second z should be 0")
    assert_equal(1, first:distanceBetween(second), "distance between 0,0 and 0,1 should be 1")
end
function test_axial_coordinates_distance_calculation_between_first_and_third()
    local first = Hexagon.new(1, 1, 30) -- 0,0
    local third = Hexagon.new(1, 3, 30) -- -1,2
    assert_equal(-1, third.axialCoords.x, "third x should be -1") --see chart for explanation
    assert_equal(2, third.axialCoords.y, "third y should be 2")
    assert_equal(-1, third.axialCoords.z, "third z should be -1")
    
    assert_equal(2, first:distanceBetween(third), "distance between 0,0 and 0,2 should be 2")
end

function test_axial_coordinates_distance_calculation_between_first_and_fourth()
    local first = Hexagon.new(1, 1, 30) -- 0,0
    local fourth = Hexagon.new(2, 3, 30) -- 
    assert_equal(0, fourth.axialCoords.x, "fourth x should be 0")
    assert_equal(2, fourth.axialCoords.y, "fourth y should be 2")
    assert_equal(-2, fourth.axialCoords.z, "fourth z should be -2")
    assert_equal(2, first:distanceBetween(fourth), "distance between 0,0 and 0,2 should be 2")
end

function test_axial_coordinates_distance_calculation_between_first_and_fifth()
    local first = Hexagon.new(1, 1, 30) -- 0,0
    local fifth = Hexagon.new(4, 5, 30) -- 
    print("######*****####", fifth.someName)
    assert_equal(1, fifth.axialCoords.x, "fourth x should be 2")
    assert_equal(4, fifth.axialCoords.y, "fourth y should be 2")
    assert_equal(-5, fifth.axialCoords.z, "fourth z should be -5")
    assert_equal(5, first:distanceBetween(fifth), "distance between 0,0 and 2,3 should be 5")
end
