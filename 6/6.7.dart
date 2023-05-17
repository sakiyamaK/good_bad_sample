enum HealthCondition {
  dead,
  danger,
  caution,
  fine,
}

class Member {
  int hitPoint;
  int maxHitPoint;

  Member({required this.hitPoint, required this.maxHitPoint});

  HealthCondition get condition {
    final double hitPointRate = hitPoint / maxHitPoint;
    // [BAD]
    // 変数になっている
    // そうなると関数の1番下まで値がどうなるか分からないため関数内の全部の処理を追う必要がある
    // [BAD]
    // デフォルトが変わったら書き換えがあちこち発生する
    HealthCondition currentCondition = HealthCondition.fine;
    // [BAD]
    // 書籍ではif else句が続くことが悪いとなっているが
    // 問題点は「結局下までコードを読まなくちゃいけない」ことにある
    if (hitPointRate == 0) {
      // [BAD]
      // ここでconditionは決定したがその後何かする必要があるか分からないため結局下まで処理を追う必要がある
      currentCondition = HealthCondition.dead;
    } else if (hitPointRate < 0.3) {
      currentCondition = HealthCondition.danger;
    } else if (hitPointRate < 0.5) {
      currentCondition = HealthCondition.caution;
    } else {
      // [BAD]
      // デフォルト値として入れているfineだから不要
      currentCondition = HealthCondition.fine;
    }

    // [BAD]
    // ここにも何十行もソースが続いているとすると
    // しれっとcurrentConditionが書き換わる実装があるかもしれない

    return currentCondition;
  }
}

void main() {
  var member = Member(hitPoint: 0, maxHitPoint: 10);
  print(member.condition);
}
