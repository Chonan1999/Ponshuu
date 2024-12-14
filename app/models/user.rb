class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # 投稿とコメント
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy

  # フォロー関連の設定
  has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followings, through: :active_relationships, source: :followed

  has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followers, through: :passive_relationships, source: :follower

  attachment :profile_image

    # ユーザーをフォローする
    def follow(user_id)
      active_relationships.create(followed_id: user_id)
    end
  
    # ユーザーのフォローを外す
    def unfollow(user_id)
      active_relationships.find_by(followed_id: user_id)&.destroy
    end
  
    # フォローしていればtrueを返す
    def following?(user)
      followings.include?(user)
    end  

end
