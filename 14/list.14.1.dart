// DartのDateTimeは'timezone'を持つため、'timezone'を無視するためのパッケージを利用します
import 'package:timezone/timezone.dart' as tz;

class Id {
  final int id;
  Id(this.id);
}

class PurchasePoint {
  final int amount;
  PurchasePoint(this.amount);
}

class Customer {
  final Id id;
  final PurchasePoint possessionPoint;

  Customer(this.id, this.possessionPoint);

  // 本来は何かの条件でユーザが有効か無効か決まる
  // 今回は偶数のみ有効
  bool get isEnable => id.id % 2 == 0;
}

class Comic {
  final Id id;
  final PurchasePoint currentPurchasePoint;

  Comic(this.id, this.currentPurchasePoint);

  // 本来は何かの条件でユーザが有効か無効か決まる
  // 今回は偶数のみ有効
  bool get isEnable => id.id % 2 == 0;
}

class PurchasePointPayment {
  final Id customerId;
  final Id comicId;
  final PurchasePoint consumptionPoint;
  final DateTime paymentDateTime;

  PurchasePointPayment._(this.customerId, this.comicId, this.consumptionPoint,
      this.paymentDateTime);

  static PurchasePointPayment create(Customer customer, Comic comic) {
    // [BAD]
    // if elseが多くて入れ子になっているため結局正常な処理がどこか分かりにくい
    if (customer.isEnable) {
      if (comic.isEnable) {
        if (comic.currentPurchasePoint.amount >
            customer.possessionPoint.amount) {
          // ここまできてようやく正常な初期化処理
          return PurchasePointPayment._(customer.id, comic.id,
              comic.currentPurchasePoint, tz.TZDateTime.now(tz.UTC));
        } else {
          throw Exception("所持ポイントが不足しています");
        }
      } else {
        throw Exception("現在取り扱いのできないコミックです");
      }
    } else {
      throw Exception("有効な購入者ではありません");
    }
  }
}

void main() {
  try {
    final currentCustomer = Customer(Id(1), PurchasePoint(100));
    final selectComic = Comic(Id(1), PurchasePoint(100));

    final purchasePointPayment =
        PurchasePointPayment.create(currentCustomer, selectComic);
  } catch (e) {
    print(e);
  }
}
