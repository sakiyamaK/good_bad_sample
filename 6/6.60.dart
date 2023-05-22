enum HealthCondition {
  dead, fine
}

class Member {
      
  int hitPoint;
  int magicPoint;
  HealthCondition state = HealthCondition.fine;

  Member({required this.hitPoint, required this.magicPoint});

  // [BAD]
  // フラグでHPかMPにダメージを与える仕様になっている
  // 使う側や後から処理を追う側からするとメソッドの中身を見ないと分からない
  void damage(bool damageFlag, int damageAmount) {
    if (damageFlag) {
      // ヒットポイントへダメージ
      // 0以下にならないようにする記述
      hitPoint = (hitPoint - damageAmount).clamp(0, hitPoint);
      // 0になったら死亡
      if (hitPoint == 0) {
        state = HealthCondition.dead;
      }
    } else {
      // マジックポイントへダメージ
      // 0以下にならないようにする記述
      magicPoint = (magicPoint - damageAmount).clamp(0, magicPoint);
    }
  }

    // [超BAD]
  // 何を実行して何の番号か中身を見ないとさっぱり分からない
  // if else が100個あったらもう...
  void execute(processNumber: Int) {
    if (processNumber == 0) {

    } else if (processNumber == 1) {

    } else if (processNumber == 2) {
      
    }
  }

}

void main() {
  var member = Member(hitPoint: 100, magicPoint: 100);
  // [BAD]
  // 何にダメージを与えているか分からない
  // メソッドとは「中身が何をしているか知らなくてもいいようにするため」にあるのに...
  // まさかこれを呼ぶとstateが変わったりMPに変化があったりするとは思わない
  member.damage(true, 20);
}
