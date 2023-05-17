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
        // 余計なelseが消えて見通しがよくなった
        if hitPointRate == 0 { return .dead }
        if hitPointRate < 0.3 { return .danger }
        if hitPointRate < 0.5 { return .caution }
        return .default
    }
}
