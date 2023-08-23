class SellingPrice {
  final int amount;

  SellingPrice(this.amount) {
    if (amount <= 0) {
      throw Exception("商品価格がマイナスです");
    }
  }
}

class SellingCommission {
  static const double _SELLING_COMMISSION_RATE = 0.1;

  // 販売手数料を計算
  int sellingCommission(SellingPrice price) =>
     (price.amount * _SELLING_COMMISSION_RATE).toInt();
}

class DeliveryCharge {
  static const int _DELIVERY_FREE_MIN = 300;

  // 配送料を計算
  int deliveryCharge(SellingPrice price) =>
    price.amount > _DELIVERY_FREE_MIN ? 0 : 500;
}

// [GOOD？]
// 獲得ポイントという無関係の処理が別classに分かれて、「販売価格」と「獲得ポイント」が疎結合になった？
// [BAD]
// ShoppingPointはSellingPriceがないとビルドできないし疎結合といっていいのかどうか...
// またこれだと5章の低凝集な状態で良いとは言えない
class ShoppingPoint {
  static const double _SHOPPING_POINT_RATE = 0.1;

  // 獲得ポイントを計算
  int shoppingPoint(SellingPrice price) =>
    (price.amount * _SHOPPING_POINT_RATE).toInt();
}

void main() {
  SellingPrice price = SellingPrice(400);
  SellingCommission commission = SellingCommission();
  DeliveryCharge delivery = DeliveryCharge();
  ShoppingPoint point = ShoppingPoint();

  print("Selling Commission: ${commission.sellingCommission(price)}");
  print("Delivery Charge: ${delivery.deliveryCharge(price)}");
  print("Shopping Point: ${point.shoppingPoint(price)}");
}

/*
  [MEMO]
  結局、低凝集と高凝集は相反する概念でバランスが大事  
*/
