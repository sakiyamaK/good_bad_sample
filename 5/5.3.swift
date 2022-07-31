//5.3

// [BAD]
// プログラムが扱うのは全部何かしらのデータなんだからDataという名前は意味がない
class MoneyData {
    // [GOOD]
    // 定数のパラメータなのでバグりにくい
    let amount: Int
    // [GOOD]
    // 0以下にならないようにバリデーションチェックをしている
    init(amount: Int = 0) {
        self.amount = amount < 0 ? 0 : amount
    }
    
    // [GOOD]
    // MoneyDataに関する処理は自身に集約されている
    // MoneyDataに修正があった場合、自身のクラス内だけ意識すればいい
    func add(other: MoneyData) -> MoneyData{
        //データを利用しているのでstaticにできない
        return MoneyData(amount: self.amount + other.amount)
    }
}

class PaymentManager {
    private var _discountRate: Double = 0.2
    
    // [BAD]
    // 外部から受け取った数値(moneyAmount1)と外部から受け取った数値(moneyAmount2)だけで完結しているメソッドで
    // インスタンスのパラメータを一切使っていないからstaticと変わらない
    // moneyAmount1, moneyAmount2を与えてくれたクラス側のかけ離れているので底凝集
    func add(moneyAmount1: Int, moneyAmount2: Int) -> Int {
        return moneyAmount1 + moneyAmount2
    }
}

let paymentManager = PaymentManager()
let moneyData1 = MoneyData(amount: 100)
let moneyData2 = MoneyData(amount: 200)

let addedMoney = paymentManager.add(moneyAmount1: moneyData1.amount, moneyAmount2: moneyData2.amount)
let addedMoneyData = MoneyData(amount: addedMoney)
