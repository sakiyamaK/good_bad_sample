class ShoppingCart {
  List<Product> products;

  ShoppingCart(this.products);

  // *** リファクタリング ***
  // 合計金額をショッピングカード側で持つ
  int get totalPrice => products.fold(
      0, (previousValue, element) => previousValue + element.price);

  void add(List<Product> products) {
    this.products.addAll(products);
  }
}

class Product {
  final Id id;
  final String name;
  final int price;

  Product(this.id, this.name, this.price);
}

class Id {
  final int id;

  Id(this.id);
}

class DeliveryCharge {
  // *** リファクタリング ***
  // マジックナンバーを定数化
  static int _chargeFreeThreshold = 2000;
  static int _payCharge = 500;
  static int _payFree = 0;

  int amount;

  DeliveryCharge._(this.amount);
  static DeliveryCharge create(ShoppingCart shoppingCart) {
    // *** リファクタリング ***
    int amount;
    if (shoppingCart.totalPrice < _chargeFreeThreshold) {
      amount = _payCharge;
    } else {
      amount = _payFree;
    }
    return DeliveryCharge._(amount);
  }
}

void main() {}
