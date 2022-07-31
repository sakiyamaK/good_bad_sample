//5.1~5.2

// [BAD]
// プログラムが扱うのは全部何かしらのデータなんだからDataという名前は意味がない
class MoneyData {
    // [GOOD]
    // 定数のパラメータなのでバグりにくい
    let amount: Int
    // [GOOD]
    // 0以下にならないようにバリデーションチェックをしている
    init(amount: Int = 0){
        self.amount = amount < 0 ? 0 : amount
    }
    
    // [GOOD]
    // MoneyDataに関する処理は自身に集約されている
    // MoneyDataに修正があった場合、自身のクラス内だけ意識すればいい
    func add(other: MoneyData) -> MoneyData {
        //データを利用しているのでstaticにできない
        return MoneyData(amount: self.amount + other.amount)
    }
}

let moneyData1 = MoneyData(amount: 100)
let moneyData2 = MoneyData(amount: 200)
// moneyData1とmoneyData2を足したければ新しいインスタンスを作る必要がある
// 言い換えるとmoneyData1とmoneyData2は変わることがない <--- ここが重要
let addedMoneyData = moneyData1.add(other: moneyData2)
