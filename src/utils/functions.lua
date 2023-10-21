local lpeg = require("lpeg")

function IsValidEmail(email)
    local pattern = lpeg.C(lpeg.R("az", "AZ", "09")^1) * "@" * lpeg.C(lpeg.R("az", "AZ", "09")^1) * "." * lpeg.C(lpeg.R("az", "AZ")^2)

    return lpeg.match(pattern, email) ~= nil
end

function GenerateRandomID()
    local idLength = 8
    local chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    local id = ""
    local rand = math.random

    for i = 1, idLength do
        local charIndex = rand(1, #chars)
        id = id .. chars:sub(charIndex, charIndex)
    end

    return id
end

return {
    IsValidEmail = IsValidEmail,
    GenerateRandomID = GenerateRandomID
}