// [BAD]
// ツッコミ所が多過ぎて全部書き換えたい

import Foundation

struct Product {
    let id: Int
    let name: String
    let price: Int
    // 新規追加
    // [BAD]
    // 既存に「通常割引」の仕様があって追加の「夏季限定割引」できるかどうか判定するパラメータなのに
    // 名前がこれではどっちのためのパラメータか分からない
    let canDiscount: Bool
    
}

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

// 仕様追加された夏季限定割引
// [BAD]
// 書籍に書いてる通り様々なバグを生む
// 「様々な」バグを生むのはこのクラスが「様々な」機能をまとめているせい
// 単一責任の原則に則ってない
class SummerDiscountManager {
    // DiscountManagerの処理を流用するために用意
    // [BAD]
    // DiscountManagerがここで使われているとは思わない
    // DiscountManagerの仕様変更がここにも影響する
    let discountManager: DiscountManager = .init()
    
    func add(product: Product) throws -> Bool {
        // productが正しいかチェック
        // [BAD]
        // 同じチェックがDiscountManagerにもある
        guard product.id > 0 else {
            throw NSError(domain: "商品が存在しません", code: 0)
        }
        
        guard !product.name.isEmpty else {
            throw NSError(domain: "商品名が空です", code: 0)
        }
        
        var tmp: Int = 0
        if product.canDiscount {
            tmp = discountManager.totalPrice + DiscountManager.getDiscountPrice(price: product.price)
        } else {
            tmp = discountManager.totalPrice + product.price
        }
        // 総額上限の判定
        if tmp <= 30000 {
            discountManager.totalPrice = tmp
            discountManager.discountProducts.append(product)
            return true
        } else {
            return false
        }
    }
}
