class WebHook::Log < ActiveRecord::Base
  belongs_to :resource, class_name: "WebHook::Resource", foreign_key: "web_hook_resource_id"
end
