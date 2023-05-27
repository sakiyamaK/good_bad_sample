// ポリシーパターンというらしい
// ぶっちゃけこんな複雑なパターンで書いたことがない

struct PurchaseHistory {
    let totalAmount: Int
    let purchaseFrequencyPerMonth: Int
    let returnRate: Double
}

protocol ExcellentCustomerRule {
    // 条件を満たすかどうか判断するパラメータだけある
    func ok(purchaseHistory: PurchaseHistory) -> Bool
}

// ゴールド会員の購入金額だけのルール
class GoldCustomerPurchaseAmountRule: ExcellentCustomerRule {
    func ok(purchaseHistory: PurchaseHistory) -> Bool {
        // swiftはメソッド中身が1行だとその演算結果がreturnされる
        // 言い換えたら1行ならreturnいらない
        100000 <= purchaseHistory.totalAmount
    }
}

// 購入頻度だけのルール
class PurchaseFrequencyRule: ExcellentCustomerRule {
    func ok(purchaseHistory: PurchaseHistory) -> Bool {
        // swiftはメソッド中身が1行だとその演算結果がreturnされる
        // 言い換えたら1行ならreturnいらない
        10 <= purchaseHistory.purchaseFrequencyPerMonth
    }
}

// 返品率だけのルール
class ReturnRateRule: ExcellentCustomerRule {
    func ok(purchaseHistory: PurchaseHistory) -> Bool {
        // swiftはメソッド中身が1行だとその演算結果がreturnされる
        // 言い換えたら1行ならreturnいらない
        purchaseHistory.returnRate <= 0.001
    }
}

// 書籍だとclassだがExcellentCustomerPolicyを
// 独立したインスタンスとすることはないはずなのでprotocolにした
// このprotocolの準拠先でルールの配列はデフォルトで決まるためaddメソッドもいらない
protocol ExcellentCustomerPolicy {
    // 書籍だとSetを使っているが配列でいいでしょ
    static var rules: [ExcellentCustomerRule] { get }
    static func complyWithAll(purchaseHistory: PurchaseHistory) -> Bool
}
// protocol extensionでcomplyWithAllの中身を定義
extension ExcellentCustomerPolicy {
    static func complyWithAll(purchaseHistory: PurchaseHistory) -> Bool {
        // 全てのルールを満たせばtrueを返す
        rules.allSatisfy { $0.ok(purchaseHistory: purchaseHistory) }
        // ↑の1行をめちゃくちゃ丁寧に書くと↓
        // return rules.allSatisfy { rule in
        //   return rule.ok(purchaseHistory: purchaseHistory)
        // }
    }
}

// 書籍だとパラメータでvar policy: ExcellentCustomerPolicyと持っているが好みの問題かも
// そのままExcellentCustomerPolicyを準拠させるなら
// 他にパラメータもないしGoldCustomerPolicyはenumで定義もできる
enum GoldCustomerPolicy: ExcellentCustomerPolicy {
    // ゴールド会員が満たすべきルールを配列で定義
    static var rules: [ExcellentCustomerRule] {
        [
            GoldCustomerPurchaseAmountRule(),
            PurchaseFrequencyRule(),
            ReturnRateRule()
        ]
    }
}

enum SilverCustomerPolicy: ExcellentCustomerPolicy {
    // シルバー会員が満たすべきルールを配列で定義
    static var rules: [ExcellentCustomerRule] {
        [
            PurchaseFrequencyRule(),
            ReturnRateRule()
        ]
    }
}

let purchaseHistory = PurchaseHistory(totalAmount: 199, purchaseFrequencyPerMonth: 20, returnRate: 0.1)

let isGoldCustomer = GoldCustomerPolicy.complyWithAll(purchaseHistory: purchaseHistory)
let isSilverCustomer = SilverCustomerPolicy.complyWithAll(purchaseHistory: purchaseHistory)


// ぶっちゃけひとつずつの条件分岐のためにprotocolやらclassやら用意しないといけないので
// 余計ややこしい感じがする
// とはいえifやswitchで条件分岐しなくても目的を果たせるやり方があると認識はしておこう