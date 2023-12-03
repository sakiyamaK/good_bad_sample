
import Foundation

// 社内の顧客管理システムとする

extension DateFormatter {
    convenience init(dateFormat: String) {
        self.init()
        self.dateFormat = dateFormat
    }
}

extension String {
    var date: Date {
        DateFormatter(dateFormat: "yyyy-MM-dd").date(from: self) ?? Date()
    }
}

extension Date {
    func check(byAdding component: Calendar.Component, value: Int) -> Bool {
        self < Calendar.current.date(byAdding: component, value: value, to: Date())!
    }
}

// 顧客
struct User {
    let id: Int
    let name: String
    var deletedAt: Date?
}

// 社員
struct Employee {
    let id: Int
    let name: String
    var createdAt: Date
    var deletedAt: Date?

    var intern: Bool
    
    // インターンが間違って優良ユーザを削除してしまった！
    // 顧客を削除できる社員を限定しよう！
    // 仕様変更に合わせてコメントを更新

    /*
     [ここのコメントが話の中心]
     インターン以外の社員が顧客を削除する
     */
    func delete(user: User) {
        guard !intern else {
          print("\(name)はユーザを削除する権限がありません")
          return
        }

        var deletedUser = user
        deletedUser.deletedAt = Date()
        // apiを叩いて登録
        print("\(name)はユーザを削除しました")
    }
}

// 本当はDBからもらうデータ
let blackUser = User(id: 1, name: "他からクレームがきまくったユーザ")

let employee1 = Employee(id: 1, name: "あなた", createdAt: "2000-10-01".date, intern: false)
let employee2 = Employee(id: 2, name: "インターン", createdAt: "2010-10-01".date, intern: true)

employee1.delete(user: blackUser)
employee2.delete(user: blackUser)
