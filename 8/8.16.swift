protocol DiscountBase {
    var price: Int { get }
    // 準拠先で違いのある割引金額をパラメータとして用意した
    var discountCharge: Int { get }
    func getDiscountedPrice() -> Int
}

extension DiscountBase {
    func getDiscountedPrice() -> Int {
        max(0, price - discountCharge)
    }
}

class RegularDiscount: DiscountBase {
    private(set) var price: Int
    private(set) var discountCharge: Int = 300
    init(price: Int) {
        self.price = price
    }
}

// 1品につき5%割引になった
class SummerDiscount: DiscountBase {
    private(set) var price: Int
    // [BAD]
    // 仕様変更で使わなくなった
    // でもDiscountBaseで必須だから用意するしかない
    // 仕方ないので「使わないよ」という意味で-1でも入れておく
    private(set) var discountCharge: Int = -1
    init(price: Int) {
        self.price = price
    }
    
    func getDiscountedPrice() -> Int {
        Int(Double(price) * 0.95)
    }
}
