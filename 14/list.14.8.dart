// テスト対象のクラス
// 配送管理クラス
// [BAD]
// 書籍のP298 14.2.1　コードの課題を整理するの通り色々と問題がある

class DeliveryManager {
  static int deliveryCharge(List<Product> products) {
    int charge = 0;
    int totalPrice = 0;
    for (var product in products) {
      totalPrice += product.price;
    }
    if (totalPrice < 2000) {
      charge = 500;
    } else {
      charge = 0;
    }
    return charge;
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
