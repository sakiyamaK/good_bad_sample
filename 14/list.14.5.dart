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

  // *** リファクタリング ***
  // 条件を反転させる
  bool get isDisable => id.id % 2 != 0;
}

class Comic {
  final Id id;
  final PurchasePoint currentPurchasePoint;

  Comic(this.id, this.currentPurchasePoint);

  // *** リファクタリング ***
  // 条件を反転させる
  bool get isDisable => id.id % 2 != 0;
}

class PurchasePointPayment {
  final Id customerId;
  final Id comicId;
  final PurchasePoint consumptionPoint;
  final DateTime paymentDateTime;

  PurchasePointPayment._(this.customerId, this.comicId, this.consumptionPoint,
      this.paymentDateTime);

  static PurchasePointPayment create(Customer customer, Comic comic) {
    // *** リファクタリングの効果 ***
    // 論理否定をなくして読みやすくする
    if (customer.isDisable) {
      throw Exception("有効な購入者ではありません");
    } else if (comic.isDisable) {
      throw Exception("現在取り扱いのできないコミックです");
    } else if (comic.currentPurchasePoint.amount >
        customer.possessionPoint.amount) {
      throw Exception("所持ポイントが不足しています");
    } else {
      return PurchasePointPayment._(customer.id, comic.id,
          comic.currentPurchasePoint, tz.TZDateTime.now(tz.UTC));
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
