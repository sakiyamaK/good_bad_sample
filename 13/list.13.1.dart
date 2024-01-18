import 'dart:core';

// ECサイトのユーザモデル
class User {
  final int id;
  final String name;
  final String email;
  final String passwordDigest; // ユーザモデル自体にこれいる？

  User(this.id, this.name, this.email, this.passwordDigest);
}

class LoginManager {
  static final LoginManager shared = LoginManager._();
  User? loginedUser;

  LoginManager._();

  Future<void> createUser(String name, String email, String password) async {
    // 本来はサーバーと通信してユーザ作成
    loginedUser = User(1, '', '', '');
  }

  Future<void> loginUser(String email, String password) async {
    // 本来はサーバーと通信してログイン
    loginedUser = User(1, '', '', '');
  }

  Future<void> delete(User user) async {
    // 本来はサーバーと通信して削除
    loginedUser = null;
  }
}
