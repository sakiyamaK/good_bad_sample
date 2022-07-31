// 5.4~5.6

import Foundation

class GiftPoint {
    static private let minPoint: Int = 0
    let value: Int
    
    // [BAD]
    // コンストラクタを公開するとどんな用途で使われるか分からない
    // 100が入る時はどんな時？
    // 0の時は？20の時は？もっとパターンはあるの？？？
    init(point: Int) {
        value = point < GiftPoint.minPoint ? GiftPoint.minPoint : point
    }
    
    // [GOOD]
    // GiftPointに関するロジックはこのクラスにまとまっている
    func add(other: GiftPoint) -> GiftPoint {
        return GiftPoint(point: self.value + other.value)
    }
    
    func isEnough(point: ConsumptionPoint) -> Bool {
        return point.value <= self.value
    }
    
    func consume(point: ConsumptionPoint) throws -> GiftPoint {
        guard self.isEnough(point: point) else {
            throw NSError(domain: "ポイントが不足しています", code: 0)
        }
        return GiftPoint(point: self.value - point.value)
    }
}

class ConsumptionPoint {
    static private let minPoint: Int = 0
    let value: Int
    
    init(point: Int) {
        self.value = point < ConsumptionPoint.minPoint ? ConsumptionPoint.minPoint : point
    }
}

// [BAD]
// 何かのロジックがあって標準ユーザかどうか決まる
// つまりここにロジックがあって低凝集にならざるをえない
let standardMemberShipPoint = GiftPoint(point: 100)

// [BAD]
// 何かのロジックがあってプレミアムユーザかどうか決まる
// つまりここにロジックがあって低凝集にならざるをえない
let premiumMemberShipPoint = GiftPoint(point: 300)
