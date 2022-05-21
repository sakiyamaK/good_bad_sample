//3.9

enum Currency { yen, dollar }

class Money {
  final int amount;
  final Currency currency;

  Money(int amount, Currency currency)
      : this.amount = (amount < 0 ? 0 : amount),
        this.currency = currency {}

  Money add(int other) {
    // [GOOD]
    // 一度生成したインスタンスに変更を加えることなく要件を満たせる
    // [補足]
    // ただし新しいインスタンスが生成するコストは発生する
    // 例えばこのクラスが10GBのデータを持ってたりするとコピーされるので時間かかる

    // [BAD]
    // otherがfinalじゃないのでここまででどう変わるか分からない
    return Money(this.amount + other, this.currency);
  }
}

void main() {
  //本来はサーバーから取得してtrue/falseのどっちか実行時に決まる値
  final specialServiceAdded = true;
  final seasonOffApplied = true;

  //1000円のmoney1を用意
  final money1 = Money(1000, Currency.yen);

  // [GOOD]
// 明確に
//「元の金額が設定されているmoney1」と
// 「配送料がかかるか判断するためのdeterminedMoney1」を
// 分けざるを得なくなる <-- ** これが大事

// [GOOD]
// finalではないから後から変更される可能性があるんだなと分かる
  Money determinedMoney1 = money1;

  if (specialServiceAdded) {
    determinedMoney1 = determinedMoney1.add(-500);
  }

  if (seasonOffApplied) {
    determinedMoney1 = determinedMoney1.add(280);
  }

  // [GOOD]
  // money1と明確に違うことが分かる
  // money1をそのまま利用してはいけないんだなと分かる
  // 今後もどんな実装が加わってもmoney1は最初に設定された値であることが保証される
  if (determinedMoney1.amount < 600) {
    print("600円以下だと配送料がかかります");
  } else {
    print("大丈夫だから処理を続けます");
  }

  // -------------------
}
