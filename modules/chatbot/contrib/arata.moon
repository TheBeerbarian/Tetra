Command "ARATA", (source, destination, args) ->
  if #args == 0
    return "need module name to lookup"

  kind = args[1]\lower!

  if kind == "plugin"
    kind = "plugins"

  path = args[2]\gsub "%.", "%/"
  print path

  url = "https://raw.githubusercontent.com/shockkolate/arata/master/#{kind}/#{path}.hs"
  print url

  res, err = geturl url

  if err ~= nil
    return "no such #{kind} #{args[2]}"

  if res == "Not Found"
    return "no such #{kind} #{args[2]}"

  return "> #{url}"
