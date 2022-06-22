// どうしても可変な設計にする場合

class HitPoint {
  // [BAD]
  // 可変であることが前提なのでletじゃないことはBADではないが
  // amountがマイナスもありえたりするなど
  // 可変なら可変で「正しい値しか」状態を保てないようにしていないことがBAD
    var amount: Int
    init(amount: Int) {
        self.amount = amount
    }
}

enum State {
    case alive, death, poison
}


class Member {
    let hitPoint: HitPoint
    let states: [State]

    init(hitPoint: HitPoint, states: [State]) {
        self.hitPoint = hitPoint
        self.states = states
    }

    func damege(damegeAmount: Int) {
        hitPoint.amount -= damegeAmount;
  }
}

let member = Member(hitPoint: HitPoint(amount: 10), states: [State.alive])

member.damege(damegeAmount: 20)

// [BAD]
// hitPointがマイナスになっている
// statesが何も切り替わってない
print(member.hitPoint.amount)
print(member.states)
