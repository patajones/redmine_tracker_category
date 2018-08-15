module RedmineTrackerCategory
  class << self	
	def demand_over_demand_forbidden
      by_settigns = Setting.plugin_redmine_tracker_category['demand_over_demand_forbidden'].to_i
      by_settigns
	end
	
	def task_without_parent_forbidden
      by_settigns = Setting.plugin_redmine_tracker_category['task_without_parent_forbidden'].to_i
      by_settigns
	end	
		
	def task_without_demand_forbidden
      by_settigns = Setting.plugin_redmine_tracker_category['task_without_demand_forbidden'].to_i
      by_settigns
	end

	def force_task_private
      by_settigns = Setting.plugin_redmine_tracker_category['force_task_private'].to_i
      by_settigns
	end	
	
	def demand_over_demand_forbidden?
      demand_over_demand_forbidden == 1
	end
	
	def task_without_parent_forbidden?
      task_without_parent_forbidden == 1
	end	

	def task_without_demand_forbidden?
      task_without_demand_forbidden == 1
	end
	
	def force_task_private?
      force_task_private == 1
	end		
  end
end
require 'patches/tracker_patch'
require 'patches/issue_patch'