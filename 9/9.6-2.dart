// 装備品をmixinで定義
mixin Equipment {
  int get defense;
}

class Head with Equipment {
  @override
  final int defense;
  
  Head(this.defense);
}

class Body with Equipment {
  @override
  final int defense;
  
  Body(this.defense);
}

class Arm with Equipment {
  @override
  final int defense;
  
  Arm(this.defense);
}

/*
 [GOOD]
 空の状態を意味する型
 複数メモリにいる意味もないのでシングルトンで設計
 */
class Empty with Equipment {
  @override
  final int defense = 0;

  // プライベートコンストラクタ
  Empty._();

  // シングルトンインスタンス
  static final Empty shared = Empty._();
}

class Member {
  /*
   [GOOD]
   swiftはoptionalじゃない型(普通の型)はnilが代入できない
   Empty型が入るためそれぞれの型もEquipmentで定義

   [BAD]
   ただ、この設計だとheadにArm型が代入できたりしてもやもやする
   */
  Equipment _head;
  Equipment _body;
  Equipment _arm;

  Member(this._head, this._body, this._arm);

  void takeOffAllEquipments() {
    _head = Empty.shared;
    _body = Empty.shared;
    _arm = Empty.shared;
  }

  int get totalDefense {
    /*
     [GOOD]
     optional型じゃないので必ずインスタンスがある
     */
    return _head.defense + _body.defense + _arm.defense;
  }
}

void main() {
// 装備品を付けてインスタンスを生成
final member = Member(
  Head(10),
  Body(10),
  Arm(20),
);


/*
 
 数千行の色んな処理
 
 */

// しれっと装備品が外れてる
member.takeOffAllEquipments();

/*
 
 数千行の色んな処理
 
 */

// 防御力を計算してもクラッシュすることがない
print(member.totalDefense);  
}

/* 
[まとめと補足]

nullを許容すると、いつどこでnullとなってクラッシュするか分からない
nullを許容すると、クラッシュさせないためにifで条件分岐が必要になる
その条件分岐は常に一緒なのか？nullの時はどうするのが正しいのか？毎回考えないといけない
そのためDartを含めた最近の言語は
「nullを許容しない方が通常」で「nullを許容させる型を特殊」な扱いとしている

つまりnullを許容させると特殊なことが色々と必要になる
またnullを許容した設計にして!の強制アンラップを使うと、それは前時代的なプログラミングに出戻ったことになる

強制アンラップは
「ここでは絶対このパラメータに値が入っているはずでクラッシュしないから大丈夫」
「null許容とかよく分からないしIDEがサジェストで!を付けたら使えるといってるから大丈夫」
ではなく
「ここでは仮にnullがくるならクラッシュさせた方がいい」
ところでしか使わない

大事なのでさらにしつこく
言い換えると強制アンラップさせるなら「クラッシュさせた方がいい理由」がないとダメ

例えば
本当はユーザIDと課金額をサーバーに送ってDBを更新するはずなのに
間違ってユーザIDがnullになって、nullと課金額をサーバーに送ると、どう処理されるか分からない
間違ってサーバーが他のユーザに課金してしまうかもしれないし、
ユーザが見つからないからサーバーの負荷がめちゃ上がるかもしれないし、
DBがクラッシュするかもしれないし、、、

そうなるぐらいなら、手元のアプリ側でクラッシュさせた方がいい

Dartは2011年に最初のバージョンが発表されて最初はjavascriptの置き換えを目的としていた
結果流行らないままマイナー言語という位置付けだったが2017年にFlutterが出て一気に流行った
そのため言語仕様的には古くnull安全がなく開発者たちは困っていた
Flutterが流行った後の2021年のver2.12でようやくnull安全機能がついて大喜びされた
https://dart.dev/null-safety/migration-guide

それぐらいnull安全は今時のプログラミング言語の基本機能とも言える
*/
