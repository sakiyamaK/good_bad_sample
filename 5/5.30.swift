class Equipment {}

class Equipments {
    var canChange: Bool {
        true //本来はロジックが入ってtrue/falseが返る
    }
    var head: Equipment = .init()
    var armor: Equipment = .init()
    var arm: Equipment = .init()
}

class Member {
    let equipments: Equipments = .init()
}

class Party {
    let members: [Member] = [Member(), Member(), Member()]
}

func equipArmor(party: Party, memberId: Int, newAromor: Equipment) {
    // [BAD]
    // パラメータの中のパラメータの中のパラメータ...とどんどん深いところのパラメータにアクセスしている
    // カプセル化できておらず、これではどこからでもアクセス可能であり、どこでどうarmorが変わったのか分からなくなる
    guard party.members[memberId].equipments.canChange else {
        return
    }
    party.members[memberId].equipments.armor = newAromor
}
