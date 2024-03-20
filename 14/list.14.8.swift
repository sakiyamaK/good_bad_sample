
import Foundation
import XCTest

// テスト対象のクラス
// 配送管理クラス
// [BAD]
// 書籍のP298 14.2.1　コードの課題を整理するの通り色々と問題がある
class DeliveryManager {
    static func deliveryCharge(products: [Product]) -> Int {
        var charge = 0
        var totalPrice = 0
        for product in products {
            totalPrice += product.price
        }
        if totalPrice < 2000 {
            charge = 500
        } else {
            charge = 0
        }
        return charge
    }
}

struct Product {
    struct Id {
        let id: Int
    }

    let id: Id
    let name: String
    let price: Int
}
