enum HealthCondition {
  dead, fine
}

class Member {
      
  int hitPoint;
  int magicPoint;
  HealthCondition state = HealthCondition.fine;

  Member({required this.hitPoint, required this.magicPoint});

  // [GOOD]
  // それぞれのメソッドを増やそう!!
  void hitPointDamage(int damageAmount) {
    // ヒットポイントへダメージ
    // 0以下にならないようにする記述
    hitPoint = (hitPoint - damageAmount).clamp(0, hitPoint);
    // 0になったら死亡
    if (hitPoint == 0) {
      state = HealthCondition.dead;
    }
  }

  void magicPointDamage(int damageAmount) {
    // マジックポイントへダメージ
    // 0以下にならないようにする記述
    magicPoint = (magicPoint - damageAmount).clamp(0, magicPoint);
  }
}

void main() {
  var member = Member(hitPoint: 100, magicPoint: 100);
  // [GOOD]
  // 何にダメージを与えているか分かる
  // 「メソッドの中身を追わなくても」何が起きるか容易に分かる
  member.hitPointDamage(20);
}
