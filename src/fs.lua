local fs = {}

-- this is a really naive and basic fs interface, until I can find something better
-- TODO: support windows, too, I guess

fs.home = os.getenv ("HOME")

-- list files in a direcfotry
function fs:ls(path)
  return io.popen('ls -Lp "'..(path or fs.home)..'"'):lines()
end

return fs