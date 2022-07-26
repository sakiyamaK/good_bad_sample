// この数値はたくさんのコードのどこかで定義されている
let MAX_TOTAL_PRICE = 200
let totalPrice = 100

func addPrice(productPrice: Int) throws {
    // [GOOD]
    // swiftは言語仕様でメソッドの引数は不変になる
    // つまりこういうバグの温床になるコードを書けないようにしている <-- 重要
    productPrice = totalPrice + productPrice
    if MAX_TOTAL_PRICE < productPrice {
        throw fatalError("購入金額の上限を超えています。")
    }
}

addPrice(productPrice: 100)

// [おまけ]
// swiftで可変な引数を扱いたい場合ばinoutを付ける
// つまりデフォルトだとBADにならないように設計されており、危険な実装になることを明示するために記述を追加する
func addPrice2(productPrice: inout Int) throws {
    productPrice = totalPrice + productPrice
    if MAX_TOTAL_PRICE < productPrice {
        throw fatalError("購入金額の上限を超えています。")
    }
}

// [おまけ]
// 呼び出す方もかなり厳重で
// Swift開発チームが「お前本当にこうしないとあかんのか？？よく考えろよ？？」
// という意志が伺える
var price = 100
try! addPrice2(productPrice: &price)
