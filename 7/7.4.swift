// forで回す時の話を簡単にするためにstructではなくclassで用意
class Member {
    enum StateType {
        case poison, dead
    }
    
    var name: String
    var hitPoint: Int
    var sateTypes: [StateType] = []

    init(name: String, hitPoint: Int) {
        self.name = name
        self.hitPoint = hitPoint
    }
}

let members = [Member(name: "田中", hitPoint: 100), Member(name: "山田", hitPoint: 100)]

// 毒状態ならHPを減らす
// [GOOD]
// guardとcontinueで
// 入れ子を解消して見やすくした
// それより下のコードを追う必要をなくした
for member in members {
    guard
        0 < member.hitPoint,
        member.sateTypes.contains(.poison)
    else { continue }

    member.hitPoint -= 10

    guard member.hitPoint <= 0 else {
        continue
    }

    member.sateTypes.append(.dead)
    member.sateTypes.removeAll { $0 == .poison }
}
