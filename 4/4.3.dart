//4.3
import 'dart:math';

class Member {
  final int power;
  final int weaponAttack;
  final int speed;
  final int defence;

  Member(
      {int power = 10, int weaponAttack = 10, int speed = 10, int defence = 0})
      : this.power = power,
        this.weaponAttack = weaponAttack,
        this.speed = speed,
        this.defence = defence {}
}

class Enemy {
  final int power;
  final int weaponAttack;
  final int speed;
  final int defence;

  Enemy(
      {int power = 10, int weaponAttack = 10, int speed = 10, int defence = 0})
      : this.power = power,
        this.weaponAttack = weaponAttack,
        this.speed = speed,
        this.defence = defence {}
}

int damege() {
  final member = Member();
  final enemy = Enemy();

  // [GOOD]
  // それぞれの行の計算結果が定数かつ正しい名前となっているため「何の数値か分かりやすい」 <-- 重要
  // 定数は変化しないため「他の行を見渡して値がどうなったか調べる必要はない」 <-- 重要

  //メンバーの腕力と武器性能が基本攻撃力
  final basicAttackPower = member.power + member.weaponAttack;
  //メンバーのスピードで攻撃力を補正
  final finalAttackPower = basicAttackPower * (1 * member.speed / 100);

  final reduction = enemy.defence / 2;
  //攻撃力から敵の防御力を差し引いたのがダメージ
  //負の値にならないように補正
  final damege = max(0, finalAttackPower - reduction).toInt();
  return damege;
}

void main() {
  print(damege());
}
