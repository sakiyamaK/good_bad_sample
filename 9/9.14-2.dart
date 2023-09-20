class Product {
  final int id;
  Product({required this.id});
}

class APIError implements Exception {
  final String message;
  APIError(this.message);
}

class Log {
  static void sendLog(Object error) {
    // ログサーバーにエラーを送る
  }
}

extension ProductExtension on List<Product> {
  void addProduct(Product product) {
    try {
      this.add(product);
      // 商品追加してサーバーに送信するが商品情報の何かが変でエラーが出るとする
      throw APIError('invalid id 1234');
    } catch (e) {
      /* 
      [GOOD]
      エラーログをサーバーに送る
      さらに画面側で何か処理する必要がある時のために再度throwする
      この時に画面にアラート表示用のエラーに変えたりするのもあり
      */      
      Log.sendLog(e);
      rethrow;
    }
  }
}

void main() {
  try {
    var reservations = <Product>[];
    reservations.addProduct(Product(id: 1234));
  } catch (e) {
    //アラートを表示
    print('Alert: $e');
  }
}

/*
[補足]
エラー処理を細かくやろうとすると結構手間なので、手を抜きがち
サーバーがどんな種類のエラーを返すか把握しきれないので雑になったりもする
そのためエラーを無視したりするのもやむをえないこともある
エラーログを送りすぎても、いざ調査する時にほとんどが無関係のエラーで調べ切れない場合もあるし

ただ、完全に無視したら紹介したような問題が起あるので
現場の状況に合わせて負担にならない程度のエラー処理の落とし所は探ろう
*/

