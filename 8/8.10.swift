// swiftはそもそも抽象クラス(インスタンス化できないクラス)を用意できない
// protocolと拡張したextension protocolがそれに当たる
// protocolにすると疎結合になるが、それでも密結合になりがちな書き方はある
protocol DiscountBase {
    var price: Int { get }
    func getDiscountedPrice() -> Int
}

// 通常の割引き
class RegularDiscount: DiscountBase {
    private(set) var price: Int
    init(price: Int) {
        self.price = price
    }
    func getDiscountedPrice() -> Int {
        max(0, price - 300)
    }
}

// 夏の割引き
class SummerDiscount: DiscountBase {
    private(set) var price: Int
    init(price: Int) {
        self.price = price
    }
    func getDiscountedPrice() -> Int {
        max(0, price - 400)
    }
}

let regular = RegularDiscount(price: 1000)
let summer = SummerDiscount(price: 1000)

print(regular.getDiscountedPrice())  // 700
print(summer.getDiscountedPrice())   // 600
