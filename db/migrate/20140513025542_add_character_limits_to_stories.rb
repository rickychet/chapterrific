class AddCharacterLimitsToStories < ActiveRecord::Migration
  def change
    add_column :stories, :lower_limit, :integer
    add_column :stories, :upper_limit, :integer
  end
end
