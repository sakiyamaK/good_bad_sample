
import Foundation
import XCTest


// テスト対象のクラス
// 配送管理クラス
class DeliveryManager {
    static func deliveryCharge(shoppingCart: ShoppingCart) -> Int {
        var charge = 0
        if shoppingCart.totalPrice < 2000 {
            charge = 500
        } else {
            charge = 0
        }
        return charge
    }
}

struct ShoppingCart {
    
    private(set) var products: [Product]
    
    // *** リファクタリング ***
    // 合計金額をショッピングカード側で持つ
    var totalPrice: Int {
        products.map({ $0.price }).reduce(0, +)
    }
        
    init(products: [Product]) {
        self.products = products
    }
    
    mutating func add(products: [Product]) {
        self.products += products
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

struct DeliveryCharge {
    let amount: Int
    
    init(shoppingCart: ShoppingCart) {
        // *** リファクタリング ***
        amount = DeliveryManager.deliveryCharge(shoppingCart: shoppingCart)
    }
}

class DeliveryChargeTests: XCTestCase {
    // 商品の合計金額が2000円未満の場合、配送料は500円
    func test_配送料が0円() {
        
        // テストする買い物かごを用意
        let testCart = ShoppingCart(products: [
            Product(id: .init(id: 1), name: "商品A", price: 500),
            Product(id: .init(id: 2), name: "商品B", price: 1499)
        ])
        
        // 配送料をテスト
        let charge = DeliveryCharge(shoppingCart: testCart)
        
        XCTAssertEqual(500, charge.amount, "違うよ")
        
    }

    // 商品の合計金額が2000円以上の場合、配送料は0円
    func test_配送料が500円() {
        
        // テストする買い物かごを用意
        let testCart = ShoppingCart(products: [
            Product(id: .init(id: 1), name: "商品A", price: 500),
            Product(id: .init(id: 2), name: "商品B", price: 1500)
        ])
        
        // 配送料をテスト
        let charge = DeliveryCharge(shoppingCart: testCart)
        
        XCTAssertEqual(0, charge.amount, "違うよ")
        
    }
}

// テスト成功
DeliveryChargeTests.defaultTestSuite.run()
