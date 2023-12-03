import 'package:intl/intl.dart';

// 社内の顧客管理システムとする

extension StringExtension on String {
  DateTime get date {
    return DateFormat('yyyy-MM-dd').parse(this);
  }
}

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

  // よし！コメントは悪なんだな！
  // じゃあコメントは消してメソッド名で分かるようにしよう！

  // [BAD]
  // メソッド名に詳細に実装状況を書いてこれではコメントを書いてるのと変わらない
  // つまりロジックが変わった時にメソッド名と合わなくなる
  /*
     [ここのコメントが話の中心]
     */
  void deleteIfEmployeeIsNotInternAndIsNotNewWokerAndIsNotDeleted(User user) {
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

  bool get enableDeleteUser => this == AccountType.admin;
}

void main() {
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

  employee1
      .deleteIfEmployeeIsNotInternAndIsNotNewWokerAndIsNotDeleted(blackUser);
  employee2
      .deleteIfEmployeeIsNotInternAndIsNotNewWokerAndIsNotDeleted(blackUser);
  employee3
      .deleteIfEmployeeIsNotInternAndIsNotNewWokerAndIsNotDeleted(blackUser);
  employee4
      .deleteIfEmployeeIsNotInternAndIsNotNewWokerAndIsNotDeleted(blackUser);
}
