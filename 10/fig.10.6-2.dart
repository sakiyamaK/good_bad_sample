import 'dart:core';

/*
[おまけ]

書籍では名前の分け方などが以降続くが、それでもどうしてもうまく分けられないことが多い。
やっかいなのが分けすぎて実装が複雑になること。
*/

/*
いざ細かく名前を分けて改修時の影響が小さくなるように実装してみたが、
運用して2年間結局一切変更がない。

void aaa(ReservationProduct product)
void bbb(ExhibitProduct product)

上の関数みたいに受け取る型が違う関数が乱立したので、
型変換の手間が発生しただけだった。
*/
class ReservationProduct {
  final int id;
  final String name;

  ReservationProduct(this.id, this.name);

  // ReservationProductからExhibitProductへ変換する
  ExhibitProduct get exhibitProduct => ExhibitProduct(id, name);
}

class ExhibitProduct {
  final int id;
  final String name;

  ExhibitProduct(this.id, this.name);
}

class ShippingProduct {
  final int id;
  final String name;

  ShippingProduct(this.id, this.name);
}

class OrderProduct {
  final int id;
  final String name;

  OrderProduct(this.id, this.name);
}

void aaa(ReservationProduct product) {}
void bbb(ExhibitProduct product) {}

/*
対策
*/

// いずれ密結合になりそうだが今のところ何も困ることがない
class Product {
  final int id;
  final String name;

  Product(this.id, this.name);
}

// 実際は同じ型だが名前変換で用途を分けておく
typedef ReservationProduct2 = Product;
typedef ExhibitProduct2 = Product;
typedef ShippingProduct2 = Product;
typedef OrderProduct2 = Product;

// こうすると名前書き換えをしてるだけなので型変換がいらない
void ccc(ReservationProduct2 product) {}
void ddd(ExhibitProduct2 product) {}

/*
そしていざ仕様変更で処理が肥大化しそうになったら、
その時にclassの実体を用意したらいい。
*/
class ReservationProduct2 extends Product {
  ReservationProduct2(int id, String name) : super(id, name);
  void reserve(Reservation reservationItem) {}
}
/*
型名は同じなので、
void ccc(ReservationProduct2 product)
はそのまま使える。
*/
