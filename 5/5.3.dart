//5.3

// [BAD]
// プログラムが扱うのは全部何かしらのデータなんだからDataという名前は意味がない
class MoneyData {
  // [GOOD]
  // 定数のパラメータなのでバグりにくい
  final amount;
  // [GOOD]
  // 0以下にならないようにバリデーションチェックをしている
  MoneyData({int amount = 0}) : this.amount = amount < 0 ? 0 : amount;

  // [GOOD]
  // MoneyDataに関する処理は自身に集約されている
  // MoneyDataに修正があった場合、自身のクラス内だけ意識すればいい
  MoneyData add(final MoneyData other) {
    //データを利用しているのでstaticにできない
    return MoneyData(amount: this.amount + other.amount);
  }
}

class PaymentManager {
  double _discountRate = 0.2;

  // [BAD]
  // 外部から受け取った数値(moneyAmount1)と外部から受け取った数値(moneyAmount2)だけで完結しているメソッドで
  // インスタンスのパラメータを一切使っていないからstaticと変わらない
  // moneyAmount1, moneyAmount2を与えてくれたクラス側のかけ離れているので底凝集
  int add(final int moneyAmount1, final int moneyAmount2) {
    return moneyAmount1 + moneyAmount2;
  }
}

void main() {
  //
  final paymentManager = PaymentManager();
  final moneyData1 = MoneyData(amount: 100);
  final moneyData2 = MoneyData(amount: 200);

  final addedMoney = paymentManager.add(moneyData1.amount, moneyData2.amount);
  final addedMoneyData = MoneyData(amount: addedMoney);
}
