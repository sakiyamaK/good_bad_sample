import 'dart:core';

/*
[GOOD]
各処理に対して明確に名前を分けたclassにした
このおかげで密結合の度合いが下がり影響範囲が限定的になった

例としてReservationが変更されても影響があるのはReservationProductだけ
*/

class ReservationProduct {
  // 予約処理
  void reserve(Reservation reservationItem) {}
}

class ExhibitProduct {
  // 出品処理
  void exhibit(Exhibit exhibitItem, AddToStock addToStock) {}
}

class ShippingProduct {
  // 発送
  void shipping(Shipping shippingItem) {}
}

class OrderProduct {
  // 注文
  void order(PaymentMethod paymentMethod) {}
}

// 予約
class Reservation {}
// 在庫
class Exhibit {}
// 在庫追加
class AddToStock {}
// 発送
class Shipping {}
// 支払い方法
class PaymentMethod {}
