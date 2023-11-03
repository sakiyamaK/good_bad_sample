// 図 10.2~10.3の実装
//
// 全部structで用意しているが深い意味はない
// structだろうがclassだろうがenumだろうがprotocolだろうが
// とにかく「名前付け」の問題について話す

import Foundation

// 商品
/* 
[BAD]
Productにロジックが多い
それぞれのfuncが100行程度でもこれで400行になる
関わる他のstructとかなりの密結合で、他のstructの改修が常にProductに影響する

密結合かどうかの見分け方は、AをビルドするためにはBやCがないといけない状態、と思っておけばいい

なぜそんな密結合が起きてしまうのか
Productという名前が抽象的すぎてECサービスのあらゆる処理に関わってしまうから

名前が抽象的かどうかもサービス全体で決まることなので、場合によってはProductでいい場合もある
*/
struct Product {
  // 予約処理
  func reserve(_ reservationItem: Reservation) {}
  // 出品処理
  func exhibit(_ exhibitItem: Exhibit, _ addToStock: AddToStock) {}
  // 発送
  func shipping(_ shippingItem: Shipping) {}
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