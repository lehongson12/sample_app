class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :micropost
  
  validates :body, presence: true, length: {maximum: 300}

  scope :order_by_creation, -> { order("created_at DESC") }
end
