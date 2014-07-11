commands = {
  LOAD = elevated() .. function(source, message)
    if #message == 0 then
      return "Need a script name"
    end

    local name = message[1]
    local script, err = tetra.bot.LoadScript(message[1])

    if err ~= nil then
      tetra.log.Printf("Can't load script " .. name .. ": %#v", err)
      return "Script " .. name .. " failed load: " .. err
    end

    return "Script " .. script.Name .. " loaded with uuid " .. script.Uuid
  end,
  UNLOAD = elevated() .. function(source, message)
    if #message == 0 then
      return "Need a script name"
    end

    local name = message[1]

    if tetra.bot.Scripts[name] == nil then
      return "Script " .. name .. " is not loaded."
    end

    local err = tetra.bot.UnloadScript(name)

    return "Script " .. name .. " unloaded"
  end,
  SCRIPTS = elevated() .. function(source, message)
    for name, script in pairs(tetra.bot.Scripts) do
      client.Notice(source, script.Client.Nick .. ": " .. name .. " (" .. script.Uuid:sub(1,8) .. ")" .. " handlers: " .. #script.Handlers)
    end

    return "End of scripts list"
  end,
  VERSION = function(source, message)
    local commit = os.capture("git rev-parse --short HEAD")
    return "Tetra 0.1-" .. commit
  end,
  NETDUMP = elevated() .. function(source, message)
    tetra.log.Printf("%#v", tetra.bot)
    tetra.log.Printf("%#v", tetra.bot.Clients.ByUID)

    for uid, client in pairs(tetra.bot.Clients.ByUID) do
      tetra.log.Printf("%#v", client)
    end

    tetra.log.Printf("%#v", tetra.bot.Channels)

    for name, channel in pairs(tetra.bot.Channels) do
      tetra.log.Printf("%#v", channel)

      for uid, cuser in pairs(channel.Clients) do
        tetra.log.Printf("%#v %#v", cuser, cuser.Client)
      end
    end

    return "Logged"
  end,
}

function parsecommands(source, message)
  message = split(message, " ")
  local verb = string.upper(table.remove(message, 1))
  local reply = ""

  if commands[verb] ~= nil then
    reply = commands[verb](source, message)
  else
    reply = "No such command " .. verb .. ". If you are having trouble, join #help."
  end

  client.Notice(source, reply)
end

function admincommands(line)
  local source, destination, message = parseLine(line)

  if is_targeted_pm(destination) then
    parsecommands(source, message)
  end
end

tetra.script.AddLuaProtohook("PRIVMSG", "admincommands")
