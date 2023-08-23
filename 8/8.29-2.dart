// Dartにはprotocolの直接的な概念は存在しないが、abstract classを使って同じような動作を再現できる
abstract class PriceAmountProtocol {
  int get amount;
}

class SellingPrice implements PriceAmountProtocol {
  final int amount;

  SellingPrice(this.amount) {
    if (amount <= 0) {
      throw Exception("商品価格がマイナスです");
    }
  }
}

// priceから計算される値を全部extension(おまけの追加機能)として追加
// ただしDartだとextensionで名前が変わるから使い勝手が悪い
// これでいいものか
extension SellingPriceExtension on SellingPrice {

  // 定数をstaticとして用意
  static const _SELLING_COMMISSION_RATE = 0.1;
  static const _DELIVERY_FREE_MIN = 300;

  // 販売手数料を計算
  int get sellingCommission => (amount * _SELLING_COMMISSION_RATE).toInt();

  // 配送料を計算
  int get deliveryCharge => _DELIVERY_FREE_MIN < amount ? 0 : 500;
}

// 獲得ポイントに関する処理は別概念なのでclass自体分けた
class ShoppingPoint {
  static const _SHOPPING_POINT_RATE = 0.1;

  // PriceAmount直接ではなくPriceAmountProtocolに依存させて疎結合を保つ
  // つまりPriceAmountの中身のうち、amount以外がどう変わろうと関係ないことを保証する
  // だけど今回はPriceAmountはamountしかないから冗長かも...
  // ついでに配列にして応用を効かせた
  final List<PriceAmountProtocol> prices;

  ShoppingPoint(this.prices);

  // 獲得ポイントを計算
  int get shoppingCharge => (
      prices.fold(0.0, (partialResult, priceAmount) => 
      partialResult + priceAmount.amount.toDouble()) * _SHOPPING_POINT_RATE
    ).toInt();
}

void main() {
  final sellingPrice1 = SellingPrice(500);
  final sellingPrice2 = SellingPrice(1500);

  print("Selling Commission for price1: ${sellingPrice1.sellingCommission}");
  print("Delivery Charge for price1: ${sellingPrice1.deliveryCharge}");
  
  print("Selling Commission for price2: ${sellingPrice2.sellingCommission}");
  print("Delivery Charge for price2: ${sellingPrice2.deliveryCharge}");

  final shoppingPoint = ShoppingPoint([sellingPrice1, sellingPrice2]);
  print("Total Shopping Point: ${shoppingPoint.shoppingCharge}");
}
