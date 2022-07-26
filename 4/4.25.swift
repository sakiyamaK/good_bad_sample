// どうしても可変な設計にする場合

import Foundation

class HitPoint {
    private static let min = 0

    // 可変であることが前提なのでletじゃないことはBADではない
    // [BAD]
    // 外部から変更できてしまうためまだマイナスになりうる
    var amount: Int
    init(amount: Int) throws {
        // [GOOD]
        // amountに_MINより小さい値が入らないようにしている
        guard amount >= HitPoint.min else {
            throw fatalError()
        }

        self.amount = amount
    }

    func damege(damegeAmount: Int) {
        let nextAmount = amount - damegeAmount
        // [GOOD]
        // amountに_MINより小さい値が入らないようにしている
        amount = max(HitPoint.min, nextAmount)
    }

    // [GOOD]
    // 本ではisZeroというメソッドだった
    // しかし内部は_MINとの比較であり,_MINは仕様変更でどう値が変わるか分からない
    // パラメータがないためメソッドにする必要もない
    var isMin: Bool {
        amount == HitPoint.min
    }
}

enum State {
    case alive, death, poison
}

class Member {
    let hitPoint: HitPoint
    // Swiftの場合はletだと配列の中身が修正されることも許していないため
    // あとから状態を変えるのであればvarとなる
    // [BAD]
    // 外部から変更できてしまう
    var states: [State]

    init(hitPoint: HitPoint, states: [State]) {
        self.hitPoint = hitPoint
        self.states = states
    }

    func damege(damegeAmount: Int) {
        hitPoint.damege(damegeAmount: damegeAmount)
        if hitPoint.isMin {
            states.removeAll { state in
                state == .alive
            }
            states.append(.death)
        }
    }
}

let member = Member(hitPoint: try! HitPoint(amount: 10), states: [State.alive])

member.damege(damegeAmount: 20)

// [GOOD]
// hitPointがマイナスにならない
// statesが切り替わっている
print(member.hitPoint.amount)
print(member.states)

// [BAD]
// member.amountが外部に公開されているためdamege()以外からも変更できてしまう
// member.stateが外部に公開されているかつListのため、外部からも変更できてしまう

// 本の対応だけではまだバグが入り込む余地があるぐらい
// 変数の利用は気をつけないといけない
member.hitPoint.amount = -20
member.states.append(.alive)
print(member.hitPoint.amount)
print(member.states)
