//後ほど説明 (*1)
enum Currency { yen, dollar }

class Money {
  //[GOOD]
  //インスタンス生成時に値が決まることを約束するlateがある
  late int amount;
  late Currency currency;
  // [GOOD]
  //コンストラクタを用意することでパラメータに必ず何か値を決めることが保証される
  Money(int amount, Currency currency) {
    // [GOOD]
    // amount不正な値が入ること許さない
    // このように「最初に不正な状態を弾いてインスタンスを正常に保つ」記述方法をguard節と言ったりする
    if (amount < 0) {
      // [おまけ]
      //不正な値がきたときの対応方法は要件ごとに異なる

      //(1) 初期値を入れてしまう
      this.amount = 0;
      this.currency = currency;
      return;

      /*
      //(2) 例外を送る
      throw Exception("不正な値が代入されました");
       */

      /*
       //(3) エラーを出してクラッシュする
      throw Error("不正な値が代入されました");
       */

    }
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
  // [GOOD] (*1)
  // currencyはenumなので不正な値が入ることがない
  final money = Money(-100, Currency.yen);
  print(money.amount);
}
