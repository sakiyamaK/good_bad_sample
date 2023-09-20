import 'package:flutter/widgets.dart';

String createHTML(List<Widget> widgets) {
  var html = """
<html>
<body>
""";

  for (var widget in widgets) {
    if (widget is Text) {
      html += """
    <label>${(widget as Text).data}</label>
    """;
    }
  }

  html += """
</body>
</html>
""";
  return html;
}

void main() {
  // Widgetのリスト (今回はTextだけです)
  List<Widget> widgets = ['hoge', 'hage', 'hige'].map((text) => Text(text)).toList();

  print(createHTML(widgets));  
}

/*
意図としてはhtmlを直接書くことなく、
便利で安全なFlutterでHTMLが書けるぞワーイな機能
今回はFlutterからHTMLを書くプログラミングだが
メタプログラムだと簡単な記述のDartから複雑な記述のDartを生成したりする

Dartもメタプログラミングっぽいことができるライブラリはあるらしい

個人的には良い仕様とは思えない
大雑把なイメージだと、現場ごとに小さい言語仕様を追加したり、
言語仕様を超えたことができたりする

書籍にあるように一般的なエンジニアが手を出すと
黒魔術と化すので使い所が難しいと思う

例のcreateHTMLで他のタグやCSSの機能を追加していったことを思うと想像しやすい
複雑化するとWidgetの何を書けばどんなHTMLが生成されるのか訳が分からなくなる

riverpod generatorとかまさにこれだと思うがなあ...
riverpodに仕様変更があったら、
riverpodの仕様変更を理解して、
その変更された後のソースを出力するためには
どんなgeneratorのコードを書けばいいか理解しないといけない二度手間になる
*/
