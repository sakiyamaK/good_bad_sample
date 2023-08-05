protocol DiscountBase {
    var price: Int { get }
    // 準拠先で違いのある割引金額をパラメータとして用意した
    var discountCharge: Int { get }
    func getDiscountedPrice() -> Int
}

extension DiscountBase {
    // 割引き計算を共通化した
    func getDiscountedPrice() -> Int {
        max(0, price - discountCharge)
    }
}

// 通常の割引き
class RegularDiscount: DiscountBase {
    private(set) var price: Int
    // [BAD]
    // このクラスだけ見てもdiscountChargeが何のためにあるのか分からない
    private(set) var discountCharge: Int = 300
    init(price: Int) {
        self.price = price
    }
}

// 夏の割引き
class SummerDiscount: DiscountBase {
    private(set) var price: Int
    // [BAD]
    // このクラスだけ見てもdiscountChargeが何のためにあるのか分からない
    private(set) var discountCharge: Int = 400
    init(price: Int) {
        self.price = price
    }
}
