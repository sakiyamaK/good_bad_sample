//3.7~3.8

import Foundation

enum Currency {
    case yen, dollar
}

class Money {
    // [GOOD]
    //letにすることでこの変数は変更されることがない
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
    // functionを用意することでMoneyに関する記述はMoenyクラスに集約できる
    func add(other: Int) {
        // [GOOD]
        // パラメータをletにしたことで生成したインスタンスの状態を後から変更するような
        // バグが生まれやすい実装を防げる ****** <- これが大事 (*1)
        amount += other
    }
}

//本来はサーバーから取得してtrue/falseのどっちか実行時に決まる値
let specialServiceAdded = true
let seasonOffApplied = true

//1000円のmoney1を用意
let money1 = Money(amount: 1000, currency: .yen)

// -------------------
// [GOOD] (*1)
// このようなバグが生まれやすい記述ができなくなる
if specialServiceAdded {
  money1.add(other: -500)
}

if seasonOffApplied {
  money1.add(other: 280)
}

if money1.amount < 600 {
    print("600円以下だと配送料がかかります")
} else {
    print("大丈夫だから処理を続けます")
}
// -------------------
