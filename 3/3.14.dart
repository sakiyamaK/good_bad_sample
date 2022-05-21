//3.14~3.17

enum Currency { yen, dollar }

class Money {
  final int amount;
  final Currency currency;

  Money(int amount, Currency currency)
      : this.amount = (amount < 0 ? 0 : amount),
        this.currency = currency {}

  // [GOOD]
  // 同じMoney型しか受け取らないようにする
  Money add(final Money other) {
    // [GOOD]
    // バリデーションチェックでotherが処理していいかどうか最初に判断する
    if (this.currency != other.currency) {
      // [おまけ]
      // 不正なパターンをどう処理するかは仕様次第
      // ここでは例外を発生させている
      throw Exception("通貨単位が違います");
    }
    return Money(this.amount + other.amount, this.currency);
  }

  // 金額を下げるメソッドも用意
  Money minus(final Money other) {
    if (this.currency != other.currency) {
      throw Exception("通貨単位が違います");
    }
    return Money(this.amount - other.amount, this.currency);
  }
}

void main() {
  //本来はサーバーから取得してtrue/falseのどっちか実行時に決まる値
  final specialServiceAdded = true;
  final seasonOffApplied = true;

  //1000円のmoney1を用意
  final money1 = Money(1000, Currency.yen);
  Money determinedMoney1 = money1;

  // [GOOD]
// 役割ごとに名前を付けた定数となり、何のために使うか明確になる
  final specialServiceAddedMoney = Money(500, Currency.yen);
  final seasonOffAppliedMoney = Money(280, Currency.yen);

  if (specialServiceAdded) {
    determinedMoney1 = determinedMoney1.minus(specialServiceAddedMoney);
  }

  if (seasonOffApplied) {
    determinedMoney1 = determinedMoney1.add(seasonOffAppliedMoney);
  }

  if (determinedMoney1.amount < 600) {
    print("600円以下だと配送料がかかります");
  } else {
    print("大丈夫だから処理を続けます");
  }
}
