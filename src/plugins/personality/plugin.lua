-- this is the main personality
-- override the functions and graphics in a plugin to make a new look

local PluginPersonality = Class { mood = "happy" }

StateShowMood = require "plugins.personality.state_show_mood"

local function demoHappy()
  plugins.personality:setMood("happy", "I found something cool")
end

local function demoSad()
  plugins.personality:setMood("sad", "no reason, no future")
end

local function demoNotifyShort()
  plugins.personality:notify("short notication")
end

local function demoNotifyLong()
  plugins.personality:notify("Es irrt der Mensch, wenn er gut gezogen, Wird selbst ein weiser Mann gewogen. Ich bin Ein Teil von jener Kraft, Die stets das Gute schafft. Es irrt der Mensch, wenn er sie beim Kragen hätte. Ich bin von je der Ordnung Freund gewesen. So schreitet in dem engen Bretterhaus (Theater, Bühne) Den ganzen Kreis der Schöpfung aus, Und wandelt mit bedächtger Schnelle Vom Himmel durch die Welt zur Hölle. Es irrt der Mensch, wenn er gut gezogen, Wird selbst ein weiser Mann gewogen. So schreitet in dem engen Bretterhaus (Theater, Bühne) Den ganzen Kreis der Schöpfung aus, Und wandelt mit bedächt'ger Schnelle Vom Himmel durch die Welt zur Hölle. Ich bin von je der Ordnung Freund gewesen. So schreitet in dem engen Bretterhaus (Theater, Bühne) Den ganzen Kreis der Schöpfung aus, Und wandelt mit bedächt'ger Schnelle Vom Himmel durch die Welt zur Hölle! Ich höre schon des Dorfs Getümmel, Hier ist des Volkes wahrer Himmel, Zufrieden jauchzet groß und klein, Hier bin ich nicht; doch viel ist mir bewusst. Es irrt der Mensch, wenn er gut gezogen, Wird selbst ein weiser Mann gewogen. Gewöhnlich glaubt der Mensch, wenn er sie beim Kragen hätte. Und wandelt mit bedächtger Schnelle Vom Himmel durch die Welt zur Hölle.")
end

local function demoNotifyMood()
  plugins.personality.mood = "excited"
  plugins.personality:notify("You found something, and it made me " ..  plugins.personality.mood .. ".")
end

-- this sets initial state of the class
function PluginPersonality:init()
  self.image = love.graphics.newImage("plugins/personality/wolfy-plus.png")
  self.image:setFilter('nearest', 'nearest')
  local g = anim8.newGrid(32, 32, self.image:getWidth(), self.image:getHeight())
  self.animations = {
    happy = anim8.newAnimation(g('1-6', 1), 0.5),
    excited = anim8.newAnimation(g('1-6', 2), 0.5),
    curious = anim8.newAnimation(g('1-6', 3), 0.5),
    lazy = anim8.newAnimation(g('1-6', 4), 0.5),
    sleepy = anim8.newAnimation(g('1-6', 5), 0.5),
    sad = anim8.newAnimation(g('1-6', 6), 0.5),
    runL= anim8.newAnimation(g('1-6', 7), 0.25),
    loading = anim8.newAnimation(g('1-6', 8), 0.5),
    error = anim8.newAnimation(g('1-6', 9), 0.5)
  }
end

-- this is called when the plugin is loaded
function PluginPersonality:load()
  plugins.menu.main:addItem("Your Pakémon", function() plugins.personality:setMood() end)
  
  plugins.menu.main:addItem("Set mood to happy", demoHappy, 2)
  plugins.menu.main:addItem("Set mood to sad", demoSad, 2)
  plugins.menu.main:addItem("Show a short notification", demoNotifyShort, 2)
  plugins.menu.main:addItem("Show a long notification", demoNotifyLong, 2)
  plugins.menu.main:addItem("Show a notification with new mood", demoNotifyMood, 2)
end

-- update the animation icon, in background
function PluginPersonality:update(dt)
  self.animations[self.mood]:update(dt)
end

-- draw current message overlay, if it applies
function PluginPersonality:draw()
  if self.message then
    local width, lines = FontBasic:getWrap(self.message, 270)
    local height = (FontBasic:getHeight(self.message) * #lines)
    love.graphics.setColor(1, 1, 1, 0.8)
    roundrect("fill", 5, 5, 310, height + 10, 10, 10)
    plugins.personality:drawMe(5, (height/2) - 4)
    love.graphics.printf({{0, 0, 0, 0.8}, self.message}, FontBasic, 40, 10, 270, "left")
  end
end

-- draw the current representation of the character
function PluginPersonality:drawMe(x, y)
  self.animations[self.mood]:draw(self.image, x, y)
end

-- optionally set, then display current mood, then come back to current-state
function PluginPersonality:setMood(mood, why)
  StateShowMood.oldGs = Gamestate.current()
  if mood then
    self.mood = mood
  end
  self.moodwhy = why or ""
  Gamestate.switch(StateShowMood)
  Timer.after(3, function() Gamestate.switch(StateShowMood.oldGs) end )
end

-- show a message overlayed on current screen
function PluginPersonality:notify(message)
  self.message = shortenText(message, 350)
  Timer.after(3, function() self.message = nil end )
end

return PluginPersonality()