# まとめ

- classのパラメータやメソッドの引数は一度用意したら「不要に」中身を変えられないようにする

  `dart`であれば`final`

  `swift`であれば`let`

  必要であれば仕方ないが、そこはバグを生みやすい

- 変数を受け取ったら不正かどうかバリデーションチェックする

- メソッドの引数は受け取るべきものしか受け取れないようにする  
  Int, Stringと言ったプリミティブ型を避ける
  

# 補足
各言語ごとにこういう「バグを生みやすい実装」を避ける仕様もある

今回の例ではなるべくどの言語でも備わっている基礎的な機能で実現した


