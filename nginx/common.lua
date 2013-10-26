local res, res_total_count = ngx.location.capture_multi{
  { "/app".. ngx.var.request_uri },
  { "/app/total_count" },
}
ngx.status = res.status
local body = string.gsub(res.body, "%$total_count%$", res_total_count.body, 1)
ngx.say(body)
