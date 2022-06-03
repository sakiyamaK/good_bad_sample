//この数値はたくさんのコードのどこかで定義されている
final MAX_TOTAL_PRICE = 200;
final totalPrice = 100;

// [GOOD]
// パラメータの値が不変なので代入される値だけ気にしたら良い
void addPrice(final int productPrice) {
  // [GOOD]
  // 別の定数に代入しなければならないので
  // 入力されたパラメータとは違う値だなというのが一目瞭然となる <-- 重要
  final increasedTotalPrice = totalPrice + productPrice;
  if (MAX_TOTAL_PRICE < increasedTotalPrice) {
    throw Exception("購入金額の上限を超えています。");
  }
}

void main() {
  addPrice(100);
}
