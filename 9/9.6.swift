// null問題

/*
 swiftはnull安全に設計されているので
 書籍のような問題を発生させるためにはむしろ一工夫させる必要がある
 つまり「普通に書けば問題を発生しない」
 */

// 装備品をprotocolで定義
protocol Equipment {
    var difence: Int { get }
}

struct Head: Equipment {
    let difence: Int
}

struct Body: Equipment {
    let difence: Int
}

struct Arm: Equipment {
    let difence: Int
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
        head!.difence + body!.difence + arm!.difence
    }
}

// 装備品を付けてインスタンスを生成
let member = Member(
    head: Head(difence: 10),
    body: Body(difence: 10),
    arm: Arm(difence: 20)
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
