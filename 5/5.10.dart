// 5.10, 5.11

// [BAD]
// 共通処理クラスを用意してる時点で役割分担がちゃんとできていない証拠
//
// 税込み価格を計算する処理
// 退会済みかどうか判断する処理
// 商品を注文する処理
// なんの関連もない
//
// 結果的にこうなった後ならダメなことが分かるが、
// 実装中どこに書いていいか分からない処理があると
// Commonという名前が「あちこちから呼ぶ共通処理は全部ここなんだな」と
// 納得したうえで書き足していってしまい、いずれ1000行超えるクラスになる
class Common {

  // これは税込み金額を計算する処理
  // あらゆる金額計算画面で税込み価格を表示するからCommonにしたっぽい
  static double calcAmountIncludingTax(
      final double amountExcludingTax, final double taxRate) {
    return amountExcludingTax * taxRate;
  }

  // これは退会済みかどうか判断する処理
  // あらゆる画面で退会済みならできない処理があったりするからCommonにしたっぽい
  static bool hasResigned(final User user) {
    //実際は退会済みかどうか判断するロジックがある
    return true;
  }

  // これは注文するかどうか判断する処理
  // あらゆる画面で注文するからCommonにしたっぽい
  static void createOrder(final Product product) {
    //実際は商品を注文する処理がある
  }
}

class User {}

class Product {}

void main() {}
