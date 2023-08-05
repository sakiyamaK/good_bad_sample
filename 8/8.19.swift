// [GOOD]
// 責務を分けましょう
// Swiftならそのままstructで処理も記述すればいい

struct Reservation {
    var id: Int
    func cancelReservation() {
        // idを使った予約キャンセル処理
    }
}

struct ViewSettings {
    func darkMode() {
    }
}

struct MailMagazine {
    func beginSendMail() {
        // mailMagazineを使ったメール配信開始処理
    }
}
