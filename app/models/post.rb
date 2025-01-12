class Post < ApplicationRecord
  has_one_attached :image  # 投稿画像の管理（Active Storage）
  
  belongs_to :user
  belongs_to :category
  has_many :comments, dependent: :destroy

  after_initialize :set_default_category, if: :new_record?

  scope :published, -> { where(status: "published") }
  enum status: { published: 0, draft: 1 }

  private

  def set_default_category
    self.category_id ||= Category.find_by(name: "純米系")&.id
  end
end
