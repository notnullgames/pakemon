--- drawing utils for make a FF4ish RPG menu-type screen

local SoundMove = love.audio.newSource("modules/rpg_look/assets/move.wav", "static")
local SoundAction = love.audio.newSource("modules/rpg_look/assets/action.wav", "static")
local SoundSelect = love.audio.newSource("modules/rpg_look/assets/select.wav", "static")

local pointer =  love.graphics.newImage('modules/rpg_look/assets/pointer.png')

local faces = {}
for i=1,16 do
    table.insert(faces, love.graphics.newImage("modules/rpg_look/assets/person".. i ..".png"))
end

local RpgLook = {}

function RpgLook:load()
end

-- draw pointer for current person or action
function RpgLook:drawPointer(x, y)
    love.graphics.draw(pointer, x, y)
end

-- play the menu-move sound
function RpgLook:soundMove()
    SoundMove:stop()
    SoundMove:play()
end

-- play the menu-action sound
function RpgLook:soundAction()
    SoundAction:stop()
    SoundAction:play()
end

-- play the menu-select sound
function RpgLook:soundSelect()
    SoundSelect:stop()
    SoundSelect:play()
end

-- draw a face, based on index
function RpgLook:drawFace(index, x, y, sx, sy)
    love.graphics.draw(faces[(index % #faces) + 1], x, y, 0, sx, sy)
end

-- draw a blue box with white outline
function RpgLook:drawBox(x, y, width, height, fillcolor, outlinecolor)
    fillcolor = fillcolor or { 0.039, 0, 0.39, 1 }
    outlinecolor = outlinecolor or { 0.8, 0.8, 0.8, 1 }
    love.graphics.setLineWidth(2)
    love.graphics.setColor(fillcolor)
    love.graphics.rectangle("fill", x, y, width, height)
    love.graphics.setColor(outlinecolor)
    love.graphics.rectangle("line", x, y, width, height)
end

return RpgLook