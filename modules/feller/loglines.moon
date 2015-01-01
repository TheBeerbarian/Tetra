sqlite3 = require "lsqlite3"

export db = sqlite3.open "var/feller.db"

db\exec [[
  CREATE TABLE IF NOT EXISTS Chatlines (
    id INTEGER PRIMARY KEY,
    time INTEGER,
    channel TEXT,
    nick TEXT,
    vhost TEXT,
    account TEXT,
    message TEXT
  );
]]

db\exec [[ BEGIN TRANSACTION; ]]

Hook "CRON-HEARTBEAT", ->
  db\exec [[
    COMMIT;
    BEGIN TRANSACTION;
  ]]

Hook "SHUTDOWN", ->
  db\exec [[ COMMIT; ]]
  db\close!

insert_stmt = assert db\prepare "INSERT INTO Chatlines VALUES(NULL, ?, ?, ?, ?, ?, ?)"

log = (channel, source, message) ->
  insert_stmt\bind_values os.time!, channel.Target!, source.Nick, source.VHost, source.Account, message
  insert_stmt\step!
  insert_stmt\reset!

Hook "FELLER-CHANMSG", (source, destination, message) ->
  message = table.concat luar.slice2table(message), " "

  log destination, source, message
