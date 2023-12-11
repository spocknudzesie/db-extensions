scripts.db = scripts.db or {
    debug = false,
}

function db:print(text)
    if scripts.db.debug then
        hecho(string.format("#777777[DB DEBUG]#r #aaaaaa%s#r\n", text))
    end
end

function db:cursorToTable(res)
    local rows = {}
    
    if type(res) == "number" then return res end -- e.g. UPDATE or INSERT
    
    local row = res:fetch({}, 'a')
    
    if not row then return {} end
    
    while row do
      table.insert(rows, row)
      row = res:fetch({}, 'a')
    end
    
    return rows
  end
  
  
function db:execute(dbName, query)
    -- print(dbName)
    -- print(query)
    self:print(query)
    local res = db.__conn[dbName]:execute(query)
    if not res then return {} end
    return db:cursorToTable(res)
end



setModulePriority("db-extensions", 1)
