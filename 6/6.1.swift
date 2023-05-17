//6.1~6.2
import Foundation

enum Magic {
    case attack, recover
    
    var costMagicPoint: Int {
        switch self {
        case .attack:
            return 10
        case .recover:
            return 20
        }
    }
}

struct Member {
    
    enum ActionType {
        case normalAttack, magic(Magic)
    }
    
    var hitPoint: Int
    var magicPoint: Int
    // [BAD?]
    // この名前はどうだろう？
    // この判断をした後に結局MPが足りなくて行動できない場合がある
    var canAct: Bool {
        // 生きてるけど行動ができない場合がある
        // 今回は特にそういう条件分岐は入れずとりあえずtrueを返してる
        return true
    }
        
    mutating func action(type: ActionType) {
        // [BAD]
        // 複雑な条件分岐
        // どこがメインの処理か分からない
        // 条件漏れが起きる
        if 0 < hitPoint {
            if canAct {
                switch type {
                case .normalAttack:
                    // 本来は攻撃時の実装がある
                    break
                case .magic(let magic):
                    if magic.costMagicPoint <= magicPoint {
                        consume(magic: magic)
                        chant(magic: magic)
                    }
                }
            }
            
        }
    }
    
    private mutating func consume(magic: Magic) {
        magicPoint = max(0, magicPoint - magic.costMagicPoint)
    }
    
    private func chant(magic: Magic) {
        // 魔法を発動
        print("魔法をくらえ！")
    }
}


var user = Member(hitPoint: 200, magicPoint: 200)
user.action(type: .magic(.attack))


