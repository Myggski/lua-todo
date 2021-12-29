local input_handler = {}

function input_handler.get_number_input()
  local inputValue

  repeat
    inputValue = tonumber(io.read())
    if not inputValue then
      print("Incorrect input, try using numbers!")
    end
  until inputValue

  -- To make it prettier in console
  print('')

  return inputValue
end

function input_handler.get_string_input()
  local inputValue

  repeat
    inputValue = tostring(io.read())
    if not inputValue or inputValue == '' then
      print("Incorrect input, try using characters")
    end
  until inputValue or inputValue ~= ''

  -- To make it prettier in console
  print('')

  return inputValue
end

return input_handler
