import 'dart:math';

class Member {
  int level;
  int agility;
  int tecnicalPoint;
  int magicAttackPoint;

  Member(
      {required this.level,
      required this.agility,
      required this.tecnicalPoint,
      required this.magicAttackPoint});
}

enum MagicType { fire, shiden, hellFire }

// 6.28
abstract class Magic {
  String get name;
  int get costMagicPoint;
  int attackPower(Member member);
  int costTecnicalPoint(Member member);
}

// 6.29
class Fire implements Magic {
  @override
  String get name => "ファイア";
  @override
  int get costMagicPoint => 2;
  @override
  int attackPower(Member member) {
    return 20 + (member.level * 0.5).toInt();
  }

  @override
  int costTecnicalPoint(Member member) {
    return 0;
  }
}

// 6.30
class Shiden implements Magic {
  @override
  String get name => "紫電";
  @override
  int get costMagicPoint => 5;
  @override
  int attackPower(Member member) {
    return 50 + (member.agility * 1.5).toInt();
  }

  @override
  int costTecnicalPoint(Member member) {
    return 5;
  }
}

// 6.31
class HellFire implements Magic {
  @override
  String get name => "地獄の業火";
  @override
  int get costMagicPoint => 16;
  @override
  int attackPower(Member member) {
    return 200 +
        (member.magicAttackPoint * 0.5).toInt() +
        member.agility * 2;
  }

  @override
  int costTecnicalPoint(Member member) {
    return 20 + (member.level * 0.4).toInt();
  }
}

// dartならenumのextensionでcomputed parameterやfunctionが導入できるのでswitchでやるべきとは思うけど
// 「switch使わなくてもできるよ」ということを示す例なので本の通りに書く
final magics = {
  MagicType.fire: Fire(),
  MagicType.shiden: Shiden(),
  MagicType.hellFire: HellFire(),
};

// 別にextensionで分ける意味もなかったが本の流れと合わせるためにここで定義しただけ
// 本だとfunctionが何にも属していないダメな設計
extension MemberExtension on Member {
    void _showMagicName(Magic magic) {
    print("名前: ${magic.name}");
  }

  void _consumeMagicPoint(Magic magic) {
    print("消費MP: ${magic.costMagicPoint}");
  }

  void _consumeTechnicalPoint(Magic magic) {
    print("消費TP: ${magic.costTecnicalPoint(this)}");
  }

  void _damage(Magic magic) {
    print("ダメージ: ${magic.attackPower(this)}");
  }

  // [GOOD]
  // ここで魔法の実行をしているがswitch文がない
  void attackMagic(MagicType magicType) {
    var magic = magics[magicType];
    if (magic == null) { return; }
    print("-------");
    this._showMagicName(magic);
    this._consumeMagicPoint(magic);
    this._consumeTechnicalPoint(magic);
    this._damage(magic);
  }

  // [コメント]
  // [おまけ]
  // ただぶっちゃけ今回の例なら直接Magicを引数で渡した方がいいw
  void attackMagic2(Magic magic) {
    print("-------");
    this._showMagicName(magic);
    this._consumeMagicPoint(magic);
    this._consumeTechnicalPoint(magic);
    this._damage(magic);    
  }
}

void main() {
  // memberを定義して魔法の呼び出し
  var member = Member(
      level: 1, agility: 1, tecnicalPoint: 1, magicAttackPoint: 1);
  member.attackMagic(MagicType.fire);
  member.attackMagic(MagicType.shiden);
  member.attackMagic(MagicType.hellFire);

  // [おまけ]
  // 直接Magicプロトコルに準拠したインスタンスを渡すパターン
  // 一応懸念点としては毎回魔法のインスタンスを生成しているところがいまいち
  // でもその程度のコストを気にする環境だとこの書籍の内容はほとんど通じないw
  member.attackMagic2(Fire());
  member.attackMagic2(Shiden());
  member.attackMagic2(HellFire());

}
