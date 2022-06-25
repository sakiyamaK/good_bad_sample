class AttackPower {
    static let MIN = 0
    // [BAD]
    // 定数になっていないのであとからどう変わるか分からない
    var value: Int
    
    init(value: Int) throws {
        // [GOOD]
        // guard節で不正な値が代入されないようにしている
        guard value >= AttackPower.MIN else {
            throw fatalError()
        }
        self.value = value
    }
    
    // [BAD]
    // インスタンスの状態を変える処理があちこちにある
    // それらのメソッドが何万行のプロジェクトの中のいたるところで呼ばれていると
    // 結局valueが今いくつなのか、上限はどこまでなのか分からない
    // もっというとicrementがマイナスだとvalueはMIN以下になるバグがある
    func reinForce(increment: Int) {
        value += increment
    }
    
    // [BAD]
    // インスタンスの状態を変える処理があちこちにある
    func disable() {
        value = AttackPower.MIN
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
attackPower.reinForce(increment: 10)

attackPower.reinForce(increment: 10)

attackPower.disable()

attackPower.reinForce(increment: 10)
// ========================================

  // [BAD]
  // weapon.attackPower.valueが結局いくつなのか実行時にしか分からない
print("weapon attack power : \(weapon.attackPower.value)")