import React, { Fragment } from "react";
// ルーティング時にReact Routerを使って、restaurantsIdをpropsとして受け取りたい場合
// React Routerでは、matchオブジェクトをpropsとして受け取り、match.params.resutaurantsIdのかたちでPATHからパラメーターを抽出することができます。
export const Foods = ({ match }) => {
  return (
    <Fragment>
      フード一覧
      <p>restaurantsIdは、{match.params.restaurantsId}です</p>
    </Fragment>
  );
};
