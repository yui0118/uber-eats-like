module Api
  module V1
    class FoodsController < ApplicationController
      def index
        # パラメーターで受け取った店舗IDに対応するレストランの情報を１つ取得する
        # restaurant_idのレストランの食べ物を全て取得する
        # JSON形式で指定のレストランにある食べ物一覧データを返却
        restaurant = Restaurant.find(params[:restaurant_id])
        foods = restaurants.foods
        render json: {
          foods: foods
        }, status: :ok
      end
    end
  end
end
