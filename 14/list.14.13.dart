// DartのDateTimeは'timezone'を持つため、'timezone'を無視するためのパッケージを利用します
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

class ShoppingCart {
  List<Product> products;

  ShoppingCart(this.products);

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
  int amount;

  DeliveryCharge._(this.amount);
  static DeliveryCharge create(ShoppingCart shoppingCart) {
    int totalPrice = 0;
    totalPrice += shoppingCart.products[0].price;
    totalPrice += shoppingCart.products[1].price;

    int charge;
    if (totalPrice < 2000) {
      charge = 500;
    } else {
      charge = 0;
    }
    return DeliveryCharge._(charge);
  }
}

void main() {}
