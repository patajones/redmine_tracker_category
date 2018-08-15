module RedmineTrackerCategory::Patches
  module TrackerPatch    
    def self.included(base)		   
       base.class_eval do          
		  belongs_to :category, :class_name => 'TrackerCategory'
	      scope :without_category, lambda {|*args|            
		    is_true = args.size > 0 ? args.first : true
			if is_true
              where("category_id is null")
		    else              
              with_category
            end
		  }
	      scope :with_category, lambda {|*args|            
		    is_true = args.size > 0 ? args.first : true
			if is_true
              where("category_id not is null")
		    else              
              without_category
            end
		  }
	      scope :demands, lambda {|*args|
		    is_true = args.size > 0 ? args.first : true
			if is_true
              where("category_id = ?", TrackerCategory::CATEGORY_DEMAND)
		    else              
              where("category_id is null or category_id <> ?", TrackerCategory::CATEGORY_DEMAND)
            end
		  }
	      scope :tasks, lambda {|*args|
		    is_true = args.size > 0 ? args.first : true
			if is_true
              where("category_id = ?", TrackerCategory::CATEGORY_TASK)
		    else              
              where("category_id is null or category_id <> ?", TrackerCategory::CATEGORY_TASK)
            end
		  }
      end
      base.extend(ClassMethods)
	  base.send(:include, InstanceMethods)	 	   
    end  
	module ClassMethods
	  def not_demand_condition
	      a = Tracker.demands(false).collect{|t|t.id}    	  
		  result = "trackers.id in (" + a.join(",") + ")"
	  end
	  def not_task_condition
	      a = Tracker.tasks(false).collect{|t|t.id}    	      	  
		  result = "trackers.id in (" + a.join(",") + ")"
	  end	  
	end
    module InstanceMethods 			
	  def demand?
		self.category.nil? ? false : self.category.id == TrackerCategory::CATEGORY_DEMAND
	  end
	  
	  def task?
		self.category.nil? ? false : self.category.id == TrackerCategory::CATEGORY_TASK
	  end	
	end	
  end
end

unless Tracker.included_modules.include? RedmineTrackerCategory::Patches::TrackerPatch
    Tracker.send(:include, RedmineTrackerCategory::Patches::TrackerPatch)
end
