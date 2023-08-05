struct Member {
    var magicPower: Int
    var affection: Int
}
// 回復処理
class HitPointRecovery {
    let chanter: Member
    let targetMemberId: Int
    let positiveFeelings: Int
    
    init(chanter: Member, targetMemberId: Int, positiveFeelings: Int) {
        self.chanter = chanter
        self.targetMemberId = targetMemberId
        self.positiveFeelings = positiveFeelings
    }
}

class PositiveFeelings {
    func value(subjectId: Int, targetId: Int) -> Int {
        return 10
    }
}
