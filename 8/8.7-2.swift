class PysicalAttack {
    func singleAttackDamage() -> Int {
        return 100
    }
    
    func doubleAttackDamage() -> Int {
        // こう改修された
        // 2回攻撃なんだからsingleAttackDamageを2回呼ぼうぜ
        return self.singleAttackDamage() + self.singleAttackDamage()
    }
}

// このクラスは何も変えてない
class FighterPysicalAttack: PysicalAttack {
    override func singleAttackDamage() -> Int {
        return super.singleAttackDamage() + 20
    }
    
    override func doubleAttackDamage() -> Int {
        return super.doubleAttackDamage() + 10
    }
}

let fighterPysicalAttack = FighterPysicalAttack()

print(fighterPysicalAttack.singleAttackDamage())
// doubleAttackDamageは
// 210だった -> 250 になっちゃった！！
print(fighterPysicalAttack.doubleAttackDamage())


/* [MEMO]
-
 FighterPysicalAttackは何も変えてない(-> Gitなどのバージョン管理ツールでも差分は出ない)
 それなのに挙動が変わった
-
 PysicalAttack側は誰に継承されてるか分からないのでここに差分があってもどこまで影響するか分からない
-
 「武闘家」という属性のためのFighterPysicalAttackということは
 「魔法使い」「弓兵」など仕様が増える度に同じことが起きる
 -
 継承は人類には早過ぎた
 Rustなどの最新言語仕様ではクラスの概念がなくなっていたりする
 SwiftもStructを中心として扱えるように機能が追加されていっている
 Objective-Cなどがクラスを中心とした設計でUIKitがObjCしかなかった頃に作られているので継承メインだった
 たぶん本当はSwiftを作った頃に完全にクラスを切り捨てたかったのかもしれない
 だけどUIKitがクラス中心なので互換性のためにSwiftもクラスの仕様を残した
 Swiftはクラスの仕様を残したうえで継承を使わないでいいようにするStruct中心の機能もある
 そしてSwiftUIはStruct中心で扱うフレームワーク
*/
