import Foundation

// ECサイトのユーザモデル
struct User {
  let id: Int
  let name: String
  let email: String
  let passwordDigest: String //ユーザモデル自体にこれいる？
}

final class LoginManager {
  static let shared: LoginManager = .init()
  private init() {}

  private(set) var loginedUser: User?

  func createUser(name: String, email: String, password: String) throws -> Void {
      // 本来はサーバーと通信してユーザ作成
      loginedUser = User(id: 1, name: "", email: "", passwordDigest: "")
  }

  func loginUser(email: String, password: String) throws -> Void {
      // 本来はサーバーと通信してログイン
      loginedUser = User(id: 1, name: "", email: "", passwordDigest: "")
  }

  func delete(user: User) throws -> Void {
      // 本来はサーバーと通信して削除
    loginedUser = nil
  }
}

