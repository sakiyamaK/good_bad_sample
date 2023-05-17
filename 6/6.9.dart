import 'dart:core';

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
    // 余計なelseが消えて見通しがよくなった
    if (hitPointRate == 0) { return HealthCondition.dead; } 
    if (hitPointRate < 0.3) { return HealthCondition.danger; } 
    if (hitPointRate < 0.5) { return HealthCondition.caution; }
    return HealthConditionExtension.defaultCondition;
  }
}


void main() {
  final member = Member(hitPoint: 0, maxHitPoint: 10);
  print(member.condition);
}