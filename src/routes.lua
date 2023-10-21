local persons = require("controllers.persons") -- Certifique-se de que o caminho está correto

local routes = {
    {
        method = "GET",
        path = "/persons",
        produces = "application/json",
        handler = persons.GetAll
    },
    {
        method = "GET",
        path = "/person/{id}",
        produces = "application/json",
        handler = persons.GetPersonById
    },
    {
        method = "POST",
        path = "/person/create",
        consumes = "application/json",
        produces = "application/json",
        input_schema = {
            Avatar = { type = "string" },
            Firstname = { type = "string" },
            Lastname = { type = "string" },
            Email = { type = "string" },
            Age = { type = "number" },
        },
        handler = persons.Create
    },
    {
        method = "DELETE",
        path = "/person/delete/{id}",
        produces = "application/json",
        handler = persons.Delete,
     },
     {
         method = "POST",
         path = "/person/update/{id}",
         consumes = "application/json",
         produces = "application/json",
         input_schema = {
             Avatar = { type = "string" },
             Firstname = { type = "string" },
             Lastname = { type = "string" },
             Email = { type = "string" },
             Age = { type = "number" },
         },
         handler = persons.Update
     },
}

return routes