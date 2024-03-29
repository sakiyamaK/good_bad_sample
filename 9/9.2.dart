// 9.2
// マジックナンバー

void main() {

/* 
当然ですが以下のコードは何を意図したか分かりますか？
今、自分の頭の中のある計算式に基づいた実装です
*/

final value1 = 100 * 30 / 2;

/*
↑のコードは何を意図したか分かりません
では、先ほどと同じ計算式に基づいた実装を書き換えてみます
*/
final width = 100;
final height = 30;
final value2 = width * height / 2;

/*
↑のコードはおそらく「三角形の面積を出すコードだな」と意図が伝わるようになります
逆に言うと、ロジックに直接数値を書くと何を意図しているのか分からなくなります

このようにロジックに直接入った数値をマジックナンバーと言います

この１例だけなら見れば分かる話ですが、マジックナンバーを意識してない実装者がプロジェクトにいると
全体で何万行もあるプロジェクトの1万行ぐらいがマジックナンバーになっていてもおかしくありません

仕様変更で「この三角形のタップが反応しづらいから面積を内部的には1.1倍にしといて」となっても
1万行の数値計算の羅列から面積を出しているところを探し出して修正することになります

このように現状動いてるけど数値の羅列ばかりで、
なんで動いてるのかよく分からない魔法の数値という意味でマジックナンバーと呼ばれてます
*/
}