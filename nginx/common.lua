local res_base, res, res_total_count = ngx.location.capture_multi{
  { "/app/base" },
  { "/app".. ngx.var.request_uri },
  { "/app/total_count" },
}
ngx.status = res.status
local user_name = ngx.var["cookie_username"]
local base_body = string.gsub(res_base.body, "%$user_name%$", user_name or "", 1)
local user_header = nil
local base_uri = ngx.var.scheme.."://"..ngx.var.host
if user_name then
  user_header = string.format(
  [[<li>
  <li><a href="%s/mypage">MyPage</a></li>
  <li>
    <form action="/signout" method="post">
      <input type="hidden" name="sid" value="%s">
      <input type="submit" value="SignOut">
    </form>
  </li>
  </li>]],
  base_uri,
  ngx.var["cookie_token"]
  )
else
  user_header = string.format([[<li><a href="%s">SignIn</a></li>]], base_uri.."/signin")
end
base_body = string.gsub(base_body, "%$user_header%$", user_header, 1)
local body = string.gsub(base_body, "%$yield%$", res.body, 1)
body = string.gsub(body, "%$total_count%$", res_total_count.body, 1)
ngx.say(body)
