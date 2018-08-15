class ChangeTrackers < ActiveRecord::Migration

  def change
    add_column :trackers, :category_id, :integer
  end

end