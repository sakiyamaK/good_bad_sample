// 5.7

class GiftPoint {
  static int _minPoint = 0;
  static int _standardMembershipPoint = 100;
  static int _premiumMembershipPoint = 300;
  final int value;

  // [GOOD]
  // コンストラクタがprivateなので変なpointを初期化パラメータにできない
  GiftPoint._(int point) : this.value = point < _minPoint ? _minPoint : point;

  // ---------------
  // [GOOD]
  // インスタンスを生成するためのfactory method
  // Dartだと専用の文法のfactory constructorとnamed constructorを組み合わせられる
  // どんな目的のインスタンスを生成するか名前ですぐ分かる
  // このふたつ以外にインスタンスを生成するパターンがないことも明確
  factory GiftPoint.forStandardMembership() {
    return GiftPoint._(_standardMembershipPoint);
  }
  // [おまけ]
  // こう書くのと同じ？
  // static forStandardMembership() {
  //   return GiftPoint._(_standardMembershipPoint);
  // }

  factory GiftPoint.forPremiumMembership() {
    return GiftPoint._(_premiumMembershipPoint);
  }
  // --------------------------

  // [GOOD]
  // GiftPointに関するロジックはこのクラスにまとまっている
  GiftPoint add(final GiftPoint other) {
    return GiftPoint._(this.value + other.value);
  }

  bool isEnough(final ConsumptionPoint point) {
    return point.value <= this.value;
  }

  GiftPoint consume(final ConsumptionPoint point) {
    if (!this.isEnough(point)) {
      throw Exception("ポイントが不足しています");
    }
    return GiftPoint._(this.value - point.value);
  }
}

class ConsumptionPoint {
  static int _minPoint = 0;
  final int value;
  ConsumptionPoint(int point)
      : this.value = point < _minPoint ? _minPoint : point;
}

void main() {
  // [GOOD]
  // なんの用途でインスタンスが生成されたのか明確
  final standardMembershipPoint = GiftPoint.forStandardMembership();
  final premiumMembershipPoint = GiftPoint.forPremiumMembership();

  // [GOOD]
  // こんなインスタンスの生成はできない
  // final standardMemberShipPoint = GiftPoint(564);
}
