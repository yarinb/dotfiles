local M = {}

setmetatable(M, {
    __index = function(t, k)
        t[k] = require("y.util." .. k)
        return t[k]
    end
})

return M
