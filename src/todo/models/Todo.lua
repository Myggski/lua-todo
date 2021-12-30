--- Returns a todo table with description and status
--- @param description string
--- @param status boolean
local function Todo(description, status)
  local description_stringyfied = description

  if type(description) == 'boolean' then
    description_stringyfied = description and 'true' or 'false'
  end 

  return {
    description = description_stringyfied and tostring(description_stringyfied) or '',
    status = status and status ~= '' and true or false,
  }
end

return Todo