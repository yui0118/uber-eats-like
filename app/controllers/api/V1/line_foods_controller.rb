module Api
  module V1
    class LineFoodsController < ApplicationController
      before_action :set_food, only: %i[create replace] # アクションの実行前にset_foodフィルタを実行

      # 仮注文の一覧表示メソッド
      def index
        # 全ての仮注文の中から、activeなもの(active: trueなLineFood)の一覧を取得して、line_foodsという変数に代入
        # activeは、LineFoodモデルのスコープで、active: trueなLineFoodの一覧をモデル名.スコープ名の形で取得できる
        line_foods = LineFood.active 
        if line_foods.exists? # 仮注文のインスタンスのデータがDBに存在するかどうかを確認
          render json: { # DBにデータが存在する場合、仮注文インスタンスから取得した情報をJSON形式で返す
            line_food_ids: line_foods.map { |line_food| line_food.id }, # 仮注文インスタンスのidを配列形式で取得
            restaurant: line_foods[0].restaurant, # 仮注文した中から先頭の仮注文した食べ物を販売する店舗の情報
            count: line_foods.sum { |line_food| line_food[:count] }, # 仮注文した食べ物の個数の合計値
            amount: line_foods.sum { |line_food| line_food.total_amount }, # 仮注文した食べ物の合計金額を「数量 × 単価」で計算
          }, status: :ok
        else # activeな仮注文インスタンスが一つもDBに存在しない場合、例外を発生させるのではなく
          # JSON形式の空データと「リクエストは成功したが、空データ」のステータスコード204を返します
          render json: {}, status: :no_content
        end
      end


      # 仮注文の作成メソッド
      def create
        # 他店舗での仮注文がすでにある場合は、JSON形式のデータを返却してreturn文で処理を終了するようにif文で条件分岐を行う。
        # activeとother_restaurantは、scopeで定義したクエリメソッドです。
        # other_restaurantの引数に現在仮注文しようとしているレストランのidを渡しています。
        # JSON形式のデータは、existing_restaurantですでに仮注文が作成されていた他店舗の情報と、new_restaurantでこのリクエストで作成しようとした新店舗の情報の２つを返します。
        # HTTPレスポンスステータスコードはサーバは要求されたページをクライアントが受け入れ可能な形式で送信することが出来ないという意味の406 Not Acceptableを返します。
        if LineFood.active.other_restaurant(@orderd_food.restautant.id).exists?
          return render json: {
            existing_restautant: LineFood.other_restaurant(@ordered_food.restaurant.id).first.restaurant.name, # 既に仮注文が作成されていた他店舗名
            new_restaurant: Food.find(params[:food_id]).restaurant.name, # 新規に仮注文を作成しようとしていた現在選択中の店舗名
          }, status: :not_acceptable # サーバは要求されたページをクライアントが受け入れ可能な形式で送信できない
        end

        # 例外パターンに当てはまらず、正常に仮注文を作成する場合は、set_line_food(@ordered_food)で仮注文インスタンスを生成
        set_line_food(@ordered_food)

        # 仮注文インスタンスをDBに保存する
        if @line_food.save # DBへの保存が成功した場合、
          render json: { # リクエストが成功してリソースの作成が完了したことを表す201 Createdと保存したデータを返します
            line_food: @line_food
          }, status: :created
        else # DBへの保存時にエラーが発生した場合、
          render json{}, status: :internal_server_error # サーバー側で処理方法がわからない事態が発生したことを示す500 Internal Server Errorをブラウザに表示
        end
      end

      def replace
        # 他店舗のactiveな仮注文商品一覧を論理削除する(activeカラムをfalseにする)
        LineFood.active.other_restaurant(@ordered_food.restaurant.id)each do |line_food|
          line_food.update_attribute(:active, false)
        end

        # 現在選択されている商品の仮注文インスタンスを作成する
        set_line_food(@ordered_food)

        # 仮注文インスタンスをDBに保存する
        if @line_food.save
          render json: {
            line_food: @line_food
          }, status: :created
        else
          # 失敗した場合はstatus: :internal_server_errorと空データを返す
          render json: {}, status: :internal_server_error
        end
      end

      private

      # 仮注文しようと現在選択中の食べ物をfood_idで取得するメソッド
      # params[:food_id]を受け取って、対応するFoodを１つ抽出し、@ordered_foodというインスタンス変数に代入
      def set_food
        @ordered_food = Food.find(params[:food_id])
      end

      # 仮注文インスタンス作成メソッド
      # 引数ordered_foodには、仮注文した食べ物インスタンスが入ってきます。
      # すでに同じ食べ物に関する仮注文が存在する場合とその食べ物に関する仮注文を新たに作成する場合で処理を分岐する
      def set_line_food(ordered_food)
        if ordered_food.line_food.present? # すでに同じ食べ物に関する仮注文が存在する場合
          @line_food = ordered_food.line_food # 既存の仮注文した食べ物に関する情報(count、active)を取得する
          @line_food.attributes = { # 仮注文インスタンスの既存の情報をattributes=メソッドで更新する
            count: ordered_food.line_food.count + params[:count], # 既存の注文した個数に現在の注文を上書き
            active: true # 仮注文で選択されていることを有効にする
          }
        else # 新しくその食べ物に関する仮注文を作成する場合
          @line_food = ordered_food.build_line_food( # 現在選択している食べ物の仮注文インスタンスを新規に作成
            count: params[:count], # 仮注文した食べ物の個数をparams[:count]で受け取り登録する
            restautant: ordered_food.restaurant, # 仮注文した食べ物に紐づく店舗のIDを登録する
            active: true # 仮注文で選択されていることを有効にする
          )
        end
      end
    end
  end
end
