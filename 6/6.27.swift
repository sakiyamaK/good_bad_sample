import Foundation

struct Member {
    var level: Int
    var agility: Int
    var tecnicalPoint: Int
    var magicAttackPoint: Int
}

enum MagicType {
    case fire, shiden, hellFire
}

// 6.28
protocol Magic {
  var name: String { get }
  var costMagicPoint: Int { get }
  func attackPower(member: Member) -> Int
  func costTecnicalPoint(member: Member) -> Int
}

// 6.29
struct Fire: Magic {
  var name: String = "ファイア"
  var costMagicPoint: Int = 2
  func attackPower(member: Member) -> Int {
    return 20 + Int(Double(member.level) * 0.5)
  }
  func costTecnicalPoint(member: Member) -> Int {
    return 0
  }
}

// 6.30
struct Shiden: Magic {
  var name: String = "紫電"
  var costMagicPoint: Int = 5
  func attackPower(member: Member) -> Int {
    return 50 + Int(Double(member.agility) * 1.5)
  }
  func costTecnicalPoint(member: Member) -> Int {
    return 5
  }
}

// 6.31
struct HellFire: Magic {
  var name: String = "地獄の業火"
  var costMagicPoint: Int = 16
  func attackPower(member: Member) -> Int {
    return 200 + Int(Double(member.magicAttackPoint) * 0.5 + Double(member.agility * 2))
  }
  func costTecnicalPoint(member: Member) -> Int {
    return 20 + Int(Double(member.level) * 0.4)
  }
}

// swiftならenumがcomputed parameterやfunctionが導入できるのでswitchでやるべきとは思うけど
// 「switch使わなくてもできるよ」ということを示す例なので本の通りに書く

let magics: [MagicType: Magic] = [
  .fire: Fire(),
  .shiden: Shiden(),
  .hellFire: HellFire()
]

// 別にextensionで分ける意味もなかったが本の流れと合わせるためにここで定義しただけ
// 本だとfunctionが何にも属していないダメな設計
extension Member {
  private func showMagicName(magic: Magic) {
      // 本来は名前を画面に表示させたりなどが実装される
      print("名前: \(magic.name)")
  }

  private func cnsumeMagicPoint(magic: Magic) {
      // 本来はMagicPointの消費処理などが実装される
      print("消費MP: \(magic.costMagicPoint)")
  }

  private func cnsumeTechnicalPoint(magic: Magic) {
      // 本来はTechnicalPointの消費処理などが実装される
      let costTecnicalPoint = magic.costTecnicalPoint(member: self)
      print("消費TP: \(costTecnicalPoint)")
  }

  private func damage(magic: Magic) {
      // 本来はDamageの消費処理などが実装される
      print("ダメージ: \(magic.attackPower(member: self))")
  }

  // [GOOD]
  // ここで魔法の実行をしているがswitch文がない
  func attackMagic(magicType: MagicType) {
      guard let magic = magics[magicType] else { return }
      print("-------")
      self.showMagicName(magic: magic)
      self.cnsumeMagicPoint(magic: magic)
      self.cnsumeTechnicalPoint(magic: magic)
      self.damage(magic: magic)
  }

  // [おまけ]
  // ただぶっちゃけ今回の例なら直接Magicを引数で渡した方がいいw
  func attack(magic: Magic) {
      print("-------")
      self.showMagicName(magic: magic)
      self.cnsumeMagicPoint(magic: magic)
      self.cnsumeTechnicalPoint(magic: magic)
      self.damage(magic: magic)
  }

}

// memberを定義して魔法の呼び出し
let member = Member(level: 1, agility: 1, tecnicalPoint: 1, magicAttackPoint: 1)
member.attackMagic(magicType: .fire)
member.attackMagic(magicType: .shiden)
member.attackMagic(magicType: .hellFire)

// [おまけ]
// 直接Magicプロトコルに準拠したインスタンスを渡すパターン
// 一応懸念点としては毎回魔法のインスタンスを生成しているところがいまいち
// でもその程度のコストを気にする環境だとこの書籍の内容はほとんど通じないw
member.attack(magic: Fire())
member.attack(magic: Shiden())
member.attack(magic: HellFire())
