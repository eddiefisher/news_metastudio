class AddVotesCountToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :votes_count, :integer
  end
end
