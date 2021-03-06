local JSON = require('JSON')

local file_handler = {}

--- Loads json from file and decode it to a table
--- @param full_file_name string
--- @return table
function file_handler.get_content_from_file(full_file_name)
  if not full_file_name then
    -- Maybe throw error later instead
    return {}
  end 

  local file_content = ''
  local file = io.open(full_file_name, "a+")

  if not file then
    -- Maybe throw error later instead
    return {}
  end

  file_content = tostring(file:read("a"))

  file:close()

  return file_content and JSON:decode(file_content) or {}
end

--- Encodes lua table to json and saves it to file
--- @param full_file_name string
--- @param content string
function file_handler.save_content_to_file(full_file_name, content)
  if not full_file_name or type(content) ~= 'table' then
    -- Maybe throw error later
    return
  end

  local file = io.open(full_file_name, "w+")

  if not file then
    -- Maybe throw error later
    return
  end

  file:seek('set', 0)
  file:write(JSON:encode(content))
  file:close()
end

return file_handler