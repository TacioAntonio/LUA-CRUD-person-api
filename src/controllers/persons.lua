local restserver = require("restserver")
local persons = require("../utils/fake_data")
require("../utils/functions")

function GetAll()
    return restserver.response():status(200):entity(persons)
end

function GetPersonById(_, id)
    function FindPersonById(id)
        for _, person in ipairs(persons) do
            if person.Id == id then
                return person
            end
        end
        return nil
    end

    local person = FindPersonById(id)

    if person then
        return restserver.response():status(200):entity(person)
    else
        return restserver.response():status(404):entity({ message = "Person not found" })
    end
end


function Create(request)
    local Avatar = request.Avatar
    local Firstname = request.Firstname
    local Lastname = request.Lastname
    local Email = request.Email
    local Age = request.Age

    if Avatar == "" then
        return restserver.response():status(404):entity({ message = "Avatar  is a required field" })
    end

    if Firstname == "" then
        return restserver.response():status(404):entity({ message = "Firstname  is a required field" })
    end

    if Lastname == "" then
        return restserver.response():status(404):entity({ message = "Lastname  is a required field" })
    end

    if Email == "" then
        return restserver.response():status(404):entity({ message = "Email  is a required field" })
    end
    
    if IsValidEmail(Email) == false then
        return restserver.response():status(404):entity({ message = "Email is invalid'" })
    end

    if Age <= 0 or Age > 120 then
        return restserver.response():status(404):entity({ message = "The Age field must be greater than 0 and less than or equal to 120" })
    end

    table.insert(persons, { 
        Id = GenerateRandomID(), 
        Avatar = Avatar, 
        Firstname = Firstname, 
        Lastname = Lastname, 
        Email = Email, 
        Age = Age
    })

    return restserver.response():status(200):entity({ message = "Stored successfully!" })
end

function Delete(_, id)
    for i, person in ipairs(persons) do

       if person.Id == id then
          table.remove(persons, i)
          
          return restserver.response():status(200):entity({ message = "Person deleted successfully!" })
       end
    end

    return restserver.response():status(404):entity("Person not found")
end

function Update(request, id)
    local Avatar = request.Avatar
    local Firstname = request.Firstname
    local Lastname = request.Lastname
    local Email = request.Email
    local Age = request.Age
    local indexToUpdate = 0;

    for i, person in ipairs(persons) do
        if person.Id == id then
            indexToUpdate = i
        end
    end

    if indexToUpdate == 0 then
        return restserver.response():status(404):entity({ message = "Person not exist" })
    end

    if Avatar == "" then
        return restserver.response():status(404):entity({ message = "Avatar  is a required field" })
    end

    if Firstname == "" then
        return restserver.response():status(404):entity({ message = "Firstname  is a required field" })
    end

    if Lastname == "" then
        return restserver.response():status(404):entity({ message = "Lastname  is a required field" })
    end

    if Email == "" then
        return restserver.response():status(404):entity({ message = "Email  is a required field" })
    end
    
    if IsValidEmail(Email) == false then
        return restserver.response():status(404):entity({ message = "Email is invalid'" })
    end

    if Age <= 0 or Age > 120 then
        return restserver.response():status(404):entity({ message = "The Age field must be greater than 0 and less than or equal to 120" })
    end
    
    persons[indexToUpdate] = { 
        Id = id,
        Avatar = Avatar;
        Firstname = Firstname;
        Lastname = Lastname;
        Email = Email;
        Age = Age;
    }

    return restserver.response():status(200):entity({ message = "Person updated successfully!" })
end

return { 
    GetAll = GetAll,
    GetPersonById = GetPersonById,
    Create = Create,
    Delete = Delete,
    Update = Update
}
