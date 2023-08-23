class SellingPrice {
  final int amount;

  SellingPrice(this.amount) {
    if (amount <= 0) {
      throw Exception("商品価格がマイナスです");
    }
  }

  static const double _SELLING_COMMISSION_RATE = 0.1;
  static const int _DELIVERY_FREE_MIN = 300;
  static const double _SHOPPING_POINT_RATE = 0.1;

  // 開発が進んで以下の機能が追加されてきた
    
  // 販売手数料を計算
  int get sellingCommission => (amount * _SELLING_COMMISSION_RATE).toInt();

  // 配送料を計算
  int get deliveryCharge => amount > _DELIVERY_FREE_MIN ? 0 : 500;
  
  // [BAD]
  // これは販売価格と明らかに別概念で蜜結合
  // 獲得ポイントを計算
  int get shoppingPoint => (amount * _SHOPPING_POINT_RATE).toInt();
}
