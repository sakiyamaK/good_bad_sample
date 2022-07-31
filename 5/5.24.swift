//5.24〜5.25

import Foundation

class Common {
    // [BAD]
    // Commonという共通処理クラスが問題 5.10.dart参照
    //
    // 戻り値がintで引数もintとdoubleと全部プリミティブ型
    // これでは何に使う数値を入れて何のためのintが返るのか分からない
    // つまりオブジェクト指向でない
    // そして regularPrice という数値だけが存在することなんてほぼない
    // 必ずそれを使うロジックがあちこちにあたりregularPriceと関連のあるデータも存在する
    func discountedPrice(regularPrice: Int, discountRate: Double) throws -> Int {
        guard regularPrice >= 0 else {
            throw NSError(domain: "", code: 0)
        }
        guard discountRate >= 0 else {
            throw NSError(domain: "", code: 0)
        }
        return Int(Double(regularPrice) * discountRate)
    }
}

class Util {
    func isFairPrice(regularPrice: Int) throws -> Bool {
        // [BAD]
        // regularPriceのバリデーションチェックがここでも必要になる
        guard regularPrice >= 0 else {
            throw NSError(domain: "", code: 0)
        }
        //適正価格を判断する処理があるとする
        return true;
    }
}
