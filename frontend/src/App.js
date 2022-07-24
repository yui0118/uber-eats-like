import React from "react";
import "./App.css";
// ReactRouterは、URLとコンポーネントを紐づける役割を担う
// React Routerは、JavaScriptを使ってページ内の更新が必要な箇所のみ更新を行います(SPA)
import { BrowserRouter as Router, Switch, Route } from "react-router-dom";

// コンポーネントのimport
// データを持つコンポーネントは、containers/配下
// データをなるべく持たないコンポーネントは、components/配下
import { Restaurants } from "./containers/Restaurants.jsx";
import { Foods } from "./containers/Foods.jsx";
import { Orders } from "./containers/Orders.jsx";

export default function App() {
  return (
    // ３つのコンポーネントをReact Routerでルーティングさせる
    // <Router>...</Router>で全体を囲み、ルーティング先のコンポーネントを<Switch>...</Switch>で囲みます。
    // <Route>...</Route>で実際の１ページへのルーティングを表します。
    // <Route>にpropsを渡すことでリクエストに対応して囲ったコンポーネントを描画します。
    // exactというpropsをtrueにすると、PATHの完全一致の場合にのみコンポーネントをレンダリングするようになります。
    // pathというpropsには、設定したいパスを持たせるようにします。
    <Router>
      <Switch>
        {/* 店舗一覧ページ */}
        <Route exact path="/restaurants">
          <Restaurants />
        </Route>
        {/* フード一覧ページ */}
        {/* Foodsコンポーネントにmatchというpropsを渡しながら、設定したPATHに対応するリクエストがあった場合にパラメーターと一緒にFoodsコンポーネントをレンダリング */}
        <Route
          exact
          path="/restaurants/:restaurantsId/foods"
          render={({ match }) => <Foods match={match} />}
        />
        {/* 注文ページ */}
        <Route exact path="/orders">
          <Orders />
        </Route>
      </Switch>
    </Router>
  );
}
