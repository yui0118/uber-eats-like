import React, { Fragment } from "react";
import { useEffect } from "react";
// api関数をimport
import { fetchRestaurants } from "../apis/restaurants";

export const Restaurants = () => {
  // useEffectを使ってコンポーネントの初期レンダリング時にのみAPI関数を一度だけ呼ぶ
  // API関数の実行が成功した場合は、関数がres.dataを返すので、その結果を(data)というかたちで受け取り、APIの返り値をコンソールに出力する
  useEffect(() => {
    fetchRestaurants().then((data) => console.log(data));
  }, []);
  return <Fragment>レストラン一覧</Fragment>;
};
