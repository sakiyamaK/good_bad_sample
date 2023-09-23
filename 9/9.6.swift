// null問題

/*
 swiftはnull安全に設計されているので
 書籍のような問題を発生させるためにはむしろ一工夫させる必要がある
 つまり「普通に書けば問題は発生しない」
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

// 強引に書籍のエラーが出るようにする書き方
class Member {
    /* 
    [BAD]
    書籍のエラーを出すためにあえてoptionalで定義
    */
    private var head: Head?
    private var body: Body?
    private var arm: Arm?
    
    init(head: Head?, body: Body?, arm: Arm?) {
        self.head = head
        self.body = body
        self.arm = arm
    }
    
    func takeOffAllEquipments() {
        head = nil
        body = nil
        arm = nil
    }
    
    var totalDifence: Int {
        /* 
        [BAD]
        書籍のエラーを出すためにあえてoptional型を!で強制アンラップしている
        */
        head!.defense + body!.defense + arm!.defense
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

// 防御力を計算してクラッシュ
print(member.totalDifence)
