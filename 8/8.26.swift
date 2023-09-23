struct Product {
    
}

/*
 [BAD]
 このクラスは「注文」「割引」「閲覧履歴」という３つの責務がひとつに混ざったクラス
 単一責任の原則に違反する
 */
// 注文を管理するクラス
class OrderService {
    private func calcDiscountPrice(price: Int) -> Int {
        // 割引価格を計算するロジック
        return price - 300
    }
    
    private func getProductBrowsingHistory(userId: Int) -> [Product] {
        // 閲覧履歴を取得するロジック
        return []
    }
}

/*
 [MEMO]
 なぜこうなってしまうのか？
 
 結局、単一責任原則の「単一」が曖昧だからだと思う
 現場ごとや自分の頭の中、で「ここまでを単一とする」と定義がはっきりさせないから迷う
 上記も「単一責任の原則に違反する」と書いたが「注文する時の処理を管理する」ことを単一と捉えたら間違いとは言えないと思う
 
 IT分野(というか理系分野)だからって明確に答えがあると思わないこと
 1+1=2みたいな万人に共通した明確な答えがあると思うから、それを探し回って見つからないから迷う
 「単一責任原則」の「単一」は「塩を少々入れると味が引き立つ」の「少々」みたいなものでまさに匙加減
 店全体のメニューなどから、塩の「少々」がどの程度を最適とするのか決めるはず
 だけど料理長の気分でその「少々」の量が変わったら全体が狂うし雇ってる料理人もどれぐらいが「少々」か分からなくなり混乱する
 
 単一責任原則の「単一」をしっかり「自分で決める」
 最適な「単一」の粒度はプロジェクトやメンバーの規模で変わってくるから変更もありえる
 ただし、「単一」の粒度を変えるならそれをしっかり意識すること
 
 そして自分で決めた単一さに基づいて他に影響を及ぼす密結合とならないように実装する
 */
