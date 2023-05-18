import Foundation

struct Member {
    var level: Int
    var agility: Int
    var tecnicalPoint: Int
    var magicAttackPoint: Int
}

enum MagicType {
    case fire, shiden, hellFire
}

// [GOOD]
// IntのままだとMPとAttackPowerを足すみたいなバグが生まれてしまうが
// それぞれの型を分けることでコンパイルエラーとなりそれが防げる
// [コメント]
// ただ、ここまで型を用意するべきかどうかはプロジェクト次第
// こういうひとつのIntなどを持つデータがあれば
//「明確に型を分けて誤った型同士を計算することを防いでるんだな」
// という目的と察することが重要 他の目的もあるかもしれないしね
struct MagciPoint {
    let value: Int
}
struct AttackPower {
    let value: Int
}
struct CostTecnicalPoint {
    let value: Int
}

protocol Magic {
    var name: String { get }
    // [GOOD]
    // 戻り値の型が明確に分かれた
    var costMagicPoint: MagciPoint { get }
    func attackPower(member: Member) -> AttackPower
    func costTecnicalPoint(member: Member) -> CostTecnicalPoint
}

struct Fire: Magic {
    var name: String = "ファイア"
    var costMagicPoint: MagciPoint = .init(value: 2)
    func attackPower(member: Member) -> AttackPower {
        return AttackPower(value: 20 + Int(Double(member.level) * 0.5))
        // もしくは型が決まってるからこう書ける
        // return .init(value: 20 + Int(Double(member.level) * 0.5))
    }
    func costTecnicalPoint(member: Member) -> CostTecnicalPoint {
        return CostTecnicalPoint(value: 0)
        // もしくは型が決まってるからこう書ける
        // return .init(value: 0)
    }
}

struct Shiden: Magic {
    var name: String = "紫電"
    var costMagicPoint: MagciPoint = .init(value: 5)
    func attackPower(member: Member) -> AttackPower {
        return AttackPower(value: 50 + Int(Double(member.agility) * 1.5))
    }
    func costTecnicalPoint(member: Member) -> CostTecnicalPoint {
        return CostTecnicalPoint(value: 5)
    }
}

struct HellFire: Magic {
    var name: String = "地獄の業火"
    var costMagicPoint: MagciPoint = .init(value: 16)
    func attackPower(member: Member) -> AttackPower {
        return AttackPower(value: 200 + Int(Double(member.magicAttackPoint) * 0.5 + Double(member.agility * 2)))
    }
    func costTecnicalPoint(member: Member) -> CostTecnicalPoint {
        return CostTecnicalPoint(value: 20 + Int(Double(member.level) * 0.4))
    }
}

let magics: [MagicType: Magic] = [
    .fire: Fire(),
    .shiden: Shiden(),
    .hellFire: HellFire()
]

extension Member {
    private func showMagicName(magic: Magic) {
        // 本来は名前を画面に表示させたりなどが実装される
        print("名前: \(magic.name)")
    }
    
    private func cnsumeMagicPoint(magic: Magic) {
        // 本来はMagicPointの消費処理などが実装される
        print("消費MP: \(magic.costMagicPoint.value)")
    }
    
    private func cnsumeTechnicalPoint(magic: Magic) {
        // 本来はTechnicalPointの消費処理などが実装される
        let costTecnicalPoint = magic.costTecnicalPoint(member: self)
        print("消費TP: \(costTecnicalPoint.value)")
    }
    
    private func damage(magic: Magic) {
        // 本来はDamageの消費処理などが実装される
        print("ダメージ: \(magic.attackPower(member: self).value)")
    }
    
    func attackMagic(magicType: MagicType) {
        guard let magic = magics[magicType] else { return }
        print("-------")
        self.showMagicName(magic: magic)
        self.cnsumeMagicPoint(magic: magic)
        self.cnsumeTechnicalPoint(magic: magic)
        self.damage(magic: magic)
    }
    
    // [おまけ]
    func attack(magic: Magic) {
        print("-------")
        self.showMagicName(magic: magic)
        self.cnsumeMagicPoint(magic: magic)
        self.cnsumeTechnicalPoint(magic: magic)
        self.damage(magic: magic)
    }
    
}

let member = Member(level: 1, agility: 1, tecnicalPoint: 1, magicAttackPoint: 1)
member.attackMagic(magicType: .fire)
member.attackMagic(magicType: .shiden)
member.attackMagic(magicType: .hellFire)

// [おまけ]
member.attack(magic: Fire())
member.attack(magic: Shiden())
member.attack(magic: HellFire())
