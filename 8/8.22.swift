// 書籍のパッケージの話題は一般的なスマホアプリ開発者には無縁の話題のため別の例で説明

import UIKit

// このようにprivateじゃないなクラスは継承ができる
class MyViewController: UIViewController {
    
    // このようにprivateじゃないパラメータは外部からアクセスできる
    var isHoge: Bool = false
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

class MyViewController2: UIViewController {
    
    // [GOOD??]
    // privateにしたから外部への影響がない？？？
    private var isHoge: Bool = false
}

/*
 [BAD]
 finalじゃないclassは継承ができる
 そうなると1000ファイルのどこかでMyViewController2は継承されて使われているかもしれない
 そうなるとisHogeを変えたら当然継承先も影響が出る
 
 あとは同じで芋づる式に影響調査がいる
 */

// final classで「これは継承できません」という証
final class MyViewController3: UIViewController {
    
    // privateにしたから外部への影響がない
    private var isHoge: Bool = false
}


/*
 [GOOD]
 finalなclassのprivateなパラメータで初めて他のファイルに影響がない状態となり
 
 (falseからtrueに変えるだけだからちょろっとこの画面を動作確認して終わりだから)「10分ぐらいでしょ」
 
 と答えることができる
 
 他のプログラミング言語で言語仕様が違う場合もあるが、気にすべき本質は同じ
 
 「そのファイルを変更しても他のファイルに影響が出ないことを保証した状態が基本」
 
 逆に言うとprivateを外すなら必ず理由があるはずで、その理由を説明できる状態にする
 コードレビューでprivateじゃない理由を説明すれば代替案も出してもらえるかもしれない
 
 理由もなくprivateを付けてないと「privateを付けろと言うたやろ！」と怒られる
 そうなると本当にprivateを外さないと実装できない時も「private付けないとまた怒られる...」となって進まなくなる
 */
