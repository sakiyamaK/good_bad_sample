import 'dart:math';

class Member {
  bool get hasTeamAttackSucceeded {
    // 何か条件によってチームアタックできない仕様になるかもしれないので
    // computed parameterで定義
    return true;
  }
  
  // 10, 20, 30, 40, 50のどれかがランダム
  final attack = (Random().nextInt(5) + 1) * 10;

  int get teamAttack => (1.1 * attack).toInt();
}

void main() {
  // 4人のメンバーを作り攻撃力が高い順に並べた
  final members = List<Member>.generate(4, (_) => Member())..sort((a, b) => b.attack.compareTo(a.attack));
  //全員の攻撃力を表示
  print(members.map((member) => member.attack.toString()).join(','));

  // [GOOD]
  // 配列操作関数を使うことで中の処理を追うことなく
  // totalDamageが求まることが分かる
  // 他に何かのパラメータを更新させたりする余地がない
  final totalDamage = members
    .where((member) => member.hasTeamAttackSucceeded && member.teamAttack > 30)
    .fold(0, (prev, member) => prev + member.teamAttack);

  print('totalDamage: $totalDamage');
}
