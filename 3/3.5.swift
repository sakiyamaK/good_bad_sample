// 3.5~3.6

import Foundation

enum Currency {
    case yen, dollar
}

class Money {
    var amount: Int
    var currency: Currency

    init(amount: Int, currency: Currency) {
        guard amount > 0 else {
            self.amount = 0
            self.currency = currency
            return
        }

        self.amount = amount
        self.currency = currency
    }

    // [GOOD]
    // functionを用意することでMoneyに関する記述はMoenyクラスに集約できる
    func add(other: Int) {
        // [BAD]
        // 実装時に「このインスタンスは現在どんな値なんだろう？」と意識ないといけないため
        // 生成したインスタンスの状態を後から変更できるとバグが生まれやすい
        amount += other
    }
}

// 本来はサーバーから取得してtrue/falseのどっちか実行時に決まる値
let specialServiceAdded = true
let seasonOffApplied = true

// 1000円のmoney1を用意
let money1 = Money(amount: 1000, currency: .yen)

if specialServiceAdded {
    money1.add(other: -500)
}

if seasonOffApplied {
    money1.add(other: 280)
}

// [BAD]
// money1は1000円なのにどっちが実行されるか分からなくなる
if money1.amount < 600 {
    print("600円以下だと配送料がかかります")
} else {
    print("大丈夫だから処理を続けます")
}
