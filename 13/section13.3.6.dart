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
・事業者でああるかどうか
*/

import 'dart:core';

enum ThemeMode { normal, dark }

// ログインした時に得られるユーザ情報
/*
目的
メールとパスワードでログインできたユーザかどうか
インスタンスが生成できたということは正しいユーザ
*/
class LoginUser {
  final int id;
  final String email;
  final String passwordDigest;

  LoginUser(
      {required this.id, required this.email, required this.passwordDigest});
}

// 他人から見たユーザ情報
/*
目的
外部に公開する
*/
class UserForOthers {
  final int id;
  final String email;
  final String address;
  final String bio;
  final String urlStr;
  late final Uri url;
  final DateTime birthday;

  UserForOthers({
    required this.id,
    required this.email,
    required this.address,
    required this.bio,
    required this.urlStr,
    required this.birthday,
  }) {
    url = Uri.parse(urlStr);
  }
}

// 自分が見たユーザ情報
/*
目的
自身の個人情報が正しいか一覧で確認する
*/
class UserForSelf {
  final int id;
  final String name;
  final String email;
  final String passwordDigest; //ユーザモデル自体にこれいる？
  final String address;
  final String phoneNumber;
  final String bio;
  final String urlStr;
  late final Uri url;
  final int discountPoint;
  final DateTime birthday;

  UserForSelf({
    required this.id,
    required this.name,
    required this.email,
    required this.passwordDigest,
    required this.address,
    required this.phoneNumber,
    required this.bio,
    required this.urlStr,
    required this.discountPoint,
    required this.birthday,
  }) {
    url = Uri.parse(urlStr);
  }
}

// 配送時にサーバーに送るユーザ情報
/*
目的
配送
住所等はサーバー側にあるのでidさえ分かればいい
*/
class UserForSendItem {
  final int id;

  UserForSendItem({required this.id});
}

// ログイン中のユーザの表示モード
/*
目的
ダークモードが標準モードか知る
*/
class UserForThemeMode {
  final int id;
  final ThemeMode themeMode;

  UserForThemeMode({required this.id, required this.themeMode});
}

// ログインした時に得られる事業者情報
/*
目的
メールとパスワードでログインできた事業者かどうか
インスタンスが生成できたということは正しい事業者
*/
class LoginCorporation {
  final int id;
  final String corporationNumber;
  final String email;
  final String passwordDigest;

  LoginCorporation({
    required this.id,
    required this.corporationNumber,
    required this.email,
    required this.passwordDigest,
  });
}

// 他人から見た事業者情報
/*
目的
外部に公開する
*/
class CorporationForOthers {
  final int id;
  final String corporationNumber;
  final String email;
  final String address;
  final String bio;
  final String urlStr;
  late final Uri url;

  CorporationForOthers({
    required this.id,
    required this.corporationNumber,
    required this.email,
    required this.address,
    required this.bio,
    required this.urlStr,
  }) {
    url = Uri.parse(urlStr);
  }
}

// 配送時にサーバーに送る事業者情報
/*
目的
配送
住所等はサーバー側にあるのでidさえ分かればいいが一応事業者番号も入れてる
*/
class CorporationForSendItem {
  final int id;
  final String corporationNumber;

  CorporationForSendItem({
    required this.id,
    required this.corporationNumber,
  });
}

main() {}
