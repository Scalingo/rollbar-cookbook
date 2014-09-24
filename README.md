Rollbar Cookbook
================

This cookbook defines a LWRP to notify deployments for your project

## Attributes

* `path` (name attribute)
* `token` (required)
* `env` (required)
* `local_username` (required)
* `revision` (automatically set from the `path` - only work for GIT)
* `rollbase_username`
* `comment`

## Example

You can define the resource the following way

```ruby
rollbar_deployment deploy_path do
  action :nothing
  token deploy_env["ROLLBAR_TOKEN"]
  env node['environment']
  local_username deploy_user
  comment "Deployed on #{node['fqdn']}"
end
```

Then in anotherhe resource, which actually deploy your app/service/etc,
you can trigger the notification.

```ruby
resource name do
    notifies :notify, "rollbar_deployment[deploy_path]", :immediately
end
```

License and Authors
-------------------

License: BSD version 3

Authors:
* Leo Unbekandt `leo.unbekandt@appsdeck.eu`
