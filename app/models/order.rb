# 注文確定テーブル
# create_table "orders", force: :cascade do |t|
#   t.integer "total_price", null: false            # 合計金額
#   t.datetime "created_at", precision: 6, null: false
#   t.datetime "updated_at", precision: 6, null: false
# end

class Order < ApplicationRecord
  has_many :line_foods # 仮注文を複数持つことができる

  validates :total_price, numericality: { greater_than :0 } # 注文の合計金額は、０円以上の数値のみを許容する


  # LineFoodデータの更新と、Orderデータの保存を処理するインスタンスメソッド
  # トランザクションの中で行うようにすることで、この２つの処理のいずれかが失敗した場合に全ての処理をなかったことにする
  def save_with_update_line_foods!(line_foods)
    ActiveRecord::Base.transaction do
      line_foods.each do |line_food|
        line_food.update_attributes!(active: false, order: self)
      end
      self.save!
    end
  end
end
