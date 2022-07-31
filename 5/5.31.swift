class Equipment {}

class Equipments {
    // [GOOD]
    // パラメータがprivateで不用意にアクセスできないので安全
    // このクラスの中だけ注意していればいい
    private var canChange: Bool {
        true //本来はロジックが入ってtrue/falseが返る
    }
    private var head: Equipment? = .init()
    private var armor: Equipment? = .init()
    private var arm: Equipment? = .init()
    
    
    func equipArmor(newArmor: Equipment) {
        guard canChange else { return }
        arm = newArmor
    }
    
    func deactivateAll() {
        head = nil
        armor = nil
        arm = nil
    }
}

class Member {
    let equipments: Equipments = .init()
}

class Party {
    let members: [Member] = [Member(), Member(), Member()]
}

func equipArmor(party: Party, memberId: Int, newAromor: Equipment) {
    // [GOOD]
    // 装備できるかどうかのロジックはEquipmentsに集約されたのでここに必要がない
    party.members[memberId].equipments.equipArmor(newArmor: newAromor)
}
