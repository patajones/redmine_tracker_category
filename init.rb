#init.rb

Redmine::Plugin.register :redmine_tracker_category do
  name 'Redmine Tracker Category'
  author 'ricardob'  
  description 'Categorize Trackers on External Demanda and Internal Task'
  version '1.0'
  settings :default => {'empty' => true}, :partial => 'settings/tracker_category_settings'
  
  requires_redmine :version_or_higher => '3.4.6' 
end

require 'redmine_tracker_category'