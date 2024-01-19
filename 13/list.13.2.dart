import 'dart:core';

enum ThemeMode { normal, dark }

// ECサイトのユーザモデル
class User {
  final int id;
  final String name;
  final String email;
  final String passwordDigest; // ユーザモデル自体にこれいる？

  /*
   ユーザの住所等の情報が追加された
   */
  final String address;
  final String phoneNumber;
  final String bio;
  final String urlStr;
  final int discountPoint;
  final ThemeMode themeMode;
  final DateTime birthday;
  // その他多くのインスタンス変数

  /*
  さらに自社以外も出品できるように仕様変更になった
  他の事業者もユーザモデルで管理するために <-- [BAD]
  法人番号を追加した
   */
  final String corporationNumber;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.passwordDigest,
    required this.address,
    required this.phoneNumber,
    required this.bio,
    required this.urlStr,
    required this.discountPoint,
    required this.themeMode,
    required this.birthday,
    required this.corporationNumber,
  });

  // URLのパースを行う関数を追加
  Uri? get url => Uri.parse(urlStr);
}

/*
 [BAD]
 事業者がログインするクラスも用意
 
 すると書籍で書いてるようなトラブルが続出した
*/
class CorporationManager {
  static final CorporationManager shared = CorporationManager._();
  User? loginedUser;

  CorporationManager._();

  Future<void> createUser(String name, String email, String password) async {
    // 本来はサーバーと通信してユーザ作成
    // loginedUser = User(1, '', '', '');
  }

  Future<void> loginUser(String email, String password) async {
    // 本来はサーバーと通信してログイン
    // loginedUser = User(1, '', '', '');
  }

  Future<void> delete(User user) async {
    // 本来はサーバーと通信して削除
    loginedUser = null;
  }
}

/*
 Userモデルの仕様変更により書籍によるトラブルが発生するようになった
 */
class LoginManager {
  static final LoginManager shared = LoginManager._();
  User? loginedUser;

  LoginManager._();

  Future<void> createUser(String name, String email, String password) async {
    // 本来はサーバーと通信してユーザ作成
    // loginedUser = User(1, '', '', '');
  }

  Future<void> loginUser(String email, String password) async {
    // 本来はサーバーと通信してログイン
    // loginedUser = User(1, '', '', '');
  }

  Future<void> delete(User user) async {
    // 本来はサーバーと通信して削除
    // loginedUser = null
  }
}

main() {}
