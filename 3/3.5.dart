//3.5~3.6

enum Currency { yen, dollar }

class Money {
  late int amount;
  late Currency currency;
  Money(int amount, Currency currency) {
    if (amount < 0) {
      this.amount = 0;
      this.currency = currency;
      return;
    }
    this.amount = amount;
    this.currency = currency;
  }

  // [GOOD]
  // functionを用意することでMoneyに関する記述はMoenyクラスに集約できる
  void add(int other) {
    // [BAD]
    // 実装時に「このインスタンスは現在どんな値なんだろう？」と意識ないといけないため
    // 生成したインスタンスの状態を後から変更できるとバグが生まれやすい
    amount += other;
  }
}

void main() {
  //本来はサーバーから取得してtrue/falseのどっちか実行時に決まる値
  final specialServiceAdded = true;
  final seasonOffApplied = true;

  //1000円のmoney1を用意
  final money1 = Money(1000, Currency.yen);

  if (specialServiceAdded) {
    money1.add(-500);
  }

  if (seasonOffApplied) {
    money1.add(280);
  }

  // [BAD]
  // money1は1000円なのにどっちが実行されるか分からなくなる
  if (money1.amount < 600) {
    print("600円以下だと配送料がかかります");
  } else {
    print("大丈夫だから処理を続けます");
  }
}
