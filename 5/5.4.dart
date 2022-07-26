// 5.4~5.6

class GiftPoint {
  static int _minPoint = 0;
  final int value;

  // [BAD]
  // コンストラクタを公開するとどんな用途で使われるか分からない
  // 100が入る時はどんな時？
  // 0の時は？20の時は？もっとパターンはあるの？？？
  GiftPoint(int point) : this.value = point < _minPoint ? _minPoint : point;

  // [GOOD]
  // GiftPointに関するロジックはこのクラスにまとまっている
  GiftPoint add(final GiftPoint other) {
    return GiftPoint(this.value + other.value);
  }

  bool isEnough(final ConsumptionPoint point) {
    return point.value <= this.value;
  }

  GiftPoint consume(final ConsumptionPoint point) {
    if (!this.isEnough(point)) {
      throw Exception("ポイントが不足しています");
    }
    return GiftPoint(this.value - point.value);
  }
}

class ConsumptionPoint {
  static int _minPoint = 0;
  final int value;
  ConsumptionPoint(int point)
      : this.value = point < _minPoint ? _minPoint : point;
}

void main() {
  // [BAD]
  // 何かのロジックがあって標準ユーザかどうか決まる
  // つまりここにロジックがあって低凝集にならざるをえない
  final standardMemberShipPoint = GiftPoint(100);

  // [BAD]
  // 何かのロジックがあってプレミアムユーザかどうか決まる
  // つまりここにロジックがあって低凝集にならざるをえない
  final premiumMemberShipPoint = GiftPoint(300);
}
