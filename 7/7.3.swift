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
// [BAD]
// 入れ子のif文
// ifなどの条件分岐が続くとelse忘れや複雑なパターンでテストしきれなくなる
for member in members {
    if 0 < member.hitPoint {
        if member.sateTypes.contains(.poison) {
            member.hitPoint -= 10
            if member.hitPoint <= 0 {
                member.sateTypes.append(.dead)
                member.sateTypes.removeAll { $0 == .poison }
            }
        }
    }
}
