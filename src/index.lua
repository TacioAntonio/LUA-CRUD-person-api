local restserver = require("restserver")
local server = restserver:new():port(3000)
local routes = require("routes")

for _, route in ipairs(routes) do
    server:add_resource("/", { route })
end

server:set_error_handler({
   produces = "application/json",
   handler = function(code, msg)
      return {
         code = code,
         message = msg,
         custom_error_field = "Not found!",
      }
   end,
})

server.server_name = "Persons server"
server:enable("restserver.xavante"):start()
