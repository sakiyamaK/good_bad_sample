// 5.7

class GiftPoint {
  static int _minPoint = 0;
  static int standardMembershipPoint = 100;
  static int premiumMembershipPoint = 300;
  final int value;

  // [GOOD]
  // コンストラクタがprivateなので変なpointを初期化パラメータにできない
  GiftPoint._(int point) : this.value = point < _minPoint ? _minPoint : point;

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

// [おまけ]
// Factoryクラス(インスタンスを生成するだけのクラス)でなく
// extensionで拡張してやると余計なクラスは増えず
// 生成ロジックだけでまとまって元の記述の見通しが悪くならない
// ただしDartのextensionの仕様がイマイチ...
// わざわざGiftPointExtという別の名前を用意しないといけない
// 同一ファイル内なら
// extension on GiftPoint {} でもいいけど...
extension GiftPointExt on GiftPoint {
  static GiftPoint forStandardMembership() {
    return GiftPoint._(GiftPoint.standardMembershipPoint);
  }

  static GiftPoint forPremiumMembership() {
    return GiftPoint._(GiftPoint.premiumMembershipPoint);
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
  final standardMembershipPoint = GiftPointExt.forStandardMembership();
  final premiumMembershipPoint = GiftPointExt.forPremiumMembership();

  // [GOOD]
  // こんなインスタンスの生成はできない
  // final standardMemberShipPoint = GiftPoint(564);
}
