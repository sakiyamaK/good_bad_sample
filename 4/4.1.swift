//4.1

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
// 後のSwiftUIはStruct中心で設計されている
// classとstructの違いは話が逸れるためここでは詳し説明しない
struct MemberStuct {
    let power: Double
    let weaponAttack: Double
    let speed: Double
    let defence: Double

    //structの場合initが勝手にできるので自分で書く必要がない
}

let member = Member()
let enemy = Enemy()

func damege() -> Int {
    // [おまけ]
    // 書籍ではpower()といったメソッド呼び出しにしていたが、引数がなく値を取得するだけなのでpowerというパラメータ呼び出しにしている

    // [BAD]
    // tmpという途中で意味が変わるパラメータになっている
    // これではダメージ計算の処理がもっと複雑に何十行になって分岐も発生したりすると
    // どこのtmpがどこを通って今どういう処理をした値なのか分からず
    // バグがあった時にどこを検証していいか分かりづらくなる
    
    //メンバーの腕力と武器性能が基本攻撃力
    var tmp: Int = member.power + member.weaponAttack
    // [おまけ] swiftの場合は計算結果が少数になってもintのままなのでintにパースする必要がない
    //メンバーのスピードで攻撃力を補正
    tmp = tmp * (1 * member.speed / 100)
    // [おまけ] swiftの場合は計算結果が少数になってもintのままなのでintにパースする必要がない
    //攻撃力から敵の防御力を差し引いたのがダメージ
    tmp = tmp - enemy.defence / 2
    //負の値にならないように補正
    tmp = max(0, tmp)
    return tmp
}

print(damege())
