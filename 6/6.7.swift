import Foundation

struct Member {

    enum HealthCondition {
        case dead, danger, caution, fine
    }

    private(set) var hitPoint: Int
    private(set) var maxHitPoint: Int
    
    var condition: HealthCondition {
        let hitPointRate = CGFloat(hitPoint) / CGFloat(maxHitPoint)
        // [BAD]
        // 変数になっている
        // そうなると関数の1番下まで値がどうなるか分からないため関数内の全部の処理を追う必要がある
        // [BAD]
        // デフォルトが変わったら書き換えがあちこち発生する
        var currentCondition: HealthCondition = .fine
        // [BAD]
        // 書籍ではif else句が続くことが悪いとなっているが
        // 問題点は「結局下までコードを読まなくちゃいけない」ことにある
        if hitPointRate == 0 {
            // [BAD]
            // ここでconditionは決定したがその後何かする必要があるか分からないため結局下まで処理を追う必要がある
            currentCondition = .dead
        } else if hitPointRate < 0.3 {
            currentCondition = .danger
        } else if hitPointRate < 0.5 {
            currentCondition = .caution
        } else {
            // [BAD]
            // デフォルト値として入れているfineだから不要
            currentCondition = .fine
        }

        // [BAD]
        // ここにも何十行もソースが続いているとすると
        // しれっとcurrentConditionが書き換わる実装があるかもしれない

        return currentCondition
    }
}


