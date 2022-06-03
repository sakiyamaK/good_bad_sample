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
  // [GOOD??]
  // GOODとは言い難いがclassを使いまわさないようにした方がよい
  final attackPowerA = AttackPower(20);
  final weaponA = Weapon(attackPowerA);
  final attackPowerB = AttackPower(20);
  final weaponB = Weapon(attackPowerB);

  //仕様追加で武器Bのパワーが変わった
  weaponB.attackPower.value = 25;

  // [GOOD]
  // 仕様追加があったweaponBだけパワーが変わった
  // [おまけ]
  // classは参照渡しという概念であるためweaponAとBの両方のパワーが変わった
  // 当日話します
  print("weapon a attack power : ${weaponA.attackPower.value}");
  print("weapon b attack power : ${weaponB.attackPower.value}");
}
