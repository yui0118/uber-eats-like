Rails.application.routes.draw do
  # app/controllers/api/v1/ディレクトリにあるコントローラーに対応するルーティングを作成
  namespace :api do
    namespace :v1 do
      resources :restaurants do # Restaurant一覧を取得
        resources :foods, only: %i[index] # 特定のRestaurantに紐づくFood一覧を取得
      end
      resources :line_foods, only: %i[index create] # 仮注文の一覧表示と作成
      put 'line_foods/replace', to: 'line_foods#replace' # 'line_foods/replace'というURLに対してPUTリクエストがきたら、line_foods_controller.rbのreplaceメソッドを呼ぶ
      resources :orders, only: %i[create] # 注文の作成
    end
  end
end
