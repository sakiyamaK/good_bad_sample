//3.10~3.13

enum Currency { yen, dollar }

class Money {
  final int amount;
  final Currency currency;

  Money(int amount, Currency currency)
      : this.amount = (amount < 0 ? 0 : amount),
        this.currency = currency {}

  // [GOOD]
  // otherも不変であることが明記されるので
  // addメソッド内でotherを変えてしまうバグをしこめなくなる <-- ** これが大事
  Money add(final int other) {
    // other = 200 //finalだからこれができない
    return Money(this.amount + other, this.currency);
  }
}

void main() {
  //本来はサーバーから取得してtrue/falseのどっちか実行時に決まる値
  final specialServiceAdded = true;
  final seasonOffApplied = true;

  //1000円のmoney1を用意
  final money1 = Money(1000, Currency.yen);

  Money determinedMoney1 = money1;

  if (specialServiceAdded) {
    determinedMoney1 = determinedMoney1.add(-500);
  }

  if (seasonOffApplied) {
    determinedMoney1 = determinedMoney1.add(280);
  }

  if (determinedMoney1.amount < 600) {
    print("600円以下だと配送料がかかります");
  } else {
    print("大丈夫だから処理を続けます");
  }
}
