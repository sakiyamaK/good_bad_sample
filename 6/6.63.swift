// ストラテジーパターンで書いた例だが、あまり良いとは思えない

protocol Damage {
    // [BAD]
    // 良い例とは思えない理由
    // 本ではmemberはどこから渡してるか分からない
    // もしかしてグローバル変数？
    // ここではパラメータとして渡すが、内部でmemberの値が変わるといういわゆる副作用が起きていることになる
    // さらにその副作用を発生させるためにMemberを参照型であるclassにする必要がある
    func execute(member: Member, damageAmount: Int)
}

class HitPointDamage: Damage {
    func execute(member: Member, damageAmount: Int) {
        // [BAD]
        // バリバリmemberの副作用が起きている
        member.hitPoint = max(0, member.hitPoint - damageAmount)
        if member.hitPoint == 0 {
            member.state = .dead
        }
    }
}

class MagicPointDamage: Damage {
    func execute(member: Member, damageAmount: Int) {
        // [BAD]
        // バリバリmemberの副作用が起きている
        member.magicPoint = max(0, member.magicPoint - damageAmount)
    }
}

enum DamageType {
    case hitPoint, magicPoint
}

let damages: [DamageType: Damage] = [
    .hitPoint: HitPointDamage(),
    .magicPoint: MagicPointDamage()
]

// 値型のstructから参照型のclassに変えた
// Swiftは値型中心として進化していっているから良くない
class Member {
    
    enum HealthCondition {
        case dead, fine
    }
    
    var hitPoint: Int
    var magicPoint: Int
    var state: HealthCondition = .fine
    
    init(hitPoint: Int, magicPoint: Int) {
        self.hitPoint = hitPoint
        self.magicPoint = magicPoint
    }
    
    // [GOOD]
    // ひとつのメソッドで実現できているという点はGOOD
    // 他のパラメータにダメージを与える仕様が追加されてもこのメソッドはもう変える必要がない
    // Memberという他にもどんどん仕様が追加されそうなクラスにおいては良いかもしれない
    func applyDamage(damageType: DamageType, damageAmount: Int) {
        // [BAD]
        // damagesという外部のグローバル配列頼みの実装
        // damagesというMemberと縁もゆかりもない配列の中身が勝手にmember(self)のパラメータを変えている
        // メソッドは「中身を追わなくていい、中身を追うのに頭と時間を使わなくていい」ためにあるのに
        // まさかここでselfのhitPointやmagicPointが変わるとは思えない
        damages[damageType]?.execute(member: self, damageAmount: damageAmount)
    }
}

let member = Member(hitPoint: 100, magicPoint: 100)
member.applyDamage(damageType: .hitPoint, damageAmount: 110)
print(member.state) //dead
