struct Member {
    var hasTeamAttackSucceeded: Bool {
        // 何か条件によってチームアタックできない仕様になるかもしれないので
        // computed parameterで定義
        true
    }
    
    // 10, 20, 30, 40, 50のどれかがランダム
    let attack: Int = Int.random(in: 1...5) * 10

    var teamAttack: Int {
        Int(1.1 * Double(attack))
    }
}

// 4人のメンバーを作り攻撃力が高い順に並べた
let members = (1...4).compactMap { _ in Member() }.sorted(by: { $0.attack > $1.attack })
//全員の攻撃力を表示
print(members.map { String($0.attack) }.joined(separator: ","))

// [GOOD]
// forの最初に条件を記載して早期breakさせることで
// 最初にどういう条件を満たせばいいかが分かり、条件を満たすと何をするのかはっきりした
// [BAD]
// totalDamageを求めているだけなのはまだ結局for文の中を追わないと分からない
// 他に何かしているかもしれないしそれは読まなきゃ分からない <-- ここが重要
var totalDamage: Int = 0
for member in members {
    guard member.hasTeamAttackSucceeded, 30 < member.teamAttack else {
        break
    }
    totalDamage += member.teamAttack
}

print("totalDamage: \(totalDamage)")
