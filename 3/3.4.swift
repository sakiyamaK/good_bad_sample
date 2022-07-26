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
        // [GOOD]
        // amount不正な値が入ること許さない
        // Swiftにはそれ用のgurad構文がある
        guard amount > 0 else {
            // [おまけ]
            // 不正な値がきたときの対応方法は要件ごとに異なる

            // (1) 初期値を入れてしまう (*3)
            self.amount = 0
            self.currency = currency
            return

                    /*
                        //(2) 例外を送る
                        throw NSError()
                        return
                        */
                    /*
                        //(1) エラーを出してクラッシュする
                        fatalError("不正な値が代入されました")
                        */
        }

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
