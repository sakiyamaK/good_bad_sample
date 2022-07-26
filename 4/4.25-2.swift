
// どうしても可変な設計にする場合

import Foundation

class HitPoint {
    private static let min = 0

    // 可変であることが前提なのでletじゃないことはBADではない
    // [GOOD]
    // setterだけprivateにして外部からgetだけできるようにする
    private(set) var amount: Int

    init(amount: Int) throws {
        guard amount >= HitPoint.min else {
            throw fatalError()
        }

        self.amount = amount
    }

    func damege(damegeAmount: Int) {
        let nextAmount = amount - damegeAmount
        amount = max(HitPoint.min, nextAmount)
    }

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
    // [GOOD]
    // setterだけprivateにして外部からgetだけできるようにする
    private(set) var states: [State]

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

// [GOOD]
// member.amountが外部から修正できない(ビルドが通らない)
// member.stateが外部から修正できない(ビルドが通らない)
member.hitPoint.amount = -20
member.states.append(.alive)
print(member.hitPoint.amount)
print(member.states)
