class AddEditorIdToStories < ActiveRecord::Migration
  def change
    add_column :stories, :editor_id, :integer
  end
end
