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

// items内に牢屋の鍵があるか調べるコードを３パターンで記載
// [BAD]
// どれもfor文で判定ロジックを書いている
// for文があると「中で何をしているかロジックを追う必要がある」 <-- ここが重要
// ロジックにバグも入りやすい
// だいたい今時の言語なら配列操作関数でだいたいの要件は満たせる
func checkPrisonKey1(items: [Item]) -> Bool {
  var hasPrisonKey = false
  for item in items {
    if item.name == "牢屋の鍵" {
      hasPrisonKey = true
      break
    }
  }
  return hasPrisonKey
}

func checkPrisonKey2(items: [Item]) -> Bool {
  for item in items {
    if item.name == "牢屋の鍵" {
      return true
    }
  }
  return false
}

func checkPrisonKey3(items: [Item]) -> Bool {
  for item in items where item.name == "牢屋の鍵" {
    return true
  }
  return false
}

print("checkPrisonKey1: \(checkPrisonKey1(items: items))")
print("checkPrisonKey2: \(checkPrisonKey2(items: items))")
print("checkPrisonKey3: \(checkPrisonKey3(items: items))")
