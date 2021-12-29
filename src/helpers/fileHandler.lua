local JSON = require('JSON')

local file_handler = {}

function file_handler.get_content_from_file(full_file_name)
  local file_content = ''
  local file = io.open(full_file_name, "a+")

  if not file then
    return {}
  end

  file_content = tostring(file:read("a"))

  file:close()

  return file_content and JSON:decode(file_content) or {}
end

function file_handler.save_content_to_file(full_file_name, content)
  local file = io.open(full_file_name, "w+")

  if not file then
    return {}
  end

  file:seek('set', 0)
  file:write(JSON:encode(content))
  file:close()
end

return file_handler