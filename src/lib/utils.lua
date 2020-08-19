-- these are shared utils everyone might nbeed

json = require "lib.json"

-- get graphic dimensions of some text
function getTextSize(text, width, font)
  if font == nil then
    font = FontBasic
  end
  if width == nil then
    width = 320
  end
  local linewidth, lines = FontBasic:getWrap(text, width)
  local height = (FontBasic:getHeight(text) * #lines)
  return height, linewidth, lines
end

-- shorten & elipsis text
function shortenText(s,w)
  local ellipsis = "…"
  local n_ellipsis = string.len(ellipsis)
  if string.len(s) > w then
      return s:sub(1,w-n_ellipsis) .. ellipsis
  end
  return s
end

-- create a rounded rectangle
function roundrect(mode, x, y, width, height, xround, yround)
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

local function encodeChar(chr)
  return string.format("%%%X",string.byte(chr))
end

-- encode string for URL
function encodeURI(str)
  local output, t = string.gsub(str,"[^%w]", encodeChar)
  return output
end

-- dump objects
function dump(o)
  if type(o) == 'table' then
     local s = '{ '
     for k,v in pairs(o) do
        if type(k) ~= 'number' then k = '"'..k..'"' end
        s = s .. '['..k..'] = ' .. dump(v) .. ','
     end
     return s .. '} '
  else
     return tostring(o)
  end
end


-- simple HTTP get text
function httpGetText(url)
  local cmd = 'wget -qO- "' .. url .. '"'
  local f = assert(io.popen(cmd, 'r'))
  local s = assert(f:read('*a'))
  f:close()
  if s == '' then
    return nil
  end
  return s
end

-- simple HTTP GET of JSON
function httpGetJson(url)
  local r = httpGetText(url)
  return r and json.decode(r)
end

-- download an image from HTTP GET
function httpGetImage(url, filename)
  local cmd = 'wget -qO /tmp/pakemon-binary "' .. url .. '"'
  local f = assert(io.popen(cmd, 'r'))
  f:close()
  f = io.open("/tmp/pakemon-binary", "rb")
  local filedata = love.filesystem.newFileData(f:read("*a"), filename)
  f:close()
  local imagedata = love.image.newImageData(filedata)
  local image = love.graphics.newImage(imagedata)
  return image
end

-- download a map image, with markers
-- other styles:
-- 'light-v10'
-- 'streets-v11'
-- 'outdoors-v11'
-- 'satellite-v9'
-- 'satellite-streets-v11'
function httpGetMap(markers, style)
  local url = "https://api.mapbox.com/styles/v1/mapbox/" .. (style or "dark-v10") .. "/static/"
  for i,v in pairs(markers) do
    url = url .. "url-" .. encodeURI("https://dynamic-icons.vercel.app/api?alt="..v[3].."&rot="..v[4].."&hex="..v[5]) .. "(" .. v[1] .. "," .. v[2] .. ")"
    if i ~= #markers then
      url = url .. ","
    end
  end
  url = url .. "/auto/320x240?access_token=pk.eyJ1IjoiZGF2aWRrb25zdW1lciIsImEiOiJja2R0OHl2OXQwcGh1MnNtcGRleDRpeWRpIn0.lGkSZTG8nmxltvK6uF8NHw&attribution=false&logo=false"
  return httpGetImage(url, "map.png")
end