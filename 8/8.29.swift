struct SellingPrice {
    let amount: Int
    
    init(amount: Int) {
        guard amount > 0 else {
            fatalError("商品価格がマイナスです")
        }
        self.amount = amount
    }
}

struct SellingCommission {
    private let SELLING_COMMISSION_RATE: Double = 0.1
    // 販売手数料を計算
    func sellingCommission(price: SellingPrice) -> Int {
        Int(Double(price.amount) * SELLING_COMMISSION_RATE)
    }
}

struct DeliveryCharge {
    private let DELIVERY_FREE_MIN: Int = 300
    // 配送料を計算
    func deliveryCharge(price: SellingPrice) -> Int {
        DELIVERY_FREE_MIN < price.amount ? 0 : 500
    }
}

// [GOOD？]
// 獲得ポイントという無関係の処理が別structに分かれて、「販売価格」と「獲得ポイント」が疎結合になった？
// [BAD]
// ShoppingPointはSellingPriceがないとビルドできないし疎結合といっていいのかどうか...
// またこれだと5章の低凝集な状態で良いとは言えない
struct ShoppingPoint {
    private let SHOPPING_POINT_RATE: Double = 0.1
    // 獲得ポイントを計算
    func deliveryCharge(price: SellingPrice) -> Int {
        Int(Double(price.amount) * SHOPPING_POINT_RATE)
    }
}

/*
  [MEMO]
  結局、低凝集と高凝集は相反する概念でバランスが大事  
*/