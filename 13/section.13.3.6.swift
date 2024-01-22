// 書籍の13.3.6のモデルの見直し

/*
・そのモデルが達成しようとしている目的をすべて洗い出す
・目的それぞれ特化したモデリングをし直す
・目的駆動名前設計にもとづき、モデルに命名する
・モデルに目的外の要素が入り込んでいる場合、さらに見直す
*/


/*
Userモデルの目的
・入力したメアドパスワードでログインできるかどうか
・他人がユーザを知る
・自身が自分の情報を知る
・そのユーザに商品を配送する
・画面の表示モード
・事業者であるかどうか
*/

// ログインした時に得られるユーザ情報
/*
目的
メールとパスワードでログインできたユーザかどうか
インスタンスが生成できたということは正しいユーザ
*/
struct LoginUser {
  let id: Int
  let email: String
  let passwordDigest: String
}

// 他人から見たユーザ情報
/*
目的
外部に公開する
*/
struct UserForOthers {
  let id: Int
  let email: String
  let address: String
  let bio: String
  let urlStr: String
  var url: URL? { URL(string: urlStr) }
  let birthday: Date
}

// 自分が見たユーザ情報
/*
目的
自身の個人情報が正しいか一覧で確認する
*/
struct UserForMe {
  let id: Int
  let name: String
  let email: String
  let passwordDigest: String //ユーザモデル自体にこれいる？
  let address: String
  let phoneNumber: String
  let bio: String
  let urlStr: String
  var url: URL? { URL(string: urlStr) }
  let discountPoint: Int
  let birthday: Date
}

// 配送時にサーバーに送るユーザ情報
/*
目的
配送
住所等はサーバー側にあるのでidさえ分かればいい
*/
struct UserForSendItem {
  let id: Int
}

// ログイン中のユーザの表示モード
/*
目的
ダークモードが標準モードか知る
*/
struct UserForThemaMode {
  let id: Int
  let themeMode: ThemeMode
}


// ログインした時に得られる事業者情報
/*
目的
メールとパスワードでログインできた事業者かどうか
インスタンスが生成できたということは正しい事業者
*/
struct LoginCoorporation {
  let id: Int
  let corporationNumber: String
  let email: String
  let passwordDigest: String
}

// 他人から見た事業者情報
/*
目的
外部に公開する
*/
struct CoorporationForOthers {
  let id: Int
  let corporationNumber: String
  let email: String
  let address: String
  let bio: String
  let urlStr: String
  var url: URL? { URL(string: urlStr) }
}

// 配送時にサーバーに送る事業者情報
/*
目的
配送
住所等はサーバー側にあるのでidさえ分かればいいが一応事業者番号も入れてる
*/
struct UserForSendItem {
  let id: Int
  let corporationNumber: String
}


/*
もちろん分けすぎるとデメリットもある
画面が変わる度にモデルを変更する必要が出たりしてめんどい
どのモデルとモデルがユーザについてなのか把握しきるのが難しい
emailの仕様がなくなった時に複数のモデルを修正する必要がある

なのでどこまで分けるかはプロジェクト次第
やろうと思えばここまで分けれる
Userモデルはひとつじゃないとダメというのは勘違い
という発想を持つことが大事
*/