import 'dart:math';

/*
 「単一責任」の「単一」とは何なのか？
 「ひとつのアプリ」と捉えたら全部ひとつのクラスに入ることになるし、
 「足し算」と捉えたら全部の足し算でクラスを分けることになるし、、、
 明確な定義などない気がする。。。
 仮に定義があってもそれに当てはまらないパターンは絶対ありそう
 そもそも「単一責任」が絶対の正解でもない
 言い換えると「あらゆる仕様」で明確に「単一責任」が決まりそれが必ず「正解」であるなら、
 それ以外はビルドエラーになるようにプログラミング言語は作らているはずである
 結局は開発チーム内や自分の中でここまでの概念を「単一」とすると決めるしかなさそう
*/

// 割引きする種類をenumで管理
enum ServiceDiscountType {
  normal,
  summer,
}

// 割引きに関する処理がここに集約される
//「割引き」を「単一」と捉えた
//「割引き」に関すること以外は書かない
extension ServiceDiscountTypeExtension on ServiceDiscountType {
  int get discountPrice {
    switch (this) {
      case ServiceDiscountType.normal:
        return 300;
      case ServiceDiscountType.summer:
        return 400;
    }
  }

  static int get maxDiscount => 20000;
}

// ひとつの製品に関する情報
//「ひとつの製品」を「単一」と捉えた
//「ひとつの製品」に関すること以外は書かない
class Product {
  final int id;
  final String name;
  final int price;
  // この製品の割引きの種類
  // DiscountTypeに依存することを良しと捉えるかどうか議論ポイント
  final List<ServiceDiscountType> discountTypes;

  Product(this.id, this.name, this.price, this.discountTypes);

  // 金額計算をしていいか
  bool get enablePrice => id > 0 && name.isNotEmpty && price > 0;

  // 割引き金額
  int get discountedPrice {
    // priceを初期値としてDiscountTypeから所定の金額を引いていく
    final totalPrice = discountTypes.fold(price, (partialResult, type) => 
                                          partialResult + type.discountPrice);
    // maxは大きい方を返す
    // priceがマイナスなら 0 を返す
    // priceがプラスなら price を返す
    // つまりマイナスになることがなくなる
    return max(0, totalPrice);
  }
}

// 複数の製品に関する情報
//「複数の製品」を「単一」と捉えた
//「複数の製品」に関すること以外は書かない
extension ProductListExtension on List<Product> {
  // 割引きを考慮した総額
  int get totalDiscountedPrice => this
        .where((product) => product.enablePrice)
        .fold(0, (partialResult, product) => 
          // DiscountTypeに依存しているところが議論ポイント
          partialResult < ServiceDiscountTypeExtension.maxDiscount 
          ? partialResult + product.discountedPrice 
          : partialResult + product.price);
  // 割引きを考慮しない総額
  int get totalPrice => this
        .where((product) => product.enablePrice)
        .fold(0, (partialResult, product) => partialResult + product.price);
}

void main() {
  List<Product> products = [
    Product(1, 'a', 100, []),
    Product(2, 'b', 1200, [ServiceDiscountType.normal]),
    Product(3, 'c', 300, [ServiceDiscountType.summer]),
    Product(4, 'd', 1300, [ServiceDiscountType.summer]),
    Product(5, 'e', 400, [ServiceDiscountType.normal, ServiceDiscountType.summer]),
  ];

  print('それぞれの金額');
  for (var product in products) {
    print('id = ${product.id}, name = ${product.name}, price = ${product.price}, discountedPrice = ${product.discountedPrice}');
  }

  print('合計金額');
  print('totalPrice = ${products.totalPrice}');
  print('totalDiscountedPrice = ${products.totalDiscountedPrice}');
}
