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
// 配列操作関数を使うことで中の処理を追うことなく
// totalDamageが求まることが分かる
// 他に何かのパラメータを更新させたりする余地がない
let totalDamage: Int = members.filter({
    $0.hasTeamAttackSucceeded && 30 < $0.teamAttack
}).reduce(0) { partialResult, member in
    partialResult + member.teamAttack
}

print("totalDamage: \(totalDamage)")
