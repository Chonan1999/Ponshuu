class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  attachment :profile_image
  attachment :image
end
