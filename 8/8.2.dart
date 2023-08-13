class Product {
  final int id;
  final String name;
  final int price;
  // 新規追加
  // [BAD]
  // 既存に「通常割引」の仕様があって追加の「夏季限定割引」できるかどうか判定するパラメータなのに
  // 名前がこれではどっちのためのパラメータか分からない
  final bool canDiscount;

  Product(this.id, this.name, this.price, this.canDiscount);
}

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
    var discountPrice = DiscountManager.getDiscountPrice(product.price);

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

  static int getDiscountPrice(int price) {
    var discountPrice = price - 300;
    if (discountPrice < 0) {
      discountPrice = 0;
    }
    return discountPrice;
  }
}

// 仕様追加された夏季限定割引
// [BAD]
// 書籍に書いてる通り様々なバグを生む
// 「様々な」バグを生むのはこのクラスが「様々な」機能をまとめているせい
// 単一責任の原則に則ってない
class SummerDiscountManager {
  // DiscountManagerの処理を流用するために用意
  // [BAD]
  // DiscountManagerがここで使われているとは思わない
  // DiscountManagerの仕様変更がここにも影響する
  final DiscountManager discountManager = DiscountManager();

  bool add(Product product) {
    // productが正しいかチェック
    // [BAD]
    // 同じチェックがDiscountManagerにもある
    if (product.id <= 0) {
      throw Exception("商品が存在しません");
    }

    if (product.name.isEmpty) {
      throw Exception("商品名が空です");
    }

    var tmp = 0;
    if (product.canDiscount) {
      tmp = discountManager.totalPrice + DiscountManager.getDiscountPrice(product.price);
    } else {
      tmp = discountManager.totalPrice + product.price;
    }
    // 総額上限の判定
    if (tmp <= 30000) {
      discountManager.totalPrice = tmp;
      discountManager.discountProducts.add(product);
      return true;
    } else {
      return false;
    }
  }
}
