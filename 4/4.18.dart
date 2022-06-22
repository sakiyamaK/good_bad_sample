class AttackPower {
  static final _MIN = 0;
  // [GOOD]
  // 定数にしてあとから変わらないようにする
  final int value;

  AttackPower(int value) : this.value = value {
    // [GOOD]
    // guard節で不正な値が代入されたら例外を流している
    if (this.value < _MIN) {
      throw Exception();
    }
  }

  // [GOOD?]
  // GOODとは言い難いが元のインスタンスを変更させてないという点では良い
  AttackPower reinForce(int increment) {
    return AttackPower(this.value + increment);
  }

  // [GOOD?]
  // GOODとは言い難いが元のインスタンスを変更させてないという点では良い
  AttackPower disable() {
    return AttackPower(_MIN);
  }
}

class Weapon {
  final AttackPower attackPower;
  // [GOOD]
  // インスタンス生成時に値が決まる定数のイニシャライザの書き方
  Weapon(AttackPower attackPower) : this.attackPower = attackPower {}
}

void main() {
  final attackPower = AttackPower(20);
  final weapon = Weapon(attackPower);

// ========================================
  //  何万行のプロジェクトの中のどこかで何箇所もこれらが書いてるとする
  // どういう順番で呼ばれるか分からない
  // classは参照渡しのためそれぞれ常に他に影響があるかもしれないと気にする必要がある
  final reinForced1 = attackPower.reinForce(10);

  final reinForced2 = attackPower.reinForce(10);

  final disabe = attackPower.disable();

  final reinForced3 = attackPower.reinForce(10);
// ========================================

  // [GOOD]
  // どこでどうプログラムが動こうと一度20と決めたパラメータは変わらない
  print("weapon attack power : ${weapon.attackPower.value}");
}
