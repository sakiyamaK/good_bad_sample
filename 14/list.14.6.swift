
import Foundation

// 書籍のリスト14.5までをやった

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

    // *** リファクタリング ***
    // 何の目的のロジックか分かりやすくする
    // この場合なら「この顧客のポイントでコミックを購入可能か判断する」ためのロジック
    func checkPointForEnablePurcase(comic: Comic) -> Bool {
      comic.currentPurchasePoint.amount <= possessionPoint.amount
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
        // [GOOD]
        // まずエラー処理を全部最初に記載する
        // 書籍では条件を反転してネスト解消とあるが
        // swiftの場合はそのためのguard文があるため条件は反転させる必要がない
        guard customer.isEnable else {
            throw NSError(domain: "有効な購入者ではありません", code: 0)
        }
        guard comic.isEnable else {
            throw NSError(domain: "現在取り扱いのできないコミックです", code: 0)
        }
        // [GOOD]
        // 顧客がそのコミックを買うのに十分なポイントを持っているか分かりやすくなった
        guard customer.checkPointForEnablePurcase(comic: comic) else {
            throw NSError(domain: "所持ポイントが不足しています", code: 0)
        }

        // [GOOD]
        // すべての例外を最初に弾いているのでここからは正常な処理となる
        // インデントが浅く見通しがいい
        self.customerId = customer.id
        self.comicId = comic.id
        self.consumptionPoint = comic.currentPurchasePoint
        self.paymentDateTime = .now
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
