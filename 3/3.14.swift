// 3.14~3.17

import Foundation

enum Currency {
    case yen, dollar
}

class Money {
    let amount: Int
    let currency: Currency

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
    // 同じMoney型しか受け取らないようにする
    func add(other: Money) -> Money {
        // [GOOD]
        // バリデーションチェックでotherが処理していいかどうか最初に判断する
        guard currency == other.currency else {
            // [おまけ]
            // 不正な入力をどう処理するかは仕様次第
            // ここではクラッシュさせている
            fatalError("通貨単位が違います")
        }
        return Money(amount: amount + other.amount, currency: currency)
    }

    // 金額を下げるメソッドも用意
    func minus(other: Money) -> Money {
        guard currency == other.currency else {
            fatalError("通貨単位が違います")
        }
        return Money(amount: amount - other.amount, currency: currency)
    }
}

// 本来はサーバーから取得してtrue/falseのどっちか実行時に決まる値
let specialServiceAdded = true
let seasonOffApplied = true

// 1000円のmoney1を用意
let money1 = Money(amount: 1000, currency: .yen)
var determinedMoney1: Money = money1

// [GOOD]
// 役割ごとに名前を付けた定数となり、何のために使うか明確になる
let specialServiceAddedMoney = Money(amount: 500, currency: .yen)
let seasonOffAppliedMoney = Money(amount: 280, currency: .yen)

if specialServiceAdded {
    determinedMoney1 = determinedMoney1.minus(other: specialServiceAddedMoney)
}

if seasonOffApplied {
    determinedMoney1 = determinedMoney1.add(other: seasonOffAppliedMoney)
}

if determinedMoney1.amount < 600 {
    print("600円以下だと配送料がかかります")
} else {
    print("大丈夫だから処理を続けます")
}
