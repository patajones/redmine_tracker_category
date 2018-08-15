module RedmineTrackerCategory::Patches
  module IssuePatch
    def self.included(base)		  
      base.send(:include, InstanceMethods)	  	  
      base.class_eval do
        before_save :update_rules		        
        validate :validate_rules
		
	    scope :demands, lambda {|*args|
		  is_true = args.size > 0 ? args.first : true
		  if is_true
            joins(:tracker).
            where(trackers: {category_id: TrackerCategory::CATEGORY_DEMAND})
		  else
            joins(:tracker).
            where(Tracker.not_demand_condition)
          end		  
		}
		  
	    scope :tasks, lambda {|*args|
		  is_true = args.size > 0 ? args.first : true
		  if is_true		
            joins(:tracker).
            where(trackers: {category_id: TrackerCategory::CATEGORY_TASK})
		  else
            joins(:tracker).		  
            where(Tracker.not_task_condition)		  		  
          end		  
        }
      end
    end
  end
  
  module InstanceMethods  
    def update_rules	  	  
	  if (self.tracker.task?) 
	    if RedmineTrackerCategory.force_task_private? && !self.is_private? && self.safe_attribute?("is_private")
	      logger.debug "PluginRedmineTrackerCategory: issue: #{self.id}: force is_private to true"
	      self.is_private=true
		end  		
	  end
    end
    
    def validate_rules
		if RedmineTrackerCategory.demand_over_demand_forbidden?
			if self.tracker.present? && self.parent_issue_id.present?
				parents_ids = Issue.find(self.parent_issue_id).ancestors.map{|i| i.id}.push(self.parent_issue_id)		
				if self.tracker.demand? && (Issue.where(id: parents_ids).demands.size > 0)
					errors.add(:tracker_id,l(:error_demand_over_demand))
				end
			end
		end
	  		
		if RedmineTrackerCategory.task_without_parent_forbidden? || RedmineTrackerCategory.task_without_demand_forbidden? 
			if self.tracker.present? && self.tracker.task?
				if self.parent_issue_id.nil?
					errors.add(:tracker_id,l(:error_tasks_without_parent))
				elsif RedmineTrackerCategory.task_without_demand_forbidden?
					parents_ids = Issue.find(self.parent_issue_id).ancestors.map{|i| i.id}.push(self.parent_issue_id)
					errors.add(:tracker_id,l(:error_tasks_without_demand)) if Issue.where(id: parents_ids).demands.empty?			
				end
			end	  
		end	  
    end
  end
end

unless Issue.included_modules.include? RedmineTrackerCategory::Patches::IssuePatch
  Issue.send(:include, RedmineTrackerCategory::Patches::IssuePatch)
end