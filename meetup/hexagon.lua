local Hexagon = {}
Hexagon.__index = Hexagon -- failed table lookups on the instances should fallback to the class table, to get methods
local abs = math.abs

local generate_points = function(self)
    local h = {}
    local x_i, y_i, i
    for i=1, 6 do
        local angle = 2 * math.pi / 6 * (i + 0.5)
        x_i = self.size * math.cos(angle)
        y_i = self.size * math.sin(angle)
        h[#h + 1] = x_i
        h[#h + 1] = y_i
    end
    
    self.vertices = {
        h[1],                 h[2],
        h[3],                 h[4],
        h[5],                 h[6],
        h[7],                 h[8],
        h[9],                 h[10],
        h[11],                h[12]
    }
end
-- pointy top hexagons
local generate_points_vertical = function(self)
    local h = {}
    h.l  = (self.size / 2) / math.sin(45)
    h.dX = math.cos(45) * h.l
    h.dY = math.sin(45) * h.l
    h.cX = h.dX + (h.l / 2)
    h.cY = h.dY
    self.vertices = {
        0,                 h.dY,
        h.dX,              0,
        h.dX + h.l,        0,
        h.dX + h.l + h.dX, h.dY,
        h.dX + h.l,        h.dY + h.dY,
        h.dX,              h.dY + h.dY
    }
end
Hexagon.generate_points = generate_points

local touch = function(self, event)
    if event.phase == "began" then
        self.displayObject:setFillColor(0, 1, 1)
    elseif event.phase == "ended" then
        self.displayObject:setFillColor(1, 1, 1)
    end
end
local generateCubeCoords = function(self, x, y)
    local cubeCoords = {}
    cubeCoords.x = x - 1
    cubeCoords.y = y - 1
    return cubeCoords
end
Hexagon.generateCubeCoords = generateCubeCoords

local generateAxialCoords = function(self, coords)
    local axialCoords = {}
    axialCoords.x = coords.x
    axialCoords.y = coords.y
    axialCoords.z = 0 - coords.x - coords.y
    return axialCoords
end
Hexagon.generateAxialCoords = generateAxialCoords

local distanceBetween = function(self, other)
    local foo = self.axialCoords
    local bar = other.axialCoords
    local xDiff = abs(bar.x - foo.x) 
    local yDiff = abs(bar.y - foo.y) 
    local zDiff = abs(bar.z - foo.z)
    local maxXY = (xDiff > yDiff) and xDiff or yDiff
    local maxYZ = (yDiff > zDiff) and yDiff or zDiff 
    return (maxXY > maxYZ) and maxXY or maxYZ
end
Hexagon.distanceBetween = distanceBetween

local generateCoordinates = function(self, x,y)
    self.cubeCoords = self:generateCubeCoords(x, y)
    self.axialCoords = self:generateAxialCoords(self.cubeCoords)
end
Hexagon.generateCoordinates = generateCoordinates

local new = function(x, y, size)
    local self = setmetatable({}, Hexagon)
    self.x = x
    self.y = y
    
    self.size = size
    self.height = size * 2
    self.width = math.sqrt(3)/2*self.height
    self:generate_points()
    self:generateCoordinates(x, y)
    self.touch = touch
    
    return self
end
Hexagon.new = new

local draw = function(self)
    local xCoord = self.width * self.x
    local vertOffset = self.size * 1/2 * (self.y-1)
    local yCoord = self.size * self.y + vertOffset
    
    if (self.y % 2 == 0) then
        xCoord = xCoord - self.width / 2
    end
    self.displayObject = display.newPolygon( xCoord, yCoord, self.vertices )
    self.displayObject.strokeWidth = 1
    self.displayObject:setStrokeColor( 0 )
    
    self.displayObject:addEventListener( "touch", self)
end
Hexagon.draw = draw

return Hexagon