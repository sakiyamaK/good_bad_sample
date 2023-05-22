protocol Damage {
  func execute(damageAmount: Int)
}

class HitPointDamage: Damage {
  func execute(damageAmount: Int) {
    
  }
}

struct Member {
      
  enum HealthCondition {
      case dead, fine
  }

  var hitPoint: Int
  var magicPoint: Int
  var state: HealthCondition = .fine

  // [GOOD]
  // それぞれのメソッドを増やそう!!
  func hitPointDamage(damageAmount: Int) {
      // ヒットポイントへダメージ
      // 0以下にならないようにする記述
      hitPoint = max(0, hitPoint - damageAmount)
      // 0になったら死亡
      if hitPoint == 0 {
        state = .dead
      }
  }

  func magicPointDamage(damageAmount: Int) {
      // マジックポイントへダメージ
      // 0以下にならないようにする記述
      magicPoint = max(0, magicPoint - damageAmount)
  }
}

let member = Member(hitPoint: 100, magicPoint: 100)
// [GOOD]
// 何にダメージを与えているか分かる
// 「メソッドの中身を追わなくても」何が起きるか容易に分かる
member.hitPointDamage(damageAmount: 20)