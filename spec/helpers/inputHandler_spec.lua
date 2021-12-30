local input_handler = require('./src/helpers/inputHandler')

insulate('input_handler', function()
  _G.print = function() end

  local setup_input_handler_test = function(test_function_name, read_func)
    -- stubbing io.read
    _G.io.read = read_func

    spy.on(_G.io, 'read')
    spy.on(_G, 'print')
    spy.on(input_handler, test_function_name)

    input_handler[test_function_name]()
  end

  describe('get_number_input', function()
    local function_name = 'get_number_input'
    local correct_return_number_value = 1
    local wrong_return_string_value = 'string'
    local wrong_return_empty_string_value = ''
    local input_error_message = 'Incorrect input, try using numbers!'

    describe('when io.read returns a number', function()
      it('should return the number recived from io.read', function() 
        setup_input_handler_test(function_name, function() 
          return correct_return_number_value
        end)
    
        assert.spy(_G.print).was_not_called_with(input_error_message)
        assert.spy(_G.io.read).was_returned_with(correct_return_number_value)
        assert.spy(input_handler[function_name]).was_returned_with(correct_return_number_value)
      end)
    end)

    describe('when io.read returns a string and then a number', function()
      it('should print a message about incorrect input then return the number recived from io.read', function() 
        local number_of_read_calls = 0

        setup_input_handler_test(function_name, function() 
          number_of_read_calls = number_of_read_calls + 1

          return number_of_read_calls > 1 
            and correct_return_number_value 
            or wrong_return_string_value 
        end)
    
        assert.spy(_G.print).was_called_with(input_error_message)
        assert.spy(_G.io.read).was_returned_with(wrong_return_string_value)
        assert.spy(_G.io.read).was_returned_with(correct_return_number_value)
        assert.spy(input_handler[function_name]).was_not_returned_with(wrong_return_string_value)
        assert.spy(input_handler[function_name]).was_returned_with(correct_return_number_value)
      end)
    end)

    describe('when io.read returns a empty string then a number', function()
      it('should print a message about incorrect input then return the number recived from io.read', function()
        local number_of_read_calls = 0

        setup_input_handler_test(function_name, function() 
          number_of_read_calls = number_of_read_calls + 1

          return number_of_read_calls > 1 
            and correct_return_number_value 
            or wrong_return_empty_string_value 
        end)
  
        assert.spy(_G.print).was_called_with(input_error_message)
        assert.spy(_G.io.read).was_returned_with(wrong_return_empty_string_value)
        assert.spy(_G.io.read).was_returned_with(correct_return_number_value)
        assert.spy(input_handler[function_name]).was_not_returned_with(wrong_return_empty_string_value)
        assert.spy(input_handler[function_name]).was_returned_with(correct_return_number_value)
      end)
    end)
  end)

  describe('get_string_input', function()
    local function_name = 'get_string_input'
    local correct_return_string_value = 'string'
    local correct_return_number_value = 1
    local wrong_return_empty_string_value = ''
    local input_error_message = 'Incorrect input, try using characters!'

    describe('when io.read returns a string', function()
      it('should return the string recived from io.read', function()
        setup_input_handler_test(function_name, function() 
          return correct_return_string_value
        end)

        assert.spy(_G.print).was_not_called_with(input_error_message)
        assert.spy(_G.io.read).was_returned_with(correct_return_string_value)
        assert.spy(input_handler[function_name]).was_returned_with(correct_return_string_value)
      end)
    end)

    describe('when io.read returns a number', function()
      it('should return the number recived from io.read, as a string', function()
        setup_input_handler_test(function_name, function() 
          return correct_return_number_value
        end)
  
        assert.spy(_G.print).was_not_called_with(input_error_message)
        assert.spy(_G.io.read).was_returned_with(correct_return_number_value)
        assert.spy(input_handler[function_name]).was_returned_with(tostring(correct_return_number_value))
      end)
    end)

    describe('when io.read returns a empty string then a string with characters', function()
      it('should print a message about incorrect input then return the string recived from io.read', function()
        local number_of_read_calls = 0

        setup_input_handler_test(function_name, function() 
          number_of_read_calls = number_of_read_calls + 1

          return number_of_read_calls > 1 
            and correct_return_string_value 
            or wrong_return_empty_string_value 
        end)
  
        assert.spy(_G.print).was_called_with(input_error_message)
        assert.spy(_G.io.read).was_returned_with(wrong_return_empty_string_value)
        assert.spy(_G.io.read).was_returned_with(correct_return_string_value)
        assert.spy(input_handler[function_name]).was_not_returned_with(wrong_return_empty_string_value)
        assert.spy(input_handler[function_name]).was_returned_with(correct_return_string_value)
      end)
    end)
  end)
end)