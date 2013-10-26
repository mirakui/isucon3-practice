total_count = ngx.shared.cache:get('total_count')

res = nil
if total_count then
  res = ngx.location.capture("/app"..ngx.var.request_uri)
else
  res, res_total_count = ngx.location.capture_multi{
    { "/app".. ngx.var.request_uri },
    { "/app/total_count" },
  }
  total_count = res_total_count.body
  ngx.shared.cache:set('total_count', total_count, 0.5)
end

ngx.status = res.status
body = string.gsub(res.body, "%$total_count%$", total_count, 1)
ngx.say(body)
