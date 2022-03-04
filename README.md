# Rollbar Cookbook

This cookbook defines a LWRP to notify deployments to Rollbar for your project.

## Attributes

* `path` (name attribute)
* `token` (required)
* `env` (required)
* `local_username` (required)
* `revision` (automatically set from the `path` - only work for GIT)
* `rollbase_username`
* `comment`

## Example

You can define the resource the following way:
```ruby
rollbar_deployment deploy_path do
  token deploy_env["ROLLBAR_TOKEN"]
  env node['environment']
  local_username deploy_user
  comment "Deployed on #{node['fqdn']}"
  action :nothing
end
```

Then in another resource, which actually deploy your app/service/etc,
you can trigger the notification with:
```ruby
resource name do
    notifies :notify, "rollbar_deployment[deploy_path]", :immediately
end
```

## License and Authors

License: BSD-3

Authors:
* Leo Unbekandt `leo@scalingo.com`
* Brandon Welsch `brandon@scalingo.com`
