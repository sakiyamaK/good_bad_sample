enum MagicType {
  fire,
  shiden,
}

class Member {
  int level;
  int agility;
  int tecnicalPoint;

  Member({required this.level, required this.agility, required this.tecnicalPoint});
}

// [BAD]?
// 書籍ではcaseの追加漏れが問題と言っているがDartだとエラーとなるためそれは起きない
// そのため同じswitch caseが並ぶことが問題になりづらい
// [BAD]
// MagicManagerという別クラスをわざわざ用意している
// しかもクラス自身にデータをもたず5章でやった低凝集な状態になっている
class MagicManager {
  String getName(MagicType magicType) {
    switch (magicType) {
      case MagicType.fire:
        return "ファイア";
      case MagicType.shiden:
        return "紫電";
    }
  }

  int costMagicPoint(MagicType magicType, Member member) {
    switch (magicType) {
      case MagicType.fire:
        return 2;
      case MagicType.shiden:
        return 5 + ((member.level * 0.2).toInt());
    }
  }

  int attackPower(MagicType magicType, Member member) {
    switch (magicType) {
      case MagicType.fire:
        return 20 + ((member.level * 0.5).toInt());
      case MagicType.shiden:
        return 50 + ((member.agility * 1.5).toInt());
    }
  }

  int costTecnicalPoint(MagicType magicType, Member member) {
    switch (magicType) {
      case MagicType.fire:
        return 0;
      case MagicType.shiden:
        return 5;
    }
  }
}

void main() {
  var member = Member(level: 10, agility: 10, tecnicalPoint: 10);
  // [BAD]
  // 「メンバー」が使う「炎」魔法なのにどちらにも関連付いてないMagicManagerを呼び出している
  // プロジェクトが肥大化すると数百のクラスができるためMagicManagerの存在に気付かず
  // MagicProcessクラスやMemberActionクラスなど新たに生み出しかねない
  print(MagicManager().attackPower(MagicType.fire, member));
}