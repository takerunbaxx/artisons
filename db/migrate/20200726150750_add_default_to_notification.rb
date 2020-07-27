class AddDefaultToNotification < ActiveRecord::Migration[5.2]
  def change
    
    change_column_default :notifications, :checked, false
    
    change_column_null :notifications, :checked, false
    
  end
end
