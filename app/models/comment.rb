class Comment < ActiveRecord::Base

    belongs_to :user
    belongs_to :finstagram_post

    validates :user, :text, :finstagram_post, presence: true

end