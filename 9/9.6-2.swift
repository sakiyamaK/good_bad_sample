// null問題

/*
 swiftはnull安全に設計されているのでnullでクラッシュを防ぐ

swiftはnullとnilが別物で定義されている
普通にiOS等のプログラミングをするだけならnilしか使わない
だがswiftはobjective-cと互換がありobjective-cはc++やcと互換がある
それらのハードウェアに近い低レイヤーにアクセスできる言語を利用する場合はnullが出てくる
言い換えるとswiftはOSすらない組み込み機器のプログラミングなどでも使えるはず？
それなら普通にC言語使えよとは思うが...
 */

// 装備品をprotocolで定義
protocol Equipment {
    var defense: Int { get }
}

struct Head: Equipment {
    let defense: Int
}

struct Body: Equipment {
    let defense: Int
}

struct Arm: Equipment {
    let defense: Int
}

/*
 [GOOD]
 空の状態を意味する型
 複数メモリにいる意味もないのでシングルトンで設計
 */
struct Empty: Equipment {
    let defense: Int = 0
    private init() {}
    static let shared = Empty()
}

class Member {
    /*
     [GOOD]
     swiftはoptionalじゃない型(普通の型)はnilが代入できない
     Empty型が入るためそれぞれの型もEquipmentで定義

     [BAD]
     ただ、この設計だとheadにArm型が代入できたりしてもやもやする
     */
    private var head: Equipment
    private var body: Equipment
    private var arm: Equipment
    
    init(head: Head, body: Body, arm: Arm) {
        self.head = head
        self.body = body
        self.arm = arm
    }
    
    func takeOffAllEquipments() {
        /*
         [GOOD]
         optional型じゃないので必ずインスタンスを代入しなければならい
         nilを許容しないため、クラッシュが起きない
         */
        head = Empty.shared
        body = Empty.shared
        arm = Empty.shared
    }
    
    var totalDefense: Int {
        /*
         [GOOD]
         optional型じゃないので必ずインスタンスがある
         */
        head.defense + body.defense + arm.defense
    }
}

// 装備品を付けてインスタンスを生成
let member = Member(
    head: Head(defense: 10),
    body: Body(defense: 10),
    arm: Arm(defense: 20)
)

/*
 
 数千行の色んな処理
 
 */

//しれっと装備品が外れてる
member.takeOffAllEquipments()

/*
 
 数千行の色んな処理
 
 */

// 防御力を計算してもクラッシュすることがない
print(member.totaldefense)


/* 
[まとめと補足]

nullを許容すると、いつどこでnullとなってクラッシュするか分からない
nullを許容すると、クラッシュさせないためにifやguardで条件分岐が必要になる
その条件分岐は常に一緒なのか？nullの時はどうするのが正しいのか？毎回考えないといけない
そのためswiftを含めた最近の言語は
「nullを許容しない方が通常」で「nullを許容させる型を特殊」な扱いとしている

つまりnullを許容させると特殊なことが色々と必要になる
またnullを許容した設計にして!の強制アンラップを使うと、それは前時代的なプログラミングに出戻ったことになる

強制アンラップは
「ここでは絶対このパラメータに値が入っているはずでクラッシュしないから大丈夫」
「optional型とかよく分からないしXcodeがサジェストで!を付けたら使えるといってるから大丈夫」
ではなく
「ここでは仮にnilがくるならクラッシュさせた方がいい」
ところでしか使わない

大事なのでさらにしつこく
言い換えると強制アンラップさせるなら「クラッシュさせた方がいい理由」がないとダメ

例えば
本当はユーザIDと課金額をサーバーに送ってDBを更新するはずなのに
間違ってユーザIDがnilになって、nilと課金額をサーバーに送ると、どう処理されるか分からない
間違ってサーバーが他のユーザに課金してしまうかもしれないし、
ユーザが見つからないからサーバーの負荷がめちゃ上がるかもしれないし、
DBがクラッシュするかもしれないし、、、

そうなるぐらいなら、手元のアプリ側でクラッシュさせた方がいい
*/