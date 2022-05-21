//3.2〜3.3

//後ほど説明 (*1)
enum Currency { yen, dollar }

//[BAD]
//そもそもビルドができないようにされている
//パラメータを初期化しないといけない
class Money {
  //[GOOD]
  //インスタンス生成時に値が決まることを約束するlateがある
  late int amount;
  late Currency currency;
  // [GOOD]
  //コンストラクタを用意することでパラメータに必ず何か値を決めることが保証される
  Money(int amount, Currency currency) {
    this.amount = amount;
    this.currency = currency;
  }

  // [おまけ]
  // Dartには他にもいくつかコンストラクタの書き方がある
  // 同じ名前のコンストラクタは定義できないから今はコメントアウトしてる
  // Money(int inputAmount, Currency inputCurrency)
  //     : this.amount = inputAmount,
  //       this.currency = inputCurrency {}
}

void main() {
  // Money(int amount, Currency currency)コンストラクタを実行してインスタンスを作る
  // [BAD]
  // amountに現実ではありえないマイナスの値が入ることを許してしまう
  // [GOOD] (*1)
  // currencyはenumなので不正な値が入ることがない
  final money = Money(-100, Currency.yen);
}
