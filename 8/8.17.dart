import 'dart:math';

// Dartにはprotocolという概念がないので、abstract classを使います
abstract class DiscountBase {
  int get price;
  int get discountCharge;
  int getDiscountedPrice() {
    // [BAD]
    // 準拠させるクラスの数だけ必要になる
    // これで全部なのか保証はどこにもない
    // 最後に謎のreturnがいるが仕様通りならそこに辿り着くことはない
    //   つまりテストできないし、変えていいのかよく分からない
    if (this is RegularDiscount) {
      return max(0, price - discountCharge);
    } else if (this is SummerDiscount) {
      return (price * 0.95).toInt();
    }
    // ここは来ないよ
    return price;
  }
}

class RegularDiscount extends DiscountBase {
  final int price;
  // [BAD]
  // このクラスだけ見てもdiscountChargeが何のためにあるのか分からない
  final int discountCharge = 300;

  RegularDiscount(this.price);
}

// 1品につき5%割引になった
class SummerDiscount extends DiscountBase {
  final int price;
  // [BAD]
  // 仕様変更で使わなくなった
  // でもDiscountBaseで必須だから用意するしかない
  // 仕方ないので「使わないよ」という意味で-1でも入れておく
  final int discountCharge = -1;

  SummerDiscount(this.price);
}

void main() {
  final regular = RegularDiscount(1000);
  final summer = SummerDiscount(1000);

  print(regular.getDiscountedPrice());  // 700
  print(summer.getDiscountedPrice());   // 950

}

/* [まとめ]
- 継承をすると色々と密結合に陥りやすい
- 「継承は悪」「interfaceは疎結合で正義」と言葉だけ覚えても使い方を間違えると同じことが起きる
*/
