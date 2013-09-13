class Article < ActiveRecord::Base
  belongs_to :user
  has_many :votes
  
  validates :title, presence: true
  validates :content, presence: true
  
  def self.index_query(page)
    order('votes_count DESC, created_at DESC').includes(:votes).page(page).per(15)
  end
  
  def is_vote?
    Vote.where(user_id: self.user_id, article_id: self.id).length == 0 ? true : false
  end
end
