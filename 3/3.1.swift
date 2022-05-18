import Foundation

//後ほど説明 (*1)
enum Currency {
    case yen, dollar
}

//[BAD]
//そもそもビルドができないようにされている
//パラメータを初期化しないといけない
class Money {
    var amount: Int
    var currency: Currency
}

let money = Money()
