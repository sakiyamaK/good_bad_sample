import Foundation

protocol DiscountTypeProtocol {
    var discountPrice: Int { get }
}

enum ServiceDiscountType: DiscountTypeProtocol {
    case normal, summer
    
    var discountPrice: Int {
        switch self {
        case .normal:
            return 300
        case .summer:
            return 400
        }
    }
    
    static var maxDiscount: Int { 20000 }
}

struct Product {
    let id: Int
    let name: String
    let price: Int
    // DiscountTypeに依存しないようにProtocolを介して疎結合にする
    // DiscountTypeの仕様がどう変わろうがdiscountPriceという値を返してくれる何かであれば何でもいい
    let discountTypes: [DiscountTypeProtocol]
    var enablePrice: Bool {
        id > 0 && !name.isEmpty && price > 0
    }
    var discountedPrice: Int {
        max(0, discountTypes.reduce(price, { partialResult, discountType in
            partialResult - discountType.discountPrice
        }))
    }
}

extension [Product] {
    var totalDiscountedPrice: Int {
        self.filter { product in
            product.enablePrice
        }.reduce(0) { partialResult, product in
            let addPrice = partialResult < ServiceDiscountType.maxDiscount ? product.discountedPrice : product.price
            return partialResult + addPrice
        }
    }
    
    var totalPrice: Int {
        self.filter { product in
            product.enablePrice
        }.reduce(0) { partialResult, product in
            partialResult + product.price
        }
    }
}

// 仕様追加でユーザランキングに応じて割引きが効くようになったとする
enum UserRank: DiscountTypeProtocol {
    case normal, silver, gold
    
    var discountPrice: Int {
        switch self {
        case .normal:
            return 0
        case .silver:
            return 100
        case .gold:
            return 200
        }
    }
}

// ユーザ
struct User {
    let id: Int
    let rank: UserRank
}


// 動作確認

let user = User(id: 1, rank: .gold)

// discountTypesを疎結合にしたことで
// サービス側の割引き以外にもユーザの状態に応じて割引きにも対応できるようになった
// 今後、他の割引きの仕様が増えても同様
let products: [Product] = [
    Product(id: 1, name: "a", price: 100, discountTypes: []),
    Product(id: 2, name: "b", price: 1200, discountTypes: [ServiceDiscountType.normal, user.rank]),
    Product(id: 3, name: "c", price: 300, discountTypes: [ServiceDiscountType.summer, user.rank]),
    Product(id: 4, name: "d", price: 1300, discountTypes: [ServiceDiscountType.summer, user.rank]),
    Product(id: 5, name: "e", price: 400, discountTypes: [ServiceDiscountType.normal, ServiceDiscountType.summer, user.rank]),
]

print("それぞれの金額")
for product in products {
    print("id = \(product.id), name = \(product.name), price = \(product.price), discountedPrice = \(product.discountedPrice)")
}

print("合計金額")
print("totalPrice = \(products.totalPrice)")
print("totalDiscountedPrice = \(products.totalDiscountedPrice)")
