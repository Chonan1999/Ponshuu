class AddDefaultCategories < ActiveRecord::Migration[7.1]
  def up
    ["純米系", "吟醸系", "本醸造系", "普通酒"].each do |category_name|
      Category.create!(name: category_name) unless Category.exists?(name: category_name)
    end
  end

  def down
    Category.where(name: ["純米系", "吟醸系", "本醸造系", "普通酒"]).destroy_all
  end
end
