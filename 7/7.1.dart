abstract class Item {
  String get name;
}

class PrisonKey implements Item {
  @override
  String get name => "牢屋の鍵";
}

class Yakuso implements Item {
  @override
  String get name => "薬草";
}

// items内に牢屋の鍵があるか調べるコードを３パターンで記載
// [BAD]
// どれもfor文で判定ロジックを書いている
// for文があると「中で何をしているかロジックを追う必要がある」 <-- ここが重要
// ロジックにバグも入りやすい
// だいたい今時の言語なら配列操作関数でだいたいの要件は満たせる
bool checkPrisonKey1(List<Item> items) {
  bool hasPrisonKey = false;
  for (var item in items) {
    if (item.name == "牢屋の鍵") {
      hasPrisonKey = true;
      break;
    }
  }
  return hasPrisonKey;
}

bool checkPrisonKey2(List<Item> items) {
  for (var item in items) {
    if (item.name == "牢屋の鍵") {
      return true;
    }
  }
  return false;
}

bool checkPrisonKey3(List<Item> items) {
  for (var item in items) {
    if (item.name == "牢屋の鍵") {
      return true;
    }
  }
  return false;
}

void main() {
  final items = <Item>[Yakuso(), PrisonKey(), Yakuso()];

  print("checkPrisonKey1: ${checkPrisonKey1(items)}");
  print("checkPrisonKey2: ${checkPrisonKey2(items)}");
  print("checkPrisonKey3: ${checkPrisonKey3(items)}");
}
