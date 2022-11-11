local typedefs = require "kong.db.schema.typedefs"

local is_present = function(v)
  return type(v) == "string" and #v > 0
end

local status_code = {
  type = "integer",
  default = 301,
  between = { 301, 302 },
}

local string = {
  type = "string"
}

local dynamic_configuration = {
  type = "record",
  fields = {
    { pattern = string },
    { replacement = string },
    { redirect_code = status_code },
    { redirect_domain = string }
  },
}

local static_configuration = {
  type = "record",
  fields = {
    { redirect_code = status_code },
    { redirect_url = string }
  },
}

return {
  name = "kong-dynamic-redirect",
  fields = {
    { protocols = typedefs.protocols_http },
    { config = {
        type = "record",
        fields = {
          { dynamic = dynamic_configuration },
          { static = static_configuration }
        },
        custom_validator = function(config)
          if is_present(config.dynamic)
          and is_present(config.static) then
            return nil, "Cannot use both static and dynamic configs at the same time!"
          end
          return true
        end,
      },
    },
  },
}

