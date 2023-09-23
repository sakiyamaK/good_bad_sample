struct SellingPrice {
    let amount: Int
    
    init(amount: Int) {
        guard amount > 0 else {
            fatalError("商品価格がマイナスです")
        }
        self.amount = amount
    }
    
    private let SELLING_COMMISSION_RATE: Double = 0.1
    private let DELIVERY_FREE_MIN: Int = 300
    private let SHOPPING_POINT_RATE: Double = 0.1
    
    // 開発が進んで以下の機能が追加されてきた
    
    // 販売手数料を計算
    var sellingCommission: Int {
        Int(Double(amount) * SELLING_COMMISSION_RATE)
    }
    
    // 配送料を計算
    var deliveryCharge: Int {
        DELIVERY_FREE_MIN < amount ? 0 : 500
    }
    
    // [BAD]
    // これは販売価格と明らかに別概念で密結合
    // 獲得ポイントを計算
    var shoppingPoint: Int {
        Int(Double(amount) * SHOPPING_POINT_RATE)
    }
}
