local Hexagon = {}
Hexagon.__index = Hexagon -- failed table lookups on the instances should fallback to the class table, to get methods

local generate_points = function(self)
    local h = {}
    local center_x , center_y = 50, 50
    local x_i, y_i, i
    for i=1, 6 do
        local angle = 2 * math.pi / 6 * (i + 0.5)
        x_i = center_x + self.height * math.cos(angle)
        y_i = center_y + self.height * math.sin(angle)
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
    h.l  = (self.height / 2) / math.sin(45)
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
        print("huh?", self.x)
        self.displayObject:setFillColor(0, 1, 1)
    elseif event.phase == "ended" then
        self.displayObject:setFillColor(1, 1, 1)
    end
end

local new = function(x, y, height)
    local self = setmetatable({}, Hexagon)
    self.x = x
    self.y = y
    
    self.height = height
    self:generate_points()
    self.touch = touch
    
    return self
end
Hexagon.new = new

local draw = function(self)
    self.displayObject = display.newPolygon( self.height * self.x, self.height * self.y, self.vertices )
    self.displayObject.strokeWidth = 1
    self.displayObject:setStrokeColor( 0 )
    
    self.displayObject:addEventListener( "touch", self)
end
Hexagon.draw = draw

return Hexagon