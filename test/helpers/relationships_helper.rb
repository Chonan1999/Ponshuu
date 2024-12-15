module RelationshipsHelper
    def follow_button(user)
      return if current_user == user  # 自分自身にはボタンを表示しない
  
      if current_user.following?(user)
        # フォロー中の状態
        content_tag(:div, id: "follow-button") do
          button_to "フォロー中", relationship_path(current_user.active_relationships.find_by(followed_id: user.id)),
                    method: :delete, remote: true, class: "btn btn-success"
        end
      else
        # フォローしていない状態
        content_tag(:div, id: "follow-button") do
          button_to "フォローする", relationships_path(followed_id: user.id),
                    method: :post, remote: true, class: "btn btn-primary"
        end
      end
    end
  end
  