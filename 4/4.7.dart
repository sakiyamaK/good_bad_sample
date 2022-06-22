//4.7~4.8

class AttackPower {
  static final _MIN = 0;
  // [BAD]
  // 定数になっていないのであとからどう変わるか分からない
  late int value;

  AttackPower(int value) {
    // [GOOD]
    // guard節で不正な値が代入されないようにしている
    if (value < _MIN) {
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

  print("weapon a attack power : ${weaponA.attackPower.value}");
  print("weapon b attack power : ${weaponB.attackPower.value}");
}
