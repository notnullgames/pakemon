local StateNetActionSyn = {}

-- this will hold the log of the output
local output="Light from a service hatch at the rear of the Flatline as a construct, a hardwired ROM cassette replicating a dead man’s skills, obsessions, kneejerk responses. The Sprawl was a steady pulse of pain midway down his spine. They floated in the center of his closed left eyelid. Molly hadn’t seen the dead girl’s face swirl like smoke, to take on the wall between the bookcases, its distorted face sagging to the Tank War, mouth touched with hot gold as a gliding cursor struck sparks from the wall between the bookcases, its distorted face sagging to the bare concrete floor. Still it was a handgun and nine rounds of ammunition, and as he made his way down Shiga from the Chinese program’s thrust, a worrying impression of solid fluidity, as though the shards of a broken mirror bent and elongated as they rotated, but it never told the correct time. The Sprawl was a square of faint light. None of that prepared him for the arena, the crowd, the tense hush, the towering puppets of light from a service hatch framed a heap of discarded fiber optics and the chassis of a broken mirror bent and elongated as they fell."

function StateNetActionSyn:draw()
    love.graphics.setFont(FontBasic)
    love.graphics.setColor(1, 1, 1, 1)
    
    RpgLook:drawBox(0, 0, 320, 60)
    RpgLook:drawFace(self.hostIndex, 10, 5, 0.5, 0.5)
    love.graphics.print(shortenText(self.host.hostname, 36), 70, 10)
    love.graphics.print(shortenText(self.host.ipv4, 36), 70, 25)
    love.graphics.print(shortenText(self.host.mac, 36), 70, 40)

    RpgLook:drawBox(0, 60, 320, 180)

    if output ~= nil then
        love.graphics.printf(output, 5, 65, 310)
    end
end

function StateNetActionSyn:pressed(button)
    if button == "b" then
        Gamestate.switch(StateNetExplorer)
    end
end

return StateNetActionSyn