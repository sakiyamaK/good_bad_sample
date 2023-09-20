// 9.4
// 文字列型執着

/*
こんなことする人いないと思うけど、、、
*/
let title = "タイトル,255,250,250,64"


/*
文字列で管理をすると間違いが入りやすい
*/
let title1 = "タイトル,255,250,250" // 足りない
let title2 = "タイトル,255,250,250,a" // 数値を入れるところに文字列
let title3 = "255,250,250,a,タイトル" // 順番が違う
let title4 = "タイトル , 255,  250, 250" // スペースが入る
let title4 = "`タイトル,ここもタイトル`,255,250,250" // データ自体に,がある場合

/*
ちゃんとクラスや構造体のデータ型にしようね！！
*/
struct Title {
  let title: String
  let red: Int
  let green: Int
  let blue: Int
  let maxTitleNumber: Int
}