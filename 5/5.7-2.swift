// 5.7

import Foundation

class GiftPoint {
    static private let minPoint: Int = 0
    static private let standardMembershipPoint: Int = 100
    static private let premiumMembershipPoint = 300
    let value: Int
    
    // [GOOD]
    // コンストラクタがprivateなので変なpointを初期化パラメータにできない
    private init(point: Int) {
        self.value = point < GiftPoint.minPoint ? GiftPoint.minPoint : point
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

// [おまけ]
// Factoryクラス(インスタンスを生成するだけのクラス)でなく
// extensionで拡張してやると余計なクラスは増えず
// 生成ロジックだけでまとまって元の記述の見通しが悪くならない
extension GiftPoint {
    // ---------------
    // [GOOD]
    // インスタンスを生成するためのfactory method
    // どんな目的のインスタンスを生成するか名前ですぐ分かる
    // このふたつ以外にインスタンスを生成するパターンがないことも明確
    static func forStandardMembership() -> GiftPoint {
        return GiftPoint(point: GiftPoint.standardMembershipPoint)
    }
    
    static func forPremiumMembership() -> GiftPoint {
        return GiftPoint(point: GiftPoint.premiumMembershipPoint)
    }
    // --------------------------
}


class ConsumptionPoint {
    static private let minPoint = 0
    let value: Int
    init(point: Int) {
        self.value = point < ConsumptionPoint.minPoint ? ConsumptionPoint.minPoint : point
    }
}

// [GOOD]
// なんの用途でインスタンスが生成されたのか明確
let standardMembershipPoint = GiftPoint.forStandardMembership()
let premiumMembershipPoint = GiftPoint.forPremiumMembership()

// [GOOD]
// こんなインスタンスの生成はできない
// final standardMemberShipPoint = GiftPoint(564);
