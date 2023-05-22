
struct Member {
      
  enum HealthCondition {
      case dead, fine
  }

  var hitPoint: Int
  var magicPoint: Int
  var state: HealthCondition = .fine

  // [BAD]
  // フラグでHPかMPにダメージを与える仕様になっている
  // 使う側や後から処理を追う側からするとメソッドの中身を見ないと分からない
  func damage(damageFlag: Bool, damageAmount: Int) {
    if damageFlag {
      // ヒットポイントへダメージ
      // 0以下にならないようにする記述
      hitPoint = max(0, hitPoint - damageAmount)
      // 0になったら死亡
      if hitPoint == 0 {
        state = .dead
      }
    } else {
      // マジックポイントへダメージ
      // 0以下にならないようにする記述
      magicPoint = max(0, magicPoint - damageAmount)
    }
  }

  // [超BAD]
  // 何を実行して何の番号か中身を見ないとさっぱり分からない
  // if else が100個あったらもう...
  func execute(processNumber: Int) {
    if processNumber == 0 {

    } else if processNumber == 1 {

    } else if processNumber == 2 {
      
    }
  }
}

let member = Member(hitPoint: 100, magicPoint: 100)
// [BAD]
// 何にダメージを与えているか分からない
// メソッドとは「中身が何をしているか知らなくてもいいようにするため」にあるのに...
// まさかこれを呼ぶとstateが変わったりMPに変化があったりするとは思わない
member.damage(damageFlag: true, damageAmount: 20)