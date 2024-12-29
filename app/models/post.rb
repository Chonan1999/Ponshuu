class Post < ApplicationRecord
  has_one_attached :image
  belongs_to :user
  belongs_to :category
  after_initialize :set_default_category, if: :new_record?
  has_many :comments, dependent: :destroy
  attachment :profile_image
  attachment :image

  scope :published, -> { where(status: "published") }
  enum status: { published: 0, draft: 1 }

  private

  def set_default_category
    self.category_id ||= Category.find_by(name: "純米系")&.id
  end

end
