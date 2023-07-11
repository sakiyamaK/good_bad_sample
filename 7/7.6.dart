import 'dart:math';

class Member {
  bool get hasTeamAttackSucceeded {
    // 何か条件によってチームアタックできない仕様になるかもしれないので
    // computed parameterで定義
    return true;
  }
  
  // 10, 20, 30, 40, 50のどれかがランダム
  int get attack => (Random().nextInt(5) + 1) * 10;

  int get teamAttack => (1.1 * attack).toInt();
}

void main() {
  // 4人のメンバーを作り攻撃力が高い順に並べた
  var members = List<Member>.generate(4, (_) => Member())..sort((a, b) => b.attack.compareTo(a.attack));
  //全員の攻撃力を表示
  print(members.map((member) => member.attack.toString()).join(','));

  // [BAD]
  // for文の中が複雑なロジックで追いづらい
  // for文を読んだ結果totalDamageを求めていることが分かるが
  // 他に何かしているかもしれないしそれは読まなきゃ分からない <-- ここが重要
  var totalDamage = 0;
  for (var member in members) {
    if (member.hasTeamAttackSucceeded) {
      if (30 < member.teamAttack) {
        totalDamage += member.teamAttack;
      } else {
        break;
      }
    }
    else {
      break;
    }
  }

  print('totalDamage: $totalDamage');
}
