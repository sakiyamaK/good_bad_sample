// [GOOD]
// 税込み価格を計算する処理
// 退会済みかどうか判断する処理
// 商品を注文する処理
// がそれぞれのクラスの処理でまとまってオブジェクト指向に沿っている

class AmountIncludingTax {
    let value: Double
    let ratio: Double
    var multipliedValue: Double { return value * ratio }
    
    AmountIncludingTax(value: Double, ratio: Double) {
        self.value = max(value, 0)
        self.ratio = max(value, 0)
    }
}

class User {
    var hasResigned: Bool {
        //実際は退会済みかどうか判断するロジックがある
        return true
    }
}

class Product {
    func createOrder() {
        //実際は商品を注文する処理がある
    }
}
