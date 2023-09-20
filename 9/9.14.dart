class Product {
  final int id;
  Product({required this.id});
}

class APIError implements Exception {
  final String message;
  APIError(this.message);
}

extension ProductExtension on List<Product> {
  void addProduct(Product product) {
    try {
      this.add(product);
      // 商品追加してサーバーに送信するが商品情報の何かが変でエラーが出るとする
      throw APIError('invalid id 1234');
    } catch (e) {
      /* 
      [BAD]
      開発時に、ちょっとprint文で確認しているだけ
      
      サーバーが返してくれたエラーに対して何もしてない
      そうすると何のエラーが出たのか分からなくなる
      */
      print(e);
    }
  }
}

void main() {
  /* 
  [BAD]
  View側の処理
  id 1234という商品を買い物かごに追加しようとしているが、
  ちょうど在庫切れになったなど何かしらの理由で出来ない場合もある
  だが、エラーが内部で握りつぶされているので、画面上何も起きない
  ログも記録していないため原因が分からない
  */
  try {
    var reservations = <Product>[];
    reservations.addProduct(Product(id: 1234));
  } catch (e) {
    //アラートを表示
  }
}
