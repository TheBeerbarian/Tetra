-- Shortens long URL's with bit.ly
-- Needs a bit.ly api key

use "strings"

function scrapeurl(str)
  return str:match("https?://[%w-_%.%?%.:/%+=&]+")
end

API_KEY = tetra.Config.ApiKeys.bitly

URL = "https://api-ssl.bitly.com/v3/shorten?access_token=" .. API_KEY .. "&longUrl="

function shorten(url)
  eurl = URL .. url_encode(url)
  res = getjson(eurl)

  if res.status_txt ~= "OK" then
    client.ServicesLog("url \"" .. url .. "\" failed to shorten: " .. res.status_txt)
  end

  return res.data.url
end

Hook("CHATBOT-CHANMSG", function(source, destination, message)
  message = strings.join(message, " ")
  local url = scrapeurl(message)

  if url ~= nil then
    if #url > 100 then
      client.Privmsg(destination, "^ " .. shorten(url))
    end
  end
end)
