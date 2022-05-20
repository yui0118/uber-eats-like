# 店舗テーブル
# create_table "restaurants", force: :cascade do |t|
#   t.string "name", null: false             # 店舗名
#   t.integer "fee", default: 0, null: false # 配送手数料
#   t.integer "time_required", null: false   # 配送にかかる時間
#   t.datetime "created_at", precision: 6, null: false
#   t.datetime "updated_at", precision: 6, null: false
# end

class Restaurant < ApplicationRecord
  # アソシエーション定義
  has_many :foods
  has_many :line_foods, through::foods

  # バリデーションを定義
  validates :name, :fee, :time_required, presence: true # カラムのデータが必ず存在する
  validates :name, length: { maximum: 30 } # 文字数を最大30文字以下に制限
  validates :fee, numericality: { greater_than :0 } # fee(手数料)が0以上の数値であること
end
