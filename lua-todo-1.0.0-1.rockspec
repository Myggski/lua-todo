-- lua-todo-1.0.0-1.rockspec
package = "lua-todo"
version = "1.0.0-1"

source = {
   url = "git+https://github.com/myggski/lua-todo",
}

description = {
   summary = "A todo application",
   detailed = [[
       I wanted to learn Lua so I did a classic todo console application. 
   ]],
   maintainer = "Tomas Wallin"
}

dependencies = {
   "lua >= 5.4",
   "json-lua >= 0.1-3",
   "busted >= 2.0.0-1"
}

build = {
   type = "builtin",
   modules = {
      main = "main.lua"
   }
}