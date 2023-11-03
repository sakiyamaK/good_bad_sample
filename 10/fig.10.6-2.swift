/*
[おまけ]

書籍では名前の分け方などが以降続くが、それでもどうしてもうまく分けられないことが多い
やっかいなのが分けすぎて実装が複雑になること
*/

/*
いざ細かく名前を分けて改修時の影響が小さくなるように実装してみたが
運用して2年間結局一切変更がない

func aaa(product: ReservationProduct)
func bbb(product: ExhibitProduct)

上の関数みたいに受け取る型が違う関数が乱立したので
型変換の手間が発生しただけだった

*/
struct ReservationProduct {
  let id: Int
  let name: String

  // ReservationProductからExhibitProductへ変換する
  var exhibitProduct: ExhibitProduct {
    ExhibitProduct(id: id, name: name)
  }
}

struct ExhibitProduct {
  let id: Int
  let name: String
}

struct ShippingProduct {
  let id: Int
  let name: String
}

struct OrderProduct {
  let id: Int
  let name: String
}

func aaa(product: ReservationProduct) {}
func bbb(product: ExhibitProduct) {}

/*
対策
*/

// いずれ密結合になりそうだが今のところ何も困ることがない
struct Product {
  let id: Int
  let name: String
}

// 実際は同じ型だが名前変換で用途を分けておく
typealias ReservationProduct2 = Product
typealias ExhibitProduct2 = Product
typealias ShippingProduct2 = Product
typealias OrderProduct2 = Product

// こうすると名前書き換えをしてるだけなので型変換がいらない
func ccc(product: ReservationProduct2) {}
func ddd(product: ExhibitProduct2) {}

/*
 そしていざ仕様変更で処理が肥大化しそうになったら
 その時にstructの実体を用意したらいい
*/
struct ReservationProduct2 {
  let id: Int
  let name: String
  func reserve(_ reservationItem: Reservation) {}
}
/*
 型名は同じなので
 func ccc(product: ReservationProduct2) {}
 はそのまま使える
*/

