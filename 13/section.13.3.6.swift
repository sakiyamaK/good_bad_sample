
// 書籍では商品のモデル図だが、これまでUserで説明していたのだからユーザモデルでやる

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
struct UserForOthers {
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