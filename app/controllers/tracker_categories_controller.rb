class TrackerCategoriesController < ApplicationController
  unloadable
  
  before_filter :require_admin

  def edit    
    @tracker = Tracker.find(params[:id])	    
  end
  
  def save
    @tracker = Tracker.find(params[:id])
	@tracker.category_id = params[:category_id]
	@tracker.save
		  
	redirect_to controller: "settings", action: "plugin", id: "redmine_tracker_category", tab: "trackers_list"
  end

end
