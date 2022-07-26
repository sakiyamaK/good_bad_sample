class AttackPower {
    static let MIN = 0
    // [GOOD]
    // 定数にしてあとから変わらないようにする
    let value: Int

    init(value: Int) throws {
        // [GOOD]
        // guard節で不正な値が代入されないようにしている
        guard value >= AttackPower.MIN else {
            throw fatalError()
        }
        self.value = value
    }

    // [GOOD?]
    // GOODとは言い難いが元のインスタンスを変更させてないという点では良い
    func reinForce(increment: Int) -> AttackPower {
        // [おまけ]
        // 他の書き方
        // return try! .init(value: self.value + increment)
        // try! .init(value: self.value + increment) //1行ならreturnもいらない

        // [おまけ]
        // 本当はtry!などせずcatchで処理すべきだが、話が逸れるため使っている
        return try! AttackPower(value: value + increment)
    }

    // [GOOD?]
    // GOODとは言い難いが元のインスタンスを変更させてないという点では良い
    func disable() -> AttackPower {
        return try! AttackPower(value: AttackPower.MIN)
    }
}

class Weapon {
    // [GOOD]
    // 定数パラメータ
    let attackPower: AttackPower

    init(attackPower: AttackPower) {
        self.attackPower = attackPower
    }
}

let attackPower = try! AttackPower(value: 20)
let weapon = Weapon(attackPower: attackPower)

// ========================================
//  何万行のプロジェクトの中のどこかで何箇所もこれらが書いてるとする
// どういう順番で呼ばれるか分からない
// classは参照渡しのためそれぞれ常に他に影響があるかもしれないと気にする必要がある
let reinForced1 = attackPower.reinForce(increment: 10)

let reinForced2 = attackPower.reinForce(increment: 10)

let disablePower = attackPower.disable()

let reinForced3 = attackPower.reinForce(increment: 10)
// ========================================

// [GOOD]
// どこでどうプログラムが動こうと一度20と決めたパラメータは変わらない
print("weapon attack power : \(weapon.attackPower.value)")
