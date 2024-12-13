class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  attachment :profile_image
  attachment :image

  scope :published, -> { where(status: 'published') }
  enum status: { published: 0, draft: 1 }

end
