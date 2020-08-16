local map = {}

local style = 'dark-v10'
-- local style = 'light-v10'
-- local style = 'streets-v11'
-- local style = 'outdoors-v11'
-- local style = 'satellite-v9'
-- local style = 'satellite-streets-v11'


function map:getMapUrl(markers)
  local url = "https://api.mapbox.com/styles/v1/mapbox/" .. style .. "/static/"
  for i,v in pairs(markers) do
    url = url .. "url-" .. encodeURI("https://dynamic-icons.vercel.app/api?alt="..v[3].."&rot="..v[4].."&hex="..v[5]) .. "(" .. v[1] .. "," .. v[2] .. ")"
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