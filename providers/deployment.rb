#
# Cookbook Name:: rollbar
# LWRP: deployment
#
# Notify deployment to Rollbar
#
# Copyright 2022, Scalingo
#
# License: BSD-3 License
#

require 'uri'
require 'net/http'

def whyrun_supported?
  true
end

action :nothing do
end

action :notify do
  if new_resource.revision
    revision = new_resource.revision
  elsif new_resource.path
    path = new_resource.path
    cwd = Dir.getwd

    Dir.chdir path
    revision = `git log -n 1 --pretty=format:"%H"`
    Dir.chdir cwd
  else
    raise "A revision or a path should be provided"
  end

  payload = {
    "access_token" => new_resource.token,
    "environment" => new_resource.env,
    "local_username" => new_resource.local_username,
    "revision" => revision
  }
  payload["comment"] = new_resource.comment if new_resource.comment
  payload["rollbar_username"] = new_resource.comment if new_resource.rollbar_username

  uri = URI(node['rollbar']['endpoint'])
  res = nil
  Net::HTTP.start uri.host, uri.port, use_ssl: uri.scheme == "https" do |http|
    req = Net::HTTP::Post.new uri.request_uri
    req.form_data = payload
    res = http.request req
  end

  if res.code != "200"
    body = res.body.length != 0 ? res.body : "<no body>"
    Chef::Log.error("Invalid status code from rollbar #{res.code}: #{body}")
  end
end
