class Product {
  final int id;
  final String name;
  final int price;

  Product(this.id, this.name, this.price);
}

// [BAD]
// ProductがDiscountできるかどうか管理する構造体が別にあることがよくない
class ProductDiscount {
  final int id;
  final bool canDiscount;

  ProductDiscount(this.id, this.canDiscount);
}

// [BAD]
// 7.8.swiftと同じくそもそもDiscountManagerという[Poduct]を管理するクラスが別にあることがよくない
class DiscountManager {
  List<Product> discountProducts = [];
  int totalPrice = 0;

  bool add(Product product, ProductDiscount productDiscount) {
    // productが正しいかチェック
    if (product.id <= 0) {
      throw Exception("商品が存在しません");
    }

    if (product.name.isEmpty) {
      throw Exception("商品名が空です");
    }

    if (product.price <= 0) {
      throw Exception("価格が0以下です");
    }

    if (product.id != productDiscount.id) {
      throw Exception("商品IDが一致しません");
    }

    // 割引価格の計算
    // [BAD]
    // この下でproductDiscount.canDiscountがfalseなら結局使わない
    var discountPrice = DiscountManager.getDiscountPrice(price: product.price);

    // [BAD]
    // tmpが何なのかよく分からない
    // 変数で定義されており、値が最終的に決定されるのがいつか分からない
    var tmp = 0;
    if (productDiscount.canDiscount) {
      tmp = totalPrice + discountPrice;
    } else {
      tmp = totalPrice + product.price;
    }
    // 総額上限の判定
    if (tmp <= 20000) {
      totalPrice = tmp;
      discountProducts.add(product);
      return true;
    } else {
      return false;
    }
  }

  static int getDiscountPrice({required int price}) {
    var discountPrice = price - 300;
    if (discountPrice < 0) {
      discountPrice = 0;
    }
    return discountPrice;
  }
}

void main() {
  
}
