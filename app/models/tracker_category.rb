class TrackerCategory < ActiveRecord::Base
  CATEGORY_DEMAND = 1
  CATEGORY_TASK = 2
  
  has_many :tracker
end
