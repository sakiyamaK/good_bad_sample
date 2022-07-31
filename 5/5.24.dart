import 'dart:ffi';

//5.24〜5.25
class Common {
  // [BAD]
  // Commonという共通処理クラスが問題 5.10.dart参照
  //
  // 戻り値がintで引数もintとdoubleと全部プリミティブ型
  // これでは何に使う数値を入れて何のためのintが返るのか分からない
  // つまりオブジェクト指向でない
  // そして regularPrice という数値だけが存在することなんてほぼない
  // 必ずそれを使うロジックがあちこちにあたりregularPriceと関連のあるデータも存在する
  int discountedPrice(int regularPrice, double discountRate) {
    if (regularPrice < 0) {
      throw Exception();
    }
    if (discountRate < 0) {
      throw Exception();
    }
    return (regularPrice * discountRate).toInt();
  }
}

class Util {
  bool isFairPrice(int regularPrice) {
    // [BAD]
    // regularPriceのバリデーションチェックがここでも必要になる
    if (regularPrice < 0) {
      throw Exception();
    }
    //適正価格を判断する処理があるとする
    return true;
  }
}
