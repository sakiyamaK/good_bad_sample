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

// [GOOD]
// IntのままだとMPとAttackPowerを足すみたいなバグが生まれてしまうが
// それぞれの型を分けることでコンパイルエラーとなりそれが防げる
// ただ、ここまで型を用意するべきかどうかはプロジェクト次第
// こういうひとつのIntなどを持つデータがあれば
//「明確に型を分けて誤った型同士を計算することを防いでるんだな」
// という目的と察することが重要 他の目的もあるかもしれないしね
class MagicPoint {
  final int value;
  MagicPoint(this.value);
}

class AttackPower {
  final int value;
  AttackPower(this.value);
}

class CostTecnicalPoint {
  final int value;
  CostTecnicalPoint(this.value);
}

abstract class Magic {
  String get name;
  // [GOOD]
  // 戻り値の型が明確に分かれた
  MagicPoint get costMagicPoint;
  AttackPower attackPower(Member member);
  CostTecnicalPoint costTecnicalPoint(Member member);
}

class Fire implements Magic {
  @override
  String get name => "ファイア";
  @override
  MagicPoint get costMagicPoint => MagicPoint(2);
  @override
  AttackPower attackPower(Member member) {
    return AttackPower(20 + (member.level * 0.5).toInt());
  }

  @override
  CostTecnicalPoint costTecnicalPoint(Member member) {
    return CostTecnicalPoint(0);
  }
}

class Shiden implements Magic {
  @override
  String get name => "紫電";
  @override
  MagicPoint get costMagicPoint => MagicPoint(5);
  @override
  AttackPower attackPower(Member member) {
    return AttackPower(50 + (member.agility * 1.5).toInt());
  }

  @override
  CostTecnicalPoint costTecnicalPoint(Member member) {
    return CostTecnicalPoint(5);
  }
}

class HellFire implements Magic {
  @override
  String get name => "地獄の業火";
  @override
  MagicPoint get costMagicPoint => MagicPoint(16);
  @override
  AttackPower attackPower(Member member) {
    return AttackPower(200 +
        (member.magicAttackPoint * 0.5).toInt() +
        member.agility * 2);
  }

  @override
  CostTecnicalPoint costTecnicalPoint(Member member) {
    return CostTecnicalPoint(20 + (member.level * 0.4).toInt());
  }
}

enum MagicType { fire, shiden, hellFire }

final magics = {
  MagicType.fire: Fire(),
  MagicType.shiden: Shiden(),
  MagicType.hellFire: HellFire(),
};

extension MemberExtension on Member {
  void _showMagicName(Magic magic) {
    print("名前: ${magic.name}");
  }

  void _consumeMagicPoint(Magic magic) {
    print("消費MP: ${magic.costMagicPoint.value}");
  }

  void _consumeTechnicalPoint(Magic magic) {
    print("消費TP: ${magic.costTecnicalPoint(this).value}");
  }

  void _damage(Magic magic) {
    print("ダメージ: ${magic.attackPower(this).value}");
  }

  void attackMagic(MagicType magicType) {
    var magic = magics[magicType];
    if (magic != null) {
      print("-------");
      this._showMagicName(magic);
      this._consumeMagicPoint(magic);
      this._consumeTechnicalPoint(magic);
      this._damage(magic);
    }
  }

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
