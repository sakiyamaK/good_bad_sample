// 3.2〜3.3

import Foundation

// 後ほど説明 (*1)
enum Currency {
    case yen, dollar
}

class Money {
    var amount: Int
    var currency: Currency
    // [GOOD]
    // init(初期化メソッド,イニシャライザ)を用意することでパラメータに必ず何か値を決めることが保証される
    init(amount: Int, currency: Currency) {
        self.amount = amount
        self.currency = currency
    }

    // [おまけ] (*2)
    // Swiftには他にもいくつかイニシャライザの書き方がある
    init(_ amount: Int, _ currency: Currency) {
        self.amount = amount
        self.currency = currency
    }
}

// init(amount: Int, currency: Currency)メソッドを実行してインスタンスを作る
// [BAD]
// amountに現実ではありえないマイナスの値が入ることを許してしまう
// [GOOD] (*1)
// currencyはenumなので不正な値が入ることがない
let money1 = Money(amount: -100, currency: .yen)

// [おまけ]
// 一般的には.initは省略する
let money2 = Money(amount: -100, currency: .yen)
//: Moneyと型を決めたら逆に、 Money.initのMoneyの方を省略することもできる
let money3: Money = .init(amount: -100, currency: .yen)
// (*2) 別のイニシャライザからインスタンスを生成
let money4 = Money(-100, .yen)
