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

  // [BAD]
  // インスタンスの状態を変える処理があちこちにある
  // それらのメソッドが何万行のプロジェクトの中のいたるところで呼ばれていると
  // 結局valueが今いくつなのか、上限はどこまでなのか分からない
  // もっというとicrementがマイナスだとvalueはMIN以下になるバグがある
  void reinForce(int increment) {
    value += increment;
  }

  // [BAD]
  // インスタンスの状態を変える処理があちこちにある
  void disable() {
    value = _MIN;
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
  attackPower.reinForce(10);

  attackPower.reinForce(10);

  attackPower.disable();

  attackPower.reinForce(10);
// ========================================

  // [BAD]
  // weapon.attackPower.valueが結局いくつなのか実行時にしか分からない
  print("weapon attack power : ${weapon.attackPower.value}");
}
