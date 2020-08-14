local request = require "lib.luajit-request"

local map = {}

local function encodeChar(chr)
    return string.format("%%%X",string.byte(chr))
end

-- these should probly go inshared util-lib
function downloadImage(url)
  local r = request.send(url)
  local filedata = love.filesystem.newFileData(r.body, 'map.png')
	local imagedata = love.image.newImageData(filedata)
  local image = love.graphics.newImage(imagedata)
  return image
end

function encodeURI(str)
    local output, t = string.gsub(str,"[^%w]",encodeChar)
    return output
end

function map:getMapUrl(markers)
  local url = "https://api.mapbox.com/styles/v1/mapbox/streets-v11/static/"
  for i,v in pairs(markers) do
    url = url .. "url-" .. encodeURI("https://dynamic-icons.vercel.app/api?alt="..v[3].."&dir="..v[4].."&hex="..v[5]) .. "(" .. v[1] .. "," .. v[2] .. ")"
    if i ~= #markers then
      url = url .. ","
    end
  end
  url = url .. "/auto/320x240?access_token=pk.eyJ1IjoiZGF2aWRrb25zdW1lciIsImEiOiJja2R0OHl2OXQwcGh1MnNtcGRleDRpeWRpIn0.lGkSZTG8nmxltvK6uF8NHw&attribution=false&logo=false"
  return url
end

function map:getMapImage(markers) 
  return downloadImage(self:getMapUrl(markers))
end

return map