// [GOOD]
// 責務を分けましょう

class Reservation {
  final int id;
  
  Reservation(this.id);
  
  void cancelReservation() {
    // idを使った予約キャンセル処理
  }
}

class ViewSettings {
  void darkMode() {
    // ダークモード表示への変更処理
  }
}

class MailMagazine {
  void beginSendMail() {
    // メール配信開始処理
  }
}

void main() {
  final reservation = Reservation(1);
  final viewSettings = ViewSettings();
  final mailMagazine = MailMagazine();
  
}