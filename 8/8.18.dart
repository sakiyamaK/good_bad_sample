class ViewSettings {}

class MailMagazine {}

// [BAD]
// どこに追いやっていいか分からない処理をUtilとかManagerに書きがち
// 結果としてそのクラスは「その他大勢」となり何をするクラスか分からなくなる
class Util {
  final int reservationId; //商品予約ID
  final ViewSettings viewSettings; //画面表示設定
  final MailMagazine mailMagazine; //メールマガジン

  Util({
    required this.reservationId,
    required this.viewSettings,
    required this.mailMagazine,
  });

  void cancelReservation() {
    // reservationIdを使った予約キャンセル処理
  }

  void darkMode() {
    // viewSettingsを使ったダークモード表示への変更処理
  }

  void beginSendMail() {
    // mailMagazineを使ったメール配信開始処理
  }
}

void main() {
  final util = Util(reservationId: 1, viewSettings: ViewSettings(), mailMagazine: MailMagazine());
}
