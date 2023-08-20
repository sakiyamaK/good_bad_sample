import Foundation

/*
 「単一責任」の「単一」とは何なのか？
 「ひとつのアプリ」と捉えたら全部ひとつのクラスに入ることになるし、
 「足し算」と捉えたら全部の足し算でクラスを分けることになるし、、、
 明確な定義などない気がする。。。
 仮に定義があってもそれに当てはまらないパターンは絶対ありそう
 そもそも「単一責任」が絶対の正解でもない
 言い換えると「あらゆる仕様」で明確に「単一責任」が決まりそれが必ず「正解」であるなら、
 それ以外はビルドエラーになるようにプログラミング言語は作らているはずである
 結局は開発チーム内や自分の中でここまでの概念を「単一」とすると決めるしかなさそう
*/

// 割引きする種類をenumで管理
// 割引きに関する処理がここに集約される
//「割引き」を「単一」と捉えた
//「割引き」に関すること以外は書かない
enum ServiceDiscountType {
    case normal, summer
    
    var discountPrice: Int {
        switch self {
        case .normal:
            return 300
        case .summer:
            return 400
        }
    }
    
    static var maxDiscount: Int {
        20000
    }
}

// ひとつの製品に関する情報
//「ひとつの製品」を「単一」と捉えた
//「ひとつの製品」に関すること以外は書かない
struct Product {
    let id: Int
    let name: String
    let price: Int
    // この製品の割引きの種類
    // DiscountTypeに依存することを良しと捉えるかどうか議論ポイント
    let discountTypes: [ServiceDiscountType]
    // 金額計算をしていいか
    var enablePrice: Bool {
        id > 0 && !name.isEmpty && price > 0
    }
    // 割引き金額
    var discountedPrice: Int {
        // priceを初期値としてDiscountTypeから所定の金額を引いていく
        let price = discountTypes.reduce(price, { partialResult, discountType in
            partialResult - discountType.discountPrice
        })
        // maxは大きい方を返す
        // priceがマイナスなら 0 を返す
        // priceがプラスなら price を返す
        // つまりマイナスになることがなくなる
        return max(0, price)
    }
}

// 複数の製品に関する情報
//「複数の製品」を「単一」と捉えた
//「複数の製品」に関すること以外は書かない
extension [Product] {
    // 割引きを考慮した総額
    var totalDiscountedPrice: Int {
        self.filter { product in
            product.enablePrice
        }.reduce(0) { partialResult, product in
            // DiscountTypeに依存しているところが議論ポイント
            let addPrice = partialResult < ServiceDiscountType.maxDiscount ? product.discountedPrice : product.price
            return partialResult + addPrice
        }
    }
    
    // 割引きを考慮しない総額
    var totalPrice: Int {
        self.filter { product in
            product.enablePrice
        }.reduce(0) { partialResult, product in
            partialResult + product.price
        }
    }
}


// 動作確認
let products: [Product] = [
    Product(id: 1, name: "a", price: 100, discountTypes: []),
    Product(id: 2, name: "b", price: 1200, discountTypes: [ServiceDiscountType.normal]),
    Product(id: 3, name: "c", price: 300, discountTypes: [ServiceDiscountType.summer]),
    Product(id: 4, name: "d", price: 1300, discountTypes: [ServiceDiscountType.summer]),
    Product(id: 5, name: "e", price: 400, discountTypes: [ServiceDiscountType.normal, ServiceDiscountType.summer]),
]

print("それぞれの金額")
for product in products {
    print("id = \(product.id), name = \(product.name), price = \(product.price), discountedPrice = \(product.discountedPrice)")
}

print("合計金額")
print("totalPrice = \(products.totalPrice)")
print("totalDiscountedPrice = \(products.totalDiscountedPrice)")
