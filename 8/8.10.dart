import 'dart:math';

// Dartでは抽象クラスを用意できる
abstract class DiscountBase {
  int get price;
  int getDiscountedPrice();
}

// 通常の割引き
class RegularDiscount implements DiscountBase {
  @override
  final int price;

  RegularDiscount(this.price);

  @override
  int getDiscountedPrice() => max(0, price - 300);
}

// 夏の割引き
class SummerDiscount implements DiscountBase {
  @override
  final int price;

  SummerDiscount(this.price);

  @override
  int getDiscountedPrice() => max(0, price - 400);
}

void main() {
  final regular = RegularDiscount(1000);
  final summer = SummerDiscount(1000);

  print(regular.getDiscountedPrice());  // 700
  print(summer.getDiscountedPrice());   // 600
}


