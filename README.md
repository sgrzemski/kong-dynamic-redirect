## Work still in progres
# Kong Dynamic Redirect plugin

HTTP redirects in Kong OSS are tough. They require two plugins to be enabled: 
- [kong-request-termination](https://docs.konghq.com/hub/kong-inc/request-termination/) to setup the 30X HTTP code
- [kong-response-transformer](https://docs.konghq.com/hub/kong-inc/response-transformer/) to set the `Location` header

This plugin covers both and supports a dynamic `Location` header generation.

![image](https://developer.mozilla.org/en-US/docs/Web/HTTP/Redirections/httpredirect.png)

## Configuration
### Dynamic configuration
```yaml
config:
  dynamic:
    pattern: ^/en
    replacement: /
    redirect_code: 302
    redirect_domain: your-new-api.com
```
### Static configuration
```yaml
config:
  static:
    redicert_url: https://your-new-website.com
    redirect_code: 302
```