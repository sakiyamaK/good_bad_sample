class PysicalAttack {
    func singleAttackDamage() -> Int {
        return 100
    }
    
    func doubleAttackDamage() -> Int {
        return 200
    }
}

class FighterPysicalAttack {
    // こうやって継承せず内部でパラメータとして持つことを
    // コンポジション構造って言うんだって
    // 初めて聞いたね！
    private let pysicalAttack = PysicalAttack()
    
    // singleAttackDamageがoverrideされるわけではないから
    // pysicalAttack.doubleAttackDamage()が先ほどの改修をしても影響がない
    func singleAttackDamage() -> Int {
        return pysicalAttack.singleAttackDamage() + 20
    }
    
    func doubleAttackDamage() -> Int {
        return pysicalAttack.doubleAttackDamage() + 10
    }
}

let fighterPysicalAttack = FighterPysicalAttack()

print(fighterPysicalAttack.singleAttackDamage())
print(fighterPysicalAttack.doubleAttackDamage())

/* [まとめ]
 -
 ただし
 これでも全く影響がないわけではない
 「通常の2回攻撃だけ300にする」というふうに仕様が変わって書き換えたら
 武闘家の2回攻撃も変わってしまうのでバグとなる
-
 ただしのただし
 「武闘家の2回攻撃は通常の2回攻撃に+10される」という仕様であるなら
 「通常の2回攻撃だけ300にする」という仕様変更自体ありえるか？という疑問もある
 「武闘家の2回攻撃は通常の2回攻撃に+10される」という仕様であるなら
 「通常の2回攻撃を300」にしたら「武闘家の2回攻撃は310であるべき」だし
 むしろ影響があって修正忘れをすることがないから良いとも言える
-
 結局良し悪しはある
 大事なのは「自分のこの書き方だと、修正があったらどこまで影響するのか」意識してコントロールできること
*/
