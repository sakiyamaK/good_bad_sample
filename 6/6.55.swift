struct Money {
  let value: Int
  func add(fee: Money) -> Money {
    Money(value: self.value + fee.value)
  }
}

// ストラテジーパターンのために用意したprotocol
protocol HotelRates {
  var fee: Money { get }
  // [GOOD]
  // そもそも「繁忙期料金」という概念があるならprotocolのパラメータにしておこう
  var busySeasonFee: Money { get } //繁忙期料金
}

// 通常宿泊料金
class RegularRates: HotelRates {
  var fee: Money {
    Money(value: 7000)
  }

  var busySeasonFee: Money {
    fee.add(fee: Money(value: 3000))
  }
}

// プレミアム宿泊料金
class PremiumRates: HotelRates {
  var fee: Money {
    Money(value: 12000)
  }
  var busySeasonFee: Money {
    fee.add(fee: Money(value: 5000))
  }
}

// RegularRatesかPremiumRatesのどちらかだとする
let hotelRates: HotelRates
// [GOOD]
// hotelRatesはHotelRatesという基本型のprotocol
// だけど準拠しているクラスのどちらであれその後の処理は何も変わらない
hotelRates = RegularRates()
// hotelRates = PremiumRates()

// [GOOD]
// RegularRatesかPremiumRatesのどっちだろうと同じ記述
// 100個XXRatesが増えようとここは変わらない
let busySeasonFee: Money = hotelRates.busySeasonFee

print("繁盛期の金額は\(busySeasonFee.value)円です")

