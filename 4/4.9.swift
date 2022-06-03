class AttackPower {
  static let MIN = 0
  // [BAD]
  // 定数になっていないのであとからどう変わるか分からない
    var value: Int
    
    init(value: Int) throws {
        // [GOOD]
        // guard節で不正な値が代入されないようにしている
        guard value > AttackPower.MIN else {
            throw fatalError()
        }
        self.value = value
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

// [BAD]
// クラスのインスタンスをパラメータとして渡して使い回している
// [おまけ]
// 本当はtry!などせずcatchで処理すべきだが、話が逸れるため使っている
let attackPower = try! AttackPower(value: 20)
let weaponA = Weapon(attackPower: attackPower)
let weaponB = Weapon(attackPower: attackPower)

//仕様追加でweaponBのパワーが変わった
weaponB.attackPower.value = 25;

// [BAD]
// 仕様追加があったのはweaponBのパワーだけなのに
// 両方のパワーが変更されてしまった
// [おまけ]
// classは参照渡しという概念であるためweaponAとBの両方のパワーが変わった
// 当日話します
print("weapon a attack power : \(weaponA.attackPower.value)");
print("weapon b attack power : \(weaponB.attackPower.value)");


