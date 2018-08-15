get 'trackers/categories', :to => redirect('settings/plugin/redmine_tracker_category')
get 'trackers/:id/categories/edit', :to => 'tracker_categories#edit'
post 'trackers/:id/categories/save', :to => 'tracker_categories#save'