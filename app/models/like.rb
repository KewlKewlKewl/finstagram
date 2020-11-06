class Like < ActiveRecord::Base

    belongs_to :user
    belongs_to :finstagram_post
    
    validates :user, :finstagram_post, presence: true
end