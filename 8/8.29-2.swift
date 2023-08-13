// 8.29.swiftをさらに修正
// 全部[GOOD]

// protocolを利用することで完全な疎結合にする
protocol PriceAmountProtocol {
    var amount: Int { get }
}


struct SellingPrice: PriceAmountProtocol {
    let amount: Int

    init(amount: Int) {
        guard amount > 0 else {
            fatalError("商品価格がマイナスです")
        }
        self.amount = amount
    }
}

// priceから計算される値を全部extension(おまけの追加機能)として追加
extension SellingPrice {
    // 必要な定数を全部SellingPrice.Constにまとめる
    // さらにprivateにすることで外部では使わないことを保証する
    private enum Const {
        static let SELLING_COMMISSION_RATE: Double = 0.1
        static let DELIVERY_FREE_MIN: Int = 300
    }
    
    // 販売手数料を計算
    var sellingCommission: Int {
        Int(Double(amount) * SellingPrice.Const.SELLING_COMMISSION_RATE)
    }
    
    // 配送料を計算
    var deliveryCharge: Int {
        SellingPrice.Const.DELIVERY_FREE_MIN < amount ? 0 : 500
    }
}

// 獲得ポイントに関する処理は別概念なのでstruct自体を分ける
struct ShoppingPoint {

    private enum Const {
        static let SHOPPING_POINT_RATE: Double = 0.1
    }
    
    // PriceAmount直接ではなくPriceAmountProtocolに依存させて疎結合を保つ
    // つまりPriceAmountの中身のうち、amount以外がどう変わろうと関係ないことを保証する
    // だけど今回はPriceAmountはamountしかないから冗長かも...
    // ついでに配列にして応用を効かせた
    let prices: [PriceAmountProtocol]
    
    // 獲得ポイントを計算
    var deliveryCharge: Int {
        // 合計金額から獲得ポイントを計算する仕様だとこんな感じ
        let chargeDoble = prices.reduce(0.0) { partialResult, priceAmount in
            partialResult + Double(priceAmount.amount)
        } * ShoppingPoint.Const.SHOPPING_POINT_RATE
        
        return Int(chargeDoble)
    }
}

/*
  [MEMO]
  低凝集と高凝集のバランスが大事と書いたが、今回の自分の判断としては
  「販売手数料」と「配送料」はユーザが支払うお金に関することだからSellingPriceにまとめた
  「獲得ポイント」はユーザがもらうお金に関することだからShoppingPointに分けた

  言い方を変えると
  「ユーザが支払うお金に関すること」を「単一責任」と捉えたのでひとつのstructに書いた
  「ユーザがもらうお金に関すること」を「単一責任」と捉えたのでひとつのstructに書いた

  これが正解や不正解ではなくバランスの問題
*/