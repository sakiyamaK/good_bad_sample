/* 
書籍ではファーストクラスコレクションという
コレクションに関する処理をカプセル化したクラスを用意するとあるが
Swiftではそもそもコレクション(配列)に機能を拡張させることができるので
新しいクラスは不要
*/

struct Member {
    var id: Int
    var isAlive: Bool
}

// [GOOD]
// Memberの配列を操作する処理はここに集約される
// 書籍に書いていることをあれこれ考える必要はない
extension [Member] {
    mutating func add(newMember: Member, maxMemberNumber: Int = 4) {
        if self.contains(where: { $0.id == newMember.id }) {
            fatalError("すでに存在している")
        }
        if self.count >= maxMemberNumber {
            fatalError("最大人数を超えています")
        }
        self.append(newMember)
    }
    
    var partyIsAlive: Bool {
        members.contains(where: { $0.isAlive })
    }
}

var members = (1...3).compactMap {
    Member(id: $0, isAlive: true)
}

members.add(newMember: Member(id: 10, isAlive: true))

print(members)
