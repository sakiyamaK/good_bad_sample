import 'dart:convert';


enum Magic {
  attack,
  recover,
}

extension MagicExtension on Magic {
  int get costMagicPoint {
    switch (this) {
      case Magic.attack:
        return 10;
      case Magic.recover:
        return 20;
      default:
        return 0;
    }
  }
}

enum ActionType {
  normalAttack,
  magic,
}


class Member {
  int hitPoint;
  int magicPoint;

  Member({required this.hitPoint, required this.magicPoint});

  // [BAD?]
  // この名前はどうだろう？
  // この判断をした後に結局MPが足りなくて行動できない場合がある
  bool get canAct {
    // 生きてるけど行動ができない場合がある
    // 今回は特にそういう条件分岐は入れずとりあえずtrueを返してる
    return true;
  }
  
  // [??]
  // Dartでenumと一緒にパラメータを渡す方法が分からなかった...
  // これだとtypeがnormalAttackでもmagicを渡すバグが起きてします
  void action(ActionType type, {Magic? magic = null}) {
    // [BAD]
    // 複雑な条件分岐
    // どこがメインの処理か分からない
    // 条件漏れが起きる
    if (hitPoint > 0) {
      if (canAct) {
        switch (type) {
          case ActionType.normalAttack:
            // 本来は攻撃時の実装がある
            break;
          case ActionType.magic:
            if (magic == null) { return; }
            if (magic.costMagicPoint <= magicPoint) {
              consume(magic);
              chant(magic);
            }
            break;
        }
      }
    }
  }

  void consume(Magic magic) {
    magicPoint = (magicPoint - magic.costMagicPoint).clamp(0, magicPoint);
  }

  void chant(Magic magic) {
    // 魔法を発動
    print("魔法をくらえ！");
  }
}

void main() {
  var user = Member(hitPoint: 200, magicPoint: 200);
  user.action(ActionType.magic, magic: Magic.attack);
}
