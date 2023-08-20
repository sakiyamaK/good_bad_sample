class PhysicalAttack {
  int singleAttackDamage() => 100;

  int doubleAttackDamage() => 200;
}

class FighterPhysicalAttack {
  // こうやって継承せず内部でパラメータとして持つことを
  // コンポジション構造って言うんだって
  // 初めて聞いたね！
  final PhysicalAttack _physicalAttack = PhysicalAttack();

  // singleAttackDamageがoverrideされるわけではないから
  // _physicalAttack.doubleAttackDamage()が先ほどの改修をしても影響がない
  int singleAttackDamage() => _physicalAttack.singleAttackDamage() + 20;
  
  int doubleAttackDamage() => _physicalAttack.doubleAttackDamage() + 10;  
}

void main() {
  final fighterPhysicalAttack = FighterPhysicalAttack();

  print(fighterPhysicalAttack.singleAttackDamage());
  print(fighterPhysicalAttack.doubleAttackDamage());
}

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
