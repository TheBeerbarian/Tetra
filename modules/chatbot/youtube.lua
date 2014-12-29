-- Based on:
-- https://github.com/TheLinx/Juiz/blob/master/modules/ytvlookup.lua

local json = require "json"
local http = require "socket.http"

function ytlookup(id)
  local res = getjson("http://gdata.youtube.com/feeds/api/videos/"..id.."?alt=json&fields=author,title")
  local author, title = res.entry.author[1].name["$t"], res.entry.title["$t"]

  return "^ Youtube: " .. title .. " - Uploaded by: " .. author
end

Hook("CHATBOT-CHANMSG", function(source, destination, message)
  message = table.concat(luar.slice2table(message), " ")

  if message:find("youtube%.com/watch") then
    client.Privmsg(destination, ytlookup(message:match("v=(...........)")))
  elseif message:find("youtu%.be/") then
    client.Privmsg(destination, ytlookup(message:match("%.be/(...........)")))
  else return end
end)

--[[ --Removing this on 2014/12/28 because of incompatible youtube API changes
Command("YT", function(source, destination, message)
  if #message < 1 then
    return "Params: string to search youtube for"
  end

  local search = table.concat(luar.slice2table(message, " "))
  local url = "https://gdata.youtube.com/feeds/api/videos?q=" .. web.encode(search) .. "&v=2&alt=jsonc"
  tetra.debug(url)

  local info = getjson("https://gdata.youtube.com/feeds/api/videos?q=" .. web.encode(search) .. "&v=2&alt=jsonc")

  if info.data.totalItems == 0 then
    print(json.encode(info))
    return "No video found"
  end

  local video = info.data.items[1]

  return "Youtube: " .. video.title .. " http://youtu.be/" .. video.id
end)
--]]
