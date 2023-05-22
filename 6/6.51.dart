class Money {
  final int value;
  Money({required this.value});

  Money add({required Money fee}) {
    return Money(value: this.value + fee.value);
  }
}

// ストラテジーパターンのために用意したprotocol
abstract class HotelRates {
  Money get fee;
}

// 通常宿泊料金
class RegularRates implements HotelRates {
  @override
  Money get fee {
    return Money(value: 7000);
  }
}

// プレミアム宿泊料金
class PremiumRates implements HotelRates {
  @override
  Money get fee {
    return Money(value: 12000);
  }
}

void main() {
  HotelRates hotelRates;
  // RegularRatesかPremiumRatesのどちらかだとする
  hotelRates = RegularRates();
  // hotelRates = PremiumRates();

  // 繁盛期の金額判定をする
  Money busySeasonFee;

  // [BAD] ストラテジーパターンなのに結局ifの分岐がいる
  // 今回はRegularRatesとPremiumRatesしかないがこれが仕様追加で100個増えたら100個のelse if
  // 追加だけじゃなく減ったりしても本当に消していいのか常に不安がつきまとうため残りっぱなしになる
  // そういうことを繰り返す結果
  // 使わないelse ifが40個残ったままだったり、名前だけ違って同じ意味のclassが10個できたり
  // 2度とメンテできない状態になる
  if (hotelRates is RegularRates) {
    busySeasonFee = hotelRates.fee.add(fee: Money(value: 3000));
  } else if (hotelRates is PremiumRates) {
    busySeasonFee = hotelRates.fee.add(fee: Money(value: 5000));
  } else {
    // dartの言語仕様上、busySeasonFeeが決まらないパターンがあることを許さない
    // そのためどれでもないelseの場合の記述も必要
    throw Exception('Unknown type of HotelRates');
  }

  print("繁盛期の金額は${busySeasonFee.value}円です");
}
