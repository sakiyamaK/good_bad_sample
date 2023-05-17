import Foundation

struct Member {

    enum HealthCondition {
        case dead, danger, caution, fine
        // [GOOD]
        // このenumのデフォルトを明記する
        static var `default`: HealthCondition { .fine }
    }

    private(set) var hitPoint: Int
    private(set) var maxHitPoint: Int
    
    var condition: HealthCondition {
        let hitPointRate = CGFloat(hitPoint) / CGFloat(maxHitPoint)
        // [GOOD]
        // 早期returnをしたため不要な変数がなくなった
        // そのおかげで「この変数には何の値が入るんだろう」とずっと気にながら処理を追う必要がなくなった
        if hitPointRate == 0 {
            // [GOOD]
            // 早期returnしているためこれ以降の処理を追う必要がない
            return .dead
        } else if hitPointRate < 0.3 {
            // [BAD?]
            // 無駄なelse 文がある
            return .danger
        } else if hitPointRate < 0.5 {
            return .caution
        } else {
            // [GOOD]
            // 最終的にdefaultを返す (この場合はfineだが仕様変更でそうじゃなくなる可能性はある)
            return .default
        }
    }
}


