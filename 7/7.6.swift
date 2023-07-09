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

// [BAD]
// for文の中が複雑なロジックで追いづらい
// for文を読んだ結果totalDamageを求めていることが分かるが
// 他に何かしているかもしれないしそれは読まなきゃ分からない <-- ここが重要
var totalDamage = 0
for member in members {
    if member.hasTeamAttackSucceeded {
        if 30 < member.teamAttack {
            totalDamage += member.teamAttack
        } else {
            break
        }
    }
    else {
        break
    }
}

print("totalDamage: \(totalDamage)")
