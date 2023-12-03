
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
    
    // 互換性のためにパラメータを一応残す
    var intern: Bool { accountType != .intern }
    
    var accountType: AccountType
    
    enum AccountType {
        case admin, normal, intern, deleted
        
        var enableDeleteUser: Bool {
            switch self {
            case .admin: true
            default: false
            }
        }
    }
    
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
    func delete(user: User) {
        guard accountType.enableDeleteUser else {
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

let employee1 = Employee(id: 1, name: "あなた", createdAt: "2000-10-01".date, accountType: .admin)
let employee2 = Employee(id: 2, name: "インターン", createdAt: "2010-10-01".date, accountType: .intern)
let employee3 = Employee(id: 4, name: "新人", createdAt: "2022-12-30".date, accountType: .normal)
let employee4 = Employee(id: 5, name: "退職者", createdAt: "2022-12-30".date, accountType: .deleted)


employee1.delete(user: blackUser)

employee2.delete(user: blackUser)

employee3.delete(user: blackUser)

employee4.delete(user: blackUser)

