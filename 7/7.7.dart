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
  // forの最初に条件を記載して早期breakさせることで
  // 最初にどういう条件を満たせばいいかが分かり、条件を満たすと何をするのかはっきりした
  // [BAD]
  // totalDamageを求めているだけなのはまだ結局for文の中を追わないと分からない
  // 他に何かしているかもしれないしそれは読まなきゃ分からない <-- ここが重要
  var totalDamage = 0;
  for (var member in members) {
    if (!member.hasTeamAttackSucceeded || member.teamAttack <= 30) {
      break;
    }
    totalDamage += member.teamAttack;
  }

  print('totalDamage: $totalDamage');
}
