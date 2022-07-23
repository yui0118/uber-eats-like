// 複数のコンポーネント、関数、モジュールから参照されるAPIリクエストに関する定数を定義する

// APIリクエスト中の画面の状態を表す定数
// REQUEST_STATE.LOADINGは、APIリクエスト中
// REQUEST_STATE.OKは、APIリクエスト成功
export const REQUEST_STATE = {
  INITIAL: "INITIAL",
  LOADING: "LOADING",
  OK: "OK",
};

export const HTTP_STATUS_CODE = {
  NOT_ACCEPTABLE: 406,
};
