// 通常攻撃を管理するクラス
class PhysicalAttack {
  // 1回攻撃
  int singleAttackDamage() {
    // 何か処理
    return 100;
  }

  // 2回攻撃
  int doubleAttackDamage() {
    // 何か処理
    return 200;
  }
}

// 操作キャラクタが武闘家の時の通常攻撃を管理するクラス
// PhysicalAttackを継承する
// [BAD]
// 継承は強力だが人類には早過ぎた
// AppleとかGoogleとかすごい人たちだけが使おう
class FighterPhysicalAttack extends PhysicalAttack {
  @override
  int singleAttackDamage() {
    // super(PhysicalAttack)クラスのメソッドに20足す
    return super.singleAttackDamage() + 20;
  }

  @override
  int doubleAttackDamage() {
    // super(PhysicalAttack)クラスのメソッドに10足す
    return super.doubleAttackDamage() + 10;
  }
}

void main() {
  final fighterPhysicalAttack = FighterPhysicalAttack();

  print(fighterPhysicalAttack.singleAttackDamage());
  print(fighterPhysicalAttack.doubleAttackDamage());
}