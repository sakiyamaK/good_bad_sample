//4.1
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

  // [BAD]
  // tmpという途中で意味が変わるパラメータになっている
  // これではダメージ計算の処理がもっと複雑に何十行になって分岐も発生したりすると
  // どこのtmpがどこを通って今どういう処理をした値なのか分からず
  // バグがあった時にどこを検証していいか分かりづらくなる

  //メンバーの腕力と武器性能が基本攻撃力
  int tmp = member.power + member.weaponAttack;
  //メンバーのスピードで攻撃力を補正
  tmp = tmp * (1 * member.speed / 100).toInt();
  //攻撃力から敵の防御力を差し引いたのがダメージ
  tmp = tmp - (enemy.defence / 2).toInt();
  //負の値にならないように補正
  tmp = max(0, tmp);
  return tmp;
}

void main() {
  print(damege());
}
