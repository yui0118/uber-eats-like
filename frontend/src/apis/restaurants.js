// axiosは、フロントエンドでHTTP通信を行う際に必要な処理をまとめて行ってくれるライブラリ
// APIを叩くURLを専用ファイルから参照する
import axios from "axios";
import { restaurantsIndex } from "../urls";

// レストラン一覧のAPIを呼ぶ関数を定義する
// コンポーネントからこの関数fetchRestaurants()を叩けば、サーバーサイドのAPIを叩いて、JSON形式のデータが返ってくるようになる
// axios.getで、引数のURLに対して、GETリクエストを行う
// axiosは、Promiseベースなので、非同期処理で、リクエストを実行します。
// GETリクエストが成功した場合は、then以降の(res.dataでレスポンスの中身を返す)処理を実行し、
// 失敗した場合は、catch以降の処理を実行する。
export const fetchRestaurants = () => {
  return axios
    .get(restaurantsIndex)
    .then((res) => {
      return res.data;
    })
    .catch((e) => console.error(e));
};
