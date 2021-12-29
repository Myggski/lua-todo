local todo_view = {}
local SEPERATOR <const> = '=================================='

--- Returns string depending on the status of the todo
--- @param todo_status boolean
--- @return string
local get_status_text = function(todo_status)
  return todo_status and 'Done' or 'In-Progress'
end

--- Returns string displaying information about a single todo
--- @param index number
--- @param todo table
--- @return string
local get_todo = function(index, todo)
  local todo_string = index and string.format('%s. ', index) or ''

  return todo_string .. string.format('%s - %s', todo.description, get_status_text(todo.status))
end

--- Displaying text that tells the user to add a description
function todo_view.add_todo()
  print('Add a description:')
end

--- Displaying text that a todo has been added
--- @param description string
function todo_view.todo_added(description)
  description = description or ''

  print(string.format('"%s" has been added!', description))
end

--- Displaying text that tells the user to add a new description 
function todo_view.update_description()
  print('Enter new description text:')
end

--- Displaying text that a todo has changed status
--- @param todo table
function todo_view.update_status(todo)
  print(string.format('"%s" has changed status from %s to %s!\n', todo.description, get_status_text(not todo.status), get_status_text(todo.status)))
end

--- Displaying text explaning that the description of a todo has been updated
--- @param old_description string
--- @param new_description string
function todo_view.description_updated(old_description, new_description)
  print(string.format('"%s" has been updated its desciption to "%s"!\n', old_description, new_description))
end

--- Displaying text explaning that a todo has been removed
--- @param description
function todo_view.todo_removed(description)
  description = description or ''

  print(string.format( '"%s" has been removed!', description))
end 

--- Displaying text explaning the status of the file loading
--- @param status boolean
function todo_view.load_from_file(status)
  local message = status and 'Loading from file successfully!' or 'Something went wrong when trying to load todos from file'

  print(message)
end

--- Displaying text explaning the status of the file saving
--- @param status boolean
function todo_view.save_to_file(status)
  local message = status and 'Saving to file successfully!' or 'Something went wrong when trying to save todos to file'

  print(message)
end

--- Displaying all the todos and requesting the user to select todo or to go back to menu
--- @param todos table
function todo_view.list_todos(todos)
  todos = todos or {}

  local list_todos_string = string.format([[List of todo(s) - (%s)
%s]], 
    #todos, SEPERATOR)

    if todos and #todos > 0 then
      for i=1, #todos do
        list_todos_string = list_todos_string .. string.format('\n%s', get_todo(i, todos[i]))
      end
    else 
      list_todos_string = list_todos_string .. '\n-- No todos found -- \n'
    end

    list_todos_string = list_todos_string .. string.format('\n%s. Go back to menu\n', #todos + 1)
    list_todos_string = list_todos_string .. string.format('\nSelect action: (Select %s to go back to menu)', #todos + 1)
    

    print(list_todos_string)
end 

--- Displays menu when the user has selected a todo
--- @param selected_todo
function todo_view.todo_actions_menu(selected_todo)
  print(string.format([[
Selected todo - %s
%s
1. Change description
2. Change status to %s
3. Remove
4. Back to menu

Select action:]], selected_todo.description, SEPERATOR, get_status_text(not selected_todo.status)))
end

--- Displays start menu
function todo_view.start_menu()
  print(string.format([[

Todo application in Lua
%s
1. Add todo
2. List all todos
3. Load from file
4. Save to file
5. Exit

Select action:]], SEPERATOR))
end

return todo_view