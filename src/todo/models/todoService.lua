local Todo = require("./src/todo/models/Todo")
local file_handler = require('./src/helpers/fileHandler')

local FULL_FILE_NAME <const> = 'todos.txt'

--- Handles the CRUD of the todos
--- @return table
local function todo_service()
  --- List of todos
  local _todos = {}

  --- Adds todo
  --- @param description string
  function add(description, status)
    _todos[#_todos + 1] = Todo(description, status)
  end

  --- Removes one todo
  --- @param index integer
  function remove(index)
    _todos[index] = nil
  end

  --- Gets a specific todo
  --- @param index integer
  function get(index)
    return _todos[index]
  end

  --- Updates the description of an already exsisting todo
  --- @param index integer
  --- @param description string
  function update_description(index, description)
    _todos[index].description = description
  end

  --- Toggles the todo status, if it's done or not
  --- @param index integer
  function toggle_status(index)
    _todos[index].status = not _todos[index].status
  end

  --- Get all the todos
  --- @return table
  function list()
    return _todos
  end

  --- Loads todos from file
  function load_from_file()
    local todos_from_file = file_handler.get_content_from_file(FULL_FILE_NAME)

    for i=1, #todos_from_file do
      table.insert(_todos, todos_from_file[i])  
    end
  end

  function save_to_file()
    file_handler.save_content_to_file(FULL_FILE_NAME, _todos)
  end

  return {
    add = add,
    get = get,
    list = list,
    remove = remove,
    update_description = update_description,
    toggle_status = toggle_status,
    load_from_file = load_from_file,
    save_to_file = save_to_file,
  }
end

return todo_service
