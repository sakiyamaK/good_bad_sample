import 'dart:math';

// Dartでのabstract classを使った宣言
abstract class DiscountBase {
  int get price;
  // 準拠先で違いのある割引金額をパラメータとして用意した
  int get discountCharge;
  // 割引き計算を共通化した
  int getDiscountedPrice() => max(0, price - discountCharge);
}

// 通常の割引き
class RegularDiscount extends DiscountBase {
  @override
  final int price;
  // [BAD]
  // このクラスだけ見てもdiscountChargeが何のためにあるのか分からない
  @override
  final int discountCharge = 300;

  RegularDiscount(this.price);
}

// 夏の割引き
class SummerDiscount extends DiscountBase {
  @override
  final int price;
  // [BAD]
  // このクラスだけ見てもdiscountChargeが何のためにあるのか分からない
  @override
  final int discountCharge = 400;

  SummerDiscount(this.price);
}

void main() {
  final regular = RegularDiscount(1000);
  final summer = SummerDiscount(1000);

  print(regular.getDiscountedPrice());  // 700
  print(summer.getDiscountedPrice());   // 600
}
