class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title, :null => false, :default => ""
      t.text :content, :null => false, :default => ""
      t.integer :user_id, index: true

      t.timestamps
    end
  end
end
