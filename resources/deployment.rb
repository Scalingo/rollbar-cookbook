# Cookbook Name:: rollbar
# LWRP: deployment
#
# Notify deployment to Rollbar
#
# Copyright 2014, Appsdeck
# 
# License: BSD version 3
#

actions [:notify, :nothing]
default_action :notify

attribute :path, :kind_of => String, :name_attribute => true
attribute :token, :kind_of => String, :required => true
attribute :env, :kind_of => String, :required => true
attribute :local_username, kind_of => String, :required => true
# Revision is defined from the checkout rev in the given path
attribute :revision, kind_of => String
attribute :rollbar_username, kind_of => String
attribute :comment, kind_of => String
