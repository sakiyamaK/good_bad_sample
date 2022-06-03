//4.7~4.8

class AttackPower {
  static final MIN = 0;
  // [BAD]
  // 定数になっていないのであとからどう変わるか分からない
  late int value;
  AttackPower(int value) {
    // [GOOD]
    // guard節で不正な値が代入されないようにしている
    if (value < MIN) {
      throw Exception();
    }
    this.value = value;
  }
}

class Weapon {
  final AttackPower attackPower;
  // [GOOD]
  // インスタンス生成時に値が決まる定数のイニシャライザの書き方
  Weapon(AttackPower attackPower) : this.attackPower = attackPower {}
}

void main() {
  // [BAD]
  // クラスのインスタンスをパラメータとして渡して使い回している
  final attackPower = AttackPower(20);
  final weaponA = Weapon(attackPower);
  final weaponB = Weapon(attackPower);

  //仕様追加でweaponBのパワーが変わった
  weaponB.attackPower.value = 25;

  // [BAD]
  // 仕様追加があったのはweaponBのパワーだけなのに
  // 両方のパワーが変更されてしまった
  // [おまけ]
  // classは参照渡しという概念であるためweaponAとBの両方のパワーが変わった
  // 当日話します
  print("weapon a attack power : ${weaponA.attackPower.value}");
  print("weapon b attack power : ${weaponB.attackPower.value}");

}
