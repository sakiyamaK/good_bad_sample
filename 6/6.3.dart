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
  // [GOD?]
  // もともとのcanActの名前を変えた
  // ステータスにおける行動チェック
  bool get canActForStatus {
    // 生きてるけど行動ができない場合がある
    // 今回は特にそういう条件分岐は入れずとりあえずtrueを返してる
    return true;
  }

  // [??]
  // Dartでenumと一緒にパラメータを渡す方法が分からなかった...
  // これだとtypeがnormalAttackでもmagicを渡すバグが起きてします
  bool canAct(ActionType type, {Magic? magic = null}) {
    switch (type) {
      case ActionType.normalAttack:
        return true;
      case ActionType.magic:
        if (magic == null) { return false; }
        return magic.costMagicPoint <= magicPoint;
    }
  }

  void action(ActionType type, {Magic? magic = null}) {
    // [GOOD]
    // メソッドの最初に例外を全て弾く
    // 早期returnをするわけだがSwiftにはそのための文法である guard bool else { return } がある
    if (hitPoint <= 0) return;
    if (!canActForStatus) return;
    if (!canAct(type, magic: magic)) return;

    // [GOOD]
    // メインの処理はインデントの浅い位置に書く
    // この時点で処理は確実に動くので例外はいらない
    // 仕様追加で他の条件が入ったとしても行動できない場合は↑のように早期にはじくので
    // メインの処理は変わらない
    switch (type) {
      case ActionType.normalAttack:
        // 本来は攻撃時の実装がある
        break;
      case ActionType.magic:
        if (magic == null) { return; }
        consume(magic);
        chant(magic);
        break;
    }
  }

  void consume(Magic magic) {
    magicPoint = (magicPoint - magic.costMagicPoint).clamp(0, magicPoint);
  }

  void chant(Magic magic) {
    print("魔法をくらえ！");
  }
}

void main() {
  var user = Member(hitPoint: 200, magicPoint: 200);
  user.action(ActionType.magic, magic: Magic.attack);
}
