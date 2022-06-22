// 5.4

import 'dart:math';

class GiftPoint {
  static int _minPoint = 0;
  final int value;

  GiftPoint(int point) : this.value = point < _minPoint ? _minPoint : point;

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
