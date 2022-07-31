// 5.26~5.27

class RegularPrice {
  late final int amount;
  RegularPrice(int amount) {
    // [GOOD]
    // 通常価格のバリーでションがここに凝集されることになる
    if (amount < 0) {
      throw Exception("マイナスだよ");
    }
    this.amount = amount;
  }
}

class DiscountRate {
  late final double amount;
  DiscountRate(double amount) {
    // [GOOD]
    // 割引率のバリーでションがここに凝集されることになる
    if (amount < 0) {
      throw Exception("マイナスだよ");
    }
    if (amount > 1) {
      throw Exception("1より大きいよ");
    }
    this.amount = amount;
  }
}

class DiscountedPrice {
  late final int amount;
  // [GOOD]
  // バリデーションされた値をもつインスタンスしか受け取れないので必ず正しい値となる
  //
  // パラメータも何を目的としたインスタンスと何を目的としたインスタンスを与えるのか明確
  DiscountedPrice(RegularPrice regularPrice, DiscountRate discountRate) {
    this.amount = (regularPrice.amount * discountRate.amount).toInt();
  }
}

void main() {
  try {
    final regularPrice1 = RegularPrice(100);
    // もし不正な値でインスタンスを生成しようとすると例外となる
    // final regularPrice2 = RegularPrice(-100);

    final discountRate1 = DiscountRate(0.5);
    final discountedPrice1 = DiscountedPrice(regularPrice1, discountRate1);

    print(regularPrice1.amount);
    print(discountRate1.amount);
    print(discountedPrice1.amount);
  } catch (e) {
    print(e.toString());
  }
}
