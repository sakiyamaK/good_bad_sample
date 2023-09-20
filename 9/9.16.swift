// メタプログラミング

/*
実はあまりよく分かってない
ソースコードを出力するソースコードみたいな？
C言語の頃でいうマクロか？？
*/

//例 SwiftでHTMLのコードを書くメタプログラミング
import UIKit

func createHTML(views: [UIView]) -> String {
    var html = """
<html>
<body>
"""
    views.forEach {
        if let label = $0 as? UILabel {
            html += """
    <label>\(label.text ?? "")</label>
    """
        }
    }
    
    html += """
</body>
</html>
"""
    return html
}

// UIViewの配列 (今回はUILabelだけしかないけど)
let views: [UIView] = ["hoge", "hage", "hige"].compactMap({
    let label = UILabel()
    label.text = $0
    return label
})

print(createHTML(views: views))

/*
意図としてはhtmlを直接書くことなく、
便利で安全なUIKitでHTMLが書けるぞワーイな機能
今回はUIKitからHTMLを書くプログラミングだが
メタプログラムだと簡単な記述のSwiftから複雑な記述のSwiftを生成したりする

例だとfunctionで書いたがSwiftもMacro機能が増えたりして
メタプログラミングっぽいことができるようになったらしい

個人的には良い仕様追加とは思えない
大雑把なイメージだと、現場ごとに小さい言語仕様を追加したり、
言語仕様を超えたことができたりする

書籍にあるように一般的なエンジニアが手を出すと
黒魔術と化すので使い所が難しいと思う

例のcreateHTMLで他のタグやCSSの機能を追加していったことを思うと想像しやすい
複雑化するとUIViewの何を書けばどんなHTMLが生成されるのか訳が分からなくなる
*/