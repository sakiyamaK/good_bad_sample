class Member {
  int level;
  int agility;
  int tecnicalPoint;

  Member({required this.level, required this.agility, required this.tecnicalPoint});
}

enum MagicType {
  fire, 
  shiden
}

// [GOOD]
// dartでは
// enumにextensionでメソッドやcomputed parameterが持たせられる
// caseの追加漏れがあるとビルドエラーとなる
// そのため書籍のようにMagicクラスを用意する必要がない
extension MagicTypeExtension on MagicType {
  // [GOOD]
  // caseの追加漏れがあるとビルドエラーとなるためswitchが乱立してもいい
  // むしろ書籍のように書くとパラメータの追加忘れが起きて危険
  /*
    switch magicType {
    case .fire:
      name = ".."
      ...
      ...
      costMagicPoint = 10
      ...
      ...
    case .shiden:
    name = ".."
    ...
    ... <-- costMagicPointの更新抜けちゃった
    ...
    */
  String get name {
    switch (this) {
      case MagicType.fire:
        return "ファイア";
      case MagicType.shiden:
        return "紫電";
    }
  }

  int costMagicPoint(Member member) {
    switch (this) {
      case MagicType.fire:
        return 2;
      case MagicType.shiden:
        return 5 + ((member.level * 0.2).toInt());
    }
  }

  int attackPower(Member member) {
    switch (this) {
      case MagicType.fire:
        return 20 + ((member.level * 0.5).toInt());
      case MagicType.shiden:
        return 50 + ((member.agility * 1.5).toInt());
    }
  }

  int costTecnicalPoint(Member member) {
    switch (this) {
      case MagicType.fire:
        return 0;
      case MagicType.shiden:
        return 5;
    }
  }
}

void main() {
  var member = Member(level: 10, agility: 10, tecnicalPoint: 10);

  // [GOOD]
  // 「炎」魔法に関連付いてattackPowerが呼び出されている
  // [コメント]
  // ただ自分としては「メンバーが炎魔法を呼び出す」というイメージだから
  // member.attackPower(MagicType.fire) と呼び出すように実装するなあ
  print(MagicType.fire.attackPower(member));
}
