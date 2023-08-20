// 通常攻撃を管理するクラス
class PhysicalAttack {
  int singleAttackDamage() {
    return 100;
  }

  int doubleAttackDamage() {
    // こう改修された
    // 2回攻撃なんだからsingleAttackDamageを2回呼ぼうぜ
    return this.singleAttackDamage() + this.singleAttackDamage();
  }
}

// このクラスは何も変えてない
class FighterPhysicalAttack extends PhysicalAttack {
  @override
  int singleAttackDamage() {
    return super.singleAttackDamage() + 20;
  }

  @override
  int doubleAttackDamage() {
    return super.doubleAttackDamage() + 10;
  }
}

void main() {
  final fighterPhysicalAttack = FighterPhysicalAttack();

  print(fighterPhysicalAttack.singleAttackDamage());
  // doubleAttackDamageは
  // 210だった -> 250 になっちゃった！！
  print(fighterPhysicalAttack.doubleAttackDamage());
}

/* [MEMO]
-
 FighterPhysicalAttackは何も変えてない(-> Gitなどのバージョン管理ツールでも差分は出ない)
 それなのに挙動が変わった
-
 PhysicalAttack側は誰に継承されてるか分からないのでここに差分があってもどこまで影響するか分からない
-
 「武闘家」という属性のためのFighterPhysicalAttackということは
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
