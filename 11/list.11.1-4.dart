import 'package:intl/intl.dart';

// 社内の顧客管理システムとする

extension StringExtension on String {
  DateTime get date {
    return DateFormat('yyyy-MM-dd').parse(this);
  }
}

// DartにはCalendar.Componentがないため、独自の列挙型を作成
enum DateTimeComponent { day, month, year }

// 顧客
class User {
  final int id;
  final String name;
  DateTime? deletedAt;

  User({required this.id, required this.name, this.deletedAt});
}

// 社員
class Employee {
  final int id;
  final String name;
  final DateTime createdAt;
  DateTime? deletedAt;

  final AccountType accountType;

  Employee(
      {required this.id,
      required this.name,
      required this.createdAt,
      this.deletedAt,
      required this.accountType});

  // インターンが間違って優良ユーザを削除してしまった！
  // 顧客を削除できる社員を限定しよう！
  // 仕様変更に合わせてコメントを更新

  //
  // 新人が間違って優良ユーザを削除してしまった！
  // 顧客を削除できる社員を限定しよう！
  // 仕様変更に合わせてコメントを更新

  //
  // 退職者が間違って優良ユーザを削除してしまった！
  // 顧客を削除できる社員を限定しよう！
  // だけど
  // bool判定が多すぎて辛くなってきたので、
  // そもそもEmployeeに管理者権限や通常社員などの状態を持たせよう
  // 仕様変更に合わせて"大幅に実装"を更新
  // =========================================
  // その結果、コメントの更新を忘れて実装と合わなくなる
  // 仕様としてはどっちが正しいのか！？
  // =========================================

  /*
     [ここのコメントが話の中心]
     インターンと新人社員以外の社員が顧客を削除する
     */
  void delete(User user) {
    if (!accountType.enableDeleteUser) {
      print("$nameはユーザを削除する権限がありません");
      return;
    }

    user.deletedAt = DateTime.now();
    // apiを叩いて登録
    print("$nameはユーザを削除しました");
  }
}

enum AccountType {
  admin,
  normal,
  intern,
  deleted;

  bool get enableDeleteUser {
    switch (this) {
      case AccountType.admin:
        return true;
      default:
        return false;
    }
  }
}

void main() {
  // 本当はDBからもらうデータ
  var blackUser = User(id: 1, name: "他からクレームがきまくったユーザ");
  var employee1 = Employee(
      id: 1,
      name: "あなた",
      createdAt: "2000-10-01".date,
      accountType: AccountType.admin);
  var employee2 = Employee(
      id: 2,
      name: "インターン",
      createdAt: "2010-10-01".date,
      accountType: AccountType.intern);
  var employee3 = Employee(
      id: 4,
      name: "新人",
      createdAt: "2022-12-30".date,
      accountType: AccountType.normal);
  var employee4 = Employee(
      id: 5,
      name: "退職者",
      createdAt: "2022-12-30".date,
      accountType: AccountType.deleted);

  employee1.delete(blackUser);
  employee2.delete(blackUser);
  employee3.delete(blackUser);
  employee4.delete(blackUser);
}
