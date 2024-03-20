import Foundation

// 書籍では省略されてるデータクラスなど --
struct Customer {
    struct Id {
        let id: Int
    }
    let id: Id
    let possessionPoint: PurchasePoint
    
    var isEnable: Bool {
        // 本来は何かの条件でユーザが有効か無効か決まる
        // 今回は偶数のみ有効
        id.id % 2 == 0
    }
}

struct Comic {
    struct Id {
        let id: Int
    }
    let id: Id
    let currentPurchasePoint: PurchasePoint
    
    var isEnable: Bool {
        // 本来は何かの条件でユーザが有効か無効か決まる
        // 今回は偶数のみ有効
        id.id % 2 == 0
    }
}

struct PurchasePoint {
    let amount: Int
}
// --

class PurchasePointPayment {
    let customerId: Customer.Id
    let comicId: Comic.Id
    let consumptionPoint: PurchasePoint
    let paymentDateTime: Date
    
    // パラメータを受け取ってインスタンスを生成する
    init?(customer: Customer, comic: Comic) throws {
        // [BAD]
        // if elseが多くて入れ子になっているため結局正常な処理がどこか分かりにくい
        if customer.isEnable {
            // idを登録
            self.customerId = customer.id
            if comic.isEnable {
                // idを登録
                self.comicId = comic.id
                if comic.currentPurchasePoint.amount <= customer.possessionPoint.amount {
                    // ここまできてようやく正常
                    self.consumptionPoint = comic.currentPurchasePoint
                    self.paymentDateTime = .now
                } else {
                    throw NSError(domain: "所持ポイントが不足しています", code: 0)
                }
            } else {
                throw NSError(domain: "現在取り扱いのできないコミックです", code: 0)
            }
        } else {
            throw NSError(domain: "有効な購入者ではありません", code: 0)
        }
    }
}

// 処理
let currentCustomer = Customer(
    id: Customer.Id(
        id: 1
    ),
    possessionPoint: PurchasePoint(
        amount: 100
    )
)

let selectComic = Comic(
    id: Comic.Id(
        id: 1
    ),
    currentPurchasePoint: PurchasePoint(
        amount: 100
    )
)

do {
    let payment = try PurchasePointPayment(
        customer: currentCustomer,
        comic: selectComic
    )
} catch let e {
    print(e)
}
