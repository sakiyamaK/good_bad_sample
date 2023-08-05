protocol DiscountBase {
    var price: Int { get }
    var discountCharge: Int { get }
    func getDiscountedPrice() -> Int
}

extension DiscountBase {
    func getDiscountedPrice() -> Int {
        // [BAD]
        // 準拠させるクラスの数だけ必要になる
        // これで全部なのか保証はどこにもない
        // 最後に謎のreturnがいるが仕様通りならそこに辿り着くことはない
        //   つまりテストできないし、変えていいのかよく分からない
        if self is RegularDiscount {
            return max(0, price - discountCharge)
        } else if self is SummerDiscount {
            return Int(Double(price) * 0.95)
        }
        // ここは来ないよ
        return price
    }
}

class RegularDiscount: DiscountBase {
    private(set) var price: Int
    // [BAD]
    // このクラスだけ見てもdiscountChargeが何のためにあるのか分からない
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
}

/* [まとめ]
- 継承をすると色々と密結合に陥りやすい
- 「継承は悪」「protocolは疎結合で正義」と言葉だけ覚えても使い方を間違えると同じことが起きる
*/
