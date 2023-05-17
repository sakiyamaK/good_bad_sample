//6.10~6.17

import Foundation

struct Member {
    var level: Int
    var agility: Int
    var tecnicalPoint: Int
}

enum MagicType {
    case fire, shiden
}

// [BAD]?
// 書籍ではcaseの追加漏れが問題と言っているがswiftだとビルドエラーとなるためそれは起きない
// そのため同じswitch caseが並ぶことが問題になりづらい
// [BAD]
// MagicManagerという別クラスをわざわざ用意している
// しかもクラス自身にデータをもたず5章でやった低凝集な状態になっている
class MagicManager {
    func getName(magicType: MagicType) -> String {
        switch magicType {
        case .fire:
            return "ファイア"
        case .shiden:
            return "紫電"
        }
    }
    
    func costMagicPoint(magicType: MagicType, member: Member) -> Int {
        switch magicType {
        case .fire:
            return 2
        case .shiden:
            return 5 + Int(Double(member.level) * 0.2)

        }
    }
    
    func attackPower(magicType: MagicType, member: Member) -> Int {
        switch magicType {
        case .fire:
            return 20 + Int(Double(member.level) * 0.5)
        case .shiden:
            return 50 + Int(Double(member.agility) * 1.5)
        }
    }
    
    func costTecnicalPoint(magicType: MagicType, member: Member) -> Int {
        switch magicType {
        case .fire:
            return 0
        case .shiden:
            return 5
        }
    }
}

let member = Member(level: 10, agility: 10, tecnicalPoint: 10)
// [BAD]
// 「メンバー」が使う「炎」魔法なのにどちらにも関連付いてないMagicManagerを呼び出している
// プロジェクトが肥大化すると数百のクラスができるためMagicManagerの存在に気付かず
// MagicProcessクラスやMemberActionクラスなど新たに生み出しかねない
MagicManager().attackPower(magicType: .fire, member: member)
