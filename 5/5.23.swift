// 魔法力を回復するメソッド
// currentMagicPoint 現在の魔法力残量
// originalMaxMagicPoint オリジナルの魔法力最大値
// maxMagicPointIncrements 魔法力最大値の増分
// return 回復後の魔法力の残量
func recoverMagicPoint(currentMagicPoint: Int, originalMaxMagicPoint: Int, maxMagicPointIncrements: [Int], recoveryAmount: Int) -> Int {
  // [おまけ]
  // 配列操作関数でできることは配列操作関数でやろう
  // forの中身のロジックを追う必要がある
  // 自由に記述できるためバグが入りやすい
  var currentMaxMagicPoint = originalMaxMagicPoint
  for maxMagicPointIncrement in maxMagicPointIncrements {
    currentMaxMagicPoint += maxMagicPointIncrement
  }

  // [おまけの続き]
  // 配列操作関数のreduceだと他のパラメータが入り込むことがない
  // reduceのことを知っていれば一目瞭然でロジックを追う必要がない
  // int currentMaxMagicPoint = originalMaxMagicPoint + maxMagicPointIncrements.reduce((a, b) => a + b);

  return min(currentMagicPoint + recoveryAmount, currentMaxMagicPoint)
}

// [BAD]↑
// 引数が多くて代入ミスが発生する
// 引数同士がただの数値の集まりでモデルとなっていないしプログラムとしての関連がない
// コメントで引数の説明を入れている -> コメントをつけないと何か分からないような引数ということ
//

class User {
    var currentMagicPoint: Int = 10
    let originalMaxMagicPoint: Int = 30
}

let user1 = User()
let user2 = User()

let recoveredMagicPoint = recoverMagicPoint(
    currentMagicPoint: user1.currentMagicPoint, // user1の現在の魔法力
    originalMaxMagicPoint: user2.originalMaxMagicPoint, //user2 オリジナルの魔法力最大値
    maxMagicPointIncrements: [12, 10, 100, 30], //この配列はどこからきた何？？
    recoveryAmount: 10 //この数値もどこからきた何？
)

//user１に代入であってるの？？
user1.currentMagicPoint = recoveredMagicPoint

// [おまけ]
// かつてのWindowsソフトウェアでは「windowを作る」という処理だけでこれだけのパラメータがあった
// わかるかボケ
// https://docs.microsoft.com/ja-jp/windows/win32/learnwin32/creating-a-window#creating-the-window
