protocol Item {
  var name: String { get }
}

struct PrisonKey: Item {
  var name: String = "牢屋の鍵"
}

struct Yakuso: Item {
  var name: String = "薬草"
}

let items: [Item] = [Yakuso(), PrisonKey(), Yakuso()]

// items内に牢屋の鍵があるか調べるコード
// [GOOD]
// 配列操作関数であるcontainsを使うことで <-- これ以下が重要
// 何かが含まれているかどうか判断していることが「中を見なくても」分かる
// 標準機能なのでロジック(単純なbool判定)にバグも入らない
func checkPrisonKey(items: [Item]) -> Bool {
  items.contains(where: { $0.name == "牢屋の鍵" })
}

print("checkPrisonKey: \(checkPrisonKey(items: items))")
// ぶっちゃけこれぐらいなら関数にする必要もないかも
print("checkPrisonKey: \(items.contains(where: { $0.name == "牢屋の鍵" }))")
