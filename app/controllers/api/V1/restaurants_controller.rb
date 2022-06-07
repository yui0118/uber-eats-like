module Api # moduleで名前空間を指定
  module V1 # api/v1/ディレクトリにあるrestaurants_controller
    class RestaurantsController < ApplicationController
      def index
        # Restaurantモデルのデータを全て取得して、restaurantsという変数に代入
        restaurants = Restaurant.all
        render json: { # JSON形式でデータを返却
          restaurants: restaurants
        }, status: :ok # リクエストが成功した場合に返すレスポンスコード200 OKをデータと一緒に返す
      end
    end
  end
end
