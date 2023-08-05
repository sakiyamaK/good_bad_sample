// 通常攻撃を管理するクラス
class PysicalAttack {
    // 1回攻撃
    func singleAttackDamage() -> Int {
        // 何か処理
        return 100
    }
    
    // 2回攻撃
    func doubleAttackDamage() -> Int {
        // 何か処理
        return 200
    }
}

// 操作キャラクタが武闘家の時の通常攻撃を管理するクラス
// PysicalAttackを継承する
// [BAD]
// 継承は強力だが人類には早過ぎた
// AppleとかGoogleとかすごい人たちだけが使おう
class FighterPysicalAttack: PysicalAttack {
    override func singleAttackDamage() -> Int {
        // super(PysicalAttack)クラスのメソッドに20足す
        return super.singleAttackDamage() + 20
    }
    
    override func doubleAttackDamage() -> Int {
        // super(PysicalAttack)クラスのメソッドに10足す
        return super.doubleAttackDamage() + 10
    }
}

let fighterPysicalAttack = FighterPysicalAttack()

print(fighterPysicalAttack.singleAttackDamage())
print(fighterPysicalAttack.doubleAttackDamage())

