require "json"
require "socket"

-- http://lua-users.org/wiki/SplitJoin
-- Compatibility: Lua-5.1
function split(str, pat)
  local t = {}  -- NOTE: use {n = 0} in Lua-5.0
  local fpat = "(.-)" .. pat
  local last_end = 1
  local s, e, cap = str:find(fpat, 1)
  while s do
    if s ~= 1 or cap ~= "" then
      table.insert(t,cap)
    end
    last_end = e+1
    s, e, cap = str:find(fpat, last_end)
  end
  if last_end <= #str then
    cap = str:sub(last_end)
    table.insert(t, cap)
  end
  return t
end

function join(table, str)
  return table.concat(table, str)
end

-- http://stackoverflow.com/a/12674376
function keys(tab)
  local keyset={}
  local n=0

  for k,v in pairs(tab) do
    n=n+1
    keyset[n]=k
  end

  return keyset
end

-- http://lua-users.org/wiki/SimpleLuaClasses
-- class.lua
-- Compatible with Lua 5.1 (not 5.0).
function class(base, init)
  local c = {}    -- a new class instance
  if not init and type(base) == 'function' then
    init = base
    base = nil
  elseif type(base) == 'table' then
    -- our new class is a shallow copy of the base class!
    for i,v in pairs(base) do
      c[i] = v
    end
    c._base = base
  end
  -- the class will be the metatable for all its objects,
  -- and they will look up their methods in it.
  c.__index = c

  -- expose a constructor which can be called by <classname>(<args>)
  local mt = {}
  mt.__call = function(class_tbl, ...)
    local obj = {}
    setmetatable(obj,c)
    if init then
      init(obj,...)
    else
      -- make sure that any stuff from the base class is initialized!
      if base and base.init then
        base.init(obj, ...)
      end
    end
    return obj
  end
  c.init = init
  c.is_a = function(self, klass)
    local m = getmetatable(self)
    while m do
      if m == klass then return true end
      m = m._base
    end
    return false
  end
  setmetatable(c, mt)
  return c
end

--[[
A = class(function (self, x)
self.x = x
end)

function A:test()
print(self.x)
end

a = A("5")
a:test() --> 5
--]]

-- Class for a limited length table
LimitQueue = class(function(self, max)
  self.max = max
  self.table = {}
end)

function LimitQueue:Add(data)
  local ret = false

  if #self.table == self.max then
    table.remove(self.table, 1)

    ret = true
  end

  table.insert(self.table, data)

  return ret
end

function LimitQueue:Pop()
  return table.remove(self.table, 1)
end

-- Simple disk-backed table
FooDB = class(function(self, fname)
  self.fname = fname

  local fhandle = io.open(fname, "r")

  if fhandle == nil then
    self.data = {}
    return
  end

  local data = fhandle:read("*a")
  fhandle:close()

  self.data = json.decode(data)

  if self.data == nil then self.data = {} end
end)

function FooDB:Commit()
  local fhandle = io.open(self.fname, "w")
  if fhandle == nil then
    error("Cannot open "..self.fname)
  end
  local string = json.encode(self.data)

  fhandle:write(string)
  fhandle:close()
end

-- http://stackoverflow.com/a/326715
function os.capture(cmd, raw)
  local f = assert(io.popen(cmd, 'r'))
  local s = assert(f:read('*a'))
  f:close()

  if raw then
    return s
  end

  s = string.gsub(s, '^%s+', '')
  s = string.gsub(s, '%s+$', '')
  s = string.gsub(s, '[\n\r]+', ' ')
  return s
end

-- decorator for requiring elevated permissions
function elevated(...)
  local mt = {__concat =
  function(a,f)
    return function(user, ...)
      if not user.IsOper() then
        return "No permissions"
      end

      local res = f(user, ...)

      client.ServicesLog(user.Nick .. ": " .. res)
      return res
    end
  end
  }

  return setmetatable({...}, mt)
end

--[[
Usage:

elevatedtest = elevated() .. function(user, message)
return "Hi master"
end

--]]

-- Okay this is pretty much hacking
function command(verb, ...)
  local mt = {__concat =
  function(a,f)
    local ret = function(user, ...)
      local res = f(user, ...)
      return res
    end

    local my_uuid = uuid.new()
    _G[my_uuid] = ret

    print("Adding command at _G." .. my_uuid)

    tetra.script.AddLuaCommand(verb, my_uuid)

    return ret
  end
  }

  return setmetatable({...}, mt)
end

--[[
Create commands programatically using decorators.
--]]

function geturl(url)
  local c, err = web.get(url)
  if err ~= nil then
    tetra.log.Printf("URL error: %#v", err)
    return nil, err
  end

  local str, err = ioutil.readall(c.Body)
  if err ~= nil then
    tetra.log.Printf("Read error: %#v", err)
    return nil, err
  end

  str = ioutil.byte2string(str)

  return str, nil
end

function getjson(url)
  obj = json.decode(geturl(url))

  return obj, nil
end

function parseLine(line)
  local source = tetra.bot.Clients.ByUID[line.Source]
  local destination = line.Args[1]
  local message = line.Args[2]

  if destination:sub(1,1) == "#" then
    destination = destination:upper()
    destination = tetra.bot.Channels[destination]
  else
    destination = tetra.bot.Clients.ByUID[destination]
  end

  return source, destination, message
end

function is_common_channel(destination)
  if not destination.IsChannel() then return false end

  if client.Channels[destination.Target()] ~= nil then
    return true
  else
    return false
  end
end

function is_targeted_pm(destination)
  return not destination.IsChannel() and destination.Nick == client.Nick
end

-- https://stackoverflow.com/questions/2282444/
function contains(table, element)
  for _, value in pairs(table) do
    if value == element then
      return true
    end
  end
  return false
end

function find(tab, val)
  for i=1, #tab do
    if tab[i] == val then return i end
  end

  return 0
end

function sleep(sec)
  socket.select(nil, nil, sec)
end

function try(t)
  local ok, err = pcall(t.main)
  if not ok then
    t.catch(err)
  end
  if t.finally then
    return t.finally()
  end
end

--[[
-- Usage:
--
-- try {
--  main: function()
--    io.open("filethatDoesnOtexist", "r")
--  end,
--  catch: function(e)
--    print("Caught error!", e)
--  end,
-- }
--]]

-- Golua sucks
pcall = unsafe_pcall
xpcall = unsafe_xpcall
