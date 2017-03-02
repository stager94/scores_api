class WebHook::Resource < ActiveRecord::Base

  has_many :logs, class_name: "WebHook::Log", foreign_key: 'web_hook_resource_id'

end
