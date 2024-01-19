import Foundation

enum ThemeMode {
    case normal, dark
}

// ECサイトのユーザモデル
struct User {
  let id: Int
  let name: String
  let email: String
  let passwordDigest: String //ユーザモデル自体にこれいる？

  /*
   ユーザの住所等の情報が追加された
   */
  let address: String
  let phoneNumber: String
  let bio: String
  let urlStr: String
  var url: URL? { URL(string: urlStr) }
  let discountPoint: Int
  let themeMode: ThemeMode
  let birthday: Date
  // その他多くのインタスンタス変数

  /*
  さらに自社以外も出品できるように仕様変更になった
  他の事業者もユーザモデルで管理するために <-- [BAD]
  法人番号を追加した
   */
   let corporationNumber: String
}

/*
 [BAD]
 事業者がログインするクラスも用意
 
 すると書籍で書いてるようなトラブルが続出した
*/
final class CorporationManager {
  static let shared: CorporationManager = .init()
  private init() {}

  private(set) var loginedUser: User?

  func createUser(name: String, email: String, password: String) throws -> Void {
      // 本来はサーバーと通信してユーザ作成
//      loginedUser = User(id: 1, name: name, email: email, passwordDigest: password)
  }

  func loginUser(email: String, password: String) throws -> Void {
      // 本来はサーバーと通信してログイン
//      loginedUser = User(id: 1, name: name, email: email, passwordDigest: password)
  }

  func delete(user: User) throws -> Void {
      // 本来はサーバーと通信して削除
      loginedUser = nil
  }
}

/*
 Userモデルの仕様変更により書籍によるトラブルが発生するようになった
 */
final class LoginManager {
  static let shared: LoginManager = .init()
  private init() {}

  private(set) var loginedUser: User?

  func createUser(name: String, email: String, password: String) throws -> Void {
      // 本来はサーバーと通信してユーザ作成
//      loginedUser = User(id: 1, name: name, email: email, passwordDigest: password)
  }

  func loginUser(email: String, password: String) throws -> Void {
      // 本来はサーバーと通信してログイン
      // loginedUser = User(id: 1, name: "", email: "", passwordDigest: "")
  }

  func delete(user: User) throws -> Void {
      // 本来はサーバーと通信して削除
    // loginedUser = nil
  }
}

