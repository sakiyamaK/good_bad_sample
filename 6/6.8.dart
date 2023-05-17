enum HealthCondition {
  dead,
  danger,
  caution,
  fine,
}

extension HealthConditionExtension on HealthCondition {
  // [GOOD]
  // このenumのデフォルトを明記する
  static get defaultCondition => HealthCondition.fine;  
}

class Member {
  int hitPoint;
  int maxHitPoint;

  Member({required this.hitPoint, required this.maxHitPoint});

  HealthCondition get condition {
    final hitPointRate = hitPoint / maxHitPoint;
    // [GOOD]
    // 早期returnをしたため不要な変数がなくなった
    // そのおかげで「この変数には何の値が入るんだろう」とずっと気にながら処理を追う必要がなくなった
    if (hitPointRate == 0) {
      // [GOOD]
      // 早期returnしているためこれ以降の処理を追う必要がない
      return HealthCondition.dead;
    } else if (hitPointRate < 0.3) {
      // [BAD?]
      // 無駄なelse 文がある
      return HealthCondition.danger;
    } else if (hitPointRate < 0.5) {
      return HealthCondition.caution;
    } else {
      // [GOOD]
      // 最終的にdefaultを返す (この場合はfineだが仕様変更でそうじゃなくなる可能性はある)
      return HealthConditionExtension.defaultCondition;
    }
  }
}


void main() {
  final member = Member(hitPoint: 0, maxHitPoint: 10);
  print(member.condition);
}