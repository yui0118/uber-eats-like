// URLの文字列を定数として定義する
// サーバーサイドで定義したURL文字列を返す定数をいくつか定義

// apiを叩く際の基本となるURL
const DEFAULT_API_LOCALHOST = "http://localhost:3000/api/v1";

// レストラン一覧のURL
export const restaurantsIndex = `${DEFAULT_API_LOCALHOST}/restaurants`;
// レストランに紐づく食べ物一覧のURL
// foodsIndexはURL文字列の途中に任意のrestaurantIdが入るため、引数にrestaurantIdを受け取り、それを文字列の中に展開している
export const foodsIndex = (restaurantId) =>
  `${DEFAULT_API_LOCALHOST}/restaurants/${restaurantId}/foods`;
export const lineFoods = `${DEFAULT_API_LOCALHOST}/line_foods`;
export const lineFoodsReplace = `${DEFAULT_API_LOCALHOST}/line_foods/replace`;
// 注文URL
export const orders = `${DEFAULT_API_LOCALHOST}/orders`;
