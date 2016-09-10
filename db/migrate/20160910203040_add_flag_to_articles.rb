class AddFlagToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :moderated, :boolean
  end
end
