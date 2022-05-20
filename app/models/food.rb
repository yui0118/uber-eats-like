# 商品テーブル
# create_table "foods", force: :cascade do |t|
#   t.integer "restaurant_id", null: false  # 店舗のID(外部キー)
#   t.string "name", null: false            # 商品名
#   t.integer "price", null: false          # 商品価格
#   t.text "description", null: false       # 商品の説明文章
#   t.datetime "created_at", precision: 6, null: false
#   t.datetime "updated_at", precision: 6, null: false
#   t.index ["restaurant_id"], name: "index_foods_on_restaurant_id"
# end

class Food < ApplicationRecord
  belongs_to :restaurant
  belongs_to :order, optional: true # optional: trueで外部キーorder_idのnilを許可する
  has_one :line_food # LineFoodモデルとFoodモデルは1:1の関係にある
end
