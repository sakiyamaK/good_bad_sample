//この数値はたくさんのコードのどこかで定義されている
final MAX_TOTAL_PRICE = 200;
final totalPrice = 100;

void addPrice(int productPrice) {
  // [BAD]
  // パラメータの値が不用意に変わってしまう
  // そのあとの条件分岐がどうなるか判断つかないのでバグの温床となる <-- 重要
  productPrice = totalPrice + productPrice;
  if (MAX_TOTAL_PRICE < productPrice) {
    throw Exception("購入金額の上限を超えています。");
  }
}

void main() {
  addPrice(100);
}
