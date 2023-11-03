import 'dart:core';

// 商品
/* 
[BAD]
Productにロジックが多い
それぞれのfuncが100行程度でもこれで400行になる
関わる他のclassとかなりの密結合で、他のclassの改修が常にProductに影響する

密結合かどうかの見分け方は、AをビルドするためにはBやCがないといけない状態、と思っておけばいい

なぜそんな密結合が起きてしまうのか
Productという名前が抽象的すぎてECサービスのあらゆる処理に関わってしまうから

名前が抽象的かどうかもサービス全体で決まることなので、場合によってはProductでいい場合もある
*/
class Product {
  // 予約処理
  void reserve(Reservation reservationItem) {}
  // 出品処理
  void exhibit(Exhibit exhibitItem, AddToStock addToStock) {}
  // 発送
  void shipping(Shipping shippingItem) {}
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
