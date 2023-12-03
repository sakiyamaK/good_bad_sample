import 'package:intl/intl.dart';

// 社内の顧客管理システムとする

extension StringExtension on String {
  DateTime get date {
    return DateFormat('yyyy-MM-dd').parse(this);
  }
}

extension DateTimeExtension on DateTime {
  bool check({required DateTimeComponent component, required int value}) {
    return this
        .isBefore(DateTime.now().add(_durationFromComponent(component, value)));
  }
}

// DartにはCalendar.Componentがないため、独自の列挙型を作成
enum DateTimeComponent { day, month, year }

Duration _durationFromComponent(DateTimeComponent component, int value) {
  switch (component) {
    case DateTimeComponent.day:
      return Duration(days: value);
    case DateTimeComponent.month:
      return Duration(days: value * 30); // 簡易計算
    case DateTimeComponent.year:
      return Duration(days: value * 365); // 簡易計算
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

  final bool intern;

  Employee(
      {required this.id,
      required this.name,
      required this.createdAt,
      required this.intern,
      this.deletedAt});

  // インターンが間違って優良ユーザを削除してしまった！
  // 顧客を削除できる社員を限定しよう！
  // 仕様変更に合わせてコメントを更新

  /*
   [ここのコメントが話の中心]
   社員が顧客を削除する
   */
  void delete(User user) {
    if (intern) {
      print("$nameはユーザを削除する権限がありません");
      return;
    }
    user.deletedAt = DateTime.now();
    // apiを叩いて登録
    print("$nameはユーザを削除しました");
  }
}

void main() {
  // 本当はDBからもらうデータ
  var blackUser = User(id: 1, name: "他からクレームがきまくったユーザ");
  var employee1 =
      Employee(id: 1, name: "あなた", createdAt: "2000-10-01".date, intern: false);
  var employee2 = Employee(
      id: 2, name: "インターン", createdAt: "2010-10-01".date, intern: true);

  employee1.delete(blackUser);
  employee2.delete(blackUser);
}
