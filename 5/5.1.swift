//5.1~5.2

//[BAD]
// プログラムが扱うのは全部何かしらのデータなんだからDataという名前は意味がない
class MoneyData {
    // [BAD]
    // 変数のパラメータはバグを生みやすい
    var amount: Int
    // [BAD]
    // バリデーションチェックされていない
    init(amount: Int = 0) {
        self.amount = amount
    }
}

//[BAD]
// Managerという名前は役割を把握しきれていない時につけがちで危険
// 正しく名前を付けられない = 仕様を把握しきれていないと思おう
//
// MoneyDataを扱うクラスが別のクラスとして設定されている
// 数百ファイルのプロジェクトのどこかにMoneyDataとOrderManagerがあるとすると関連があることに気付けない
// MoneyDataが変更された時にここがバグっても見落としがちになる
class OrderManager {
    // [BAD]
    // MoneyDataを扱うクラスのくせにパラメータはint型を受け取っている
    // 何のintを処理するためのメソッドかさっぱり分からない
    //
    // staticなパラメータやメソッドはインスタンスと関連付かない
    // すなわちデータと一切関わりがないということなのでその時点で低凝集の証となる
    static func add(moneyAmount1: Int, moneyAmount2: Int) -> Int {
        return moneyAmount1 + moneyAmount2
    }
}

let moneyData1 = MoneyData(amount: 100)
let moneyData2 = MoneyData(amount: 200)
// [おまけ]
// let moneyData1と定数として用意してもclass自体が参照型なので中身を変えることができてしまう
moneyData1.amount = OrderManager.add(moneyAmount1: moneyData1.amount, moneyAmount2: moneyData2.amount)
