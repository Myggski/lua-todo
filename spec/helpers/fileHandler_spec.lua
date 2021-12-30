local file_handler = require('./src/helpers/fileHandler')

insulate('fileHandler', function()
  local TEST_FULL_FILE_NAME <const> = 'test_file.txt'

  local does_file_exist = function(name)
    local file = io.open(name, 'r')

    if file ~= nil then 
      io.close(file) 
      return true 
    else 
      return false 
    end
 end

  after_each(function()
    os.remove(TEST_FULL_FILE_NAME)
  end)

  describe('get_content_from_file', function()
    describe('when the file does not exist', function()
      it('should create a file and return a empty table', function()
        assert.is_falsy(does_file_exist(TEST_FULL_FILE_NAME))

        local file_content = file_handler.get_content_from_file(TEST_FULL_FILE_NAME)

        assert.is_truthy(does_file_exist(TEST_FULL_FILE_NAME))
        assert.is_same(file_content, {})
      end)
    end)

    describe('when the file does already exist and contains json', function()
      local test_content = { test_string = 'test_string', test_boolean = true }

      it('should return the json as table', function()
        assert.is_falsy(does_file_exist(TEST_FULL_FILE_NAME))

        file_handler.save_content_to_file(TEST_FULL_FILE_NAME, test_content)
        local file_content = file_handler.get_content_from_file(TEST_FULL_FILE_NAME)

        assert.is_truthy(does_file_exist(TEST_FULL_FILE_NAME))
        assert.is_same(file_content, test_content)
      end)
    end)
  end)

  describe('when the file name is empty', function()
    it('should not create a file, but should return an empty table', function()
      assert.is_falsy(does_file_exist(TEST_FULL_FILE_NAME))

      local file_content = file_handler.get_content_from_file('')
      
      assert.is_falsy(does_file_exist(TEST_FULL_FILE_NAME))
      assert.is_same(file_content, {})
    end)
  end)

  describe('save_content_to_file', function()
    local test_content = { test_string = 'test_string' }

    describe('when the file does not exist', function()
      it('should create a file and save the content to file', function() 
        assert.is_falsy(does_file_exist(TEST_FULL_FILE_NAME))

        file_handler.save_content_to_file(TEST_FULL_FILE_NAME, test_content)
        local content_from_file = file_handler.get_content_from_file(TEST_FULL_FILE_NAME)

        assert.is_same(content_from_file, test_content)
        assert.is_truthy(does_file_exist(TEST_FULL_FILE_NAME))
      end)
    end)

    describe('when the file does already exist and contains json', function()
      local start_test_content = { test_string = 'old_test_string', test_boolean = false }
      local new_test_content = { test_string = 'new_test_string', test_boolean = true }

      it('should overwrite the current content with the new', function()
        assert.is_falsy(does_file_exist(TEST_FULL_FILE_NAME))

        file_handler.save_content_to_file(TEST_FULL_FILE_NAME, start_test_content)
        file_handler.save_content_to_file(TEST_FULL_FILE_NAME, new_test_content)
        
        local file_content = file_handler.get_content_from_file(TEST_FULL_FILE_NAME)

        assert.is_truthy(does_file_exist(TEST_FULL_FILE_NAME))
        assert.is_same(file_content, new_test_content)
      end)
    end)

    describe('when the file name is empty', function()
      it('should not create a file', function()
        assert.is_falsy(does_file_exist(TEST_FULL_FILE_NAME))
  
        file_handler.save_content_to_file('', test_content)
        
        assert.is_falsy(does_file_exist(TEST_FULL_FILE_NAME))
      end)
    end)
  end)
end)