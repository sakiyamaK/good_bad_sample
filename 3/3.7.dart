//3.7~3.8

enum Currency { yen, dollar }

class Money {
  // [GOOD]
  // finalにすることでこのパラメータは変更されることがない
  final int amount;
  final Currency currency;

  // コンストラクタも特殊な書き方じゃないと代入できない
  Money(int amount, Currency currency)
      : this.amount = (amount < 0 ? 0 : amount),
        this.currency = currency {}

  // [GOOD]
  // functionを用意することでMoneyに関する記述はMoenyクラスに集約できる
  void add(int other) {
    // [GOOD]
    // パラメータをfinalにしたことで生成したインスタンスの状態を後から変更するような
    // バグが生まれやすい実装を防げる ****** <- これが大事 (*1)
    amount += other;
  }
}

void main() {
  //本来はサーバーから取得してtrue/falseのどっちか実行時に決まる値
  final specialServiceAdded = true;
  final seasonOffApplied = true;

  //1000円のmoney1を用意
  final money1 = Money(1000, Currency.yen);

  // -------------------
  // [GOOD] (*1)
  // このようなバグが生まれやすい記述ができなくなる
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
  // -------------------
}
