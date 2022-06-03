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

// [GOOD??]
// GOODとは言い難いがclassを使いまわさないようにした方がよい
// [おまけ]
// 本当はtry!などせずcatchで処理すべきだが、話が逸れるため使っている
let attackPowerA = try! AttackPower(value: 20)
let weaponA = Weapon(attackPower: attackPowerA)
let attackPowerB = try! AttackPower(value: 20)
let weaponB = Weapon(attackPower: attackPowerB)

//仕様追加でweaponBのパワーが変わった
weaponB.attackPower.value = 25;

// [GOOD]
// 仕様追加があったweaponBだけパワーが変わった
print("weapon a attack power : \(weaponA.attackPower.value)");
print("weapon b attack power : \(weaponB.attackPower.value)");


