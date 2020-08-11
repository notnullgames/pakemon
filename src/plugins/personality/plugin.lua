-- this is the main personality
-- override the functions and graphics in a plugin to make a new look

local Personality = Class { mood = "happy" }

local StateShowMood = require "plugins.personality.mood"

-- shorten & elipsis text
local function shorten(s,w)
    local ellipsis = "…"
    local n_ellipsis = string.len(ellipsis)
    if string.len(s) > w then
        return s:sub(1,w-n_ellipsis) .. ellipsis
    end
    return s
end

-- create a rounded rectangle
local function roundrect(mode, x, y, width, height, xround, yround)
	local points = {}
	local precision = (xround + yround) * .1
	local invprec = 1/precision
	local tI, hP = table.insert, .5*math.pi
	if xround > width*.5 then xround = width*.5 end
	if yround > height*.5 then yround = height*.5 end
	local X1, Y1, X2, Y2 = x + xround, y + yround, x + width - xround, y + height - yround
	local sin, cos = math.sin, math.cos
	for i = 0, precision do
		local a = (i*invprec-1)*hP
		points[#points+1] = X2 + xround*cos(a)
		points[#points+1] = Y1 + yround*sin(a)
	end
	for i = 0, precision do
		local a = i*invprec*hP
		points[#points+1] = X2 + xround*cos(a)
		points[#points+1] = Y2 + yround*sin(a)
	end
	for i = 0, precision do
		local a = (i*invprec+1)*hP
		points[#points+1] = X1 + xround*cos(a)
		points[#points+1] = Y2 + yround*sin(a)
	end
	for i = 0, precision do
		local a = (i*invprec+2)*hP
		points[#points+1] = X1 + xround*cos(a)
		points[#points+1] = Y1 + yround*sin(a)
	end
	love.graphics.polygon(mode, unpack(points))
end

function Personality:init()
  self.image = love.graphics.newImage("plugins/personality/personality.png")
  self.image:setFilter('nearest', 'nearest')
  local g = anim8.newGrid(32, 32, self.image:getWidth(), self.image:getHeight())
  -- TODO: these are basically random. need some better anmimations.
  self.animations = {
    sad = anim8.newAnimation(g(7,5, 8,5, 9,5), 0.2),
    happy = anim8.newAnimation(g(4,5, 6,5), 0.2),
    curious = anim8.newAnimation(g(1,5, 2,5, 3,5), 0.2),
    excited = anim8.newAnimation(g(4,2, 5,1, 5,3, 6,1 ), 0.2),
  }
end

-- update the animation icon if it's showing
function Personality:update(dt)
  self.animations[self.mood]:update(dt)
end

-- draw current overlay, if it applies
function Personality:draw()
  if self.message then
    local width, lines = FontBasic:getWrap(self.message, 270)
    local height = (FontBasic:getHeight(self.message) * #lines)
    love.graphics.setColor(1, 1, 1, 0.8)
    roundrect("fill", 5, 5, 310, height + 10, 10, 10)
    personality:drawMe(5, (height/2) - 4)
    love.graphics.printf({{0, 0, 0, 0.8}, self.message}, FontBasic, 40, 10, 270, "left")
  end
end

-- draw the current representation of the character
function Personality:drawMe(x, y)
  self.animations[self.mood]:draw(self.image, x, y)
end

-- optionally set, then display current mood, then come back to current-state
function Personality:setMood(mood, why)
  local oldGs = Gamestate.current()
  if mood then
    self.mood = mood
  end
  self.moodwhy = why or ""
  Gamestate.switch(StateShowMood)
  Timer.after(3, function() Gamestate.switch(oldGs) end )
end

-- show a message overlayed on current screen
function Personality:notify(message)
  self.message = shorten(message, 350)
  Timer.after(3, function() self.message = nil end )
end

return Personality()