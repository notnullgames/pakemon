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

-- download an image from the web
function downloadImage(url)
  local r = request.send(url)
  local filedata = love.filesystem.newFileData(r.body, 'map.png')
  local imagedata = love.image.newImageData(filedata)
  local image = love.graphics.newImage(imagedata)
  return image
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
function httpGetText(url, params)
  if params then
    local c = 1
    for i,v in pairs(params) do
      print(i,v)
      if c == 1 then
        url = url .. '?'
      else
        url = url .. '&'
      end
      url = url .. encodeURI(i) .. '=' .. encodeURI(v)
      c = c + 1
    end
  end
  local cmd = 'wget -qO- "' .. url .. '"'
  local f = assert(io.popen(cmd, 'r'))
  local s = assert(f:read('*a'))
  f:close()
  return s
end

-- simple HTTP GET of JSON
function httpGetJson(url, params)
  return json.decode(httpGetText(url, params))
end