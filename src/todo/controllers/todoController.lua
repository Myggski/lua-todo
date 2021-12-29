local input_handler = require('./src/helpers/inputHandler')
local todo_view = require('./src/todo/views/todoView')
local TodoService = require('./src/todo/models/todoService')

local todo_controller = {}
local service = TodoService()

local update_todo_description = function(selected_todo_index, old_description)
  local new_description_input

  repeat
    todo_view.update_description()
    new_description_input = input_handler.get_string_input()
  until new_description_input

  service.update_description(selected_todo_index, new_description_input)
  todo_view.description_updated(old_description, new_description_input)
end

local update_todo_status = function(selected_todo_index, selected_todo)
  service.toggle_status(selected_todo_index)
  todo_view.update_status(selected_todo)
end 

local remove_todo = function(selected_todo_index, selected_todo)
  service.remove(selected_todo_index)
  todo_view.todo_removed(selected_todo.description)
end 

local select_todo = function(selected_todo_index)
  local selected_todo_action_input
  local selected_todo = service.get(selected_todo_index)
  local REMOVE_TODO_ACTION <const> = 3
  local BACK_TO_MENU_OPTION <const> = 4

  repeat
    repeat
      todo_view.todo_actions_menu(selected_todo)
      selected_todo_action_input = input_handler.get_number_input()
    until selected_todo_action_input >= 1 and selected_todo_action_input <= BACK_TO_MENU_OPTION

    if selected_todo_action_input == 1 then
      update_todo_description(selected_todo_index, selected_todo.description)
    elseif selected_todo_action_input == 2 then
      update_todo_status(selected_todo_index, selected_todo)
    elseif selected_todo_action_input == 3 then
      remove_todo(selected_todo_index, selected_todo)
    end

  until selected_todo_action_input == REMOVE_TODO_ACTION or selected_todo_action_input == BACK_TO_MENU_OPTION
end

--- Adds todo to the list
local add_todo = function()
  local todo_description_input

  repeat
    todo_view.add_todo()
    todo_description_input = input_handler.get_string_input()
  until todo_description_input and todo_description_input ~= ''

  service.add(todo_description_input)
  todo_view.todo_added(todo_description_input)
end 

local list_todos = function()
  local selected_todo_index
  local todos = service.list()
  local BACK_TO_MENU_OPTION <const> = #todos + 1

  todo_view.list_todos(todos)

  repeat
    selected_todo_index = input_handler.get_number_input()
  until selected_todo_index >= 1 and selected_todo_index <= BACK_TO_MENU_OPTION

  if selected_todo_index ~= BACK_TO_MENU_OPTION then
    select_todo(selected_todo_index)
  end
end

local try_load_from_file = function()
  local status = pcall(service.load_from_file)

  todo_view.load_from_file(status)
end 

local try_save_to_file = function()
  local status = pcall(service.save_to_file)

  todo_view.save_to_file(status)
end

function todo_controller.init()
  local action_input
  local EXIT_INPUT <const> = 5

  repeat 
    repeat
      todo_view.start_menu()
      action_input = input_handler.get_number_input()
    until action_input >= 1 and action_input <= EXIT_INPUT

    if not action_input ~= EXIT_INPUT then
      if action_input == 1 then
        add_todo()
      elseif action_input == 2 then
        list_todos()
      elseif action_input == 3 then
        try_load_from_file()
      elseif action_input == 4 then
        try_save_to_file()
      end 
    end
  until action_input == EXIT_INPUT

  os.exit()
end 

return todo_controller.init()