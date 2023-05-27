enum HealthCondition {
  dead, fine
}

enum DamageType {
  hitPoint, magicPoint
}

abstract class Damage {
  void execute(Member member, int damageAmount);
}

class HitPointDamage implements Damage {
  @override
  void execute(Member member, int damageAmount) {
    // [BAD]
    // バリバリmemberの副作用が起きている
    member.hitPoint = (member.hitPoint - damageAmount).clamp(0, member.hitPoint);
    if (member.hitPoint == 0) {
      member.state = HealthCondition.dead;
    }    
  }
}

class MagicPointDamage implements Damage {
  @override
  void execute(Member member, int damageAmount) {
    // [BAD]
    // バリバリmemberの副作用が起きている
    member.magicPoint = (member.magicPoint - damageAmount).clamp(0, member.magicPoint);
  }
}

class Member {
      
  HealthCondition state = HealthCondition.fine;
  int hitPoint;
  int magicPoint;

  Member({required this.hitPoint, required this.magicPoint});

  // [GOOD]
  // ひとつのメソッドで実現できているという点はGOOD
  // 他のパラメータにダメージを与える仕様が追加されてもこのメソッドはもう変える必要がない
  void applyDamage(DamageType damageType, int damageAmount, Map<DamageType, Damage> damages) {
    // [BAD]
    // damageType、damageAmount、damages辞書という3つのプログラム的に関連のないパラメータが必須になっている
    // damagesというMemberと縁もゆかりもない辞書の中身が勝手にmember(this)のパラメータを変えている
    // メソッドは「中身を追わなくていい、中身を追うのに頭と時間を使わなくていい」ためにあるのに
    // まさかここでselfのhitPointやmagicPointが変わるとは思えない
    damages[damageType]!.execute(this, damageAmount);
  }
}

void main() {
  var damages = <DamageType, Damage>{
    DamageType.hitPoint: HitPointDamage(),
    DamageType.magicPoint: MagicPointDamage(),
  };

  var member = Member(hitPoint: 100, magicPoint: 100);
  member.applyDamage(DamageType.hitPoint, 50, damages);
  print(member.state); //dead
}
