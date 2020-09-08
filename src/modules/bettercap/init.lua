local ModuleBettercap = {}

-- send command to bettercap
function ModuleBettercap:run(command)
  return httpPostJson("http://127.0.0.1:8081/api/session", json.encode({ cmd = command }))
end

-- get current LAN session
function ModuleBettercap:lan()
  return httpGetJson("http://127.0.0.1:8081/api/session/lan")
end

-- restart probe (if it goes stale)
function ModuleBettercap:restartProbe()
  pakemon.bettercap:run('net.probe off')
  pakemon.bettercap:run('net.probe on')
end

function ModuleBettercap:load()
end

return ModuleBettercap