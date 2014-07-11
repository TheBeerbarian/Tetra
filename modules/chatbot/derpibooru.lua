local json = require "json"

function dblookup(id)
  local url = "http://derpiboo.ru/"..id..".json?nocomments"

  local obj, err = getjson(url)

  if err ~= nil then
    return nil, err
  end

  return obj, nil
end

function summarize(info)
  local ret = "^ Derpibooru: "
  ret = ret .. "Tags: " .. info.tags

  return ret
end

function db_scrape(line)
  local source, destination, message = parseLine(line)

  if message:find("derpiboo.ru/(%d+)") then
    local id = message:match("/(%d+)")

    if id == nil then
      return
    end

    local info, err = dblookup(id)

    if err ~= nil then
      client.Privmsg(destination, "Could not look up that image. Does it exist?")
      return
    end

    client.Privmsg(destination, summarize(info))
  end
end

tetra.script.AddLuaProtohook("PRIVMSG", "db_scrape")