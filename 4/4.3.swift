// 4.1

import Foundation

class Member {
    let power: Int
    let weaponAttack: Int
    let speed: Int
    let defence: Int

    init(power: Int = 10, weaponAttack: Int = 10, speed: Int = 10, defence: Int = 0) {
        self.power = power
        self.weaponAttack = weaponAttack
        self.speed = speed
        self.defence = defence
    }
}

class Enemy {
    let power: Int
    let weaponAttack: Int
    let speed: Int
    let defence: Int

    init(power: Int = 10, weaponAttack: Int = 10, speed: Int = 10, defence: Int = 0) {
        self.power = power
        self.weaponAttack = weaponAttack
        self.speed = speed
        self.defence = defence
    }
}

// [おまけ]
// 実はSwiftの場合Classを使うよりStructを中心に使う方が良い
// UIKitのViewControllerなどはObjC互換のためclass中心で設計されているが
// 後のSwiftはstruct中心で設計されている
// classとstructの違いは話が逸れるためここでは詳し説明しない
struct MemberStuct {
    let power: Double
    let weaponAttack: Double
    let speed: Double
    let defence: Double

    // structの場合initが勝手にできるので自分で書く必要がない
}

let member = Member()
let enemy = Enemy()

func damege() -> Int {
    // [GOOD]
    // それぞれの行の計算結果が定数かつ正しい名前となっているため「何の数値か分かりやすい」 <-- 重要
    // 定数は変化しないため「他の行を見渡して値がどうなったか調べる必要はない」 <-- 重要

    // メンバーの腕力と武器性能が基本攻撃力
    let basicAttackPower: Int = member.power + member.weaponAttack
    // メンバーのスピードで攻撃力を補正
    let finalAttackPower = basicAttackPower * (1 * member.speed / 100)

    let reduction = enemy.defence / 2
    // 攻撃力から敵の防御力を差し引いたのがダメージ
    // 負の値にならないように補正
    let damege = max(0, finalAttackPower - reduction)
    return damege
}

print(damege())
