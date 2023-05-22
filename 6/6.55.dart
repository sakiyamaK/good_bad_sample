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
  // [GOOD]
  // そもそも「繁忙期料金」という概念があるならprotocolのパラメータにしておこう
  Money get busySeasonFee; //繁忙期料金
}

// 通常宿泊料金
class RegularRates implements HotelRates {
  @override
  Money get fee {
    return Money(value: 7000);
  }

  @override
  Money get busySeasonFee {
    return fee.add(fee: Money(value: 3000));
  }
}

// プレミアム宿泊料金
class PremiumRates implements HotelRates {
  @override
  Money get fee {
    return Money(value: 12000);
  }

  @override
  Money get busySeasonFee {
    return fee.add(fee: Money(value: 5000));
  }
}

void main() {
  // RegularRatesかPremiumRatesのどちらかだとする
  HotelRates hotelRates;
  // [GOOD]
  // hotelRatesはHotelRatesという基本型のprotocol
  // だけど準拠しているクラスのどちらであれその後の処理は何も変わらない
  hotelRates = RegularRates();
  // hotelRates = PremiumRates();

  // [GOOD]
  // RegularRatesかPremiumRatesのどっちだろうと同じ記述
  // 100個XXRatesが増えようとここは変わらない
  Money busySeasonFee = hotelRates.busySeasonFee;

  print("繁盛期の金額は${busySeasonFee.value}円です");
}
