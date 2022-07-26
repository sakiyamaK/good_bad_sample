// そもそもswiftはclass(参照型)によって発生するバグを避けるために
// struct(値型)中心に移行している
// UIKitはclassメイン
// SwiftUIはstructメイン

// [おまけ]
// [GOOD]
// class中心ではなくstruct中心で設計している

struct AttackPower {
    static let MIN = 0
    var value: Int

    init(value: Int) throws {
        // [GOOD]
        // guard節で不正な値が代入されないようにしている
        guard value >= AttackPower.MIN else {
            throw fatalError()
        }
        self.value = value
    }
}

struct Weapon {
    // あとで値を変えるからわざとvar
    // [BAD] 本来はあとで値を変えること自体がダメだが今は例を示すため
    var attackPower: AttackPower
}

let attackPower = try! AttackPower(value: 20)

// [GOOD]
// structは値渡しのためメソッドに渡すとコピーされる

let weaponA = Weapon(attackPower: attackPower)
// あとで値を変えるからわざとvar
// [BAD] 本来はあとで値を変えること自体がダメだが今は例を示すため
var weaponB = Weapon(attackPower: attackPower)

weaponB.attackPower.value = 25

// [GOOD]
// 仕様追加があったweaponBだけパワーが変わった
print("weapon a attack power : \(weaponA.attackPower.value)")
print("weapon b attack power : \(weaponB.attackPower.value)")
