class AddOutlineToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :outlines, :text
  end
end
