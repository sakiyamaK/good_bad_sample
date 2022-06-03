//この数値はたくさんのコードのどこかで定義されている
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

addPrice(100)
