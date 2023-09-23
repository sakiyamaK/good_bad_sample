// 9.5
// グローバル変数

/* 
どのクラスや構造体にも含まれずいつでもどこからでもアクセスできるパラメータ
*/

// グローバル変数
var userName = "イーロソ・マクソ"

struct User {
  let name: String
}

func tapUserName() {
  let user = User(name: "スティーデブ・ジョブズ")

  /* 
  色々な処理
  */

  //****** しれっとグローバル変数を書き換え ******/
  userName = "ビル・ゲロツ"

  /* 
  色々な処理
  */

  // 本来は画面に出す
  print(user.name)
}

func tapFollowButton() {
  let user = User(name: "マーク・ザッカーバーカ")

  /* 
  色々な処理
  */

  // 本来は画面に出す
  print(user.name)
  // イーロソ・マクソと出るはずなのにビル・ゲロツと出ちゃった！！
  print(userName)
}

tapUserName();
tapFollowButton();

/*
グローバル変数は影響範囲を最小限にするという設計の真逆

どこからでもアクセスできるということは
・グローバル変数の修正は全てのソースコードに影響を及ぼす
・グローバル変数を呼び出している箇所は全てのソースコードから影響を受ける

1万行のプロジェクトの1行1行の全てが影響し合うことになる
*/

/*
ただし、絶対に使ってはいけないわけではない
システム上、本当にひとつしかないものが分かれるとそれはそれでバグが起きる
スマホの現在地、OSやアプリのバージョンなど
これらをローカル変数にすると、
タブで分かれてる画面で、Aの画面では現在地は東京、Bの画面では更新を忘れて現在地が大阪、とか起きたりする

結局は良し悪し
影響範囲が小さい設計 = 同じ修正をあちこちしなくちゃいけなくなる場合がある
影響範囲が大きい設計 = １箇所の修正が全体に影響を及ぼす

意識して影響範囲を制御できることが大事
*/