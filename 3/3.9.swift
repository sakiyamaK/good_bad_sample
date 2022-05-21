//3.9~3.13

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
    // swiftはデフォルトでメソッドのパラメータはlet扱いになる
    func add(other: Int) -> Money {
        // [GOOD]
        // 一度生成したインスタンスに変更を加えることなく要件を満たせる
        // [補足]
        // ただし新しいインスタンスが生成するコストは発生する
        // 例えばこのクラスが10GBのデータを持ってたりするとコピーされるので時間かかる
        return Money(amount: self.amount + other, currency: self.currency)
    }
}

//本来はサーバーから取得してtrue/falseのどっちか実行時に決まる値
let specialServiceAdded = true
let seasonOffApplied = true

//1000円のmoney1を用意
let money1 = Money(amount: 1000, currency: .yen)


// [GOOD]
// 明確に
//「元の金額が設定されているmoney1」と
// 「配送料がかかるか判断するためのdeterminedMoney1」を
// 分けざるを得なくなる <-- ** これが大事

// [GOOD]
// varと明記されることで後から変更される可能性があるんだなと分かる
var determinedMoney1: Money = money1

if specialServiceAdded {
    determinedMoney1 = determinedMoney1.add(other: -500)
}

if seasonOffApplied {
    determinedMoney1 = determinedMoney1.add(other: 280)
}

// [GOOD]
// money1と明確に違うことが分かる
// money1をそのまま利用してはいけないんだなと分かる
// 今後もどんな実装が加わってもmoney1は最初に設定された値であることが保証される
if determinedMoney1.amount < 600 {
    print("600円以下だと配送料がかかります")
} else {
    print("大丈夫だから処理を続けます")
}
// -------------------
