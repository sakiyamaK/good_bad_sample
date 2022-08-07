// 5.28~5.29

class MagicPoint {
    // [GOOD]
    // 5.23.dartでパラパラだった引数のパラメータたちがMagicPointというひとつのクラスに関連付けられた
    // つまりこの３つは常に関わりのあるパラメータであることが分かる
    private var currentAmount: Int
    private let originalMaxAmount: Int
    private let maxIncrements: [Int]
    
    init(currentAmount: Int, originalMaxAmount: Int, maxIncrements: [Int]) {
        self.currentAmount = currentAmount
        self.originalMaxAmount = originalMaxAmount
        self.maxIncrements = maxIncrements
    }
    
    var current: Int { currentAmount }
    var maxAmount: Int {
        originalMaxAmount + maxIncrements.reduce(into: 0) { result, value in result = result + value }
    }
    
    // [GOOD]
    // 5.23.swiftで複数あったパラメータの数がひとつになった
    func recover(recoverAmount: Int) {
        currentAmount = min(currentAmount + recoverAmount, maxAmount)
    }
}

let magicPoint = MagicPoint(currentAmount: 100, originalMaxAmount: 100, maxIncrements: [100, 20, 30, 40])
print(magicPoint.current)
magicPoint.recover(recoverAmount: 1000000);
print(magicPoint.current)
