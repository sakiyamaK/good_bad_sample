import Foundation

struct Member {
    var level: Int
    var agility: Int
    var tecnicalPoint: Int
}

// [GOOD]
// swiftでは
// enumにメソッドやcomputed parameterが持たせられる
// caseの追加漏れがあるとビルドエラーとなる
// そのため書籍のようにMagicクラスを用意する必要がない
enum MagicType {
    case fire, shiden
    
    // [GOOD]
    // caseの追加漏れがあるとビルドエラーとなるためswitchが乱立してもいい
    // むしろ書籍のように書くとパラメータの追加忘れが起きて危険
    /*
     switch magicType {
     case .fire:
       name = ".."
        ...
        ...
       costMagicPoint = 10
        ...
        ...
     case .shiden:
     name = ".."
      ...
      ... <-- costMagicPointの更新抜けちゃった
      ...
     */
    var name: String {
        switch self {
        case .fire:
            return "ファイア"
        case .shiden:
            return "紫電"
        }
    }
    
    func costMagicPoint(member: Member) -> Int {
        switch self {
        case .fire:
            return 2
        case .shiden:
            return 5 + Int(Double(member.level) * 0.2)

        }
    }
    
    func attackPower(member: Member) -> Int {
        switch self {
        case .fire:
            return 20 + Int(Double(member.level) * 0.5)
        case .shiden:
            return 50 + Int(Double(member.agility) * 1.5)
        }
    }
    
    func costTecnicalPoint(member: Member) -> Int {
        switch self {
        case .fire:
            return 0
        case .shiden:
            return 5
        }
    }

}


let member = Member(level: 10, agility: 10, tecnicalPoint: 10)
// [GOOD]
// 「炎」魔法に関連付いてattackPowerが呼び出されている
// [コメント]
// ただ自分としては「メンバーが炎魔法を呼び出す」というイメージだから
// member.attackPower(magicType: .fire) と呼び出すように実装するなあ
MagicType.fire.attackPower(member: member)
