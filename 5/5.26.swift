// 5.26~5.27

import Foundation

class RegularPrice {
    let amount: Int
    init(amount: Int) throws {
        // [GOOD]
        // 通常価格のバリーでションがここに凝集されることになる
        guard amount >= 0 else {
            throw NSError(domain: "マイナスだよ", code: 0)
        }
        self.amount = amount
    }
}

class DiscountRate {
    let amount: Double
    init(amount: Double) throws {
        // [GOOD]
        // 割引率のバリーでションがここに凝集されることになる
        guard amount >= 0 else {
            throw NSError(domain: "マイナスだよ", code: 0)
        }
        guard amount <= 1 else {
            throw NSError(domain: "1より大きいよ", code: 0)
        }
        self.amount = amount
    }
}

class DiscountedPrice {
    let amount: Int
    // [GOOD]
    // バリデーションされた値をもつインスタンスしか受け取れないので必ず正しい値となる
    //
    // パラメータも何を目的としたインスタンスと何を目的としたインスタンスを与えるのか明確
    init(regularPrice: RegularPrice, discountRate: DiscountRate) {
        self.amount = Int(Double(regularPrice.amount) * discountRate.amount)
    }
}

do {
    let regularPrice1 = try RegularPrice(amount: 100)
    // もし不正な値でインスタンスを生成しようとすると例外となる
//    let regularPrice2 = try RegularPrice(amount: -100)
    
    let discountRate1 = try DiscountRate(amount: 0.5)
    
    let discountedPrice1 = DiscountedPrice(regularPrice: regularPrice1, discountRate: discountRate1)
    
    print(regularPrice1.amount)
    print(discountRate1.amount)
    print(discountedPrice1.amount)
} catch (let e) {
    print(e.localizedDescription)
}
