3.times do |n| # 3つrestaurantインスタンスを作成
  restaurant = Restaurant.new(
    name: "testレストラン_#{n}",
    fee: 100,
    time_required: 10,
  )

  12.times do |m| # 1つのrestaurantにつき12個のfoodインスタンスを作成
    restaurant.foods.build( # restaurantに紐づくfoodインスタンスを作成
      name: "フード名_#{m}",
      price: 500,
      description: "フード_#{m}の説明文です。"
    )
  end

  restaurant.save! # 生成したrestaurantインスタンスのデータをDBに保存する
end
