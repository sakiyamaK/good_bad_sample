// 9.4
// 文字列型執着

void main() {

/*
こんなことする人いないと思うけど、、、
*/
final title = "タイトル,255,250,250,64";

/*
文字列で管理をすると間違いが入りやすい
*/
final title1 = "タイトル,255,250,250"; // 足りない
final title2 = "タイトル,255,250,250,a"; // 数値を入れるところに文字列
final title3 = "255,250,250,a,タイトル"; // 順番が違う
final title4 = "タイトル , 255,  250, 250"; // スペースが入る
final title5 = "`タイトル,ここもタイトル`,255,250,250"; // データ自体に,がある場合 
}

/*
ちゃんとクラスや構造体のデータ型にしようね！！
*/
class Title {
  final String title;
  final int red;
  final int green;
  final int blue;
  final int maxTitleNumber;

  Title({
    required this.title,
    required this.red,
    required this.green,
    required this.blue,
    required this.maxTitleNumber,
  });
}
