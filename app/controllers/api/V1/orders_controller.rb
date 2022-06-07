module Api
  module V1
    class OrdersController < ApplicationController
      # 本注文作成メソッド
      def create
        # 仮注文時にrender jsonしたパラメーターのデータを本注文作成時にフロント側から受け取る
        # 複数の商品の仮注文インスタンスのidの配列としてパラメーターでフロントから受け取り、
        # 受け取ったパラメーターから対象のidの仮注文インスタンスを取得し、posted_line_foodsという変数に配列形式で代入
        posted_line_foods = LineFood.where(id: params[:line_food_ids])
        # 本注文インスタンスを作成
        # total_priceメソッドを使って合計金額を計算し、結果をtotal_priceカラムに追加する
        order = Order.new(
          total_price: total_price(posted_line_foods)
        )
        # 本注文インスタンスをDBに保存する(save_with_update_line_foods!メソッドは、orderモデルに定義したインスタンスメソッド)
        if order.save_with_update_line_foods!(posted_line_foods)
          render json: {}, status: :no_content # DBへの保存が成功した場合にはstatus: :no_contentと空データを返す
        else
          render json: {}, status: :internal_server_error # DBへの保存が失敗した場合にはstatus: :internal_server_errorを返す
        end

        private

        # 本注文の合計金額計算メソッド
        # total_amountは、仮注文商品の合計金額を求めるインスタンスメソッド(商品の単価 x 個数)
        def total_price(posted_line_foods)
          posted_line_foods.sum {|line_food| line_food.total_amount } + posted_line_foods.first.restaurant.fee
        end
      end
    end
  end
