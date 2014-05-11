class AddAdditionToStories < ActiveRecord::Migration
  def change
    add_column :stories, :addition, :text
  end
end
