local Hexagon = {}
Hexagon.__index = Hexagon -- failed table lookups on the instances should fallback to the class table, to get methods

local generate_points = function(self)
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