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

// items内に牢屋の鍵があるか調べるコード
// [GOOD]
// 配列操作関数であるcontainsを使うことで <-- これ以下が重要
// 何かが含まれているかどうか判断していることが「中を見なくても」分かる
// 標準機能なのでロジック(単純なbool判定)にバグも入らない
bool checkPrisonKey(List<Item> items) {
  return items.any((item) => item.name == "牢屋の鍵");
}

void main() {
  final items = <Item>[Yakuso(), PrisonKey(), Yakuso()];

  print("checkPrisonKey: ${checkPrisonKey(items)}");
  // ぶっちゃけこれぐらいなら関数にする必要もないかも
  print("checkPrisonKey: ${items.any((item) => item.name == "牢屋の鍵")}");
}
