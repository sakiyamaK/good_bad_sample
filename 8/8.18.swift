struct ViewSettings {
}
struct MailMagazine {
}

// [BAD]
// どこに追いやっていいか分からない処理をUtilとかManagerに書きがち
// 結果としてそのクラスは「その他大勢」となり何をするクラスか分からなくなる
class Util {
    private var reservationId: Int //商品予約ID
    private var viewSettings: ViewSettings //画面表示設定
    private var mailMagazine: MailMagazine //メールマガジン
    
    init(reservationId: Int, viewSettings: ViewSettings, mailMagazine: MailMagazine) {
        self.reservationId = reservationId
        self.viewSettings = viewSettings
        self.mailMagazine = mailMagazine
    }
    
    func cancelReservation() {
        // reservationIdを使った予約キャンセル処理
    }
    
    func darkMode() {
        // viewSettingsを使ったダークモード表示への変更処理
    }
    
    func beginSendMail() {
        // mailMagazineを使ったメール配信開始処理
    }

}
