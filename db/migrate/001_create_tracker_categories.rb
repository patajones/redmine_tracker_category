class CreateTrackerCategories < ActiveRecord::Migration

  def self.up    
    create_table :tracker_categories do |t|
      t.string :name, null: false
    end
    TrackerCategory.create!(name: 'External Demand')
    TrackerCategory.create!(name: 'Internal Task')    
  end
  
  def self.down
    drop_table :tracker_categories
  end  
end
