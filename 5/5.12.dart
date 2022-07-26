import 'dart:math';

// [GOOD]
// 税込み価格を計算する処理
// 退会済みかどうか判断する処理
// 商品を注文する処理
// がそれぞれのクラスの処理でまとまってオブジェクト指向に沿っている

class AmountIncludingTax {
  final double value;
  final double ratio;
  double get multipliedValue => value * ratio;

  AmountIncludingTax(double value, double ratio)
      : this.value = max(value, 0),
        this.ratio = max(value, 0);
}

class User {
  bool get hasResigned {
    //実際は退会済みかどうか判断するロジックがある
    return true;
  }
}

class Product {
  void createOrder() {
    //実際は商品を注文する処理がある
  }
}

void main() {}