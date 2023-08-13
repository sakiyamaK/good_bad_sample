// [BAD]
// ツッコミ所が多過ぎて全部書き換えたい
import Foundation

struct Product {
    let id: Int
    let name: String
    let price: Int
    
}

// [BAD]
// ProductがDiscountできるかどうか管理する構造体が別にあることがよくない
struct ProductDiscount {
    let id: Int
    let canDiscount: Bool
}

// [BAD]
// 7.8.swiftと同じくそもそもDiscountManagerという[Poduct]を管理するクラスが別にあることがよくない
class DiscountManager {
    var discountProducts: [Product] = []
    var totalPrice: Int = 0
    
    func add(product: Product, productDiscount: ProductDiscount) throws -> Bool {
        // productが正しいかチェック
        guard product.id > 0 else {
            throw NSError(domain: "商品が存在しません", code: 0)
        }
        
        guard !product.name.isEmpty else {
            throw NSError(domain: "商品名が空です", code: 0)
        }
        
        guard product.price > 0 else {
            throw NSError(domain: "価格が0以下です", code: 0)
        }
        
        guard product.id == productDiscount.id else {
            throw NSError(domain: "商品IDが一致しません", code: 0)
        }
        
        // 割引価格の計算
        // [BAD]
        // この下でproductDiscount.canDiscountがfalseなら結局使わない
        let discountPrice = DiscountManager.getDiscountPrice(price: product.price)
        
        // [BAD]
        // tmpが何なのかよく分からない
        // 変数で定義されており、値が最終的に決定されるのがいつか分からない
        var tmp: Int = 0
        if productDiscount.canDiscount {
            tmp = totalPrice + discountPrice
        } else {
            tmp = totalPrice + product.price
        }
        // 総額上限の判定
        if tmp <= 20000 {
            totalPrice = tmp
            discountProducts.append(product)
            return true
        } else {
            return false
        }
    }
    
    static func getDiscountPrice(price: Int) -> Int {
        var discountPrice = price - 300
        if discountPrice < 0 {
            discountPrice = 0
        }
        return discountPrice
    }
}
