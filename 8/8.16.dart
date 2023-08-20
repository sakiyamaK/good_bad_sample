import 'dart:math';

abstract class DiscountBase {
  int get price;
  int get discountCharge;
  int getDiscountedPrice() => max(0, price - discountCharge);
}

// 通常の割引き
class RegularDiscount extends DiscountBase {
  @override
  final int price;
  @override
  final int discountCharge = 300;

  RegularDiscount(this.price);
}

// 1品につき5%割引になった
class SummerDiscount extends DiscountBase {
  @override
  final int price;
  // [BAD]
  // 仕様変更で使わなくなった
  // でもDiscountBaseで必須だから用意するしかない
  // 仕方ないので「使わないよ」という意味で-1でも入れておく
  @override
  final int discountCharge = -1;

  SummerDiscount(this.price);
  // 仕様変更のために追加された計算
  @override
  int getDiscountedPrice() => (price * 0.95).toInt();
}

void main() {
  final regular = RegularDiscount(1000);
  final summer = SummerDiscount(1000);

  print(regular.getDiscountedPrice());  // 700
  print(summer.getDiscountedPrice());   // 950
}
