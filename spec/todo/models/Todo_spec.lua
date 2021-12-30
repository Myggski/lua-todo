local Todo = require('./src/todo/models/Todo')

insulate('Todo', function()
  describe('calling Todo without parameters', function()
    it('should create a todo with empty description and status set to false', function() 
      local todo = Todo()

      assert.is_same(todo, {
        description = '', 
        status = false
      })
    end)
  end)

  describe('calling Todo with one parameter', function()
    it('should create a todo with a set description and status set to false', function() 
      local description = 'description'
      local todo = Todo(description)

      assert.is_same(todo, {
        description = description, 
        status = false
      })
    end)
  end)

  describe('calling Todo with two parameters', function()
    describe('first parameter as a string, and second as a boolean', function()
      it('should create a todo with a set description and status set to true', function() 
        local description = 'description'
        local status = true
        local todo = Todo(description, status)
  
        assert.is_same(todo, {
          description = description, 
          status = status
        })
      end)
    end)

    describe('first parameter as boolean, and second as a string', function()
      it('should convert boolean to string and set status to true', function()
        local expected_description_1 = 'true'
        local expected_status_1 = true
        local todo_1 = Todo(true, 'status')

        local expected_description_2 = 'false'
        local expected_status_2 = false
        local todo_2 = Todo(false, '')

        assert.is_same(todo_1, {
          description = expected_description_1, 
          status = expected_status_1
        })

        assert.is_same(todo_2, {
          description = expected_description_2,
          status = expected_status_2
        })
      end)
    end)
  end)
end)