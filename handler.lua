local kong_meta = require "kong.meta"
local kong = kong

local DynamicRedirectHandler = {
  PRIORITY = 800,
  VERSION = kong_meta.version,
}

function DynamicRedirectHandler:access(conf)
  request_path = kong.request.get_path_with_query()
  scheme = kong.request.get_scheme()

  if conf.dynamic then
    local status  = conf.dynamic.redirect_code
    local pattern = conf.dynamic.pattern
    if conf.dynamic.replacement then
      replacement = conf.dynamic.replacement
    else
      replacement = ""
    end
    local domain = conf.dynamic.redirect_domain

    redirect_path = string.gsub(request_path, pattern, replacement)
    redirect_path = string.gsub(redirect_path, '//', '/')
    redirect_url = scheme .. "://" .. domain .. redirect_path

    return kong.response.exit(status, nil, {
      ["Location"] = redirect_url
    })

  elseif conf.static then
    local status  = conf.static.redirect_code
    local url = conf.static.redirect_url

    return kong.response.exit(status, nil, {
      ["Location"] = url
    })
  end
end

return DynamicRedirectHandler