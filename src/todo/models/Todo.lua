--- Returns a todo table with description and status
--- @param description string
--- @param status boolean
local function Todo(description, status)
  return {
    description = description or '',
    status = status or false,
  }
end

return Todo