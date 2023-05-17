//6.3

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
        case attack, magic(Magic)
    }
    
    var hitPoint: Int
    var magicPoint: Int
    // [GOD?]
    // もともとのcanActの名前を変えた
    // ステータスにおける行動チェック
    var canActForStatus: Bool {
        // 生きてるけど行動ができない場合がある
        return true
    }
    
    func canAct(type: ActionType) -> Bool {
        switch type {
        case .attack:
            return true
        case .magic(let magic):
            return magic.costMagicPoint <= magicPoint
        }

    }
        
    mutating func action(type: ActionType) {
        // [GOOD]
        // メソッドの最初に例外を全て弾く
        // 早期returnをするわけだがSwiftにはそのための文法である guard bool else { return } がある
        guard 0 < hitPoint else {
            return
        }
        guard canActForStatus else {
            return
        }
        guard canAct(type: type) else {
            return
        }

        // [GOOD]
        // メインの処理はインデントの浅い位置に書く
        // この時点で処理は確実に動くので例外はいらない
        // 仕様追加で他の条件が入ったとしても行動できない場合は↑のように早期にはじくので
        // メインの処理は変わらない
        switch type {
        case .attack:
            // 本来は攻撃時の実装がある
            break
        case .magic(let magic):
            consume(magic: magic)
            chant(magic: magic)
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


