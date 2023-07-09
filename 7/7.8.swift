struct Member {
    var id: Int
    var isAlive: Bool
}

// フィールドに関する処理のあるクラス
class FieldManager {
    private static let maxMemberNumber: Int = 4
    private(set) var members: [Member] = []
    
    init(members: [Member]) {
        self.members = members
    }
    // [BAD]
    // フィールドでパーティーを追加するメソッドなわけだが
    // イベントでパーティーを追加したり、戦闘中にパーティーが抜けたり
    // などなど別のManagerで同じロジックが入る可能性が高い
    // まぁそもそもFieldでやることなんて他にもたくさんあるだろうから
    // メンバーに関するロジックを記載したらFatなクラスになるに決まってる
    func add(newMember: Member) {
        if members.contains(where: { $0.id == newMember.id }) {
            fatalError("すでに存在している")
        }
        if members.count >= FieldManager.maxMemberNumber {
            fatalError("最大人数を超えています")
        }
        members.append(newMember)
    }
    
    // [BAD]
    // 上のメソッドと同じ理由
    func partyIsAlive(in members: [Member]) -> Bool {
        members.contains(where: { $0.isAlive })
    }
}

// 戦闘に関する処理のあるクラス
class BattleManager {
    private static let maxMemberNumber: Int = 4
    private(set) var members: [Member] = []
    
    init(members: [Member]) {
        self.members = members
    }
    
    // [BAD]
    // FieldManagerと同様のロジック
    func add(newMember: Member) {
        if members.contains(where: { $0.id == newMember.id }) {
            fatalError("すでに存在している")
        }
        if members.count >= BattleManager.maxMemberNumber {
            fatalError("最大人数を超えています")
        }
        members.append(newMember)
    }
}


let members = (1...3).compactMap {
    Member(id: $0, isAlive: true)
}

let field = FieldManager(members: members)
    
field.add(newMember: Member(id: 10, isAlive: true))


print(field.members)
