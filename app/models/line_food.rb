# 仮注文テーブル
# create_table "line_foods", force: :cascade do |t|
#   t.integer "food_id", null: false                # 商品ID
#   t.integer "restaurant_id", null: false          # 店舗ID
#   t.integer "order_id"                            # 注文ID
#   t.integer "count", null: false                  # 商品の注文個数
#   t.boolean "active", default: false, null: false # 仮注文が作成されているかどうかの状態
#   t.datetime "created_at", precision: 6, null: false
#   t.datetime "updated_at", precision: 6, null: false
#   t.index ["food_id"], name: "index_line_foods_on_food_id"
#   t.index ["order_id"], name: "index_line_foods_on_order_id"
#   t.index ["restaurant_id"], name: "index_line_foods_on_restaurant_id"
# end

class LineFood < ApplicationRecord
  belongs_to :food
  belongs_to :restaurant
  belongs_to :order, optional: true # optionalをtrueにすることで関連付けが任意になり、関連付けをしなくてもエラーになりません

  validates :count, numericality: { greater_than: 0 } # 注文個数は、0以上の数値をのみを許容

  # スコープ定義
  # scopeはモデルそのものや関連するオブジェクトに対するクエリメソッドを指定できる
  # activeは、全てのLineFoodからactiveレコードがtrueなものだけを取得できるクエリメソッド(仮注文がある食べ物だけを取得)
  # other_restaurantは、restaurant_idが特定の店舗IDではないもの一覧を返すクエリメソッド(他店舗に仮注文があるかどうかを確認)
  scope :active, -> { where(active: true) }
  scope :other_restaurant, -> (picked_restaurant_id) { where.not(restaurant_id: picked_restaurant_id) }

  # 仮注文の合計金額を求めるインスタンスメソッド
  def total_amount
    food.price * count
  end
end
