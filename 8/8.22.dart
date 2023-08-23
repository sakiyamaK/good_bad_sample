import 'package:flutter/material.dart';

class MyViewWidget extends StatelessWidget {
  // このようにprivateじゃないパラメータは外部からアクセスできる
  bool isHoge = false;

  @override
  Widget build(BuildContext context) {
    return Container(); 
  }
}

/*
 [BAD]
 すでにプロジェクトでは1000を超えるファイルがある
 
 ここでisHogeの初期値をtrueに変える仕様変更があるとする
 会議で「どれぐらいかかる？」と聞かれたら
 (falseからtrueに変えるだけだからちょろっとこの画面を動作確認して終わりだから)「10分ぐらいでしょ」と答えた
 
 だが
 
 isHogeはprivateじゃないためプロジェクトの1000ファイルからアクセスされているかもしれない
 isHogeを変えたら1000ファイルのどこかも影響されるかもしれないので1000ファイル分の確認が必要になる
 それで使われいなければまだ良かったですむが、実際に5ファイルで使われていたらその5ファイル分の確認と修正が必要になる
 
 そして
 
 そういう外部への影響を意識していないプロジェクトだから
 その修正した5ファイル内もまた1000ファイルのどこで使われているか分からないので確認する必要がある
 
 というふうに芋づる式に影響が広がり結果的321ファイルの修正が必要だったとかもありえる
 結果的に3ヶ月修正が必要だったりして「最初10分て言うたやないか、ちゃんと見積もりしろや」となる
 */
class MyViewWidget2 extends StatelessWidget {
  // privateにしたから外部への影響がない
  final bool _isHoge = false;

  @override
  Widget build(BuildContext context) {
    return Container(); 
  }
}

// Dartでは`final`を使って継承できないクラスを定義することはできない。
// どうしよう...?? 人間が気を付けるしかないのか？？