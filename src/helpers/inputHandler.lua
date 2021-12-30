local input_handler = {}

--- Listens to user input and returns the value as a number
--- @return number
function input_handler.get_number_input()
  local inputValue

  repeat
    inputValue = tonumber(io.read())
    if not inputValue then
      print('Incorrect input, try using numbers!')
    end
  until inputValue

  -- To make it prettier in console
  print('')

  return inputValue
end

--- Listens to user input and returns the value as a string
--- @return string
function input_handler.get_string_input()
  local inputValue

  repeat
    inputValue = tostring(io.read())
    if not inputValue or inputValue == '' then
      print('Incorrect input, try using characters!')
    end
  until inputValue and inputValue ~= ''

  -- To make it prettier in console
  print('')

  return inputValue
end

return input_handler
