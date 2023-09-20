// 例外の握りつぶし

struct Product {
    let id: Int
}

enum APIError: Error {
    case invalidRequest(String)
}

extension [Product] {
    mutating func add(product: Product) throws {
        do {
            self.append(product)
            // 商品追加してサーバーに送信するが商品情報の何かが変でエラーが出るとする
            throw APIError.invalidRequest("invalid id 1234")

        } catch(let e) {
            /*
             [BAD]
             開発時に、ちょっとprint文で確認しているだけ
             
             サーバーが返してくれたエラーに対して何もしてない
             そうすると何のエラーが出たのか分からなくなる
             */
            print(e)
        }
    }
}

/*
 [BAD]
 View側の処理
 id 1234という商品を買い物かごに追加しようとしているが、
 ちょうど在庫切れになったなど何かしらの理由で出来ない場合もある
 だが、エラーが内部で握りつぶされているので、画面上何も起きない
 ログも記録していないため原因が分からない
 */
//
do {
    var reservations: [Product] = []
    try reservations.add(product: Product(id: 1234))
}
catch(let e) {
    //アラートを表示
}
