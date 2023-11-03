// 図 10.6~10.7の実装

import Foundation

/*
[GOOD]
各処理に対して明確に名前を分けたstructにした
このおかげで密結合の度合いが下がり影響範囲が限定的になった

例としてReservationが変更されても影響があるのはReservationProductだけ
*/

struct ReservationProduct {
  // 予約処理
  func reserve(_ reservationItem: Reservation) {}
}

struct ExhibitProduct {
  // 出品処理
  func exhibit(_ exhibitItem: Exhibit, _ addToStock: AddToStock) {}
}

struct ShippingProduct {
  // 発送
  func shipping(_ shippingItem: Shipping) {}
}

struct OrderProduct {
  // 注文
  func order(_ paymentMethod: PaymentMethod) {}
}

// 予約
struct Reservation {}
// 在庫
struct Exhibit {}
// 在庫追加
struct AddToStock {}
// 発送
struct Shipping {}
// 支払い方法
struct PaymentMethod {}